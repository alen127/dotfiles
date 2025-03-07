return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		-- make sure to load after mason somehow!
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"php-debug-adapter",
			},
		})
		local dap = require("dap")
		local dapui = require("dapui")
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		-- Connect dap with dap-ui
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- php debugging, make sure xdebug is installed and configured properly according to vscode-php-debug
		dap.adapters.php = {
			type = "executable",
			command = "/home/alen/.local/share/nvim/mason/bin/php-debug-adapter",
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
			},
		}

		-- dap keybinds
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		vim.keymap.set("n", "<Leader>dC", dap.run_to_cursor, {})
		vim.keymap.set("n", "<Leader>dT", dap.terminate, {})
		-- inspect under cursor
		vim.keymap.set("n", "<Leader>d?", function()
			require("dapui").eval(nil, { enter = true })
		end)
		-- dap-ui keybinds
		vim.keymap.set("n", "<Leader>dU", dapui.toggle, {})
	end,
}
