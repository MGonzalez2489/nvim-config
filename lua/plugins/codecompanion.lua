return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  opts = {
    language = "Spanish",
    adapters = {
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "gemini-api-key", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
            },
            env = {
              GEMINI_API_KEY = "GEMINI_API_KEY",
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        roles = {
          user = "Manuel",
        },
        adapter = {
          name = "gemini",
          model = "gemini-2.5-flash",
        },
      },
      inline = {
        adapter = {
          name = "gemini",
          model = "gemini-2.5-flash",
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
          width = 0.4,
        },
      },
    },

    strategies = {
      chat = {
        adapter = {
          name = "gemini",
          model = "gemini-2.5-flash",
        },
        -- adapter = "gemini",
        roles = { user = "Manuel" },
        slash_commands = {
          ["buffer"] = { opts = { contains_code = true } },
          ["file"] = { opts = { contains_code = true } },
          ["project"] = {
            callback = function(chat)
              -- Esto le pasa tu archivo de reglas automáticamente al chat
              return "/read AI.md"
            end,
            description = "Cargar reglas del proyecto",
          },
        },
      },
      inline = { adapter = "gemini" },
      agent = { adapter = "gemini", enabled = true }, -- ¡Habilita el modo agente!
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
