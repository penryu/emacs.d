;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq autoload-file (concat dotfiles-dir "loaddefs.el")
      secrets-file (concat dotfiles-dir "secrets.el")
      custom-file (concat dotfiles-dir "custom.el"))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;; load secrets
(when (file-exists-p secrets-file) (load secrets-file))

;; load customizations
(when (file-exists-p custom-file) (load custom-file))

;; standards
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'thingatpt)
(require 'imenu)
(require 'whitespace)
(require 'undo-tree)

;; custom
(require 'saiyix-defuns)
(require 'saiyix-bindings)
(require 'saiyix-misc)
(require 'saiyix-registers)
(require 'saiyix-org)
(require 'saiyix-pianobar)
(require 'saiyix-lisp)
(require 'saiyix-shell)
(require 'saiyix-git)
(require 'saiyix-paste)
(require 'saiyix-tex)
(require 'saiyix-haskell)
(require 'saiyix-scala)
(require 'saiyix-ocaml)
(require 'saiyix-dotnet)
(require 'saiyix-ruby)
(require 'saiyix-perl)
(require 'saiyix-web)

(setq server-name (concat dotfiles-dir "/server"))
(server-start)

(global-undo-tree-mode)

;; Setup scratch
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "")

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
 (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; enable desktop-save-mode
(desktop-save-mode 1)

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Tramp
;(setq tramp-verbose 6)  ; debug value; 0-10; default:3
(setq tramp-default-method "scpc")
;; allow for zsh's $RPS
(setq shell-prompt-pattern
      "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
(setq tramp-shell-prompt-pattern
      "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

;; Appearance

(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 42))

(defun set-theme ()
  (if (>= emacs-major-version 24)
      (load-theme 'zenburn)
    (add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme"))
    (require 'color-theme)
    (color-theme-initialize)
    (color-theme-zenburn)))
(set-theme)

;; Column Mode
(setq column-number-mode t)

;;; You can keep system- or user-specific customizations here

(setq os-type (case system-type
                (berkeley-unix "bsd")
                (darwin "darwin")
                (gnu/linux "linux")
                (windows-nt "windows")
                (otherwise
                 (remove-if-not 'letterp
                                (symbol-name system-type)))))

(setq short-system-name (car (split-string system-name "\\.")))

(setq system-specific-config (concat dotfiles-dir short-system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name)
      os-specific-config (concat dotfiles-dir os-type ".el"))

(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(if (file-exists-p os-specific-config) (load os-specific-config))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; init.el ends here
