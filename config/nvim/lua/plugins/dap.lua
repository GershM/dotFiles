return {
    -- Debugger
    { 'leoluz/nvim-dap-go' },
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "nvim-telescope/telescope-dap.nvim" },
    { 'theHamsta/nvim-dap-virtual-text' },
    { "mxsdev/nvim-dap-vscode-js" },
    { "jay-babu/mason-nvim-dap.nvim" },
    {
        "microsoft/vscode-js-debug",
        opt = true,
        build = "npm install --legacy-peer-deps && npm run compile",
        tag = 'v1.74.1'
    },
    { "lommix/godot.nvim"}
}
