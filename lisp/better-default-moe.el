;;turn down voice
(setq visible-bell t)

(defun full-auto-save ()
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (basic-save-buffer)))))
(add-hook 'auto-save-hook 'full-auto-save)

(global-set-key (kbd "C-q") (lambda () (interactive) (save-some-buffers t) (kill-emacs)))
(defun full-save-quit () (interactive) (save-some-buffers t))

(require 'real-auto-save)
(add-hook 'prog-mode-hook 'real-auto-save-mode)
(setq real-auto-save-interval 20)
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

;; bakcup
(setq backup-directory-alist
      `((".*" . ,"~/.emacs.d/.backup")))

(setq auto-save-file-name-transforms
	`((".*" ,"~/.emacs.d/.backup" t)))

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


(provide 'better-default-moe)
