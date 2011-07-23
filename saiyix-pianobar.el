(autoload 'pianobar "pianobar" nil t)

(setq pianobar-global-modeline t)

(global-set-key (kbd "M-o p") 'pianobar-play-or-pause)
(global-set-key (kbd "M-o n") 'pianobar-next-song)
(global-set-key (kbd "M-o l") 'pianobar-love-current-song)
(global-set-key (kbd "M-o b") 'pianobar-ban-current-song)
(global-set-key (kbd "M-o s") 'pianobar-change-station)

(provide 'saiyix-pianobar)
