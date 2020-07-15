# .spacemacs.d

## Layer config
```lisp
     python
     javascript
     auto-completion
     ;; openscad
     (spell-checking
                     )
     syntax-checking
     semantic
     better-defaults
     emacs-lisp
     git
     helm
     lsp
     markdown
     (conda :variables conda-anaconda-home "/homes/galberding/miniconda3")
     multiple-cursors
     ;; (c-c++ :variables c-c++-backend 'lsp-ccls)
     (c-c++ :variables
            c-c++-enable-clang-support t)
     org
     (shell :variables
             shell-default-height 30
             shell-default-position 'bottom)

     ;; version-control
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
