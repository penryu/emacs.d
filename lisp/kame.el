;;; kame.el --- -*- emacs-lisp -*-
; kame-specific emacs init file

(autoload 'twittering-mode "twittering-mode" "Twitter mode" t)
(eval-after-load 'twittering-mode
  (setq twittering-use-master-password t))

(add-to-list 'load-path (concat vendor-dir "/erc"))
(load "erc-penryu.el")
