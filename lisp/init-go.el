(require-package 'go-mode)
(require-package 'company-go)
(require-package 'go-guru)

(setenv "GOPATH" "/home/season/gowork")

(setenv "PATH" "/home/season/.rvm/gems/ruby-2.1.5/bin:/home/season/.rvm/gems/ruby-2.1.5@global/bin:/home/season/.rvm/rubies/ruby-2.1.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/home/season/go/bin:/home/season/.rvm/bin$GOPATH/bin")
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


(go-guru-hl-identifier-mode)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

(add-to-list 'load-path "$GOPATH/src/github.com/dougm/goflymake")
(load "$GOPATH/src/github.com/dougm/goflymake/go-flymake.el")
(require 'go-flymake)

;; (load "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete.el")
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(provide 'init-go)
