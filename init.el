(require 'cask "~/.cask/cask.el")
(cask-initialize)

(setq default-directory "~/.emacs.d/")
(add-to-list 'load-path (expand-file-name "./lisp/" default-directory))

(require 'appearance-moe)
(require 'company-snippets-moe)
(require 'evil-mode-moe)
(require 'helm-mode-moe)
(require 'pittcat-org-moe)
(require 'better-default-moe)
(require 'tools-moe)

;; For elpy
(setq elpy-rpc-python-command "python3")
;; For interactive shell
(setq python-shell-interpreter "python3")
(elpy-enable)
(setq tab-width 4)
(set-variable 'python-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)


(add-hook 'python-mode-hook 'py-yapf-enable-on-save)


(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(defun toggle-flycheck-error-buffer ()
  "toggle a flycheck error buffer."
  (interactive)
  (if (string-match-p "Flycheck errors" (format "%s" (window-list)))
      (dolist (w (window-list))
        (when (string-match-p "*Flycheck errors*" (buffer-name (window-buffer w)))
          (delete-window w)
          ))
    (flycheck-list-errors)
    )
  )

(global-set-key (kbd "<f8>") 'toggle-flycheck-error-buffer)
(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "<f6>") 'py-yapf-buffer)
