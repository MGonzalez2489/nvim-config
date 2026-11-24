local specs = vim.deepcopy(require("lazyvim.plugins.extras.lang.go"))

-- Go's debugger must not load as a dependency of JavaScript debugging.
for _, spec in ipairs(specs) do
  if spec[1] == "mfussenegger/nvim-dap" then
    for index, dependency in ipairs(spec.dependencies) do
      if dependency[1] == "leoluz/nvim-dap-go" then
        table.remove(spec.dependencies, index)
        dependency.ft = { "go", "gomod", "gowork", "gotmpl" }
        dependency.dependencies = { "mfussenegger/nvim-dap" }
        specs[#specs + 1] = dependency
        break
      end
    end
    break
  end
end

return specs
