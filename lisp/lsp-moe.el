(require 'lsp-mode)
(require 'lsp-python)
(require 'lsp-ui)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(setq company-lsp-async t)
(setq company-lsp-enable-snippet t)
(setq lsp-ui-flycheck-enable nil)
(setq lsp-ui-flycheck nil)
(setq lsp-ui-flycheck-live-reporting nil)
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


;; keymap

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
;; lsp-map
(global-set-key (kbd "M-;") 'xref-find-definitions)
(global-set-key (kbd "M-?") 'xref-find-references)
(define-key evil-normal-state-map (kbd "C-n") 'lsp-ui-peek-jump-forward)
(define-key evil-normal-state-map (kbd "C-p") 'lsp-ui-peek-jump-backward)


;; langs
;; python
(lsp-define-stdio-client lsp-python "python"
			 (lsp-make-traverser #'(lambda (dir)
						 (directory-files
						  dir
						  nil
						  "")))
			 '("pyls"))


(add-hook 'python-mode-hook #'lsp-python-enable)



(provide 'lsp-moe)
