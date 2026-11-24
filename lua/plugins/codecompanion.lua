return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {
    opts = {
      language = "Spanish",
    },
    interactions = {
      chat = {
        -- it setup the default model
        adapter = {
          name = "copilot_acp",
        },
        slash_commands = {
          ["buffer"] = { opts = { contains_code = true } },
          ["file"] = { opts = { contains_code = true } },
          ["project"] = {
            callback = function(chat)
              if not require("codecompanion.config").can_send_code() then
                return
              end
              local path = LazyVim.root() .. "/AI.md"
              if vim.fn.filereadable(path) == 0 then
                vim.notify("No se encontro AI.md en la raiz del proyecto", vim.log.levels.WARN)
                return
              end
              require("codecompanion.interactions.shared.rules.helpers").add_context({
                { path = path, content = table.concat(vim.fn.readfile(path), "\n") },
              }, chat)
            end,
            description = "Cargar reglas del proyecto",
            opts = { contains_code = true },
          },
        },
      },
      inline = {
        adapter = {
          name = "copilot",
          -- model = "gemini-2.5-flash",
        },
      },
    },

    display = {
      diff = {
        provider = "vertical",
      },
      chat = {
        window = {
          layout = "vertical",
          width = 0.45,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
