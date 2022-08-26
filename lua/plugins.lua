-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

function get_setup(name)
    return string.format('require("setup/%s")', name)
end

return require("packer").startup({
    function(use)
        -- Packer can manage itself
        use({ "wbthomason/packer.nvim" })

        use ({
            'rmagatti/auto-session',
            config = function()
                require('auto-session').setup {
                    log_level = 'info',
                    auto_session_suppress_dirs = {'~/', '~/Projects'}
                }
            end
        })

        use({
            "nvim-lualine/lualine.nvim",
            config = get_setup("lualine"),
            event = "VimEnter",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        })

        use({ "Mofiqul/dracula.nvim" })
        use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })

    if packer_bootstrap then
        require("packer").sync()
    end
end,
config = {
    display = {
        open_fn = require("packer.util").float,
    },
    profile = {
        enable = true,
        threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
},
})
