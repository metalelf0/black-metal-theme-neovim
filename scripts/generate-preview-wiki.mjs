import { copyFile, mkdir, readdir, writeFile } from "node:fs/promises";
import path from "node:path";

const [, , previewDir, wikiDir] = process.argv;

if (!previewDir || !wikiDir) {
  throw new Error("Usage: node scripts/generate-preview-wiki.mjs <preview-dir> <wiki-dir>");
}

const names = new Set(await readdir(previewDir));
const variants = ["", "-alt", "-light", "-light-alt"];
const themes = [...names]
	.filter((name) => /^[a-z0-9-]+\.jpg$/.test(name))
	.map((name) => name.slice(0, -4))
	.filter((theme) => variants.every((variant) => names.has(`${theme}${variant}.jpg`)))
	.sort();

if (themes.length === 0) {
	throw new Error(`No complete theme preview sets found in ${previewDir}`);
}

const imageDir = path.join(wikiDir, "images", "theme-previews");
await mkdir(imageDir, { recursive: true });

const lines = ["# Theme previews", ""];

for (const theme of themes) {
	const title = theme.split("-").map((part) => part[0].toUpperCase() + part.slice(1)).join(" ");
	lines.push(`## ${title}`, "");

	for (const variant of variants) {
		const name = `${theme}${variant}`;
		const filename = `${name}.jpg`;
		await copyFile(path.join(previewDir, filename), path.join(imageDir, filename));
		lines.push(`### ${name}`, "", `![${name}](images/theme-previews/${filename})`, "");
	}
}

const pagePath = path.join(wikiDir, "Theme-previews.md");
await writeFile(pagePath, `${lines.join("\n")}\n`);
console.log(`Generated ${themes.length} theme sections in ${pagePath}`);
