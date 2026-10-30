-- Core W (Weir) syntax, filetype detection and buffer options, from the weir checkout.
vim.opt.runtimepath:append(vim.fn.expand '~/code/weir/editors/nvim')

-- `weir` on $PATH, else the checkout's release build (`cargo build --release` keeps it current).
local weir = vim.fn.executable 'weir' == 1 and 'weir' or vim.fn.expand '~/code/weir/target/release/weir'

-- `weir lsp` on `.w` and `.weir` buffers: diagnostics, hover, go-to-definition.
vim.lsp.config('weir', {
  cmd = { weir, 'lsp' },
  filetypes = { 'weir' },
  root_markers = { 'Cargo.toml', '.git' },
})
vim.lsp.enable 'weir'

-- `weir fmt` on save through conform's format_on_save (init.lua). Only `.weir` has a formatter;
-- `.w` (Core W) shares the filetype and gets none.
local conform = require 'conform'
conform.formatters.weir_fmt = {
  command = weir,
  -- `weir fmt` reads a path, not stdin: conform writes the buffer to a temp file beside it.
  args = { 'fmt', '--write', '$FILENAME' },
  stdin = false,
}
conform.formatters_by_ft.weir = function(bufnr)
  if vim.api.nvim_buf_get_name(bufnr):match '%.weir$' then
    return { 'weir_fmt' }
  end
  return {}
end
