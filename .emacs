;;(load-theme 'wombat)

;; General config
(setq frame-title-format "emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(column-number-mode)
(global-linum-mode 1)

;; (require 'git-gutter)
;; If you enable global minor mode
;; (global-git-gutter-mode Nil)
(projectile-mode +1)

;; LSP Settings
(setq read-process-output-max 3000000) ;; 3mb
(setq gc-cons-threshold 900000000) ;; 900mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil)
;; (Info-find-node "emacs" "Auto Save Control")
;; (use-package focus-autosave-mode
;;   :config (focus-autosave-mode 1))

;; (auto-save-visited-mode t)
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
;; (use-package dracula-theme
;;   :config
;;   (load-theme 'dracula t)
;;   :ensure t)

(load-theme 'tsdh-light t)

;; (use-package spacemacs-common
;;     :ensure spacemacs-theme
;;     :config (load-theme 'spacemacs-light t))

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

  :commands lsp
  )

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))  ; or lsp-deferred

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))
(setq lsp-dart-sdk-dir "/home/schorschi/snap/flutter/common/flutter/bin/cache/dart-sdk")
(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp))

;; Optional Flutter packages
(use-package hover :ensure t) ;; run app from desktop without emulator

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


;; (add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
;; ;; or whatever your install space is + "/share/emacs/site-lisp"
;; (require 'rosemacs-config)

;; Mode hooks:
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-flyspell)
;; (add-hook 'latex-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook #'turn-on-flyspell)


(when (require 'ansi-color nil t)
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun my/advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'my/advice-compilation-filter))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(auto-save-file-name-transforms '(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" "/tmp/\\2" nil)))
 '(auto-save-timeout 5)
 '(auto-save-visited-file-name t)
 '(auto-save-visited-mode t)
 '(company-clang-use-compile-flags-txt t)
 '(company-dabbrev-code-everywhere t)
 '(company-dabbrev-code-ignore-case t)
 '(company-dabbrev-minimum-length 3)
 '(company-dabbrev-time-limit 0.2)
 '(company-etags-everywhere nil)
 '(company-minimum-prefix-length 2)
 '(company-tooltip-idle-delay 0.3)
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" default))
 '(electric-pair-mode t)
 '(fci-rule-color "#BBBBBB")
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(helm-adaptive-mode t nil (helm-adaptive))
 '(helm-ag-fuzzy-match t)
 '(helm-ag-use-temp-buffer t)
 '(helm-follow-mode-persistent t)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(lsp-file-watch-ignored-directories
   '("[/\\\\]\\.git$" "[/\\\\]\\.hg$" "[/\\\\]\\.bzr$" "[/\\\\]_darcs$" "[/\\\\]\\.svn$" "[/\\\\]_FOSSIL_$" "[/\\\\]\\.idea$" "[/\\\\]\\.ensime_cache$" "[/\\\\]\\.eunit$" "[/\\\\]node_modules$" "[/\\\\]\\.fslckout$" "[/\\\\]\\.tox$" "[/\\\\]\\.stack-work$" "[/\\\\]\\.bloop$" "[/\\\\]\\.metals$" "[/\\\\]target$" "[/\\\\]\\.ccls-cache$" "[/\\\\]\\.deps$" "[/\\\\]build-aux$" "[/\\\\]autom4te.cache$" "[/\\\\]\\.reference$" "[/\\\\]gSearch$"))
 '(lsp-pyls-plugins-autopep8-enabled nil)
 '(lsp-pyls-plugins-yapf-enabled t)
 '(lsp-pylsp-plugins-yapf-enabled t)
 '(lsp-pyright-typechecking-mode "basic")
 '(lsp-pyright-venv-path "/home/schorschi/miniconda3/envs")
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(hover lsp-dart lsp-pyright lsp-python-ms xterm-color helm-projectile markdown-preview-mode git-gutter golden-ratio langtool spacemacs-theme solarized-theme hemisu-theme hemisu-light-theme espresso-theme leuven-theme anti-zenburn-theme flycheck flychecker plantuml-mode srefactor cmake-mode magit-todos crux latex-preview-pane preview-latex auctex yasnippet-snippets yasnippet jupyter ein spaceline spaceline-config hl-todo pdf-tools helm-ag multi-term company lsp-ui lsp-mode helm which-key treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil use-package treemacs auto-complete))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-todo ((t (:inherit hl-todo :italic t))))
 '(region ((t (:inherit match :extend t :background "SkyBlue4" :foreground "white smoke")))))
