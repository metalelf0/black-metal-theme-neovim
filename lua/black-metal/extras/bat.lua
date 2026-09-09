local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local bat = Util.template(
		[=[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>name</key>
	<string>${theme} colors for ${extra}</string>
	<key>author</key>
	<string>Andrea Schiavini (original code by Casey Miller)</string>
	<key>url</key>
	<string>${url}</string>
	<key>upstream</key>
	<string>${upstream}</string>
	<key>settings</key>
	<array>
		<dict>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>${bg}</string>
				<key>caret</key>
				<string>${fg}</string>
				<key>foreground</key>
				<string>${fg}</string>
				<key>invisibles</key>
				<string>${grey}</string>
				<key>lineHighlight</key>
				<string>${line}</string>
				<key>selection</key>
				<string>${visual}</string>
				<key>selectionBorder</key>
				<string>${alt}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Comment</string>
			<key>scope</key>
			<string>comment</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${comment}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>String</string>
			<key>scope</key>
			<string>string</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${string}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Number</string>
			<key>scope</key>
			<string>constant.numeric</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${number}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Keyword</string>
			<key>scope</key>
			<string>keyword</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${keyword}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Function</string>
			<key>scope</key>
			<string>entity.name.function</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${func}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Type</string>
			<key>scope</key>
			<string>storage.type, entity.name.type</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${type}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Constant</string>
			<key>scope</key>
			<string>constant</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${constant}</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Operator</string>
			<key>scope</key>
			<string>keyword.operator</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>${operator}</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
]=],
		colors
	)
	return bat
end

return M
