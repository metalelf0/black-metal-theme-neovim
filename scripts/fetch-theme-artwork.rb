#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "json"
require "nokogiri"
require "ferrum"

obsimusic_root = ENV.fetch("OBSIMUSIC_ROOT", File.expand_path("../../obsimusic", __dir__))
obsimusic_lib = File.join(obsimusic_root, "lib")
abort "ObsiMusic not found at #{obsimusic_root}; set OBSIMUSIC_ROOT to its directory" unless File.file?(File.join(obsimusic_lib, "obsimusic.rb"))

$LOAD_PATH.unshift(obsimusic_lib)
require "obsimusic"

REFERENCES = {
  "bathory" => ["Bathory", "Hammerheart", "1990"],
  "burzum" => ["Burzum", "Filosofem", "1996"],
  "dark-funeral" => ["Dark Funeral", "The Secrets of the Black Arts", "1996"],
  "darkthrone" => ["Darkthrone", "Transilvanian Hunger", "1994"],
  "emperor" => ["Emperor", "In the Nightside Eclipse", "1994"],
  "gorgoroth" => ["Gorgoroth", "Twilight of the Idols - In Conspiracy with Satan", "2003"],
  "immortal" => ["Immortal", "At the Heart of Winter", "1999"],
  "impaled-nazarene" => ["Impaled Nazarene", "Tol Cormpt Norz Norz Norz...", "1993"],
  "khold" => ["Khold", "Phantom", "2002"],
  "marduk" => ["Marduk", "Panzer Division Marduk", "1999"],
  "mayhem" => ["Mayhem", "The Dawn of the Black Hearts", "1995"],
  "nile" => ["Nile", "Black Seeds of Vengeance", "2000"],
  "taake" => ["Taake", "Hordalands doedskvad", "2005"],
  "thyrfing" => ["Thyrfing", "Valdr Galga", "1999"],
  "venom" => ["Venom", "Welcome to Hell", "1981"],
  "windir" => ["Windir", "Arntor", "1999"]
}.freeze

def normalized_title(title)
  title.downcase.gsub(/[^\p{Alnum}]+/, " ").strip
end

def fetch_artwork(page, parser, album)
  page.go_to(album.source_url)
  page.network.wait_for_idle
  album_doc = Nokogiri::HTML(page.body)

  cover_url = parser.send(:extract_cover_url, album_doc)
  band_url = album_doc.at_css("h2.band_name a")&.[]("href")
  raise "No cover image found on #{album.source_url}" unless cover_url
  raise "No band page found on #{album.source_url}" unless band_url

  page.go_to(band_url)
  page.network.wait_for_idle
  band_doc = Nokogiri::HTML(page.body)
  logo = band_doc.at_css("a#logo")
  logo_url = logo&.[]("href") || logo&.at_css("img")&.[]("src")
  logo_url = parser.send(:normalize_image_url, logo_url)
  raise "No band logo found on #{band_url}" unless logo_url

  { cover: cover_url, logo: logo_url }
end

def download_image(url, filepath)
  return if ObsiMusic::Utils::ImageDownloader.download(url, filepath)

  raise "Could not download #{url}"
end

output_dir = ARGV.fetch(0) { abort "Usage: fetch-theme-artwork.rb <output-dir> [theme ...]" }
themes = ARGV.drop(1)
references = themes.empty? ? REFERENCES : REFERENCES.slice(*themes)
abort "Unknown theme(s): #{(themes - REFERENCES.keys).join(', ')}" if themes.any? { |theme| !REFERENCES.key?(theme) }

FileUtils.mkdir_p(output_dir)
parser = ObsiMusic::Parsers::MetalArchivesParser.new
browser = nil
page = nil
artwork = []

begin
  references.each do |theme, (band, title, year)|
    cover_path = File.expand_path("#{theme}-cover.jpg", output_dir)
    logo_path = File.expand_path("#{theme}-logo.jpg", output_dir)

    if [cover_path, logo_path].all? { |filepath| File.file?(filepath) && File.size?(filepath) }
      puts "Using cached artwork: #{band}"
      artwork << { theme: theme, cover: cover_path, logo: logo_path }
      next
    end

    results = parser.search(album_title: title, band_name: band)
    album = results.find { |result| result.year == year && normalized_title(result.title) == normalized_title(title) }
    raise "Metal Archives album not found: #{band} — #{title} (#{year})" unless album

    puts "Downloading artwork: #{band} — #{title} (#{year})"
    browser ||= Ferrum::Browser.new(headless: true)
    page ||= browser.create_page
    images = fetch_artwork(page, parser, album)
    download_image(images.fetch(:cover), cover_path)
    download_image(images.fetch(:logo), logo_path)
    artwork << { theme: theme, cover: cover_path, logo: logo_path }
  end
ensure
  browser&.quit
end

File.write(File.join(output_dir, "artwork.json"), JSON.pretty_generate(artwork))
