
(require 'paredit)


;; General Lisp

(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c l") "lambda")
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
(define-key lisp-mode-shared-map (kbd "C-\\") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)


;;; Slime

(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(defvar slime-helper-el "~/.quicklisp/slime-helper.el")
(when (file-exists-p slime-helper-el)
  (load (expand-file-name slime-helper-el))
  (require 'slime-autoloads)
  (slime-setup '(slime-repl)))


;;; Emacs Lisp

;(require 'eldoc)

(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'esk-remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'run-coding-hook)

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

(eval-after-load 'eldoc-mode
  '(progn
     (eldoc-add-command
      'paredit-backward-delete
      'paredit-close-round)))

(defun esk-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))


;;; Clojure

(autoload 'clojure-mode "clojure-mode" "Clojure editing mode" t)

(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'run-coding-hook)


;;; Common Lisp

(setq slime-lisp-implementations
      '((sbcl ("sbcl") :coding-system utf-8-unix)
        (ccl ("ccl" "--quiet"))))


;;; Scheme

(require 'quack)
(setq quack-run-scheme-always-prompts-p nil)
(setq quack-default-program "racket")

(setq geiser-active-implementations '(racket))
(setq geiser-default-implementation '(racket))
(load (expand-file-name "~/.emacs.d/vendor/geiser/elisp/geiser.el"))

(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook 'enable-paredit-mode)


(provide 'saiyix-lisp)
