local status, hop = pcall(require, "hop")
if not status then
	return
end

local directions = require("hop.hint").HintDirection

vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })

hop.setup({ keys = "etovxqpdygfblzhckisuran" })
