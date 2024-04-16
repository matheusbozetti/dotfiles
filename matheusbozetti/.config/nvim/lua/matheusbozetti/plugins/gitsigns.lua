return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true,
    max_file_length = 10000, -- Disable if file is longer than this (in lines)
    signs = {
      add = { text = '' },
      change = { text = '' },
      delete = { text = '' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      ignore = { text = '◌' },
      rename = { text = '➜' },
      conflict = { text = '' },
      untracked = { text = '★' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      map('n', '<leader>gp', gs.preview_hunk_inline, { desc = 'Preview git hunk inline' })
      map('n', '<leader>gd', gs.diffthis, { desc = 'Diff hunk' })
      map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
      map('n', '<leader>gD', function()
        gs.diffthis('~')
      end, { desc = 'Toggle difference' })
      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
