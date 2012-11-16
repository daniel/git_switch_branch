# Git Switch Branch

This gem simplifies switching between git branches without losing uncommitted changes. Its meant as an alternative for "git checkout" and "git stash".

1. If the branch you are switching from contains uncommitted changes they will be automatically
saved to the folder ~/.git-switch-branch/REPO_NAME/BRANCH_NAME.

2. If the branch you are switching to contains saved changes they will be automatically restored.

3. It makes it easier to sync uncommitted changes between computers.

## Installation

Add this line to your application's Gemfile:

    gem 'git-switch-branch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-switch-branch

## Usage

Basic usage is just:

    $ gsb

This will give you a list of all branches to choose from.

    $ 1. master
    $ 2. 123-nasty-bug

If you know the name of the branch or part of the name you can do:

    $ gsb 123

## Syncing between computers

If you are using Dropbox you can easily sync your uncommitted changes between all your computers.

    mkdir -p ~/.git-switch-branch
    ln -s ~/.git-switch-branch ~/Dropbox/.git-switch-branch

## Known Bugs

* Empty files are not restored.

## Todo

* Make it possible to find and automatically track remote branches.
* Use the Git gem more (instead of the git shell command).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Supported platforms

git_switch_branch has been tested with:

* OS X Lion
* Ruby 1.8.7, 1.9.3
* Git 1.7.7, 1.7.8, 1.8.0
