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

(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/Downloads/plantuml.jar"))

(setq plantuml-jar-path "~/Downloads/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

(use-package plantuml-mode
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

;; ;; PDF vierwer
;; (pdf-loader-install)
;; (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )


;; Latex packages
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  )


(use-package latex-preview-pane
  :ensure t
  :config
  (latex-preview-pane-enable)
  )


(use-package platformio-mode
  :ensure t)

;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))

(require 'doc-view)
(defcustom doc-view-pdfdraw-program
  (cond
   ((executable-find "pdfdraw") "pdfdraw")
   (t "mutool draw"))
  "Name of MuPDF's program to convert PDF files to PNG."
  )

;; (setq doc-view-pdfdraw-program "/homes/galberding/emacs_setup/pdfview/bin/mutool draw")
(unless (package-installed-p 'crux)
  (package-refresh-contents)
  (package-install 'crux))


;; Org mode
(use-package cdlatex
  :ensure t
  :config
  (setq cdlatex-env-alist
     '(("axiom" "\\begin{axiom}\nAUTOLABEL\n?\n\\end{axiom}\n" nil)
       ("theorem" "\\begin{theorem}\nAUTOLABEL\n?\n\\end{theorem}\n" nil)))
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)

  )

(use-package srefactor
  :ensure t)

(require 'srefactor)
(semantic-mode 1)
