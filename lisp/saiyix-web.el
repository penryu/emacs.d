;; Markdown

(autoload 'markdown-mode "markdown-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;; web-mode

(defun saiyix-web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-style-padding 2))

(add-hook 'web-mode-hook 'saiyix-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml$" . web-mode))

;; PHP

(autoload 'php-mode "php-mode" "PHP editing mode" t)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-hook 'php-mode-hook 'run-coding-hook)
(add-hook 'php-mode-hook
          (lambda ()
            (set (make-local-variable 'c-basic-offset) 4)
            (set (make-local-variable 'tab-width) 8)
            (set (make-local-variable 'indent-tabs-mode) nil)))

(provide 'saiyix-web)
