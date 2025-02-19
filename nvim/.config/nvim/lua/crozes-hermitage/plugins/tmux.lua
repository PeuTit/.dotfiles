local map = require('crozes-hermitage.utils').map

return {
  {
    'numToStr/navigator.nvim',
    config = function()
      ---@diagnostic disable-next-line: missing-parameter
      require('Navigator').setup()

      map({ 'n', 't' }, '<A-h>', '<Cmd>NavigatorLeft<CR>')
      map({ 'n', 't' }, '<A-l>', '<Cmd>NavigatorRight<CR>')
      map({ 'n', 't' }, '<A-k>', '<Cmd>NavigatorUp<CR>')
      map({ 'n', 't' }, '<A-j>', '<Cmd>NavigatorDown<CR>')
      map({ 'n', 't' }, '<A-space>', '<Cmd>NavigatorPrevious<CR>')
    end
  },
}
