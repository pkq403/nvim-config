return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    require('nvim-treesitter-textobjects').setup({})

    local function jump_to_opposite_tag()
      local node = vim.treesitter.get_node()
      while node do
        local t = node:type()
        if t == 'element' or t == 'script_element' or t == 'style_element'
            or t == 'jsx_element' or t == 'jsx_fragment' then
          local sr, sc, er, ec = node:range()
          local cur = vim.api.nvim_win_get_cursor(0)
          local cur_r, cur_c = cur[1] - 1, cur[2]
          if cur_r == sr and cur_c == sc then
            vim.api.nvim.win_set_cursor(0, { er + 1, ec })
          else
            vim.api.nvim.win_set_cursor(0, { sr + 1, sc })
          end
          return
        end
        node = node:parent()
      end
    end

    local html_filetypes = { 'html', 'xml', 'jsx', 'tsx', 'svelte', 'vue', 'php' }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = html_filetypes,
      callback = function(args)
        vim.keymap.set('n', '%', jump_to_opposite_tag, {
          buffer = args.buf,
          desc = 'Jump to opposite tag (treesitter)',
        })
      end,
    })
  end,
}
