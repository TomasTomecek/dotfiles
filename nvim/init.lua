-- Minimal neovim config; must work on both nvim 0.10 (CentOS Stream 10) and 0.11 (Fedora).
--
-- Syntax highlighting is neovim's builtin (regex syntax files, plus builtin
-- treesitter for lua/vim/help/markdown). Plugins that have started requiring
-- nvim 0.11 are pinned to their last 0.10-compatible version; before bumping
-- a pin, test on 0.10.

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Options ]]
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Plugins ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically
  'kien/ctrlp.vim',

  {
    'svrana/neosolarized.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    config = function()
      require('neosolarized').setup { comment_italics = true, background_set = false }
      vim.cmd.colorscheme 'neosolarized'
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    tag = 'v1.0.2', -- v2.x requires nvim 0.11
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'nvim-mini/mini.statusline',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = false }
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}, {
  ui = { icons = { cmd = 'cmd', config = 'cfg', event = 'event', ft = 'ft', init = 'init', keys = 'keys', plugin = 'plugin', runtime = 'rt', require = 'req', source = 'src', start = 'start', task = 'task', lazy = 'lazy ' } },
})
