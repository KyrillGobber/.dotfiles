return {
    "github/copilot.vim",
    enabled = false,
    keys = {
        { "<C-L>", function() require("copilot").accept() end, desc = "toggle copilot panel" },
        { "<C-j>", function() require("copilot").next() end, desc = "toggle copilot panel" },
        { "<C-k>", function() require("copilot").prev() end, desc = "toggle copilot panel" },
    },
}
