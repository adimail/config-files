return {
    "goolord/alpha-nvim",
    lazy = false,
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
      ____   ___  _   _  ____ _   _    _    _____ _
     / ___| / _ \| \ | |/ ___| | | |  / \  |  ___/ \
     \___ \| | | |  \| | |   | |_| | / _ \ | |_ / _ \
      ___) | |_| | |\  | |___|  _  |/ ___ \|  _/ ___ \
     |____/ \___/|_| \_|\____|_| |_/_/   \_\_|/_/   \_\

  _____ _______  _______   _____ ____ ___ _____ ___  ____
 |_   _| ____\ \/ /_   _| | ____|  _ \_ _|_   _/ _ \|  _ \
   | | |  _|  \  /  | |   |  _| | | | | |  | || | | | |_) |
   | | | |___ /  \  | |   | |___| |_| | |  | || |_| |  _ <
   |_| |_____/_/\_\ |_|   |_____|____/___| |_| \___/|_| \_\
]]

        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
            dashboard.button(
                "f",
                " " .. " Find file",
                ":lua require('core.telescopePickers').prettyFilesPicker({ picker = 'find_files' })<CR>"
            ),
            dashboard.button("n", "󰙴 " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button(
                "r",
                " " .. " Recent files",
                ":lua require('core.telescopePickers').prettyFilesPicker({ picker = 'oldfiles' })<CR>"
            ),
            dashboard.button(
                "g",
                " " .. " Find text",
                ":lua require('core.telescopePickers').prettyGrepPicker({ picker = 'live_grep' })<CR>"
            ),
            dashboard.button("e", " " .. " Explore", ":Neotree toggle<CR>"),
            dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }

        -- set highlight
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 10
        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local cwd = "  " .. vim.fn.getcwd()
                dashboard.section.footer.val = cwd
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
