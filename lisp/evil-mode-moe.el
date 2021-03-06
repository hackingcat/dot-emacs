
;;vim
;;evil
(evil-mode 1)

;;Evil-leader
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ff" 'helm-find-files
  "bb" 'helm-mini
  "bk" 'kill-buffer
  "bd" 'kill-this-buffer
  "bn" 'next-buffer
  "bp" 'previous-buffer
  "qr" 'restart-emacs
  "ci" 'evilnc-comment-or-uncomment-lines
  "fs" 'full-auto-save
  "qq" 'save-buffers-kill-emacs
  "sq" '  (lambda () (interactive) (save-some-buffers t) (kill-emacs))
  "<up>" 'windmove-up
  "<down>" 'windmove-down
  "<left>" 'windmove-left
  "<right>" 'windmove-right
  "wd" 'delete-window
  "ws" 'split-window-below
  "w2" 'split-window-horizontally
  "wv" 'split-window-horizontally
  "s/" 'helm-do-ag-this-file
  "ag" 'helm-ag
  "ss" 'helm-swoop
  "or" 'helm-org-rifle
  "fei" (lambda () (interactive) (find-file "~/.emacs.d/init.el"))
  "fec" (lambda () (interactive) (find-file "~/.emacs.d/Cask"))
  "<SPC>" 'helm-M-x
  "df" 'delete-file-and-buffer
  "hi" 'helm-imenu
  "rn" 'rename-file-and-buffer
  )
;; escape
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(define-key evil-visual-state-map (kbd "ESC ESC") (kbd "C-g"))
(define-key evil-normal-state-map (kbd "ESC ESC") (kbd "C-g"))
(define-key evil-normal-state-map (kbd "Q") 'delete-window)
(define-key evil-normal-state-map (kbd "gd") 'xref-find-definitions)
(define-key evil-visual-state-map (kbd "Q") 'delete-windows)
(define-key evil-insert-state-map (kbd "C-v") 'x-clipboard-yank)
;; evil-surround
(global-evil-surround-mode 1)
;; evil-visualstar
(global-evil-visualstar-mode)

;; evil-quickscope
(global-evil-quickscope-mode 1)
;; evil
(define-key evil-normal-state-map (kbd "S-<left>")
  (lambda ()
    (interactive)
    (evil-visual-char)
    (backward-char)))
(define-key evil-normal-state-map (kbd "S-<right>") 
  (lambda ()
    (interactive)
    (evil-visual-char)
    (forward-char)))
(define-key evil-visual-state-map (kbd "S-<left>")

  #'backward-char)
(define-key evil-visual-state-map (kbd "S-<right>") 
  #'forward-char)

(defun evil-unimpaired/paste-below ()
  (interactive)
  (evil-insert-newline-below)
  (evil-paste-after 1))

(defun evil-unimpaired/paste-above ()
  (interactive)
  (evil-insert-newline-above)
  (evil-paste-after 1))

(define-key evil-normal-state-map (kbd "[ p") 'evil-unimpaired/paste-above)
(define-key evil-normal-state-map (kbd "] p") 'evil-unimpaired/paste-below)

(defun evil-unimpaired/insert-space-above (count)
  (interactive "p")
  (dotimes (_ count) (save-excursion (evil-insert-newline-above))))

(defun evil-unimpaired/insert-space-below (count)
  (interactive "p")
  (dotimes (_ count) (save-excursion (evil-insert-newline-below))))

(define-key evil-normal-state-map (kbd "[ SPC")
  'evil-unimpaired/insert-space-above)
(define-key evil-normal-state-map (kbd "] SPC")
  'evil-unimpaired/insert-space-below)





(provide 'evil-mode-moe)
