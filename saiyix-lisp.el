
(require 'paredit)

;; Hooks

(add-hook 'lisp-interaction-mode-hook 'turn-on-paredit)

(add-hook 'lisp-mode-hook 'turn-on-paredit)

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'esk-remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'run-coding-hook)

(add-hook 'slime-repl-mode-hook 'turn-on-paredit)

;; Keys

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c l") "lambda")
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
(define-key lisp-mode-shared-map (kbd "C-\\") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

;; (defface esk-paren-face
;;    '((((class color) (background dark))
;;       (:foreground "grey50"))
;;      (((class color) (background light))
;;       (:foreground "grey55")))
;;    "Face used to dim parentheses."
;;    :group 'starter-kit-faces)

;;; Emacs Lisp

(require 'eldoc)

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

;;; Slime

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(require 'slime-autoloads)
(slime-setup '(slime-repl))


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

(add-hook 'scheme-mode-hook 'turn-on-paredit)
(add-hook 'geiser-repl-mode-hook 'turn-on-paredit)


(provide 'saiyix-lisp)
