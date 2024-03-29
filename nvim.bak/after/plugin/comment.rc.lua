local status, comment = pcall(require, "Comment")
if not status then
	return
end

local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

-- comment.setup({
-- 	pre_hook = ts_context_commentstring.create_pre_hook(),
-- })

comment.setup({
	pre_hook = function(ctx)
		local filetype = ctx.ft
		if filetype == "typescriptreact" then
			return ts_context_commentstring.create_pre_hook()(ctx)
		end
	end,
	-- pre_hook = function(ctx)
	-- 	-- Only calculate commentstring for tsx filetypes
	-- 	local filetype = vim.bo.filetype
	-- 	if filetype == "typescript" or filetype == "typescriptreact" then
	-- 		-- if vim.bo.filetype == "typescriptreact" then
	-- 		local U = require("Comment.utils")
	--
	-- 		-- Determine whether to use linewise or blockwise commentstring
	-- 		local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
	--
	-- 		-- Determine the location where to calculate commentstring from
	-- 		local location = nil
	-- 		if ctx.ctype == U.ctype.blockwise then
	-- 			location = require("ts_context_commentstring.utils").get_cursor_location()
	-- 		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
	-- 			location = require("ts_context_commentstring.utils").get_visual_start_location()
	-- 		end
	--
	-- 		return require("ts_context_commentstring.internal").calculate_commentstring({
	-- 			key = type,
	-- 			location = location,
	-- 		})
	-- 	end
	-- end,
})

-- comment.setup({
-- 	ignore = "^ *	*$",
-- 	pre_hook = function(ctx)
-- 		-- Only calculate commentstring for tsx filetypes
-- 		if vim.bo.filetype == "typescriptreact" then
-- 			local U = require("Comment.utils")

-- 			-- Determine whether to use linewise or blockwise commentstring
-- 			local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

-- 			-- Determine the location where to calculate commentstring from
-- 			local location = nil
-- 			if ctx.ctype == U.ctype.block then
-- 				location = require("ts_context_commentstring.utils").get_cursor_location()
-- 			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
-- 				location = require("ts_context_commentstring.utils").get_visual_start_location()
-- 			end

-- 			return require("ts_context_commentstring.internal").calculate_commentstring({
-- 				key = type,
-- 				location = location,
-- 			})
-- 		end
-- 	end,
-- 	-- pre_hook = ts_context_commentstring.create_pre_hook(),
-- })
