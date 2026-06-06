return {
  -- Install Gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
