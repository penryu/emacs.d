;(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

;; Aqua doesn't inherit PATH from a shell
(add-to-list 'exec-path "/usr/local/bin")

(add-to-list 'default-frame-alist '(font . "Lucida-Sans-Typewriter-12"))
