(defalias 'perl-mode 'cperl-mode)

(eval-after-load 'cperl-mode
  '(progn
     (define-key cperl-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key cperl-mode-map (kbd "C-M-h") 'backward-kill-word)))

(add-to-list 'auto-mode-alist '("\\.p[lm]$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pod$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . tt-mode))

;; TODO: flymake
;; TODO: electric bugaloo 

(provide 'saiyix-perl)
