-- Allows display of word count in md/text files
local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

-- When you search for a string, this lets you display the number of matches. From: https://github.com/kristijanhusak/neovim-config/blob/master/nvim/lua/partials/statusline.lua#L154-L164
function searchResult()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 0 })
  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

-- local lineNum = vim.api.nvim_win_get_cursor(0)[1]
local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
  local val = vim.api.nvim_win_get_cursor(0)[2]
  -- pad value to 3 units to stop geometry shift
  return string.format("%03d", val)
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- get colors from Nightfox to use in the words count
-- local nfColors = require("nightfox.colors").init("nordfox")

-- print(vim.inspect(nfColors))
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(res)
        return res:sub(1, 1)
      end,
    } },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source, color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      function()
        return "%="
      end,
      { "filename", path = 1, shorting_target = 40 },
      {
        getWords,
        -- color = { fg = nfColors["bg_alt"] or "#333333", bg = nfColors["fg"] or "#eeeeee" },
        color = { fg = "#333333", bg = "#eeeeee" },
        separator = { left = "", right = "" },
      },
      { searchResult },
    },
    lualine_x = { { "filetype", icon_only = true } },
    lualine_y = { { require("auto-session-library").current_session_name } },
    lualine_z = {
      { getColumn, padding = { left = 1, right = 0 } },
      { getLines, icon = "", padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      { "diff", source = diff_source, color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      function()
        return "%="
      end,
      { "filename", path = 1, shorting_target = 40 },
    },
    lualine_x = { { getLines, icon = "", padding = 1 } },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})
