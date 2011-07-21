(add-to-list 'load-path (concat dotfiles-dir "/vendor/tuareg-mode"))
(autoload 'tuareg-mode "tuareg" "OCaml editing mode" t)

(add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . tuareg-mode))
(add-hook 'tuareg-mode-hook 'whitespace-mode)

(eval-after-load 'tuareg-mode
  (require 'camldebug))


(provide 'saiyix-ocaml)
