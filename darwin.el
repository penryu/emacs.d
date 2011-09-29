(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

(add-to-list 'exec-path "/usr/local/bin")

(when window-system
  (add-to-list 'default-frame-alist '(height . 42))
  (add-to-list 'default-frame-alist '(width . 100))
  (set-face-attribute 'default nil :font "Lucida-Sans-Typewriter-12"))

(server-start)
