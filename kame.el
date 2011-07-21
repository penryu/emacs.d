;;; kame.el --- -*- emacs-lisp -*-
; kame-specific emacs init file

(eval-after-load 'slime
  '(add-to-list 'slime-lisp-implementations
                '(ccl ("ccl" "--quiet"))))

(add-to-list 'load-path (concat (getenv "HOME") "/code/twittering-mode"))
(autoload 'twittering-mode "twittering-mode" "Twitter mode" t)
(eval-after-load 'twittering-mode
  (setq twittering-use-master-password t))

(add-to-list 'load-path (concat (getenv "HOME") "/.emacs.d/vendor/erc"))
(load "erc-penryu.el")

