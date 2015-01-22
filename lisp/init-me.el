(setq default-tab-width 4)

;yasnippet
(add-to-list 'load-path "~/.emacs.d/plugin")
(require-package 'yasnippet)
(put 'upcase-region 'disabled nil)

;;(semantic-load-enable-guady-code-helpers)

(setq ac-auto-start 4)
;(global-set-key "\M-/" 'auto-complete)

;; (defun ac-semantic-candidate (prefix)                                           
;;   (if (memq major-mode                                                                                             
;;             '(c-mode c++-mode jde-mode java-mode))                                                                
;;       (mapcar 'semantic-tag-name                                                                                    
;;               (ignore-errors                                                                                        
;;                 (or (semantic-ia-get-completions                                                                    
;;                      (semantic-analyze-current-context) (point))                                                 
;;                     (senator-find-tag-for-completion (regexp-quote prefix)))))))

(require-package 'auto-complete)
(require-package 'auto-complete-clang)
(require 'auto-complete-config)

;; 添加c-mode和c++-mode的hook，开启auto-complete的clang扩展  
(defun wttr/ac-cc-mode-setup ()
  (make-local-variable 'ac-auto-start)
  (setq ac-auto-start t)              ;auto complete using clang is CPU sensitive  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-hook 'wttr/ac-cc-mode-setup)  
(add-hook 'c++-mode-hook 'wttr/ac-cc-mode-setup)
(ac-config-default)
(global-auto-complete-mode t)
(define-key ac-mode-map  [(tab)] 'auto-complete)

;; (setq ac-clang-flags  (list
;;                        "-I/usrinclude"
;;                        "-I/usr/src/linux-headers-3.5.0-43/include"
;;                        "-I/usr/include/c++/4.6.3/"
;;                        ))


(setq ac-clang-flags
      (mapcar(lambda (item)(concat "-I" item))
         (split-string
 "
 /usr/include/c++/4.6
 /usr/include/c++/4.6/x86_64-linux-gnu
 /usr/include/c++/4.6/backward
 /usr/include/c++/4.6/ext
 /usr/include/c++/4.6/bits
 /usr/include/c++/4.6/parallel
 /usr/include/c++/4.6/profile
 /usr/include/c++/4.6/tr1
 /usr/src/linux-headers-3.5.0-43/include
 /usr/local/include
 /usr/lib/gcc/x86-64-linux-gnu/4.4.5/include
 /usr/lib/gcc/x86-64-linux-gnu/4.4.5/include-fixed
 /usr/include/x86-64-linux-gnu
 /usr/include
")))  
;; set htmlize
(add-to-list 'load-path "~/.emacs.d/plugin/html/")
(require-package 'htmlize)

;; cscope
(add-hook 'c-mode-common-hook                                                                                                       
      '(lambda ()                                                                                                                   
        (require 'xcscope)))

(add-hook 'js2-mode'
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
   (dot . t)
   (plantuml . t)
   ))

(auto-image-file-mode t)

(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plugin/plantuml.jar"))
(setq org-confirm-babel-evaluate nil)

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

(require 'one)

(provide 'init-me)
