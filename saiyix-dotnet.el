(add-to-list 'load-path (concat dotfiles-dir "/vendor/dotnet"))

;; C# mode
(autoload 'csharp-mode "csharp-mode" "mode for editing C# source" t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;; F# mode
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)
(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

(defun csharp-repl ()
  "Open new side-by-side window and start CSharpRepl in it."
  (interactive)
  (split-window)
  (other-window 1)
  (comint-run "csharp"))

(provide 'saiyix-dotnet)
