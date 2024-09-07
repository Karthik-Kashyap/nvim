local M = {}

M.ui = {
  theme = "aquarium", -- or whatever theme you're using
  hl_override = require "custom.highlights".override,
}
M.nvimtree = {
    git = {
        enable = true,
    },
    renderer = {
        highlight_git = true,
        icons = {
        show = {
            git = true,
            },
        },
    },
    view = {
        side = "right",
    },
}
return M
