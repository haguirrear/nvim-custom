return {
  "/diepm/vim-rest-console",
  config = function()
    vim.g.vrc_set_default_mapping = 0
    vim.g.vrc_response_default_content_type = "application/json"
    vim.g.vrc_output_buffer_name = "_OUTPUT.json"
    vim.g.vrc_auto_format_response_enabled = 1
    vim.g.vrc_split_request_body = 1
    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq',
    }
    vim.keymap.set("n", "<leader>Rr", ":call VrcQuery()<CR>", { desc = "Run request under cursor" })
  end
}
