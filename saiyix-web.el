;(load (expand-file-name "~/.emacs.d/vendor/nxhtml/autostart.el"))

(autoload 'php-mode "php-mode" "PHP editing mode" t)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-hook 'php-mode-hook 'run-coding-hook)
(add-hook 'php-mode-hook
          (lambda ()
            (set (make-local-variable 'c-basic-offset) 4)
            (set (make-local-variable 'tab-width) 8)
            (set (make-local-variable 'indent-tabs-mode) nil)))

(provide 'saiyix-web)
