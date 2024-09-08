vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
--local opts = { noremap = true, silent = true }
--vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

vim.opt.rtp:prepend(lazypath)



vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.o.statuscolumn = "%s %l %r "
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.breakindent = true

-- general Behaviour
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
-- vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.writebackup = false
vim.g.cursorline = true
vim.opt.ruler = true
vim.opt.rulerformat = '%l,%{luaeval("get_column()")}%P'

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require('jdtls')
    if jdtls then
      local current_buffer = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = current_buffer })
      local jdtls_client = vim.tbl_filter(function(client)
        return client.name == "jdtls"
      end, clients)[1]

      if not jdtls_client then
        jdtls.start_or_attach(require('plugins.java')[1].config())
      -- else
      --   print("JDTLS is already attached init lua")
      end
    else
      print("JDTLS is not available")
    end
  end,
})
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
