;; Emacs profile for gnus

(setq user-full-name "Ming Ji")
(setq user-mail-address "blueseason@gmail.com")

;; We use gnus for email NOW!
;;(setq starttls-use-gnutls t)

(load-library "smtpmail")
(load-library "nnimap")
(load-library "starttls")

(require 'gnus-notify+)

(setq gnus-default-directory "~/.emacs.d/EmacsData/Gnus/")                    ;默认目录
(setq gnus-home-directory "~/.emacs.d/EmacsData/Gnus/")                       ;主目录
(setq gnus-dribble-directory "~/.emacs.d/EmacsData/Gnus/")                    ;恢复目录
(setq gnus-directory "~/.emacs.d/EmacsData/Gnus/News/")                       ;新闻组的存储目录
(setq gnus-article-save-directory "~/.emacs.d/EmacsData/Gnus/News/")          ;文章保存目录

;; 常规设置
(gnus-agentize)                                     ;开启代理功能, 以支持离线浏览
(setq gnus-inhibit-startup-message t)               ;关闭启动时的画面
(setq gnus-novice-user nil)                         ;关闭新手设置, 不进行确认
(setq gnus-expert-user t)                           ;不询问用户
(setq gnus-show-threads t)                          ;显示邮件线索
(setq gnus-interactive-exit nil)                    ;退出时不进行交互式询问
(setq gnus-use-dribble-file nil)                    ;不创建恢复文件
(setq gnus-always-read-dribble-file nil)            ;不读取恢复文件
(setq gnus-asynchronous t)                          ;异步操作
(setq gnus-large-newsgroup 500)                     ;设置大容量的新闻组默认显示的大小

;; customize how to splite the windows
(gnus-add-configuration
 '(article
   (vertical 1.0
             (summary .35 point)
             (article 1.0))))

;; System encoding
;; Anyway, try utf-8
(set-language-environment 'UTF-8)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq default-keyboard-coding-system 'utf-8-unix)
(setq default-sendmail-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-terminal-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq gnus-default-charset 'chinese-iso-8bit
      gnus-group-name-charset-group-alist '((".*" . cn-gb-2312))
      gnus-summary-show-article-charset-alist
    	'((1 . cn-gb-2312)
  		  (2 . gb18030)
  		  (3 . chinese-iso-8bit)
  		  (4 . gbk)
  		  (5 . big5)
  		  (6 . utf-8))
      gnus-newsgroup-ignored-charsets
        '(unknown-8bit x-unknown iso-8859-1 gb18030 x-gbk))


(setq gnus-secondary-select-methods '(;;(nnimap "imap.gmail.com"
;;               (nnimap-address "imap.gmail.com")
;;               (nnimap-server-port 993)
;; 			     (remove-prefix "INBOX.")
;;               (nnimap-authinfo-file "~/.emacs.d/gnus/.authinfo")
;;               (nnimap-stream ssl))
;;									 (nnimap "imap.126.com"
;;               (nnimap-address "imap.126.com")
;;               (nnimap-server-port 143)
;;			   (remove-prefix "INBOX.")
;;               (nnimap-authinfo-file "~/.emacs.d/gnus/.authinfo")
;;               (nnimap-stream starttls)) ;; attention, 163.com use starttls
;;									  (nntp "freenews.netfront.net")
;;									  (nntp "localhost")
                                      )
			  						  )

;;(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil);
;;									  ("smtp.126.com" 25 nil nil))
;;          smtpmail-smtp-server "smtp.gmail.com"
;;          smtpmail-default-smtp-server "smtp.gmail.com"
;;          send-mail-function 'smtpmail-send-it
;;          message-send-mail-function 'smtpmail-send-it
;;          smtpmail-smtp-service 587
;;          smtpmail-auth-credentials '(("smtp.gmail.com"
;;									   587
;;									   "your_email_name@gmail.com"
;;									   nil)
;;									  ("smtp.126.com"
;;									   25
;;									   "your_email_name@`126.com"
;;									   nil)))

;; Display the image
(auto-image-file-mode 1)  
(setq w3m-toggle-inline-images t)
(setq mm-inline-large-images t)  
(add-to-list 'mm-attachment-override-types "image/.*")  

(setq gnus-mime-display-multipart-related-as-mixed nil)
(setq mm-text-html-renderer 'w3m)
(eval-after-load "mm-decode"
	'(progn 
		(add-to-list 'mm-discouraged-alternatives "text/html")
	        (add-to-list 'mm-discouraged-alternatives "text/richtext")))
(setq mm-inline-text-html-with-images t)
(setq mm-inline-text-html-with-w3m-keymap nil)

;; The newsgroup subscribe
;;(setq gnus-nntp-server "freenews.netfront.net")
(setq gnus-nntp-server "news.aoie.org")
(setq gnus-secondary-select-methods '((nntp "news.aoie.org")))
(setq gnus-nntp-server "news.gmane.org")
;;(setq gnus-nntp-server "localhost") 

(setq gnus-default-subscribed-newsgroups
	  '( "cn.bbs.comp.emacs"
		"gwene.org.anyshare"
		"gwene.cn.coolshell"
		"cn.comp.os.linux" 
		"cn.bbs.comp.lang.python"
		"gmane.linux.nfs"
		"gmane.linux.kernel.cifs"
		"gmane.linux.kernel.autofs"
		"gmane.linux.redhat.general"
		"gmane.comp.lang.c.general"
		"gmane.comp.python.general"
		"gmane.comp.shells.bash.help"
		"gmane.comp.version-control.git"
		"gmane.emacs.gnus.general"
		"gmane.lisp.china"
		"gmane.org.gnu.discuss"
		))

;; Display formate
;; Thread summary
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "")
(setq gnus-sum-thread-tree-single-indent "")
(setq gnus-sum-thread-tree-root "●")
(setq gnus-sum-thread-tree-false-root "☆")
(setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─►")
(setq gnus-sum-thread-tree-single-leaf "╰─►")

;; 概要显示设置
(setq gnus-summary-gather-subject-limit 'fuzzy) ;聚集题目用模糊算法
(setq gnus-summary-line-format "%4P %U%R%z%O %{%14&user-date;%} %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")
(defun gnus-user-format-function-a (header) ;用户的格式函数 `%ua'
  (let ((myself (concat "< taozhijiang@gmail.com >"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))
(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "TD %H:%M")   ;当天
        (604800 . "W%w %H:%M")                ;七天之内
        ((gnus-seconds-month) . "%d %H:%M")   ;当月
        ((gnus-seconds-year) . "%m-%d %H:%M") ;今年
        (t . "%y-%m-%d %H:%M")))              ;其他

;; 时间显示
(add-hook 'gnus-article-prepare-hook 'gnus-article-date-local) ;将邮件的发出时间转换为本地时间
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)   ;跟踪组的时间轴
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)              ;新闻组分组

;; 线程设置
(setq
 gnus-use-trees t                                                       ;联系老的标题
 gnus-tree-minimize-window nil                                          ;用最小窗口显示
 gnus-fetch-old-headers 'some                                           ;抓取老的标题以联系线程
 gnus-generate-tree-function 'gnus-generate-horizontal-tree             ;生成水平树
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject ;聚集函数根据标题聚集
 )
;; 排序
(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)                               ;时间的逆序
        (not gnus-thread-sort-by-number)))                           ;跟踪的数量的逆序
;; 自动跳到第一个没有阅读的组
(add-hook 'gnus-switch-on-after-hook 'gnus-group-first-unread-group) ;gnus切换时
(add-hook 'gnus-summary-exit-hook 'gnus-group-first-unread-group)    ;退出Summary时
;; 自动更新新消息
(add-hook 'gnus-summary-exit-hook 'gnus-notify+)        ;退出summary模式后
(add-hook 'gnus-group-catchup-group-hook 'gnus-notify+) ;当清理当前组后
(add-hook 'mail-notify-pre-hook 'gnus-notify+)          ;更新邮件时
;; 斑纹化
(setq gnus-summary-stripe-regexp        ;设置斑纹化匹配的正则表达式
      (concat "^[^"
              gnus-sum-thread-tree-vertical
              "]*"))
;; 最后设置
(gnus-compile)                          ;编译一些选项, 加快速度

(provide 'init-gnus)
