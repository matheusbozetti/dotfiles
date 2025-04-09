return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      defaults = {
        file_ignore_patterns = { 'node_modules/*', '.git/*', '.vscode/*', 'dist/*' },
        path_display = { 'truncate' },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = { prompt_position = 'top', preview_width = 0.6 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.8,
          preview_cutoff = 120,
        },
      },
    })

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set(
      'n',
      '<leader>fF',
      ':Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>',
      { desc = '[F]ind ALL [F]iles (Even Hidden)' }
    )
    vim.keymap.set(
      'n',
      '<leader>fd',
      ':Telescope find_files find_command=fd,--type,d<CR>',
      { desc = '[F]ind [D]irectory' }
    )
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    vim.keymap.set('v', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind in [G]it' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ft', builtin.diagnostics, { desc = '[F]ind Diagnos[t]ics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = '[C] Find Colorschemes' })
    vim.keymap.set('n', '<leader>fv', builtin.lsp_document_symbols, { desc = '[V] Find Variables (Symbols)' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = '[F]ind [/] in Open Files' })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[F]ind [N]eovim files' })
  end,
}
