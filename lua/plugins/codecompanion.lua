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
    },
    display = {
      chat = {
        window = {
          layout = "vertical",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
