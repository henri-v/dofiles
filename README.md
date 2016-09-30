# dotfiles
Configuration files

## Getting started
On Windows, run `initialize.cmd all`. On Unix, run
`path/to/dotfiles/initialize all` from your home directory.

## Updating
Most settings use files directly in this dotfiles repository. However, e.g.
git settings are configured directly using git commands. To reconfigure
certain settings, you can give just a single component, e.g.:

    > initialize.cmd git
    $ path/to/dotfiles/initialize git
