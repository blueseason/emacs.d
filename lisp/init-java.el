;; cedet

(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)            ; Enable template insertion menu


;;jdk path
;;(jde-jdk-registry (quote (("1.6.0_18" . "$JAVA_HOME"))))
(add-to-list 'load-path  "~/.emacs.d/java/jdee-2.4.0.1/lisp")
;;(load-file "~/.emacs.d/java/myjde.el")
(setq jde-web-browser "firefox")
(setq jde-jdk-doc-url "~./javadoc/jdkse6/docs/index.html")
(require 'jde)

(defun ac-semantic-candidate (prefix)
  (if (memq major-mode
            '(c-mode c++-mode jde-mode java-mode))
      (mapcar 'semantic-tag-name
              (ignore-errors
                (or (semantic-ia-get-completions
                     (semantic-analyze-current-context) (point))
                    (senator-find-tag-for-completion (regexp-quote prefix)))))))



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jde-global-classpath (quote ("")))
 '(jde-sourcepath (quote ("/home/season/project/omsdb")))
 '(jde-help-docsets (quote (("User (javadoc)" " /home/season/download/spring-framework-3.0.5.RELEASE/docs/javadoc-api/" nil) ("JDK API" "/home/season/javadoc/jdkse6/docs/api" nil))))
 '(jde-jdk-registry (quote (("1.6.0" . "$JAVA_HOME")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "Red"))))
 '(flymake-warnline ((((class color)) (:underline "Orange")))))

;;modiflied flymake
(require 'flymake)
(setq flymake-compiler-jar "~/.emacs.d/java/ecj-flymake/jars/compiler.jar")
(global-set-key [f4] 'flymake-display-err-menu-for-current-line)
(global-set-key [f3] 'flymake-goto-next-error)

(defun compile-server-dir-init (base-dir src-dir lib-dir)
  (let* ((temp-file (flymake-init-create-temp-buffer-copy 
					      'java-ecj-create-temp-file))
		  (jar-files (files-in-below-directory-safe base-dir lib-dir))
		   (class-path (mapconcat 'identity jar-files ":"))
		    (command (format (concat "-emacs -1.6 -proceedOnError -proc:none " 
									   "-warn:-serial -warn:+uselessTypeCheck,unnecessaryElse -warn:+over-ann "
									     "-sourcepath %s %s %s\n")
							   (get-source-dir base-dir src-dir) 
							     (get-class-path-string class-path) 
								   temp-file)))
    (list command)))

(defun compile-server-rabbit-init ()
  (compile-server-dir-init "/home/season/project/" "omsdb" "external_libs"))

(push '("/home/season/project/omsdb.+\\.java$" 
		compile-server-rabbit-init 
		compile-server-flymake-cleanup)
      flymake-allowed-file-name-masks)



(push '("\\(.*?\\):\\([0-9]+\\): error: \\(.*?\\)\n" 1 2 nil 2 3 
	(6 compilation-error-face)) compilation-error-regexp-alist)

(add-hook 'jde-mode-hook 'flymake-mode-on)

(require 'flymake-java)

(setq cscope-do-not-update-database t)

(add-hook 'jde-mode-hook (function cscope:hook))

(provide 'init-java)