# Testing

`nix flake check -L` checks emitter metadata and runs a QEMU VM with the real
archived ipkg 0.99.163 client. It checks net failure, offline recovery, protected
configuration on transport switches/upgrades, native batching, account/directory
ownership, services, native downgrade and upgrade admin intent, driver dependency
and refresh, foreign-root script suppression/helper guards, removal and GC.
Native removal purges configuration; the test verifies that ownership policy.
Nix and Python are preinstalled; this is not an embedded-device installer test.
Use ordinary native install for upgrades, force-reinstall for same-version
transport replacement, and force-defaults for noninteractive config prompts.

Additional native-payload VM coverage installs, executes, upgrades and removes
a producer-prepared static payload in a target root without `/nix`. A separate
bundled-client variant repeats the original lifecycle suite with actual static
Nix and an incompatible external candidate.
