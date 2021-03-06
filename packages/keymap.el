;; Add prefix key

(define-prefix-command 'leader-map)
(define-prefix-command 'action-map)

(global-set-key (kbd "M-m") 'leader-map)
(global-set-key (kbd "M-RET") 'action-map)

;; Keymap

;; (global-set-key (kbd "M-RET c") 'comment-line)
(define-key action-map (kbd "c") 'comment-line)
(global-set-key (kbd "M-c") 'comment-line)
(global-set-key (kbd "M-q") 'comment-line)
;; Multi cursor
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-s-a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; shell
;;(global-set-key (kbd "M-RET t") 'multi-term-open-split-buffer)
(define-key leader-map (kbd "'") 'multi-term-dedicated-toggle)

;; Replace buffer list
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-s") 'helm-occur)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
;; (define-prefix-command "space-map"  "M-m")

;; ;; git
(define-key leader-map (kbd "g s") 'magit-status)
(define-key leader-map (kbd "g c") 'magit-clone)

;; Duplicate line
;; (global-set-key (kbd "M-RET d l") 'duplicate-line)
(define-key leader-map (kbd "l d") 'duplicate-line)

;; Move line
(global-set-key [(meta shift up)]  'move-line-up)
(global-set-key [(meta shift down)]  'move-line-down)

;; File Tree (Treenacs)
(define-key leader-map (kbd "f t") 'treemacs)

;; File Spell check (flyspell)
(define-key leader-map (kbd "f s") 'flyspell-correct-word-before-point)

;; Latex preview window
(define-key leader-map (kbd "p l") 'latex-preview-pane-mode)

;; Search
(define-key leader-map (kbd "S") 'helm-ag)

;; crux
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
(global-set-key (kbd "C-c o") #'crux-open-with)
(global-set-key [(shift return)] #'crux-smart-open-line)
(global-set-key (kbd "s-r") #'crux-recentf-find-file)
(global-set-key (kbd "C-<backspace>") #'crux-kill-line-backwards)
(global-set-key [remap kill-whole-line] #'crux-kill-whole-line)


;; Srefactor
(define-key leader-map "sr" 'srefactor-refactor-at-point)
(define-key leader-map "b" 'helm-projectile)

;;
(define-key leader-map "yi" 'yas-insert-snippet)

(define-key leader-map "P" 'projectile-command-map)

(global-set-key (kbd "M-o") 'ace-window)

;; Resize window
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
