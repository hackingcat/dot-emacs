;;company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.5)
(setq company-minimum-prefix-length 2)
(setq company-ddabbrev-code-everywhere t)
(setq company-dabbrev-code-modes t)
(setq company-dabbrev-code-other-buffers 'all)
(setq company-dabbrev-ignore-buffers "\\`\\'")



(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-lsp)
  (add-to-list 'company-backends '(company-capf :with company-dabbrev))
  )
;; yasnippet

(require 'yasnippet)
(yas-reload-all)

(add-hook 'prog-mode-hook #'yas-minor-mode)

(provide 'company-snippets-moe)
