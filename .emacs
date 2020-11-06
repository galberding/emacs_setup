;;(load-theme 'wombat)

;; General config
(setq frame-title-format "emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(column-number-mode)
(global-linum-mode 1)


;; (set-face-attribute 'region nil :background "gray20")

;; highlight line with the cursor, preserving the colours.
(global-hl-line-mode 1)

(winner-mode t)

(windmove-default-keybindings)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar package-path "~/emacs_setup/packages/")

(defun load-package (package-name)
  (load (concat package-path package-name))
  )


;; Setup Repo and packages ----------------------------------------------------------------------------------------------------

(require 'package)
(setq package-list '(use-package multiple-cursors helm-ag pdf-tools))
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

(use-package yasnippet
  :config
  (add-to-list 'load-path
               "~/.emacs.d/plugins/yasnippet")
  (yas-global-mode 1)
  :ensure t)

(use-package yasnippet-snippets
  :ensure t)

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "M-RET")
(setq lsp-signature-render-documentation nil)
(setq lsp-ui-doc-enable nil)

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
;; (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map [tab] 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))


(setq ccls-executable "~/emacs_setup/ccls/install/bin/ccls")
(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(load-package "treemacs.el")

(load-package "tools.el")

(load-package "keymap.el")


(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
(require 'rosemacs-config)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-clang-use-compile-flags-txt t)
 '(company-dabbrev-code-everywhere t)
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-minimum-length 3)
 '(company-dabbrev-time-limit 0.2)
 '(company-etags-everywhere nil)
 '(company-minimum-prefix-length 2)
 '(company-tooltip-idle-delay 0.3)
 '(electric-pair-mode t)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(cmake-mode crux latex-preview-pane preview-latex auctex yasnippet-snippets yasnippet jupyter ein spaceline spaceline-config hl-todo pdf-tools helm-ag multi-term company lsp-ui lsp-mode helm which-key treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil use-package treemacs auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:extend t :background "#44475a" :weight normal))))
 '(hl-todo ((t (:inherit hl-todo :italic t))))
 '(region ((t (:inherit match :extend t :background "SkyBlue4" :foreground "white smoke")))))
