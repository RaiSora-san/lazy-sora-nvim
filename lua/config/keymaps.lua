-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore vanilla vim 's' behavior: delete char under cursor, enter insert mode
vim.keymap.set("n", "s", "cl", { desc = "Substitute character" })
vim.keymap.set("x", "s", "c", { desc = "Substitute selection" })

--unbind mason
pcall(vim.keymap.del, "n", "<leader>cm")

-- converting with pandoc
local function pandoc_convert(ext)
  local file = vim.fn.expand("%:p")
  local output = vim.fn.expand("%:p:r") .. "." .. ext
  vim.cmd("!pandoc " .. vim.fn.shellescape(file) .. " -o " .. vim.fn.shellescape(output))
  vim.notify("Exported to " .. output, vim.log.levels.INFO)
end

-- convert to pdf
vim.keymap.set("n", "<leader>cp", function()
  pandoc_convert("pdf")
end, { desc = "Convert to PDF" })
-- convert to docx
vim.keymap.set("n", "<leader>cw", function()
  pandoc_convert("docx")
end, { desc = "Convert to DOCX" })
-- convert to odt
vim.keymap.set("n", "<leader>co", function()
  pandoc_convert("odt")
end, { desc = "Convert to ODT" })
-- convert to md
vim.keymap.set("n", "<leader>cm", function()
  pandoc_convert("md")
end, { desc = "Convert to Markdown" })

-- gagal disable keybind lmao
-- vim.keymap.set("n", "<leader>cp", "<cmd>Vellum<cr>", { desc = "Markdown Preview" })
-- keys = { { '<leader>cp', '<cmd>Vellum<cr>', desc = 'Markdown preview' } },
