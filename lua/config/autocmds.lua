-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- Turn off autoformat
vim.g.autoformat = false

-- turn off spellchecks and diagnostic for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    -- 1. Turn off spell check specifically for this markdown buffer
    vim.opt_local.spell = false

    -- 2. Disable diagnostics (W signs, inline warnings) specifically for this buffer
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
-- vim.filetype.add({
--   extension = {
--     md = "markdown",
--     markdown = "markdown",
--   },
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "pandoc",
--   callback = function()
--     vim.bo.filetype = "markdown"
--   end,
-- })
