-- Rust: rustaceanvim owns rust-analyzer. Never also enable `rust_analyzer` through vim.lsp/Mason,
-- or every buffer gets two clients with duplicated diagnostics.
-- https://github.com/mrcjkb/rustaceanvim

---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      local function map(lhs, rhs, desc, mode) vim.keymap.set(mode or 'n', lhs, rhs, { buffer = bufnr, desc = 'Rust: ' .. desc }) end
      map('K', function() vim.cmd.RustLsp { 'hover', 'actions' } end, 'Hover actions')
      map('gra', function() vim.cmd.RustLsp 'codeAction' end, 'Code action (grouped)', { 'n', 'x' })
      map('<leader>rr', function() vim.cmd.RustLsp 'runnables' end, '[R]unnables')
      map('<leader>rt', function() vim.cmd.RustLsp 'testables' end, '[T]estables')
      map('<leader>rd', function() vim.cmd.RustLsp 'debuggables' end, '[D]ebuggables')
      map('<leader>rm', function() vim.cmd.RustLsp 'expandMacro' end, 'Expand [M]acro')
      map('<leader>re', function() vim.cmd.RustLsp { 'explainError', 'current' } end, '[E]xplain error')
      map('<leader>rD', function() vim.cmd.RustLsp { 'renderDiagnostic', 'current' } end, 'Render [D]iagnostic')
      map('<leader>rc', function() vim.cmd.RustLsp 'openCargo' end, 'Open [C]argo.toml')
      map('<leader>rp', function() vim.cmd.RustLsp 'parentModule' end, '[P]arent module')
    end,
    default_settings = {
      ['rust-analyzer'] = {
        -- Own target dir (target/rust-analyzer): flycheck no longer blocks on, or invalidates,
        -- the build-dir lock held by `cargo build`/`cargo test` running in a terminal.
        cargo = { targetDir = true },
        check = { command = 'clippy' },
      },
    },
  },
}

vim.pack.add {
  { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range '9.*' },
  -- rustaceanvim picks up nvim-dap and codelldb/lldb-dap from $PATH for `:RustLsp debuggables`.
  'https://github.com/mfussenegger/nvim-dap',
  { src = 'https://github.com/saecki/crates.nvim', version = vim.version.range '0.*' },
}

-- Cargo.toml: versions, features and upgrades through an in-process LSP, so blink.cmp and the
-- regular `K`/`gra` mappings work without extra completion sources.
require('crates').setup {
  lsp = { enabled = true, actions = true, completion = true, hover = true },
}

local dap = require 'dap'
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step out' })

require('which-key').add { { '<leader>r', group = '[R]ust' } }
