-- Terraform: LSP (terraformls) + tflint are configured in init.lua.
-- Adds the hashivim helper commands and treats *.tfvars/*.tf as terraform.
return {
  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'tf', 'hcl' },
    init = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 0 -- conform.nvim handles fmt
    end,
  },
}
