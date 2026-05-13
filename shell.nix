{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    python311
    python311Packages.pip
    python311Packages.virtualenv
    
    stdenv.cc.cc.lib
    zlib
    glib
  ];

  shellHook = ''
    # Allow pip-installed binaries to find dynamically linked C libraries
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.glib
    ]}:$LD_LIBRARY_PATH
  '';
}