vim.cmd [[packadd packer.nvim]]

-- Plugin manager
return require('packer').startup(function(use)
		use 'wbthomason/packer.nvim'

		-- Fuzzy finder
		use {
				'nvim-telescope/telescope.nvim', tag = '0.1.6',
				requires = { {'nvim-lua/plenary.nvim'} }
		}

		-- File tree
		use {
				'nvim-tree/nvim-tree.lua',
				requires = {
						'nvim-tree/nvim-web-devicons',
				},
		}

		-- Tabs
		use { 'romgrk/barbar.nvim' }

		use {"akinsho/toggleterm.nvim", tag = '*', config = function()
				require("toggleterm").setup()
		end}

		use {'MunifTanjim/nui.nvim'}

		-- Theme ( mocha ) 
		use { "catppuccin/nvim", as = "catppuccin" }

		-- Hl color codes
		use { 'brenoprata10/nvim-highlight-colors' }

		-- Status line
		use ("nvim-lualine/lualine.nvim")

		-- Color picker
		use 'uga-rosa/ccc.nvim';

		-- Highlight multiple words
		-- use 'Mr-LLLLL/interestingwords.nvim'

		-- Scroll bar
		use("petertriho/nvim-scrollbar")
		-- Search and Git options for the scrollbar
		use {
				"kevinhwang91/nvim-hlslens",
				config = function()
						require("scrollbar.handlers.search").setup({
						})
				end,
		}
		use {
				"lewis6991/gitsigns.nvim",
				config = function()
						require('gitsigns').setup()
						require("scrollbar.handlers.gitsigns").setup()
				end
		}

		-- Auto indentation
		use { 'vidocqh/auto-indent.nvim' }

		-- Smooth scroll
		use { 'karb94/neoscroll.nvim' }

		-- Treesitter & treesitter playground
		use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
		use('nvim-treesitter/playground')

		-- Auto closing tags
		use("windwp/nvim-autopairs")
		use("windwp/nvim-ts-autotag")

		-- Harpoon man file navigation
		use('theprimeagen/harpoon')

		-- Undo tree
		use('mbbill/undotree')

		-- Multiline editing
		use { 'mg979/vim-visual-multi' }

		-- LSP setup
		use {
				'VonHeikemen/lsp-zero.nvim',
				branch = 'v3.x',
				requires = {
						{'williamboman/mason.nvim'},
						{'williamboman/mason-lspconfig.nvim'},

						{'neovim/nvim-lspconfig'},
						{'hrsh7th/nvim-cmp'},
						{'hrsh7th/cmp-nvim-lsp'},
						{'L3MON4D3/LuaSnip'},
				}
		}

		-- Command mode popup
		use {
				'folke/noice.nvim',
				dependencies = {
						'MunifTanjim/nui.nvim',
						'nvim-notify',
						'rcarriga/nvim-notify',
				}
		}

		use 'rcarriga/nvim-notify'

		-- Commenting
		use {
				'numToStr/Comment.nvim',
				config = function()
						require('Comment').setup()
				end
		}

end)
