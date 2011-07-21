(add-to-list 'load-path (concat dotfiles-dir "/vendor/magit"))
(add-to-list 'load-path (concat dotfiles-dir "/vendor/mo-git-blame"))

(require 'magit)

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(provide 'saiyix-git)
