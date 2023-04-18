local status, emmet = pcall(require, "emmet-vim")
if not status then
	return
end

emmet.setup({
	function()
		vim.g.user_emmet_leader_key = ";"

		vim.g.user_emmet_settings = {
			indent_blockelement = 1,
		}
	end,
})
