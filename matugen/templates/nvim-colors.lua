local M = {}

M.colors = {
	fg = "{{colors.on_background.default.hex}}",
	bg = "NONE",
	primary = "{{colors.primary.default.hex}}",
	secondary = "{{colors.secondary.default.hex}}",
	surface = "{{colors.surface_variant.default.hex}}",
	error = "{{colors.error.default.hex}}",
}

function M.apply()
	local hls = {
		Normal = { fg = M.colors.fg, bg = M.colors.bg },
		NormalNC = { fg = M.colors.fg, bg = M.colors.bg },
		NormalFloat = { bg = M.colors.bg },
		FloatBorder = { fg = M.colors.primary, bg = M.colors.bg },
		SignColumn = { bg = M.colors.bg },
		EndOfBuffer = { fg = M.colors.surface, bg = M.colors.bg },
		NeoTreeNormal = { bg = M.colors.bg },
		NeoTreeNormalNC = { bg = M.colors.bg },
		TelescopeNormal = { bg = M.colors.bg },
		TelescopeBorder = { fg = M.colors.primary, bg = M.colors.bg },
		WhichKeyFloat = { bg = M.colors.bg },
		LazyNormal = { bg = M.colors.bg },
		MasonNormal = { bg = M.colors.bg },
		CursorLine = { bg = M.colors.surface },
		CursorLineNr = { fg = M.colors.primary, bold = true },
		Keyword = { fg = M.colors.primary, bold = true },
		Function = { fg = M.colors.primary },
		String = { fg = M.colors.secondary },
		Comment = { fg = M.colors.surface, italic = true },
		ErrorMsg = { fg = M.colors.error, bg = M.colors.bg },
	}
	for group, settings in pairs(hls) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

-- File Watcher for Instant Hot-Reload
local uv = vim.uv or vim.loop
local path = vim.fn.stdpath("config") .. "/lua/matugen-colors.lua"

if not _G.MatugenWatcher then
	_G.MatugenWatcher = uv.new_fs_event()
	_G.MatugenWatcher:start(
		path,
		{},
		vim.schedule_wrap(function(err, _, _)
			if not err then
				package.loaded["matugen-colors"] = nil
				require("matugen-colors").apply()
			end
		end)
	)
end

return M
