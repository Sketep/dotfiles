-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"  -- use system clipboard
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8             -- keep 8 lines visible above/below cursor
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true          -- case-sensitive only when query has uppercase

-- Plugins
require("lazy").setup({

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        color_overrides = {
          mocha = { peach = "#fab387" },
        },
        highlight_groups = {
          CursorLineNr = { fg = "peach" },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },


  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "cpp", "python", "javascript", "typescript", "lua", "bash", "html", "css", "json" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Icons (used by lualine)
  { "nvim-tree/nvim-web-devicons" },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

  -- Auto close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

})


-- Markdown and text file wrapping autocmd
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown", "text"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.spell = true          -- spell check for prose
        vim.opt_local.textwidth = 0         -- no hard wrapping
        vim.opt_local.colorcolumn = ""      -- hide the column guide

        vim.keymap.set('n', 'j', function()
            return vim.v.count > 0 and 'j' or 'gj'
        end, {expr = true, buffer = true})

        vim.keymap.set('n', 'k', function()
            return vim.v.count > 0 and 'k' or 'gk'
        end, {expr = true, buffer = true})
    end
})
