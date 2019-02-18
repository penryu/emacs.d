;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq lisp-dir (concat dotfiles-dir "lisp/")
      vendor-dir (concat dotfiles-dir "vendor/")
      elpa-dir (concat dotfiles-dir "elpa/"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el")
      secrets-file (concat dotfiles-dir "secrets.el")
      custom-file (concat dotfiles-dir "custom.el"))

(add-to-list 'load-path lisp-dir)
(add-to-list 'load-path vendor-dir)

;; Package Repositories

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

(setq package-enable-at-startup nil)
(if (< emacs-major-version 24) (require 'package-e23))
(package-initialize)

(unless (package-installed-p 'cider)
  (package-install 'cider))

(unless (package-installed-p 'company)
  (package-install 'company))

(global-company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

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
(require 'saiyix-lisp)
(require 'saiyix-shell)
(require 'saiyix-git)
(require 'saiyix-tex)
(require 'saiyix-haskell)
(require 'saiyix-scala)
(require 'saiyix-ocaml)
(require 'saiyix-dotnet)
(require 'saiyix-python)
(require 'saiyix-ruby)
(require 'saiyix-perl)
(require 'saiyix-web)

(server-start)

(global-undo-tree-mode)

;; Setup scratch
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "")

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
 (concat dotfiles-dir "/autosaves/"))

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
(setq tramp-default-method "scp")
;; allow for zsh's $RPS
(setq shell-prompt-pattern
      "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
(setq tramp-shell-prompt-pattern
      "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

;; Appearance

(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 42))

(setq custom-theme-directory elpa-dir)
(load-theme 'flatland-black)

;; Column Mode
(setq column-number-mode t)

;;; You can keep system- or user-specific customizations here
;; evaluate os of host system
(setq os-type (case system-type
                (berkeley-unix "bsd")
                (darwin "darwin")
                (gnu/linux "linux")
                (windows-nt "windows")
                (otherwise
                 (remove-if-not 'letterp
                                (symbol-name system-type)))))
;; derive name of os-specific config file
(setq short-system-name (car (split-string system-name "\\.")))
;; derive full path to host-specific configs
(setq system-specific-config (concat lisp-dir short-system-name ".el")
      user-specific-config (concat lisp-dir user-login-name ".el")
      user-specific-dir (concat lisp-dir user-login-name)
      os-specific-config (concat lisp-dir os-type ".el")
      local-config (concat lisp-dir "local.el"))
;; load hostname-specific config
(if (file-exists-p system-specific-config) (load system-specific-config))
;; load user-specific config
(if (file-exists-p user-specific-config) (load user-specific-config))
;; add user-specific dir (is this useful?)
(add-to-list 'load-path user-specific-dir)
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))
;; add os-specific config
(if (file-exists-p os-specific-config) (load os-specific-config))
;; load local config
(if (file-exists-p local-config) (load local-config))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
         (1+ (current-column))))))

(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
              (hs-toggle-hiding)
            (error t))
          (hs-showall))
    (toggle-selective-display column)))

(global-set-key (kbd "C-\\") 'toggle-hiding)

;(add-hook 'python-mode-hook 'hs-minor-mode)


;;; init.el ends here
