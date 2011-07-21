(autoload 'php-mode "php-mode" "PHP editing mode" t)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-hook 'php-mode-hook 'run-coding-hook)

(provide 'saiyix-php)
