-- nvim-lspconfig dropped its erlangls config (erlang_ls is unmaintained, #4292),
-- but LazyVim's erlang extra still enables `erlangls = {}`. Supply the config here.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        erlangls = {
          cmd = { "erlang_ls" },
          filetypes = { "erlang" },
          root_markers = { "rebar.config", "erlang.mk", ".git" },
        },
      },
    },
  },
  -- erlang_ls starts an "Indexing <file>" $/progress job on every didChange,
  -- so noice flashes a popup on each keystroke. Hide its progress messages.
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            return vim.tbl_get(message.opts, "progress", "client") == "erlangls"
          end,
        },
        opts = { skip = true },
      })
    end,
  },
}
