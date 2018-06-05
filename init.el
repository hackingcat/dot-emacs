(require 'cask "~/.cask/cask.el")
(cask-initialize)


;;appearance
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; set font size
(set-face-attribute 'default nil :height 135)
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
  "<SPC>" 'helm-M-x
  "df" 'delete-file-and-buffer
  )
(define-key evil-visual-state-map (kbd "ESC ESC") (kbd "C-g"))
(define-key evil-normal-state-map (kbd "ESC ESC") (kbd "C-g"))
(define-key evil-insert-state-map (kbd "C-v") 'x-clipboard-yank)
;; evil-surround
(global-evil-surround-mode 1)

;; helm and async
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
(async-bytecomp-package-mode 1)

(setq helm-follow-mode-persistent nil)
(helm-mode 1)
(setq helm-recentf-fuzzy-match 1)
(setq helm-buffers-fuzzy-matching 1)
(setq helm-completion-in-region-fuzzy-match 1)
(setq helm-M-x-fuzzy-match 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)


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
(global-set-key (kbd "M-d") #'helm-describe-modes)

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

;; super-save
(super-save-mode +1)
(setq super-save-auto-save-when-idle t)

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


(global-set-key (kbd "M-d") #'helm-describe-modes)

;; self-function
(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

;;autocomplete
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 2)

;; yasnippet
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'python-mode-hook #'yas-minor-mode)

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))
;; flycheck
(global-flycheck-mode)
;; python

;; langs
;; python
;; elpy

(elpy-enable)
