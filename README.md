# .spacemacs.d

## Emacs Requirerments 
```bash
sudo apt-get install build-essential texinfo-doc-nonfree install-info info libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses5-dev libxpm-dev automake autoconf libgnutls28-dev texinfo
```


## Layer config
```lisp
     csv
     javascript
     markdown
     python
     semantic
     auto-completion
     better-defaults
     emacs-lisp
     git
     helm

     lsp
     ;; markdown
     (multiple-cursors :variables multiple-cursors-backend 'mc)

     ;; (c-c++ :variables c-c++-backend 'rtags)
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
     ;; sonicpi
     treemacs
     (ranger :variables
             ranger-show-preview t)
     major-modes
```

## Shortcuts
```lisp
  (global-set-key (kbd "S-M-<left>")  'windmove-left)
  (global-set-key (kbd "S-M-<right>") 'windmove-right)
  (global-set-key (kbd "S-M-<up>")    'windmove-up)
  (global-set-key (kbd "S-M-<down>")  'windmove-down)

  ;; Multicursor
  (global-set-key (kbd "C-s-n") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-s-p") 'mc/mark-previous-like-this)

```
