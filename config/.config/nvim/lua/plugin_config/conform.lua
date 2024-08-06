local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		go = { "gofumpt" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>P", function()
	conform.format({
		lsp_fallback = true,
		async = false,
	})
end, { desc = "Format file or range (in visual mode)" })
