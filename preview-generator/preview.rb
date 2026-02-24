require 'gem'
string = "a string"
symbol = :symbol
fixnum = 666
float = 0.00
array = Array.new
array = ["black", 'metal', 666]
hash = { 666: 'beast', "666" => "beast" }
regex = /[abc]/

# this is a comment
class Person
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def self.greet
    "hallo"
  end
end

person1 = Person.new(name: "Chris")
puts Person::greet, " ", person1.name, "\n"
puts "another #{Person::greet} #{person1.name}"
