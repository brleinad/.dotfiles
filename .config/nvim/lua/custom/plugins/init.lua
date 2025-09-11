-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Load custom keybindings
require 'custom.keymaps'

return {
  'f-person/git-blame.nvim',
  opts = {
    -- your configuration comes here
    -- for example
    enabled = false, -- if you want to enable the plugin
    message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
    date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
    virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
  },
}
