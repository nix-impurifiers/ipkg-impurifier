# Native tooling

The VM fixture builds ipkg 0.99.163, preserved by OpenWrt's source mirror:
https://mirror2.openwrt.org/sources/ipkg-0.99.163.tar.gz

ipkg and its bundled BusyBox-derived libbb retain their upstream GPL-2.0-or-later
copyright and license notices. `nix/tools.nix` applies literal-format fixes for
modern compiler diagnostics to the GPL-covered native source, and chooses the
fixture's state directory at configure time. These modifications do not change
the upstream license. The native client is independent of the MIT emitter and
shared engine. Application licenses are also independent.
