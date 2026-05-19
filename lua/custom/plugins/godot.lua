return {
  'Lommix/godot.nvim', -- Note: Case sensitivity matters for GitHub URLs
  lazy = true,
  cmd = { 'GodotRun', 'GodotDebug', 'GodotBreakAtCursor', 'GodotStep', 'GodotQuit', 'GodotContinue' },
  config = function()
    require('godot').setup {
      -- Path to your Godot executable
      bin = 'godot',

      -- DAP configuration
      dap = {
        host = '127.0.0.1',
        port = 6006,
      },

      -- GUI settings for console (passed to nvim_open_win)
      gui = {
        console_config = {
          anchor = 'SW',
          border = 'double',
          col = 1,
          height = 10,
          relative = 'editor',
          row = 99999,
          style = 'minimal',
          width = 99999,
        },
      },

      -- Expose user commands automatically
      expose_commands = true,
    }
  end,
}
