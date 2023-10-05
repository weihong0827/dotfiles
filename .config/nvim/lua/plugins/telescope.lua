return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep({})
      end,
      desc = "Find Word",
    },
  },
}
