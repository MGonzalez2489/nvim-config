local function nestjs_port()
  local port = tonumber(vim.fn.input("Enter port for NestJS: ", "9229"))
  if not port or port < 1 or port > 65535 or port % 1 ~= 0 then
    vim.notify("Invalid port number. Defaulting to 9229.", vim.log.levels.WARN)
    return 9229
  end
  return port
end

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "js-debug-adapter", "codelldb" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = false,
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      local utils = require("dap.utils")
      dap.set_log_level("DEBUG")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "::1",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process ID",
          processId = utils.pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Local NestJS (dynamic port)",
          address = "localhost",
          port = nestjs_port,
          cwd = "${workspaceFolder}",
          restart = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "ZTO - Dockerised NestJS (dynamic port)",
          address = "localhost",
          port = nestjs_port,
          localRoot = "${workspaceFolder}",
          remoteRoot = "/usr/src/app",
          restart = true,
        },
      }
      dap.configurations.typescript = {
        vim.deepcopy(dap.configurations.javascript[1]),
        vim.deepcopy(dap.configurations.javascript[2]),
        vim.deepcopy(dap.configurations.javascript[3]),
      }
    end,
  },
}
