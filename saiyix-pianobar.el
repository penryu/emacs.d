(autoload 'pianobar "pianobar" nil t)

(setq pianobar-global-modeline t)

(global-set-key (kbd "C-x p p") 'pianobar-play-or-pause)
(global-set-key (kbd "C-x p n") 'pianobar-next-song)
(global-set-key (kbd "C-x p l") 'pianobar-love-current-song)
(global-set-key (kbd "C-x p b") 'pianobar-ban-current-song)
(global-set-key (kbd "C-x p s") 'pianobar-change-station)

(provide 'saiyix-pianobar)
