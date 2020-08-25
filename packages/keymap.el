;; Keymap

(global-set-key (kbd "M-RET c") 'comment-line)


;; Multi cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; shell
(global-set-key (kbd "M-RET t") 'multi-term-open-split-buffer)


;; Replace buffer list
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-prefix-command "space-map"  "M-m")

;; git
(global-set-key (kbd "M-m g s") 'magit-status)
(global-set-key (kbd "M-m g c") 'magit-clone)
