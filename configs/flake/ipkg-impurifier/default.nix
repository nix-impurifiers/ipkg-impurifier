# SPDX-License-Identifier: MIT
{ ... }:
{ lib, inputs, ... }:
{
  flake.lib = lib.mkForce {
    ipkg-impurifier =
      { pkgs }:
      import ../../../nix {
        inherit pkgs;
        coreSrc = inputs.impurifier;
        sourceInfo = inputs.self;
      };
  };
  perSystem =
    { pkgs, ... }:
    let
      impurifier = import ../../../nix {
        inherit pkgs;
        coreSrc = inputs.impurifier;
        sourceInfo = inputs.self;
      };
    in
    {
      packages = {
        native-ipkg = import ../../../nix/tools.nix { inherit pkgs; };
        default = impurifier.engine;
        engine = impurifier.engine;
        runtime-ipk = impurifier.runtimeIpk;
        hello-net-ipk = impurifier.makeNetIpk { pkg = pkgs.hello; };
        hello-offline-ipk = impurifier.makeOfflineIpk { pkg = pkgs.hello; };
      };
      formatter = pkgs.nixfmt-tree;
      checks = import ../../../tests {
        inherit pkgs impurifier;
        coreSrc = inputs.impurifier;
      };
    };
}
