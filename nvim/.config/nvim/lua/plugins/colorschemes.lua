return {
  {
    "catppuccin/nvim",
    main = "catppuccin",
    opts = {
      integrations = {
        barbar = true,
        blink_cmp = true,
        diffview = true,
        fidget = true,
        mason = true,
        telescope = {
          style = "nvchad",
        },
        which_key = true,
      },
    },
  },
}
