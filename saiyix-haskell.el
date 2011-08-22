(add-to-list 'load-path (concat dotfiles-dir "/vendor/haskell-mode"))
(load "haskell-site-file")

(autoload 'haskell-mode "haskell" "Haskell editing mode" t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;;; indentation modes are mutually exclusive
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(provide 'saiyix-haskell)
