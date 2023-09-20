local lualine_icons = require('irfash.icons.lualine')

require("lualine").setup({
    options = {

        icons_enabled = true,
        always_divide_middle = true,
        globalstatus = true,
        theme = "auto", --theme, --"material",--"auto",
        component_separators = lualine_icons.component_separators,
        section_separators = lualine_icons.section_separators,
        disabled_filetypes = {},
    },
})
