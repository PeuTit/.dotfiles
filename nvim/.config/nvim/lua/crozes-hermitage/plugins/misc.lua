return {
  {
    'hat0uma/csvview.nvim',
    config = function()
      local group = vim.api.nvim_create_augroup("CsvViewEvents", {})
      vim.api.nvim_create_autocmd("User", {
        pattern = "CsvViewAttach",
        group = group,
        callback = function()
          print("CsvView is attached")
        end,
      })
    end
  },
}
