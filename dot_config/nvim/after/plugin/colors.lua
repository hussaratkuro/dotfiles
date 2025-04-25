function ColorMyPencils(color)
	color = color or "catppuccin-frappe"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	-- vim.api.nvim_set_hl(0, "NormaliFloat", { bg = "none"})
	vim.api.nvim_set_hl(0, "Visual", { bg = "#ff00ff", fg = '#f0f6fc'})
	-- vim.api.nvim_set_hl(0, "LineNr", { fg = '#f5b0b6'})
	vim.api.nvim_set_hl(0, "LineNr", { fg = '#e3dac9'})
	vim.api.nvim_set_hl(0, 'NonText', { fg = '#888888' })
	vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#e3dac9' })
	vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#888888' })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#607691" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#db88ce" })
	vim.o.guifont = "JetBrainsMono Nerd Font:h10"

	vim.g.neovide_transparency = 0.6
	vim.g.transparency = 0.6
	vim.g.neovide_background_color = ("#ffffff" .. string.format("%x", math.floor(((255 * vim.g.transparency) or 0.6 ))))
end


vim.opt.termguicolors = true

require("nvim-highlight-colors").setup {
	render = 'background',

	virtual_symbol = '■',

	enable_named_colors = true,

	enable_tailwind = false,

	custom_colors = {
		{ label = '%-%-theme%-primary%-color', color = '#0f1219' },
		{ label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
	}
}

require("catppuccin").setup {
	custom_highlights = function(colors)
		return {
			Comment = { fg = colors.red },
			TabLineSel = { bg = colors.black },
			CmpBorder = { fg = colors.surface2 },
			Pmenu = { bg = colors.black },
		}
	end,
	integrations = {
		treesitter = true,
	}
}

ColorMyPencils()
