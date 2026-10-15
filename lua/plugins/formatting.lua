return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    default_format_opts = {
      lsp_format = "never",
    },
    -- Map filetypes to formatters
    formatters_by_ft = {
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      pandoc = { "prettier" },
    },
    -- Format on save configuration
    -- format_on_save = {
    --   timeout_ms = 2000,
    --   lsp_fallback = true,
    formatters = {
      prettier = {
        condition = function()
          return true -- Always run Prettier, even if no .prettierrc exists
        end,
        prepend_args = { "--parser", "markdown" },
      },
    },
  },
  -- },
}
