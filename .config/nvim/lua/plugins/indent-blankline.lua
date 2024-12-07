return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "▏",
			priority = 2,
			repeat_linebreak = false,
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
			show_exact_scope = true,
			injected_languages = false,
			priority = 500,
		},
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
			},
		},
	},
}
