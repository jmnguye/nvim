require("telescope").setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			-- ces raccourcis fonctionne en mode insert
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
				["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
				["<C-q>"] = require("telescope.actions").smart_send_to_qflist
					+ require("telescope.actions").open_qflist, -- send selected to quickfixlist
			},
		},
	},
})

require("telescope").load_extension("fzf")
