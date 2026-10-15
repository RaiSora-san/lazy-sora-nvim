return {
  "folke/flash.nvim",
  keys = {
    -- unset flash's default 's' binding entirely
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },
  },
}
