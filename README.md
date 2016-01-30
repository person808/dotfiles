# My dotfiles

## Install

Requires [GNU stow](http://www.gnu.org/software/stow/)

Run this:

```sh
git clone https://github.com/person808/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow <topic-folder>
```

This will use `stow` to symlink files to the appropriate directory.  Everything
is configured and tweaked within `~/.dotfiles`.

## Files

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to `$fish_user_paths` and be made
  available everywhere.

- **arch/**: Arch Linux specific PKGBUILDS.
