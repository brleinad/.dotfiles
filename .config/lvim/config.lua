-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.format_on_save.enabled = true
lvim.colorscheme = "solarized"
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"
vim.cmd [[command! W w]]
vim.cmd [[command! Q q]]

lvim.builtin.dap.active = true


local mason_path = vim.fn.stdpath("data") .. "/mason/"
require("dap").adapters.node2 = {
  type = "executable",
  command = "node",
  args = { mason_path .. "packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

local function get_jest_test_name()
  local row = vim.fn.line(".") - 1
  local lines = vim.api.nvim_buf_get_lines(0, 0, row + 1, false)

  for i = row, 0, -1 do
    local line = lines[i + 1]
    local test_name = line:match('it%s*%(%s*["\'](.-)["\']')
        or line:match('test%s*%(%s*["\'](.-)["\']')
    if test_name then
      return test_name
    end
  end
  return nil
end


lvim.plugins = {
  {
    "ishan9299/nvim-solarized-lua",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[ colorscheme solarized ]]
    end
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "joerdav/templ.vim",
  },
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    build = "nvim -l build/init.lua",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
        "terraform",
      },
    },
  },
}

require 'colorizer'.setup()

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}


local lspconfig = require "lspconfig"
lspconfig.tsserver.setup {
  root_dir = lspconfig.util.root_pattern(".git"),
}

local dap = require("dap")

dap.defaults.fallback.external_terminal = {
  command = "/Applications/WezTerm.app/Contents/MacOS/wezterm",
  args = { "start", "--" },
}

dap.configurations.javascript = {
  {
    type = "node2",
    request = "launch",
    name = "Debug Current Vitest Test",
    -- skipFiles= ["<node_internals>/**", "**/node_modules/**"],
    program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
    args = function()
      local test_name = get_jest_test_name()
      local file = vim.fn.expand("%")
      return { file, "--test-name-pattern", test_name }
    end,
    -- args= ["run", "${relativeFile}"],
    smartStep = true,
  },
  {
    name = "Debug Current Jest Test",
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
    args = function()
      local test_name = get_jest_test_name()
      local file = vim.fn.expand("%")
      return { file, "--test-name-pattern", test_name }
    end,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    internalConsoleOptions = "neverOpen",
  },
  {
    name = "Debug Current Mocha Test",
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/node_modules/mocha/bin/mocha",
    args = function()
      local test_name = get_jest_test_name()
      local file = vim.fn.expand("%")
      return { file, "-g", test_name, "--runInBand" }
    end,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    internalConsoleOptions = "neverOpen",
  },
  {
    name = "Debug Current Node Test",
    type = "node2",
    request = "launch",
    program = "env node",
    args = function()
      local test_name = get_jest_test_name()
      local file = vim.fn.expand("%")
      return { "--test-name-pattern", test_name, "--test", file }
    end,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    internalConsoleOptions = "neverOpen",
  },
  {
    name = "Debug Jest Test (File)",
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
    args = {
      "${file}",
      "--runInBand",
    },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    internalConsoleOptions = "neverOpen",
  },
  {
    name = "Launch file",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
  },
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}
dap.configurations.typescript = dap.configurations.javascript

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "tailwindcss"
end, lvim.lsp.automatic_configuration.skipped_servers)

require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "package.json"),
})
