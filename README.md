# My dotfiles

## Install

Requires [GNU stow](http://www.gnu.org/software/stow/)

Run this:

```sh
git clone https://github.com/person808/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow *
```

This will use `stow` to symlink files to the appropriate directory.
Everything is configured and tweaked within `~/.dotfiles`.

## Topics

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there.

## Special files

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.

## Thanks

Inspired by [holman/dotfiles](https://github.com/holman/dotfiles) and this
[blog post](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
