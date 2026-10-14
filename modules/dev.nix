{
  config,
  lib,
  pkgs,
  ...
}:

{

  environment = {
    systemPackages = with pkgs; [
      astyle
      bash-language-server
      beautysh
      ccls
      gcc
      libgcc
      harper
      jq
      jq-lsp
      lua-language-server
      nixd
      nixfmt
      shellcheck
      stylua
      tailwindcss-language-server
      tree-sitter
    ];
  };

}
