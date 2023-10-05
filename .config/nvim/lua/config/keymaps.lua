-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
map("n", "<leader>o", "<cmd>Neotree<CR>", { desc = "Focus Neo Tree", remap = true })
map("n", "-", "<c-w>s", { desc = "split window below", remap = true })
map("n", "|", "<c-w>v", { desc = "split window right", remap = true })

-- chatgpt
map("v", "<leader>ci", function()
  require("chatgpt").edit_with_instructions()
end, { desc = "Edit With Instuctions" })

map("v", "<leader>crt", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
map("v", "<leader>cro", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
map("v", "<leader>cre", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
map("v", "<leader>crf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
map("v", "<leader>crr", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })

map("n", "<leader>ca", "<cmd>ChatGPTActAs<CR>")
map("n", "<leader>cc", "<cmd>ChatGPT<CR>")

-- move the selected line up and down using j and k keymap
--

map("v", "<leader>/", "gc")

-- horizontal terminal
map("n", "<leader>h", "<cmd>split term://zsh<CR>", { desc = "Horizontal Terminal" })
