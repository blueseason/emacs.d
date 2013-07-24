(setq default-tab-width 4)

;yasnippet
(add-to-list 'load-path "~/.emacs.d/plugin")
(require 'yasnippet-bundle)
(put 'upcase-region 'disabled nil)

;;(semantic-load-enable-guady-code-helpers)

(setq ac-auto-start 4)
(global-set-key "\M-/" 'auto-complete)

(defun ac-semantic-candidate (prefix)                                           
  (if (memq major-mode                                                                                             
            '(c-mode c++-mode jde-mode java-mode))                                                                
      (mapcar 'semantic-tag-name                                                                                    
              (ignore-errors                                                                                        
                (or (semantic-ia-get-completions                                                                    
                     (semantic-analyze-current-context) (point))                                                 
                    (senator-find-tag-for-completion (regexp-quote prefix)))))))

;; set htmlize
(add-to-list 'load-path "~/.emacs.d/plugin/html/")
(require 'htmlize)

;; cscope
(add-hook 'c-mode-common-hook                                                                                                       
      '(lambda ()                                                                                                                   
        (require 'xcscope)))
(setq cscope-do-not-update-database t)

(require 'psvn)

;;slime
(setq inferior-lisp-program "sbcl") ; your Lisp system
(add-to-list 'load-path "~/project/slime/")  ; your SLIME directory
(require 'slime-autoloads)
(slime-setup '(slime-fancy))

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "linux")
  ;; other customizations
  (setq tab-width 4
                c-basic-offset 4
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)



;;
;;(setq load-path (cons "~/project/org-7.8.06/lisp" load-path))
;;(setq load-path (cons "~/project/org-7.8.06/contrib/lisp" load-path))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (ruby . t)
   (plantuml . t)
   ))

(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>") 
                                 ("/" italic "<i>" "</i>")
                                 ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
                                 ("=" org-code "<code>" "</code>" verbatim)
                                 ("~" org-verbatim "<code>" "</code>" verbatim)
                                 ("+" (:strike-through t) "<del>" "</del>")
                                 ("@" org-warning "<b>" "</b>")))
      org-export-latex-emphasis-alist (quote 
                                       (("*" "\\textbf{%s}" nil)
                                        ("/" "\\emph{%s}" nil) 
                                        ("_" "\\underline{%s}" nil)
                                        ("+" "\\texttt{%s}" nil)
                                        ("=" "\\verb=%s=" nil)
                                        ("~" "\\verb~%s~" t)
                                        ("@" "\\alert{%s}" nil)))
      )

(require 'org-latex)

(setq org-export-latex-listings t)
(add-to-list 'org-export-latex-classes
          '("org-article"
             "\\documentclass{org-article}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(provide 'init-me)
