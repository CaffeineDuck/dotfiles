vim.api.nvim_create_user_command("GenerateSpell", function()
  vim.cmd("mkspell! " .. vim.fn.expand("%"))
end, {})
