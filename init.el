(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;appearance
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; set font size
(set-face-attribute 'default nil :height 140)
; theme settings
;; Global settings (defaults)
(load-theme 'doom-one t)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

; dashboard
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Happy Hacking")
(setq dashboard-startup-banner 'official)
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (registers . 5)))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))




;;autocomplete
(add-hook 'after-init-hook 'global-company-mode)

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
  "<up>" 'windmove-up
  "<down>" 'windmove-down
  "<left>" 'windmove-left
  "<right>" 'windmove-right
  "wd" 'delete-window
  "sw" 'split-window-below
  "w2" 'split-window-horizontally
  "wv" 'split-window-horizontally
  "s/" 'helm-do-ag-this-file
  "ss" 'helm-swoop
  "or" 'helm-org-rifle
  "fei" (lambda () (interactive) (find-file "~/.emacs.d/init.el"))
  "fec" (lambda () (interactive) (find-file "~/.emacs.d/Cask"))
  )
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key evil-insert-state-map (kbd "C-v") 'x-clipboard-yank)
;; evil-surround
(global-evil-surround-mode 1)

;; helm and async
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
(async-bytecomp-package-mode 1)

(custom-set-variables
 '(helm-follow-mode-persistent t))
(setq helm-follow-mode-persistent nil)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; helm-swoop
;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
;; Disable pre-input
(setq helm-swoop-pre-input-function
      (lambda () ""))
(setq helm-swoop-use-fuzzy-match t)
;;others

;;turn down voice
(setq visible-bell t)


;;Auto-save
(defun full-auto-save ()
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (basic-save-buffer)))))
(add-hook 'auto-save-hook 'full-auto-save)
(defun save-all ()
(interactive)
(save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)
;;restart
(setq restart-emacs-restore-frames t)



;; which-key
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-popup-type 'minibuffer)

;; auto-pair
(autopair-global-mode) ;; enable autopair in all buffers
;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)

;; org-mode
(global-set-key (kbd "C-x p i") 'org-cliplink)
(global-set-key (kbd "C-SPC") 'nil)

;; bakcup
(setq backup-directory-alist
      `((".*" . ,"~/.emacs.d/.backup")))

(setq auto-save-file-name-transforms
	`((".*" ,"~/.emacs.d/.backup" t)))
