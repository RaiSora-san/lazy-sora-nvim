return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- Default options: saves images to an "assets" folder relative to the markdown file
    default = {
      dir_path = "assets",
      use_absolute_path = false,
    },
  },
  -- keys = {
  --   { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  -- },
}
