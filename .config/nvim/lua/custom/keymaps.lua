-- Custom keybindings
-- Add your personal keybindings here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Example keybindings (uncomment and modify as needed):

-- Quick save
-- map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- Quick quit
-- map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

-- Toggle line numbers
-- map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'Toggle line numbers' })

-- Clear search highlights
-- map('n', '<leader>h', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Add your custom keybindings below this line

-- ============================================================================
-- NVIMTREE (File Explorer) Keybindings
-- ============================================================================
-- Toggle file explorer
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
map('n', '<leader>E', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus file explorer' })

-- ============================================================================
-- TELESCOPE Keybindings (Enhanced from LunarVim)
-- ============================================================================
-- File operations
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Find help' })
map('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', { desc = 'Find keymaps' })
map('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', { desc = 'Recent files' })

-- LSP operations
map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<CR>', { desc = 'LSP definitions' })
map('n', '<leader>lr', '<cmd>Telescope lsp_references<CR>', { desc = 'LSP references' })
map('n', '<leader>li', '<cmd>Telescope lsp_implementations<CR>', { desc = 'LSP implementations' })
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>', { desc = 'LSP document symbols' })
map('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<CR>', { desc = 'LSP workspace symbols' })

-- Quick access to telescope menu
map('n', '<leader>f', '<cmd>Telescope<CR>', { desc = 'Telescope menu' })

-- ============================================================================
-- LSP Keybindings (LunarVim style)
-- ============================================================================
-- Hover information
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover information' })

-- Go to definition/declaration
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Go to implementation' })

-- Signature help and diagnostics
map('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- Code actions and rename
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })

-- ============================================================================
-- EDITING Keybindings (LunarVim style)
-- ============================================================================
-- Move lines up/down
map('n', '<M-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<M-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<M-j>', '<cmd>m \'>+1<CR>gv=gv', { desc = 'Move selection down' })
map('v', '<M-k>', '<cmd>m \'<-2<CR>gv=gv', { desc = 'Move selection up' })

-- Comment toggling
map('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
map('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment' })
map('n', 'gb', '<cmd>lua require("Comment.api").toggle.blockwise.current()<CR>', { desc = 'Toggle block comment' })
map('v', 'gb', '<ESC><cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', { desc = 'Toggle block comment' })

-- Clear search highlights
map('n', '<leader>h', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Quick save and quit
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>q!<CR>', { desc = 'Force quit' })

-- Toggle line numbers
map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'Toggle line numbers' })
