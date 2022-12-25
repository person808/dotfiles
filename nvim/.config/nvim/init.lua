local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Misc Settings
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.lazyredraw = true
vim.opt.wildignore:append({
	"*.o",
	"*.obj",
	"*~",
	"*.pyc",
	"*.svg",
	"*.jpg",
	".cache/**",
	".local/**",
	".gem/**",
	".m2/**",
	".gradle/**",
})
vim.opt.mouse = "a"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.showmode = false

autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Misc Keybindings
-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Leader>fed", ":e <C-r>=resolve(expand($MYVIMRC))<CR><CR>", { desc = "Edit init.lua" })

-- Text display
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.signcolumn = "auto:1-3"
vim.opt.termguicolors = true

-- Searching/Moving around
vim.opt.inccommand = "nosplit"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 5

-- Open files at the last known cursor position
autocmd("BufReadPost", {
	group = augroup("restore_position", { clear = true }),
	pattern = "*",
	callback = function()
		vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" ]])
	end,
})

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffers and Splits
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<Leader>wd", ":close<CR>")

-- Folding
vim.opt.foldlevelstart = 10

-- Indentation
vim.opt.copyindent = true

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Backup/Undo
vim.opt.undolevels = 10000
vim.opt.undofile = true
vim.opt.shortmess:append({ c = true })
vim.opt.wildmode = { "longest", "full" }

-- Terminal
vim.keymap.set("t", "<Esc>", [[<c-\><c-n>]])
vim.keymap.set("n", [[<Leader>']], ":terminal<CR>")
autocmd("TermOpen", {
	group = augroup("terminal", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.spell = false
	end,
})

-- Diagnostics
vim.diagnostic.config({
	signs = true,
	underline = true,
	virtual_text = false,
	float = { border = "single" },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	"sheerun/vim-polyglot",
	"axelf4/vim-strip-trailing-whitespace",
	"tpope/vim-commentary",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"junegunn/vim-slash",
	"lukas-reineke/indent-blankline.nvim",
	"kyazdani42/nvim-web-devicons",
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true },
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({ mirage = true })
			vim.cmd("colorscheme ayu-mirage")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		keys = {
			{ "<leader>ft", ":NvimTreeToggle<CR>", desc = "File tree" },
		},
		config = function()
			require("nvim-tree").setup()
		end,
	},
	{
		"simnalamburt/vim-mundo",
		keys = {
			{ "<leader>u", ":MundoToggle<CR>", desc = "Undo tree" },
		},
		config = function()
			vim.g.mundo_preview_bottom = true
			vim.g.mundo_width = 30
			vim.g.mundo_verbose_graph = false
		end,
	},
	{
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_resolve_links = 1
			vim.g.rooter_change_directory_for_non_project_files = "current"
		end,
	},
	{
		"linty-org/key-menu.nvim",
		config = function()
			local key_menu = require("key-menu")
			key_menu.set("n", "<leader>")
			key_menu.set("n", "<leader>b", { desc = "Buffers" })
			key_menu.set("n", "<leader>f", { desc = "Files" })
			key_menu.set("n", "<leader>g", { desc = "Git" })
			key_menu.set("n", "<leader>r", { desc = "Refactor" })
			key_menu.set("n", "<leader>s", { desc = "Search" })
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local kinds = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "ﰕ",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "廓",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}

			cmp.setup({
				experimental = {
					ghost_text = true,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, vim_item)
						vim_item.menu = vim_item.kind
						vim_item.kind = kinds[vim_item.kind]

						return vim_item
					end,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({ border = "single" }),
					documentation = cmp.config.window.bordered({ border = "single" }),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup()
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			-- Add spaces between pairs
			npairs.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					local pair = opts.line:sub(opts.col, opts.col + 1)
					return vim.tbl_contains({ "()", "[]", "{}" }, pair)
				end, 1),
				Rule("( ", " )")
						:with_pair(function()
							return false
						end, 1)
						:with_move(function(opts)
							return opts.prev_char:match(".%)") ~= nil
						end)
						:use_key(")"),
				Rule("{ ", " }")
						:with_pair(function()
							return false
						end, 1)
						:with_move(function(opts)
							return opts.prev_char:match(".%}") ~= nil
						end)
						:use_key("}"),
				Rule("[ ", " ]")
						:with_pair(function()
							return false
						end, 1)
						:with_move(function(opts)
							return opts.prev_char:match(".%]") ~= nil
						end)
						:use_key("]"),
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/nvim-lsp-installer",
			"ray-x/lsp_signature.nvim",
			"kosayoda/nvim-lightbulb",
			"folke/neodev.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("nvim-lsp-installer").setup({ automatic_installation = true })
			require("neodev").setup()

			local on_attach = function(client, bufnr)
				require("lsp_signature").on_attach({
					handler_opts = {
						border = "single",
					},
				})

				-- Auto open diagnostics
				local lsp_augroup = vim.api.nvim_create_augroup("lsp", { clear = true })
				vim.api.nvim_create_autocmd(
					"CursorHoldI",
					{ group = lsp_augroup, buffer = bufnr, callback = vim.lsp.buf.signature_help }
				)
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = lsp_augroup,
					buffer = bufnr,
					callback = function()
						vim.diagnostic.open_float({ border = "single", focusable = false })
						vim.lsp.buf.document_highlight()
						require("nvim-lightbulb").update_lightbulb()
					end,
				})
				vim.api.nvim_create_autocmd(
					"CursorMoved",
					{ group = lsp_augroup, buffer = bufnr, callback = vim.lsp.buf.clear_references }
				)

				local function lsp_map(lhs, rhs, callback, opts)
					local options = vim.tbl_extend("force", { silent = true, buffer = bufnr }, opts or {})
					vim.keymap.set(lhs, rhs, callback, options)
				end

				lsp_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
				lsp_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
				lsp_map("n", "K", vim.lsp.buf.hover)
				lsp_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
				lsp_map("n", "<C-k>", vim.lsp.buf.signature_help)
				lsp_map(
					"n",
					"<leader>sj",
					require("telescope.builtin").lsp_document_symbols,
					{ desc = "Document symbols" }
				)
				lsp_map(
					"n",
					"<leader>sJ",
					require("telescope.builtin").lsp_workspace_symbols,
					{ desc = "Workspace symbols" }
				)
				lsp_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
				lsp_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
				lsp_map("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { desc = "List workspace folders" })
				lsp_map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
				lsp_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
				lsp_map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
				lsp_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
				lsp_map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
				lsp_map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
				lsp_map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			}

			local default_lsp_config = { capabilities = capabilities, on_attach = on_attach, handlers = handlers }
			local servers = {
				"bashls",
				"clangd",
				"cmake",
				"eslint",
				"html",
				"jsonls",
				"pyright",
				"sumneko_lua",
				"tsserver",
				"vimls",
			}
			local configs = {}

			for _, server in ipairs(servers) do
				local opts = vim.tbl_get(configs, server) or default_lsp_config
				lspconfig[server].setup(opts)
			end

			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = true })
			end, {})
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					border = "single",
				},
				select = {
					backend = { "builtin" },
					builtin = {
						border = "single",
					},
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
				autopairs = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"akinsho/nvim-bufferline.lua",
		lazy = false,
		keys = {
			{ "L", ":BufferLineCycleNext<CR>" },
			{ "H", ":BufferLineCyclePrev<CR>" },
		},
		config = true,
	},
	{
		"hoob3rt/lualine.nvim",
		config = {
			options = { theme = "ayu", globalstatus = true },
			sections = {
				lualine_b = { "branch", "diff" },
				lualine_x = { { "diagnostics", sources = { "nvim_lsp" } }, "encoding", "fileformat", "filetype" },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<Leader><Leader>",
				require("telescope.builtin").builtin,
				desc = "Telescope Actions",
			},
			{
				"<Leader>ff",
				function()
					local opts = {}
					local ok = pcall(require("telescope.builtin").git_files, opts)
					if not ok then
						require("telescope.builtin").find_files(opts)
					end
				end,
				desc = "Project files",
			},
			{ "<Leader>fr", require("telescope.builtin").oldfiles, desc = "Recent files" },
			{ "<Leader>fs", require("telescope.builtin").live_grep, desc = "Grep" },
			{ "<Leader>bb", require("telescope.builtin").buffers, desc = "Buffers" },
			{ "<Leader>ss", require("telescope.builtin").current_buffer_fuzzy_find, desc = "Search" },
		},
		config = function()
			require("telescope").setup({
				defaults = require("telescope.themes").get_dropdown({
					borderchars = {
						{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
					width = 0.8,
					prompt_title = false,
					sorting_strategy = "ascending",
				}),
			})
		end,
	},
	{
		"TimUntersberger/neogit",
		keys = {
			{
				"<leader>gs",
				function()
					require("neogit").open({ kind = "split" })
				end,
				desc = "Status",
			},
			{
				"<leader>gl",
				function()
					require("neogit").open({ "log", kind = "split" })
				end,
				desc = "Log",
			},
			{
				"<leader>gk",
				function()
					require("neogit").open({ "commit", kind = "split" })
				end,
				desc = "Commit",
			},
		},
	},
}, {
	install = {
		colorscheme = { "ayu-mirage" },
	},
})
