return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.phpcbf,
				null_ls.builtins.diagnostics.phpcs.with({
					args = { "--standard=PSR12", "--ignore=MissingDocComment", "$FILENAME" },
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
