local status, ts = pcall(require, "typescript")
if not status then
	return
end

ts.setup({})
