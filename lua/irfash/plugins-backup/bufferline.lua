local map = vim.api.nvim_set_keymap
local bufferline = require 'bufferline'



local diagnostics_signs = {
    ['error'] = '',
    warning = '',
    default = '',
}

bufferline.setup {
    options = {
        always_show_bufferline = false,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = ' '
            for e, n in pairs(diagnostics_dict) do
                local sym = diagnostics_signs[e] or diagnostics_signs.default
                s = s .. (#s > 1 and ' ' or '') .. sym .. ' ' .. n
            end
            return s
        end,
        --        separator_style = 'slant',
    },
}

local opts = { silent = true, nowait = true, noremap = true }
map('n', 'gb', '<cmd>BufferLinePick<cr>', opts)
map('n', '<leader>d', '<cmd>bdelete!<cr>', opts)
