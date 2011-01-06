;;====================================
;; over wride default set
;;====================================
(setq load-path (cons (expand-file-name "~/.emacs.d/") load-path)) ; .el 読み込みパス追加
(fset 'yes-or-no-p 'y-or-n-p)                      ; yes or no を y or n へ
(line-number-mode t)                               ; モードラインにライン数表示
(column-number-mode t)                             ; モードラインにカラム数表示
(setq backup-inhibited t)                          ; バックアップファイルを作らない
(setq make-backup-files nil)                       ; 自動バックアップ中止
(setq auto-save-default nil)                       ; 自動セーブ中止
(setq-default tab-width 4)                         ; tabスペース
(setq-default indent-tabs-mode nil)                ; インデントでtab使用しない
(setq kill-whole-line t)                           ; C-kで一行削除
(setq visible-bell t)                              ; buffの結果をタイトルバーへ表示
(setq text-mode-hook 'turn-on-auto-fill)           ; 自動折り返しを無効化
(put 'narrow-to-region 'disabled nil)              ; ナローイング有効
(setq inhibit-startup-message t)                   ; 起動時のmessageを表示しない
(transient-mark-mode 1)                            ; マークした範囲(リージョン)をハイライトする
(show-paren-mode 1)                                ; 対応する括弧を光らせる。
;(global-highlight-changes 'active)                 ; 変更箇所をハイライト
;(add-hook 'write-file-hooks 'highlight-changes-rotate-faces) ; 変更箇所を保存のたびにハイライト
(require 'generic-x)

;;====================================
;; Mac Only
;;====================================
(when (eq system-type 'darwin)
  (setq mac-command-key-is-meta nil)
  (setq default-input-method "MacOSX")
  (set-alpha '(90 80))
  (setq mac-option-modifier 'meta))

;;====================================
;; auto-save-visited-file-name
;;====================================
(defun my-auto-save()
  (if (and buffer-file-name
           (buffer-modified-p)
           (not buffer-read-only))
      (save-buffer)))
(run-with-idle-timer 1.0 t 'my-auto-save)

;;====================================
;; keybind
;;====================================
(global-set-key "\C-\\" 'undo)                     ; C-\でundo
(global-set-key "\C-j" 'newline)                   ; 改行
(global-set-key "\C-m" 'newline-and-indent)        ; 改行 + インデント
(global-set-key "\C-h" 'delete-backward-char)      ; バックスペース
(global-set-key "\C-cr" 'replace-string)           ; 置換
(global-set-key "\C-cc" 'comment-region)           ; C-c c を範囲指定コメントに
(global-set-key "\C-cu" 'uncomment-region)         ; C-c u を範囲指定コメント解除に
(global-set-key "\C-o" '(lambda () (interactive)
                          (switch-to-buffer "*Find*"))) ; *Find*

;;====================================
;; utf-8 is default charset
;;====================================
;(require 'un-define)
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(auto-compression-mode t)

;;====================================
;; Anything
;;====================================
(require 'anything)
(require 'anything-config)
(setq anything-sources
      '(anything-c-source-buffers+
;        anything-c-source-colors
;        anything-c-source-recentf
;        anything-c-source-bookmarks
;        anything-c-source-file-cache
;        anything-c-source-emacs-variable-at-point
;        anything-c-source-emacs-function-at-point
;        anything-c-source-file-name-history
;        anything-c-source-anything-grep-fallback
;        anything-c-source-anything-google-fallback
        anything-c-source-emacs-commands
;        anything-c-source-emacs-functions
        anything-c-source-ctags
        anything-c-source-man-pages
        anything-c-source-info-pages
        anything-c-source-files-in-current-dir+
        ))
(define-key global-map (kbd "C-l") 'anything)

;;====================================
;; Yasnippet
;;====================================
(add-to-list 'load-path "~/.emacs.d/yasnippet-0.6.1c/")
(require 'yasnippet)
(require 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
(global-set-key (kbd "C-c y") 'anything-c-yas-complete)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet-0.6.1c//snippets")


;;====================================
;; ECB
;;====================================
(require 'ecb-autoloads)
(global-set-key "\C-o" 'ecb-goto-window-directories)
(custom-set-variables
 '(ecb-layout-name "left13")
 '(ecb-source-path (quote (("~" "home"))))
)
;;====================================
;; Autoinstall
;;====================================
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;====================================
;; Auto-complate
;;====================================
(require 'auto-complete)
(global-auto-complete-mode t)

;;====================================
;; ruby-mode
;;====================================
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
            (inf-ruby-keys)))
(add-hook 'ruby-mode-hook
          (lambda()
            (inf-ruby-keys)
            (require 'ruby-electric)
            (ruby-electric-mode t)
;            (define-key ruby-mode-map "\C-c\C-l" 'ruby-lint)

;; overwride bracket ("1110.time{ ")
             (setq ruby-electric-newline-before-closing-bracket t)
             (defun ruby-electric-curlies(arg)
               (interactive "P")
               (self-insert-command (prefix-numeric-value arg))
               (if (ruby-electric-is-last-command-char-expandable-punct-p)
                   (cond ((ruby-electric-code-at-point-p)
                          (insert "|e| ")
                          (save-excursion
                            (insert " }")))
                         ((ruby-electric-string-at-point-p)
                          (save-excursion
                            (backward-char 1)
                            (when (char-equal ?\# (preceding-char))
                              (forward-char 1)
                              (insert " }")))))))
	     ))

;;====================================
;; css-mode
;;====================================
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\.css'" . css-mode) auto-mode-alist))
(setq cssm-indent-level 4)
(setq cssm-indent-function #'cssm-c-style-indenter)

;;====================================
;; shell-mode
;;====================================
(add-hook 'shell-mode-hook
   (function (lambda ()
      (define-key shell-mode-map [up] 'comint-previous-input)
      (define-key shell-mode-map [down] 'comint-next-input))))


