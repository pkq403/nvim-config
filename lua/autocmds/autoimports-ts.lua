return vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('organise_imports', { clear = true }),
  pattern = '*.ts',
  callback = function()
    local diagnostics = vim.diagnostic.get(0)
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = {
          'source.addMissingImports.ts' --[[@as any]],
        },
        diagnostics = diagnostics,
      },
    }
    vim.lsp.buf.code_action {
      apply = true,
      context = { only = { 'source.organizeImports' }, diagnostics = diagnostics },
    }
  end,
})
