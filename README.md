# com-merlinnot

`com-merlinnot` is a blog sample written mostly in functional languages.

It features:

* Stack environment
* Cabal building system
* Test suite
* GHCi development
* Compiling for both tests and production
* Basic yesod framework features

#### How to install

```bash
git clone https://github.com/merlinnot/com-merlinnot.git
cd com-merlinnot/
stack install yesod-bin cabal-install --install-ghc
stack build
```
#### Quick Start Guide for developers

First you need to [install it (see previous section)](#how-to-install).

##### Start a development server:

```bash
stack exec -- yesod devel
```
Port defaults to 3000

##### And start modyfing files!


#### Workflow

This repository uses [git flow](https://github.com/nvie/gitflow)
