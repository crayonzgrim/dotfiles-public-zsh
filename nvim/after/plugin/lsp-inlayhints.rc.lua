local status, inlayHints = pcall(require, "lsp-inlayhints")
if not status then
	return
end

inlayHints.setup({})
