local api = vim.api

local exclude_ft = { "help", "git", "markdown", "snippets", "text", "gitconfig"}--, "alpha" }
require("indent_blankline").setup {
  -- U+2502 may also be a good choice, it will be on the middle of cursor.
  -- U+250A is also a good choice

show_current_context = true,
    show_current_context_start = true,
  char = "▏",
  show_end_of_line = false,
  disable_with_nolist = true,
  buftype_exclude = { "terminal" },
  filetype_exclude = exclude_ft,
}


