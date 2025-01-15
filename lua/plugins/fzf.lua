return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      return {
        fzf_opts = {
          ["--layout"] = "default",
        },
      }
    end,
    keys = {
      { "<C-p>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
  },
}
