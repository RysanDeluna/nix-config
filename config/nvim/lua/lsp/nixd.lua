-- Nix LSP
--

vim.lsp.config('nixd', {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", "git" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nisys.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.ni.options',
                },
            },
        }
    }
})
