local lush_status, lush = pcall(require, "lush")
if not lush_status then
	return
end

local solid_status, darcula_solid = pcall(require, "lush_theme.darcula-solid")
if not lush_status then
	return
end

local spec = lush.extends({ darcula_solid }).with(function()
	local yellow = lush.hsl(37, 100, 71)

	return {
		Type({ fg = yellow }),
		Function({ fg = darcula_solid.Normal.fg }),
	}
end)

lush(spec)

vim.cmd.colorscheme("darcula-solid")
