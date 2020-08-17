# Spacemacs setup on Ubuntu

- [Spacemacs setup on Ubuntu](#spacemacs-setup-on-ubuntu)
  * [Emacs Requirerments](#emacs-requirerments)
  * [Build emacs27](#build-emacs27)
  * [Spacemacs setup](#spacemacs-setup)
    + [Quick Setup (TODO: Needs to be tested!)](#Quick-Setup)
    + [Spacemacs Setup](#Spacemacs-Setup)
  * [Layer config](#layer-config)
  * [Shortcuts](#shortcuts)
  * [LSP - Clangd setup](#lsp---clangd-setup)
    + [Compile clangd from sources](#compile-clangd-from-sources)
  * [LSP - Python](#lsp---python)
  * [Update Ubuntu and Spacemacs](#update-ubuntu-and-spacemacs)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Emacs Requirerments
```bash
sudo apt-get install build-essential texinfo-doc-nonfree install-info info libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses5-dev libxpm-dev automake autoconf libgnutls28-dev texinfo
```

## Build emacs27

```bash
./build_emacs27.sh
# Add emacs installation to path
echo "export PATH=$(pwd)/emacs/emacs-27/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```

## [Spacemacs](https://www.spacemacs.org/) setup

### Quick setup
* Use predefined configfile `.spacemacs` to setup layer config and shortcuts

```
./setup_spacemacs.sh
```
### Spacemacs setup

```
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd  ~/.emacs.d
git checkout develop # otherwise some packages below will not work
```

## Layer config

* Start Emacs
* Open the Configuration (`M-m f e d`)
* Insert/replace content of `dotspacemacs-configuration-layers'()`
* Reload configuration (`M-m f e R`)

```lisp
dotspacemacs-configuration-layers
   '(
     csv
     javascript
     markdown
     python
     semantic
     (auto-completion :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t)
     better-defaults
     emacs-lisp
     git
     helm

     lsp
     (multiple-cursors :variables multiple-cursors-backend 'mc)
     (c-c++ :variables c-c++-backend 'lsp-clangd
            c-c++-enable-clang-support t
            c-c++-enable-clang-format-on-save t
            )
     ;; (c-c++ :variables c-c++-backend 'lsp-ccls)
     ;; org
     (shell :variables
            shell-default-shell 'multi-term
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     treemacs
     (ranger :variables
             ranger-show-preview t)
     major-modes
)
```

## Shortcuts
```lisp
(defun dotspacemacs/user-config ()
  ;; Switching between windows
  (global-set-key (kbd "S-M-<left>")  'windmove-left)
  (global-set-key (kbd "S-M-<right>") 'windmove-right)
  (global-set-key (kbd "S-M-<up>")    'windmove-up)
  (global-set-key (kbd "S-M-<down>")  'windmove-down)

  ;; Multicursor mark next/previos
  (global-set-key (kbd "C-s-n") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-s-p") 'mc/mark-previous-like-this)
)

```

## LSP - Clangd setup
* [C/C++ Layer](https://develop.spacemacs.org/layers/+lang/c-c++/README.html)

```bash
sudo apt install bear # https://github.com/rizsotto/Bear
sudo apt install clangd
```

### Compile clangd from sources
* Dependencies: CMake >= 3.18
```bash
mkdir cmake && cd cmake
wget https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1-Linux-x86_64.sh
chmod +x cmake-3.18.1-Linux-x86_64.sh
cd bin
echo "export PATH=$(pwd):\$PATH" >> ~/.bashrc
source ~/.bashrc
```
* All other dependencies should be in place after building emacs
```bash
./build_clangd.sh
cd llvm-project/clangd/bin
echo "export PATH=$(pwd):\$PATH" >> ~/.bashrc
source ~/.bashrc
```

## LSP - Python
* Setup [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
```

* [Python Layer](https://develop.spacemacs.org/layers/+lang/python/README.html)
* Install LSP:
```bash
pip install python-language-server[all] importmagic epc pyls-isort pyls-mypy pyls-black
```
## Update Ubuntu and Spacemacs
* Add this script to `~/bin` for easy access
* Script will perform update, dist-upgrade and pull the latest changes of develop
```
./sysupdate
```
