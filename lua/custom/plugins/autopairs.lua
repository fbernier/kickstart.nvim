-- https://github.com/windwp/nvim-autopairs
-- Function-call parens on completion accept come from blink.cmp's auto_brackets, not from here.

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }

local npairs = require 'nvim-autopairs'
npairs.setup {}
npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')
