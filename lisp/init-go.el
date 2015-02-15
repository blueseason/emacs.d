(require-package 'go-mode)
(require-package 'company-go)

(setenv "GOPATH" "/home/season/goworkspace")

(setenv "PATH" "/home/season/.rvm/gems/ruby-2.0.0-p451/bin:/home/season/.rvm/gems/ruby-2.0.0-p451@global/bin:/home/season/.rvm/rubies/ruby-2.0.0-p451/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/season/go/bin:/home/season/.rvm/bin:/home/season/workspace/Ant/bin:$GOPATH/bin")
(require 'go-mode-autoloads)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-k") 'godoc)))

(load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")
(add-hook 'go-mode-hook 'go-oracle-mode)

(add-to-list 'load-path "~/goworkspace/src/github.com/dougm/goflymake")
;(load "$GOPATH/src/github.com/dougm/goflymake/go-flymake.el")
(require 'go-flymake)

;; (load "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete.el")
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(provide 'init-go)
