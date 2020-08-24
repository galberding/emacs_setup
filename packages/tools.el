;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))


;; optional if you want which-key integration
(use-package which-key
  :ensure t
    :config
    (which-key-mode))


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

