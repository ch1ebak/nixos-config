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
      gh
      git
      harper
      jq
      jq-lsp
      lua-language-server
      nixd
      nixfmt
      shellcheck
      stylua
      tailwindcss-language-server
    ];
  };

}
