;; flycheck-pos-tip-mode
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(global-set-key (kbd "<f8>") 'toggle-flycheck-error-buffer)
(global-set-key (kbd "<f6>") 'py-yapf-buffer)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(provide 'programming-moe)


;; zeal-at-point
(add-hook 'python-mode-hook
   (lambda () (setq zeal-at-point-docset '("python3" "django"))))

;; insert-shebang
(require 'insert-shebang)

;; evil-map
(evil-leader/set-key
  "gz" 'zeal-at-point
  "el" 'helm-flycheck
  "en" 'flycheck-next-error
  "ep" 'flycheck-previous-error
 )
