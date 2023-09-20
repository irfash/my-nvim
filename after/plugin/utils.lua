--require('rose-pine').setup({
--disable_background = true
--})
--require('material').setup({
--disable_background = true
--})

--require("dracula").setup({
--    disable_background = true
--})

function ColorMyPencils(color)
color = color or "gruvbox"


--vim.cmd.colorscheme(color)
--require(color).setup({
--disable_background = true
--})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- ColorMyPencils()

