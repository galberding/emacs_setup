(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed t)


(setq show-paren-delay 0)           ; how long to wait?
(show-paren-mode t)                 ; turn paren-mode on
(setq show-paren-style 'parenthesis) ; alternatives are 'parenthesis' and 'mixed'


(require 'paren)
(set-face-background 'show-paren-match
		     (face-background 'default))
(set-face-foreground 'show-paren-match "#42FF4E")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold :underline t)



;; Highlight keywords

(use-package hl-todo
       :ensure t
       :custom-face
       (hl-todo ((t (:inherit hl-todo :italic t))))
       :hook ((prog-mode . hl-todo-mode)
              (yaml-mode . hl-todo-mode)))

(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF")))

(use-package org
  :ensure t)

;; Remove Whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Move line
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))



;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; New mode line
(use-package spaceline
  :config
  (spaceline-emacs-theme)
  (spaceline-helm-mode)
  :ensure t)


;; optional if you want which-key integration
(use-package which-key
  :ensure t
    :config
    (which-key-mode))

;; Spellchecking in Comments
(use-package flyspell
  :config
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))


;; Terminal:
(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/bash"
	multi-term-dedicated-window-height 25
	multi-term-dedicated-max-window-height 50
	multi-term-dedicated-window t
	)

  )


(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun multi-term-open-split-buffer()
  (interactive)
  (split-and-follow-horizontally)
  (shrink-window (/ (window-height (next-window)) 2))
  (multi-term)
  )

;; PDF vierwer
(pdf-loader-install)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
