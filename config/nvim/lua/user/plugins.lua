local packer_bootstrap = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	use("folke/tokyonight.nvim")

	use("nvim-lualine/lualine.nvim")

	use({ "tidalcycles/vim-tidal", as = "tidal" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
