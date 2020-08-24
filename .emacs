;;(load-theme 'wombat)

;; General config
(setq frame-title-format "emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))


(column-number-mode)
(global-linum-mode 1)
(show-paren-mode 1)


;; highlight line with the cursor, preserving the colours.
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray20")

(winner-mode t)

(windmove-default-keybindings)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar package-path "~/Projects/emacs_setup/packages/")

(defun load-package (package-name)
  (load (concat package-path package-name))
  )


;; Setup Repo and packages ----------------------------------------------------------------------------------------------------

(require 'package)
(setq package-list '(use-package multiple-cursors helm-ag))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;----------------------------------------------------------------------------------------------------


;; Themes
(use-package dracula-theme
  :config
  (load-theme 'dracula t)
  :ensure t)


;; Helm Config
(use-package helm
  :ensure t) 
(require 'helm-config)
(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t)
(helm-mode 1)


;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "M-RET")

(use-package lsp-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :ensure t :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(load-package "treemacs.el")

(load-package "tools.el")

(load-package "keymap.el")

;; Highlight todo
;; Add c++ lsp
;; bookmarks
;; search in files (ag)
;; buttom row infos
;; move lines up and down
;; remove white space on save
;; spell checking
;; closing brackets
;; outsource modules/packages for better structured config
