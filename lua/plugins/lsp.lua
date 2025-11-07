return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    -- make sure mason installs the server
    servers = {
      html = {

        root_dir = function(bufnr, on_dir)
          if vim.fs.root(bufnr, { "angular.json" }) == nil then
            -- Lógica para root_dir de html genérico si no hay angular.json
            local root = require("lspconfig.util").root_pattern(".git", "package.json")(bufnr)
            return root and on_dir(root)
          end
          return nil -- No inicia el servidor si se encuentra angular.json
        end,
      },

      --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
      --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
      tsserver = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
      vtsls = {
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
        keys = {
          {
            "gD",
            function()
              local win = vim.api.nvim_get_current_win()
              local params = vim.lsp.util.make_position_params(win, "utf-16")
              LazyVim.lsp.execute({
                command = "typescript.goToSourceDefinition",
                arguments = { params.textDocument.uri, params.position },
                open = true,
              })
            end,
            desc = "Goto Source Definition",
          },
          {
            "gR",
            function()
              LazyVim.lsp.execute({
                command = "typescript.findAllFileReferences",
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              })
            end,
            desc = "File References",
          },
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
          {
            "<leader>cM",
            LazyVim.lsp.action["source.addMissingImports.ts"],
            desc = "Add missing imports",
          },
          {
            "<leader>cu",
            LazyVim.lsp.action["source.removeUnused.ts"],
            desc = "Remove unused imports",
          },
          {
            "<leader>cD",
            LazyVim.lsp.action["source.fixAll.ts"],
            desc = "Fix all diagnostics",
          },
          {
            "<leader>cV",
            function()
              LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
            end,
            desc = "Select TS workspace version",
          },
        },
      },
      angularls = {},
      tailwindcss = {},
      cssls = {},
      yamlls = {},
    },
    setup = {
      --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
      --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
      tsserver = function()
        -- disable tsserver
        return true
      end,
      ts_ls = function()
        -- disable tsserver
        return true
      end,
      vtsls = function(_, opts)
        if vim.lsp.config.denols and vim.lsp.config.vtsls then
          ---@param server string
          local resolve = function(server)
            local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
            vim.lsp.config(server, {
              root_dir = function(bufnr, on_dir)
                local is_deno = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) ~= nil
                if is_deno == (server == "denols") then
                  if root_dir then
                    return root_dir(bufnr, on_dir)
                  elseif type(markers) == "table" then
                    local root = vim.fs.root(bufnr, markers)
                    return root and on_dir(root)
                  end
                end
              end,
            })
          end
          resolve("denols")
          resolve("vtsls")
        end

        Snacks.util.lsp.on({ name = "vtsls" }, function(buffer, client)
          client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
            ---@type string, string, lsp.Range
            local action, uri, range = unpack(command.arguments)

            local function move(newf)
              client:request("workspace/executeCommand", {
                command = command.command,
                arguments = { action, uri, range, newf },
              })
            end

            local fname = vim.uri_to_fname(uri)
            client:request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = {
                "getMoveToRefactoringFileSuggestions",
                {
                  file = fname,
                  startLine = range.start.line + 1,
                  startOffset = range.start.character + 1,
                  endLine = range["end"].line + 1,
                  endOffset = range["end"].character + 1,
                },
              },
            }, function(_, result)
              ---@type string[]
              local files = result.body.files
              table.insert(files, 1, "Enter new path...")
              vim.ui.select(files, {
                prompt = "Select move destination:",
                format_item = function(f)
                  return vim.fn.fnamemodify(f, ":~:.")
                end,
              }, function(f)
                if f and f:find("^Enter new path") then
                  vim.ui.input({
                    prompt = "Enter move destination:",
                    default = vim.fn.fnamemodify(fname, ":h") .. "/",
                    completion = "file",
                  }, function(newf)
                    return newf and move(newf)
                  end)
                elseif f then
                  move(f)
                end
              end)
            end)
          end
        end)

        Snacks.util.lsp.on({ name = "angularls" }, function(_, client)
          --HACK: disable angular renaming capability due to duplicate rename popping up
          client.server_capabilities.renameProvider = false
        end)

        -- copy typescript settings to javascript
        opts.settings.javascript =
          vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
      end,
      angularls = function(_, opts)
        opts.root_dir = require("lspconfig.util").root_pattern("angular.json")
        opts.filetypes = { "typescript", "javascript", "html", "json" }
        require("lspconfig").angularls.setup({ server = opts })

        -- Snacks.util.lsp.on({ name = "angularls" }, function(_, client)
        --   --HACK: disable angular renaming capability due to duplicate rename popping up
        --   client.server_capabilities.renameProvider = false
        -- end)
      end,
    },
  },
}
