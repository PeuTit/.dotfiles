return {
  {
    "folke/todo-comments.nvim",
    opts = {},
    keys = {
      { "<leader>sT", function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "NOTE" } })
      end,  desc = "Todo/Fix/Fixme/Note" },
    },
  },
  { 'numToStr/Comment.nvim', opts = {} },
}
