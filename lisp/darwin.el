(if (fboundp 'menu-bar-mode) (menu-bar-mode 0))

;; Aqua doesn't inherit PATH from a shell
(add-to-list 'exec-path "/usr/local/bin")

(add-to-list 'default-frame-alist '(font . "Source Code Pro Light 11"))
