{
            description = "A fuzzy Tmux session manager with deleting, renaming and more!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        lib,
        ...
      }: {
        packages.default = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "sessionb";
          version = "dev";

          src = ./.;
          nativeBuildInputs = [pkgs.makeWrapper];

          postPatch = ''
            substituteInPlace sessionb.tmux \
              --replace "\$CURRENT_DIR/scripts/sessionb.sh" "$out/share/tmux-plugins/sessionb/scripts/sessionb.sh"
            substituteInPlace scripts/sessionb.sh \
              --replace "/tmux-sessionb/scripts/reload_sessions.sh" "$out/share/tmux-plugins/sessionb/scripts/reload_sessions.sh"
          '';

          postInstall = ''
            chmod +x $target/scripts/sessionb.sh
            wrapProgram $target/scripts/sessionb.sh \
              --prefix PATH : ${with pkgs; lib.makeBinPath [zoxide fzf gnugrep gnused coreutils]}
            chmod +x $target/scripts/reload_sessions.sh
            wrapProgram $target/scripts/reload_sessions.sh \
              --prefix PATH : ${with pkgs; lib.makeBinPath [coreutils gnugrep gnused]}
          '';

          meta = with lib; {
  description = "A fuzzy Tmux session manager with deleting, renaming and more!";
            homepage = "https://github.com/omerxx/tmux-sessionb";
            platforms = platforms.all;
          };
        };
      };
    };
}
