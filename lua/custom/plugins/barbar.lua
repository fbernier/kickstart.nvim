-- https://github.com/romgrk/barbar.nvim

-- Must be set before the plugin's runtime files load, or barbar calls setup() with defaults first.
vim.g.barbar_auto_setup = false

vim.pack.add {
  -- Tracks master: the last tag (v1.9.1) predates the Neovim 0.13 BufModifiedSet removal and fails to load.
  'https://github.com/romgrk/barbar.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
}

-- File icons resolve through mini.icons' nvim-web-devicons mock (init.lua, section 4).
require('barbar').setup {
  clickable = true,
  icons = { filetype = { enabled = vim.g.have_nerd_font } },
}

local function map(lhs, cmd, desc) vim.keymap.set('n', lhs, '<Cmd>' .. cmd .. '<CR>', { silent = true, desc = desc }) end

map('<A-,>', 'BufferPrevious', 'Previous buffer')
map('<A-.>', 'BufferNext', 'Next buffer')
map('<A-<>', 'BufferMovePrevious', 'Move buffer left')
map('<A->>', 'BufferMoveNext', 'Move buffer right')
for i = 1, 9 do
  map('<A-' .. i .. '>', 'BufferGoto ' .. i, 'Go to buffer ' .. i)
end
map('<A-0>', 'BufferLast', 'Go to last buffer')
map('<A-p>', 'BufferPin', 'Pin/unpin buffer')
map('<A-c>', 'BufferClose', 'Close buffer')
map('<C-p>', 'BufferPick', 'Pick buffer')
map('<leader>bb', 'BufferOrderByBufferNumber', 'Order by [b]uffer number')
map('<leader>bd', 'BufferOrderByDirectory', 'Order by [d]irectory')
map('<leader>bl', 'BufferOrderByLanguage', 'Order by [l]anguage')
map('<leader>bw', 'BufferOrderByWindowNumber', 'Order by [w]indow number')

require('which-key').add { { '<leader>b', group = '[B]uffers' } }
