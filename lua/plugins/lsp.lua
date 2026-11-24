local function nx_root(bufnr, on_dir)
  local root = vim.fs.root(bufnr, { "nx.json", "angular.json", "tsconfig.base.json" })
    or vim.fs.root(bufnr, { "package.json", ".git" })

  on_dir(root or vim.fn.getcwd())
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },

    servers = {
      -- Keep the TypeScript project at the Nx workspace root so references
      -- between apps and libs are resolved from the same tsserver instance.
      vtsls = {
        root_dir = nx_root,
        single_file_support = false,
      },
      angularls = {
        root_markers = { "nx.json", "angular.json" },
        single_file_support = false,
      },
    },

    setup = {
      angularls = function(_, opts)
        opts.on_attach = function(client, _)
          client.server_capabilities.documentRangeFormattingProvider = false
          client.server_capabilities.foldingRangeProvider = false
        end
      end,
    },
  },
}
