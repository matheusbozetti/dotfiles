--- Function to chose color theme
--@param color string | '"rose-pine"' | '"catppuccin-mocha"' | '"tokyonight-night"'
--@return nil
function ColorMe(color)
  -- color = color or 'catppuccin-mocha'
  -- color = color or 'tokyonight-night'
  -- color = color or 'kanagawa'
  color = color or 'gruvbox-material'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end
