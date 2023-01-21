#+TITLE: The Aura Package Manager
#+AUTHOR: Colin

| Build                                                      | Release                                   | Chat                                               | Downloads                                                       | Languages                                         |
|------------------------------------------------------------+-------------------------------------------+----------------------------------------------------+-----------------------------------------------------------------+---------------------------------------------------|
| [[https://github.com/fosskers/aura/workflows/Tests/badge.svg]] | [[http://hackage.haskell.org/package/aura][https://img.shields.io/hackage/v/aura.svg]] | [[https://gitter.im/aurapm/aura][https://img.shields.io/gitter/room/aurapm/aura.svg]] | [[https://img.shields.io/github/downloads/fosskers/aura/total.svg]] | :uk: :jp: :croatia: :sweden: :de: :es: :portugal: :fr: :ru: :it: :serbia: :norway: :indonesia: :cn: |

Welcome to the main repository for Aura, a secure, multilingual package manager
for Arch Linux.

* Table of Contents                                       :TOC_4_gh:noexport:
- [[#aura][Aura]]
  - [[#what-is-aura][What is Aura?]]
  - [[#the-aura-philosophy][The Aura Philosophy]]
    - [[#aura-is-pacman][Aura is Pacman]]
    - [[#arch-is-arch---aur-is-aur][Arch is Arch - AUR is AUR]]
    - [[#all-together][All Together]]
    - [[#quiet-building][Quiet Building]]
    - [[#run-as-root-build-as-a-user][Run as Root, Build as a User]]
    - [[#know-your-system][Know your System]]
    - [[#downgradibility][Downgradibility]]
    - [[#no-orphans][No Orphans]]
    - [[#arch-linux-for-everyone][Arch Linux for Everyone]]
    - [[#haskell][Haskell]]
  - [[#installation][Installation]]
    - [[#prebuilt-binaries][Prebuilt Binaries]]
    - [[#building-from-source][Building from Source]]
  - [[#sample-usage][Sample Usage]]
    - [[#installing-packages][Installing Packages]]
    - [[#package-set-snapshots][Package Set Snapshots]]
    - [[#downgrading-via-the-package-cache][Downgrading via the Package Cache]]
    - [[#searching-the-pacman-log][Searching the Pacman Log]]
    - [[#managing-orphan-packages][Managing Orphan Packages]]
  - [[#localisation][Localisation]]
- [[#the-aur-haskell-library][The ~aur~ Haskell Library]]
- [[#the-aur-security-tool][The ~aur-security~ Tool]]

* Aura

** What is Aura?

Aura is a package manager for Arch Linux. It's main purpose is as an /AUR
helper/, in that it automates the process of installating packages from the Arch
User Repositories. It is, however, capable of much more.

** The Aura Philosophy

*** Aura is Pacman

Aura doesn't just mimic ~pacman~... it /is/ ~pacman~. All ~pacman~ operations
and their sub-options are allowed. Some even hold special meaning in Aura as
well.

*** Arch is Arch - AUR is AUR

~-S~ yields pacman packages and /only/ pacman packages. This agrees with the
above. Thus in Aura, the ~-A~ operation is introduced for obtaining AUR
packages. ~-A~ comes with sub-options you're used to (~-u~, ~-s~, ~-i~, etc.).

*** All Together

Dependencies and packages are not built and installed one at a time. Install
order is as follows:

1. All pacman dependencies (all at once).
2. All AUR dependencies that don't depend on each other (all at once, in groups).
3. All "top level" AUR packages (all at once).

*** Quiet Building

By default ~makepkg~ output is suppressed. If you want the people behind you to
think you're a cool hacker, then this suppression can be disabled by using
~-x~ alongside ~-A~.

*** Run as Root, Build as a User

~makepkg~ gets very upset if you try to build a package as root. That said, a
built package can't be handed off to pacman and installed if you /don't/ run as
root. Other AUR helpers ignore this problem, but Aura does not. Even when run
with ~sudo~, packages are built with normal user privileges, then handed to
pacman and installed as root.

*** Know your System

Editing PKGBUILDs mid-build is not default behaviour. An Arch user should know
/exactly/ what they're putting into their system, thus research into prospective
packages should be done beforehand. However, for functionality's sake, the
option ~--hotedit~ used with ~-A~ will prompt the user for PKGBUILD editing.
Regardless, as a responsible user you must know what you are building.

*** Downgradibility

Built AUR package files are moved to the package cache. This allows for them to
be easily downgraded when problems arise. Other top AUR helper programs do not
do this. The option ~-B~ will save a package state, and ~-Br~ will restore a
state you select. ~-Au~ also automatically invokes a save, to help you roll back
from problematic updates.

*** No Orphans

Sometimes dependencies lose their /required/ status, but remain installed on
your system. Sometimes AUR package ~makedepends~ aren't required at all after
install. Packages like this just sit there, receiving upgrades for no reason.
Aura helps keep track of and remove packages like this.

*** Arch Linux for Everyone

English is well established as the world's Lingua Franca, and is also the
dominant language of computing and the internet. That said, it's natural that
some people are going to be more comfortable working in their native language.
From the beginning Aura has been built with multiple-language support in mind,
making it very easy to add new ones.

*** Haskell

Aura is written in Haskell, which means easy development and beautiful code.
Please feel free to use it as a simple Haskell reference. Aura code
demonstrates:

- Parser Combinators (~megaparsec~)
- CLI Flag Handling (~optparse-applicative~)
- Concurrency (~scheduler~)
- Shell Interaction (~typed-process~)
- Pretty Printing (~prettyprinter~)
- Logging (~rio~)

** Installation

*** Prebuilt Binaries

It is recommended to install the prebuilt binary of Aura:

#+begin_src bash
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U <the-package-file-that-makepkg-produces>
#+end_src

*** Building from Source

You will need the [[https://docs.haskellstack.org/en/stable/README/][Stack Tool]] for Haskell to compile Aura yourself. Then:

#+begin_src bash
git clone https://github.com/fosskers/aura.git
cd aura
stack install -- aura
#+end_src

This may take a while to initially build all of Aura's dependencies. Once
complete, your ~aura~ binary will be available in ~/home/YOU/.local/bin/~.

** Sample Usage

*** Installing Packages

| Command              | Function                                                                              |
|----------------------+---------------------------------------------------------------------------------------|
| ~aura -A <package>~  | Install an AUR package.                                                               |
| ~aura -Au~           | Upgrade all installed AUR packages.                                                   |
| ~aura -Akuax~        | Author's favourite (upgrades, removes makedeps, shows PKGBUILD diffs, shows progress) |
| ~aura -Ai <package>~ | Look up information on an AUR package.                                                |
| ~aura -As <regex>~   | Search the AUR via a regex.                                                           |
| ~aura -Ap <package>~ | Display a package's PKGBUILD.                                                         |

*** Package Set Snapshots

| Command        | Function                                                        |
|----------------+-----------------------------------------------------------------|
| ~aura -B~      | Store a JSON record of all installed packages.                  |
| ~aura -Br~     | Restore a saved record. Rolls back and uninstalls as necessary. |
| ~aura -Bc <n>~ | Delete all but the most recent ~n~ saved states.                |

*** Downgrading via the Package Cache

| Command             | Function                                                            |
|---------------------+---------------------------------------------------------------------|
| ~aura -C <package>~ | Downgrade a package.                                                |
| ~aura -Cs <regex>~  | Search the package cache for files that match a regex.              |
| ~aura -Cc <n>~      | Delete all but the most recent ~n~ versions of each cached package. |

*** Searching the Pacman Log

| Command              | Function                                         |
|----------------------+--------------------------------------------------|
| ~aura -L~            | View the Pacman log.                             |
| ~aura -Li <package>~ | View the install / upgrade history of a package. |
| ~aura -Ls <regex>~   | Search the Pacman log via a regex.               |

*** Managing Orphan Packages

Orphan packages are those whose install reason is marked as "As Dependency", but
are not actually depended upon by any installed package.

| Command                     | Function                                                     |
|-----------------------------+--------------------------------------------------------------|
| ~aura -O~                   | Display orphan packages.                                     |
| ~aura -O --adopt <package>~ | Change a package's install reason to ~Explicitly installed~. |
| ~aura -Oj~                  | Uninstall all orphan packages.                               |

** Localisation

As mentioned in the Philosophy above, adding new languages to Aura is quite
easy. If you speak a language other than those available and would like it added
to Aura, please consult [[./aura/LOCALISATION.md][LOCALISATION.md]].

Aura is currently translated by these generous people:

| Language   | Translators                                     |
|------------+-------------------------------------------------|
| Chinese    | Kai Zhang                                       |
| Croatian   | Denis Kasak and "stranac"                       |
| Esperanto  | Zachary "Ghosy" Matthews                        |
| French     | Ma Jiehong and Fabien Dubosson                  |
| German     | Lukas Niederbremer and Jonas Platte             |
| Indonesian | "pak tua Greg"                                  |
| Italian    | Bob Valantin and Cristian Tentella              |
| Japanese   | Colin Woodbury and Onoue Takuro                 |
| Norwegian  | "chinatsun"                                     |
| Polish     | Chris Warrick                                   |
| Portuguese | Henry Kupty, Thiago Perrotta, and Wagner Amaral |
| Russian    | Kyrylo Silin, Alexey Kotlyarov                  |
| Serbian    | Filip Brcic                                     |
| Spanish    | Alejandro Gómez and Sergio Conde                |
| Swedish    | Fredrik Haikarainen and Daniel Beecham          |

* The ~aur~ Haskell Library

A library for accessing the AUR, powered by [[https://haskell-servant.readthedocs.io/en/stable/][Servant]].

* The ~aur-security~ Tool

Performs a sweep of all PKGBUILDs on the [[https://aur.archlinux.org/][AUR]], looking for Bash misuse.
