-- Comment.nvim for toggling comments
return {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
    require('Comment').setup {
      -- Add any configuration options here if needed
      -- The plugin works out of the box with sensible defaults
    }
  end,
}
