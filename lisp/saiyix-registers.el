;; Use C-x r j followed by the letter of the register
;; (i for init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(dolist (r `((?e (file . ,dotfiles-dir))
             (?i (file . ,(concat dotfiles-dir "init.el")))
             (?f (file . ,(concat dotfiles-dir "saiyix-defuns.el")))
             (?b (file . ,(concat dotfiles-dir "saiyix-bindings.el")))
             (?m (file . ,(concat dotfiles-dir "saiyix-misc.el")))
             (?r (file . ,(concat dotfiles-dir "saiyix-registers.el")))
             (?s (file . ,(concat dotfiles-dir "secrets.el")))))
  (set-register (car r) (cadr r)))

(provide 'saiyix-registers)
