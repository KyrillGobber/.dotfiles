return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
    { "<leader>fh", function() require("telescope.builtin").find_files({hidden = true}) end, desc = "Find Files (Incl. hidden)" },
    { "<leader>b", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>cs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document Symbols" },
    { "<leader>ac", function() require("telescope.builtin").diagnostics() end, desc = "Diagnostics" },
    { "<leader>r", function() require("telescope.builtin").registers() end, desc = "Registers" },
    { "<leader>ts", function() require("telescope.builtin").treesitter() end, desc = "Treesitter" },
    { "<leader>pl", function() require("telescope.builtin").builtin() end, desc = "Telescope Builtins" },
    { "<leader>gb", function() require("telescope.builtin").git_branches() end, desc = "Git Branches" },
    { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        }
      }
    })
    
    require("telescope").load_extension("ui-select")
  end
}
