(require-package 'go-mode)

(setenv "PATH" "/home/season/.rvm/gems/ruby-2.0.0-p451/bin:/home/season/.rvm/gems/ruby-2.0.0-p451@global/bin:/home/season/.rvm/rubies/ruby-2.0.0-p451/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/season/go/bin:/home/season/.rvm/bin:/home/season/workspace/Ant/bin")
(require 'go-mode-autoloads)

(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'init-go)
