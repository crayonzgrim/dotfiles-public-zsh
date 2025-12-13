local M = {}
local LazyvimUtil = require("lazyvim.util")

function M.toggleInlayHints()
  local bufnr = vim.api.nvim_get_current_buf()
  local current = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not current, { bufnr = bufnr })

  -- 상태 메시지 출력
  if not current then
    print("✓ Inlay hints enabled")
  else
    print("✗ Inlay hints disabled")
  end
end

function M.toggleAutoformat()
  LazyvimUtil.format.toggle()
end

return M
