;; add tuareg mode for editing

(add-to-list 'load-path (concat dotfiles-dir "/vendor/tuareg-mode"))

(setq utop-command "opam config exec \"utop -emacs\"")

(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(autoload 'tuareg-mode "tuareg" "OCaml editing mode" t)

(add-hook 'tuareg-mode-hook 'whitespace-mode)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

(add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . tuareg-mode))

(eval-after-load 'tuareg-mode
  (require 'camldebug))




(provide 'saiyix-ocaml)
