-- https://github.com/mistricky/codesnap.nvim
-- The generator is a prebuilt native library, downloaded into the plugin's lua/libs on first load.

vim.pack.add { { src = 'https://github.com/mistricky/codesnap.nvim', version = 'v2.1.1' } }

require('codesnap').setup {}

vim.keymap.set('x', '<leader>cc', ':CodeSnap<CR>', { silent = true, desc = '[C]odeSnap: [c]opy to clipboard' })
-- Timestamped so saves don't overwrite each other; expanded here because the generator takes the path verbatim.
vim.keymap.set(
  'x',
  '<leader>cs',
  [[:<C-u>exe "'<,'>CodeSnapSave " . expand('~/Pictures/codesnap-') . strftime('%Y%m%d-%H%M%S') . '.png'<CR>]],
  { silent = true, desc = '[C]odeSnap: [s]ave PNG to ~/Pictures' }
)
vim.keymap.set('x', '<leader>ca', ':CodeSnapASCII<CR>', { silent = true, desc = '[C]odeSnap: [a]SCII to clipboard' })
vim.keymap.set('x', '<leader>ch', ':CodeSnapHighlight<CR>', { silent = true, desc = '[C]odeSnap: [h]ighlight to clipboard' })
