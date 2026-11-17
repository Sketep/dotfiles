-- Prose mode: :Prose or <leader>uW toggles a distraction-free writing view.
local function toggle_prose()
  local zen = Snacks.zen
  if zen.win and zen.win:valid() then
    zen.win:close() -- on_close restores buffer state
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local saved = { completion = vim.b[buf].completion }
  local normal_bg = Snacks.util.color("Normal", "bg") or "#000000"

  Snacks.zen({
    win = {
      width = 80,
      -- Solid backdrop in the colorscheme's bg color: hides everything behind it.
      backdrop = { transparent = false, blend = 99, bg = normal_bg },
      wo = {
        winhighlight = "NormalFloat:Normal",
        wrap = true,
        linebreak = true, -- wrap at word boundaries
        breakindent = true,
        spell = true,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        winbar = "%=%#Comment#%{wordcount().words} words ", -- word count, top right
      },
    },
    on_open = function()
      vim.b[buf].completion = false -- blink.cmp checks this per buffer
      vim.diagnostic.enable(false, { bufnr = buf })
    end,
    on_close = function()
      vim.b[buf].completion = saved.completion
      vim.diagnostic.enable(true, { bufnr = buf })
    end,
  })
end

return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_user_command("Prose", toggle_prose, { desc = "Toggle prose mode" })
    end,
    keys = {
      { "<leader>uW", toggle_prose, desc = "Toggle Prose Mode" },
    },
  },
}
