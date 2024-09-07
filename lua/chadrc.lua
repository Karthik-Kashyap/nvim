-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "nightowl",
  hl_override = {
    LineNr = { fg = "#FFFFFF" },
    TabLine = { fg = "#FFFFFF" },
    TabLineSel = { fg = "#FFFFFF" },
  },

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

return M
