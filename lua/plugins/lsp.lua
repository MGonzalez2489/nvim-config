return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "typescript-language-server",
        "angular-language-server",
        "some-sass-language-server",
        -- "json-lsp",
        "html-lsp",
        -- "prettier",
      })
    end,
  },
}
