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


(require 'lsp-mode)
(require 'lsp-python)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(setq
lsp-ui-sideline-enable nil
lsp-ui-doc-max-height 10
lsp-enable-completion-at-point t
lsp-ui-doc-position 'bottom
lsp-ui-doc-header t
lsp-ui-doc-include-signature nil
)

(setq-default lsp-ui-doc-frame-parameters '((left . -1)
					    (top . -1)
					    (min-width . 0)
					    (width . 0)
					    (min-height . 0)
					    (height . 0)
					    (internal-border-width . 5)
					    (vertical-scroll-bars . t)
					    (horizontal-scroll-bars . nil)
					    (left-fringe . 0)
					    (right-fringe . 0)
					    (menu-bar-lines . 0)
					    (tool-bar-lines . 0)
					    (line-spacing . 0.1)
					    (unsplittable . t)
					    (undecorated . t)
					    (visibility . nil)
					    (no-other-frame . t)
					    (no-special-glyphs . t)))



(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
;; lsp-map
(global-set-key (kbd "M-;") 'xref-find-definitions)
(global-set-key (kbd "M-?") 'xref-find-references)
(define-key evil-normal-state-map (kbd "C-n") 'lsp-ui-peek-jump-forward)
(define-key evil-normal-state-map (kbd "C-p") 'lsp-ui-peek-jump-backward)

(lsp-define-stdio-client lsp-python "python"
			 (lsp-make-traverser #'(lambda (dir)
						 (directory-files
						  dir
						  nil
						  "")))
			 '("pyls"))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-lsp))

(setq company-lsp-async t)
(setq company-lsp-enable-snippet t)

(add-hook 'python-mode-hook #'lsp-python-enable)

;; highlight-indentation
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#e3e3d3")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
;; neotree
(require 'neotree)
(global-set-key [f2] 'neotree-toggle)


(setq vc-follow-symlinks t)
