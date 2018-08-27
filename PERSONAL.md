# Personal nixpkgs

This is my personal branch of the nixpkgs repository.
It should not be merged into the canonical repository.

## Usage

### Regular

The end result of
```
cd $(mktemp -d) &&
   git init &&
   git remote add origin https://github.com/nextmoose/nixpkgs.git &&
   git fetch origin master &&
   git checkout origin/master &&
   nix build -A launch-development-environment &&
   ./result/bin/launch-development-environment &&
```
should be an error because you did not specify any of the required
switches for the script.

```
nix-env -i $(readlink result)
```