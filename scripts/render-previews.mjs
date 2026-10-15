import { chromium } from "playwright";
import sharp from "sharp";
import { mkdir, readdir, unlink } from "node:fs/promises";
import path from "node:path";

const [, , inputDir, outputDir] = process.argv;

if (!inputDir || !outputDir) {
  throw new Error("Usage: node scripts/render-previews.mjs <html-dir> <output-dir>");
}

await mkdir(outputDir, { recursive: true });

const browser = await chromium.launch({
  executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE,
});
const page = await browser.newPage({
  viewport: { width: 1200, height: 760 },
  deviceScaleFactor: 2,
});

for (const filename of await readdir(inputDir)) {
  if (!filename.endsWith(".html")) continue;

  const htmlPath = path.resolve(inputDir, filename);
  const pngPath = path.join(outputDir, filename.replace(/\.html$/, ".png"));
  const jpgPath = path.join(outputDir, filename.replace(/\.html$/, ".jpg"));

  await page.goto(`file://${htmlPath}`);
  await page.screenshot({ path: pngPath, fullPage: true });
  await sharp(pngPath).jpeg({ quality: 92 }).toFile(jpgPath);
  await unlink(pngPath);
}

await browser.close();
