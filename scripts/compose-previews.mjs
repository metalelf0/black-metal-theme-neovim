import sharp from "sharp";
import { readFile } from "node:fs/promises";
import path from "node:path";

const [, , artworkManifest, outputDir] = process.argv;

if (!artworkManifest || !outputDir) {
  throw new Error("Usage: node scripts/compose-previews.mjs <artwork-manifest> <output-dir>");
}

const tileWidth = 1200;
const tileHeight = 760;
const captionHeight = 72;
const previewHeight = tileHeight + captionHeight;
const headerHeight = 380;
const gap = 48;
const padding = gap;
const column = (index) => padding + index * (tileWidth + gap);
const contentTop = padding + headerHeight + gap;
const contentRow = (index) => contentTop + index * (previewHeight + gap);
const artwork = JSON.parse(await readFile(artworkManifest, "utf8"));

async function tile(input, width = tileWidth, height = tileHeight) {
  return sharp(input)
    .rotate()
    .resize(width, height, {
      fit: "contain",
      background: "#000000",
    })
    .flatten({ background: "#000000" })
    .jpeg({ quality: 92 })
    .toBuffer();
}

async function addTile(inputs, source, left, top, width = tileWidth, height = tileHeight) {
  inputs.push({ input: await tile(source, width, height), left, top });
}

async function previewTile(source, label) {
  const caption = Buffer.from(
    `<svg width="${tileWidth}" height="${captionHeight}" xmlns="http://www.w3.org/2000/svg"><text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#ffffff" font-family="Arial, sans-serif" font-size="32">${label}</text></svg>`,
  );

  return sharp({
    create: {
      width: tileWidth,
      height: previewHeight,
      channels: 3,
      background: "#000000",
    },
  })
    .composite([
      { input: await tile(source), left: 0, top: 0 },
      { input: caption, left: 0, top: tileHeight },
    ])
    .jpeg({ quality: 92 })
    .toBuffer();
}

async function addPreview(inputs, source, label, left, top) {
  inputs.push({ input: await previewTile(source, label), left, top });
}

for (const { theme, cover, logo } of artwork) {
  const canvasWidth = tileWidth * 3 + gap * 2 + padding * 2;
  const canvasHeight = headerHeight + gap + previewHeight * 2 + gap + padding * 2;
  const inputs = [];

  await addTile(inputs, logo, padding, padding, canvasWidth, headerHeight);
  const previewBlockHeight = previewHeight * 2 + gap;
  const coverTop = contentTop + Math.round((previewBlockHeight - tileHeight) / 2);
  await addTile(inputs, cover, column(0), coverTop);
  await addPreview(inputs, path.join(outputDir, `${theme}.jpg`), theme, column(1), contentRow(0));
  await addPreview(inputs, path.join(outputDir, `${theme}-alt.jpg`), `${theme}-alt`, column(2), contentRow(0));
  await addPreview(inputs, path.join(outputDir, `${theme}-light.jpg`), `${theme}-light`, column(1), contentRow(1));
  await addPreview(inputs, path.join(outputDir, `${theme}-light-alt.jpg`), `${theme}-light-alt`, column(2), contentRow(1));

  await sharp({
    create: {
      width: canvasWidth,
      height: canvasHeight,
      channels: 3,
      background: "#000000",
    },
  })
    .composite(inputs)
    .jpeg({ quality: 92 })
    .toFile(path.join(outputDir, `${theme}-full.jpg`));
}
