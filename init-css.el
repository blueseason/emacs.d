;;; Colourise CSS colour literals
(when (eval-when-compile (>= emacs-major-version 24))
  ;; rainbow-mode needs color.el, bundled with Emacs >= 24.
  (require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook 'rainbow-mode)))



;;; Embedding in html
(require-package 'mmm-mode)
(after-load 'mmm-vars
  (mmm-add-group
   'html-css
   '((css-cdata
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*>[ \t\n]*\\(//\\)?<!\\[CDATA\\[[ \t]*\n?"
      :back "[ \t]*\\(//\\)?]]>[ \t\n]*</style>"
      :insert ((?j js-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</script>" @)))
     (css
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*>[ \t]*\n?"
      :back "[ \t]*</style>"
      :insert ((?j js-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</style>" @)))
     (css-inline
      :submode css-mode
      :face mmm-code-submode-face
      :front "style=\""
      :back "\"")))
  (dolist (mode (list 'html-mode 'nxml-mode))
    (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-css)))



;;; CSS flymake
(require-package 'flymake-css)
(defun maybe-flymake-css-load ()
  "Activate flymake-css as necessary, but not in derived modes."
  (when (eq major-mode 'css-mode)
    (flymake-css-load)))
(add-hook 'css-mode-hook 'maybe-flymake-css-load)



;;; SASS and SCSS
(require-package 'sass-mode)
(require-package 'scss-mode)
(require-package 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)
(add-hook 'scss-mode-hook 'flymake-sass-load)
(setq-default scss-compile-at-save nil)



;;; LESS
(require-package 'less-css-mode)
(require-package 'flymake-less)
(add-hook 'less-css-mode-hook 'flymake-less-load)

(defvar sanityinc/skewer-less-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "C-c C-k") 'sanityinc/skewer-less-save-and-reload)
    m)
  "Keymap for `sanityinc/skewer-less-mode'.")

(define-minor-mode sanityinc/skewer-less-mode
  "Minor mode allowing LESS stylesheet manipulation via `skewer-mode'."
  nil
  " LessSkew"
  sanityinc/skewer-less-mode-map
  (progn
    (add-hook 'after-save-hook 'sanityinc/skewer-less-reload nil t)))

(defun sanityinc/skewer-less-save-and-reload ()
  "When skewer appears to be active, ask for a reload."
  (interactive)
  (save-buffer)
  (sanityinc/skewer-less-reload))

(defun sanityinc/skewer-less-reload ()
  "When skewer appears to be active, ask for a reload."
  (interactive)
  (skewer-eval "less.refresh();"))



;;; Auto-complete CSS keywords
(after-load 'auto-complete
  (dolist (hook '(css-mode-hook sass-mode-hook scss-mode-hook))
    (add-hook hook 'ac-css-mode-setup)))


(provide 'init-css)
