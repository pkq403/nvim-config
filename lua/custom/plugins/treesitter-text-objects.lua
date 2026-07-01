return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Ensure main treesitter is loaded
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    vim.g.no_plugin_maps = true
  end,
  config = function()
    -- Native-like repeatable moves using Treesitter queries
    local move = require 'nvim-treesitter-textobjects.move'

    -- Jump to NEXT HTML/XML Tag
    vim.keymap.set({ 'n', 'x', 'o' }, ']t', function()
      move.goto_next_start '@tag.outer'
    end, { desc = 'Next tag start' })

    -- Jump to PREVIOUS HTML/XML Tag
    vim.keymap.set({ 'n', 'x', 'o' }, '[t', function()
      move.goto_previous_start '@tag.outer'
    end, { desc = 'Previous tag start' })

    -- Optional: If you also want to jump to the actual end boundaries of a tag block
    vim.keymap.set({ 'n', 'x', 'o' }, ']T', function()
      move.goto_next_end '@tag.outer'
    end, { desc = 'Next tag end' })

    vim.keymap.set({ 'n', 'x', 'o' }, '[T', function()
      move.goto_previous_end '@tag.outer'
    end, { desc = 'Previous tag end' })
  end,
}
