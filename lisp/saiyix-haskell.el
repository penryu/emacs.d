(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;;; indentation modes are mutually exclusive
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(provide 'saiyix-haskell)