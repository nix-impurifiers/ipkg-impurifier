# SPDX-License-Identifier: MIT
{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "ipkg";
  version = "0.99.163";
  src = pkgs.fetchurl {
    urls = [
      "https://people.osmocom.org/laforge/ipaccess-nano3G/GPL/ipkg-0.99.163.tar.gz"
      "https://mirror2.openwrt.org/sources/ipkg-0.99.163.tar.gz"
    ];
    curlOpts = "--connect-timeout 20";
    hash = "sha256-QFdD4boyDtYJXUKomPFIbjrx10XK4r1F3+HYQDpNiZU=";
  };
  nativeBuildInputs = [ pkgs.autoreconfHook ];
  env.NIX_CFLAGS_COMPILE = "-Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types -std=gnu99 -fcommon";
  postPatch = ''
    substituteInPlace libipkg.c --replace-fail 'printf(msg);' 'printf("%s", msg);' --replace-fail 'printf(question);' 'printf("%s", question);'
    substituteInPlace libbb/xfuncs.c --replace-fail 'error_msg_and_die(memory_exhausted);' 'error_msg_and_die("%s", memory_exhausted);'
    substituteInPlace libbb/unzip.c --replace-fail 'error_msg(memory_exhausted);' 'error_msg("%s", memory_exhausted);'
  '';
  configureFlags = [ "--with-ipkglibdir=/var/lib" ];
  postInstall = ''
    ln -s ipkg-cl $out/bin/ipkg
    install -Dm644 COPYING $out/share/licenses/ipkg/COPYING
  '';
  meta.license = pkgs.lib.licenses.gpl2Plus;
}
