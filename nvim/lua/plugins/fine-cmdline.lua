return {
    "VonHeikemen/fine-cmdline.nvim",
    requires = {
        { "MunifTanjim/nui.nvim" },
    },
    setup = function()
        vim.api.nvim_set_keymap("n", "<CR>", "<cmd>FineCmdline<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
    end,
    config = function()
        require("fine-cmdline").setup({
            cmdline = {
                enable_keymaps = true,
                smart_history = true,
                prompt = ": ",
            },
            popup = {
                position = {
                    row = "10%",
                    col = "50%",
                },
                size = {
                    width = "60%",
                },
                border = {
                    style = "rounded",
                },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },
            hooks = {
                set_keymaps = function(imap, feedkeys)
                    imap("<Esc>", require("fine-cmdline.fn").close)
                    imap("<C-c>", require("fine-cmdline.fn").close)
                    imap("<Up>", require("fine-cmdline.fn").up_search_history)
                    imap("<Down>", require("fine-cmdline.fn").down_search_history)
                end,
            },
        })
    end,
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
        { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").previous({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous trouble/quickfix item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next trouble/quickfix item",
        },
    },
}
