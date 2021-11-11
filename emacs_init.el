; Use the package manager
(require 'package)
; Sets package management sources
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://elpa.emacs-china.org/melpa/") t)

(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives 
               '("gnu" . "http://elpa.gnu.org/packages/")))

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)




; Initialize the package manager
(package-initialize)
;; install org-mode
;;(unless package-archive-contents    ;; Refresh the packages descriptions
;;  (package-refresh-contents))
(setq package-load-list '(all))     ;; List of packages to load
(unless (package-installed-p 'org)  ;; Make sure the Org package is
  (package-install 'org))



;;未安装则先安装
;; Declare packages
;;(setq my-packages
;;      '(neotree
;;		company
;;        evil-search-highlight-persist
;;        evil))
;;;; Iterate on packages and install missing ones
;;(dolist (pkg my-packages)
;;  (unless (package-installed-p pkg)
;;    (package-install pkg)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ess org-plus-contrib sqlup-mode markdown-mode auctex ## cmake-mode cmake-ide evil-search-highlight-persist neotree projectile auto-complete ensime evil)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(hl-line ((t (:background "color-233"))))
;; '(linum ((t (:foreground "#93a1a1" :background "#073642" :box nil))))
;; '(neo-file-link-face ((t (:foreground "white")))))
; tab 4
;(setq tab-width 4)


;; org make tab work
(setq evil-want-C-i-jump nil)

(setq default-tab-width 4)
; Use evil mode
(require 'evil)
(evil-mode t)
(setq evil-search-wrap t
      evil-regexp-search t)
(modify-syntax-entry ?_ "w")
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)

; Use company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key evil-insert-state-map (kbd "C-x C-f") 'company-files)
;;(setq company-dabbrev-downcase nil)



; Use org mode
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;lineNum mode
(global-linum-mode t)

;;(setq linum-format "%d") ;; alternative solution to intermittent line numbers
 
(setq linum-format " %d ")
(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
  (propertize (format (format " %%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)

(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

;;     (defun linum-format-func (line)
;;       (let ((w (length
;;                 (number-to-string (count-lines (point-min) (point-max))))))
;;         (concat
;;          (propertize (make-string (- w (length (number-to-string line))) ?0)
;;                      'face 'linum-leading-zero)
;;          (propertize (number-to-string line) 'face 'linum))))

(setq linum-format 'linum-format-func)))


;; set scala mode
(defun scala-indentation-from-preceding ()
   ;; Return suggested indentation based on the preceding part of the
   ;; current expression. Return nil if indentation cannot be guessed.
   (save-excursion
   (scala-backward-spaces)
   (and 
     (not (bobp))
   (if (eq (char-syntax (char-before)) ?\()
      (scala-block-indentation)
      (progn
        (when (eq (char-before) ?\))
        (backward-sexp)
        (scala-backward-spaces))
        t
       ;;(scala-looking-at-backward scala-expr-start-re)

      ))
    (if (scala-looking-at-backward scala-expr-start-re)
      (+ (current-indentation) scala-mode-indent:step)
      (current-indentation)
    ))))


;;(require 'ensime)
;;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)



;; set Auto-Complete mode
(setq ac-auto-start nil)



;; set neotree
(add-to-list 'load-path "/Users/blacktulip/.emacs.d/elpa/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;;(setq projectile-switch-project-action 'neotree-projectile-action)

;;(defun neotree-project-dir ()
;;  "Open NeoTree using the git root."
;;  (interactive)
;;  (let ((project-dir (projectile-project-root))
;;        (file-name (buffer-file-name)))
;;    (neotree-toggle)
;;    (if project-dir
;;        (if (neo-global--window-exists-p)
;;            (progn
;;              (neotree-dir project-dir)
;;              (neotree-find file-name)))
;;      (message "Could not find git project root."))))
;;(global-set-key [f8] 'neotree-project-dir)

;; 匹配括号高亮
(show-paren-mode t) 


;; 打开大文件
(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))

;; hs-minor-mode 
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'scala-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'sh-mode-hook  'hs-minor-mode)
(add-hook 'sql-mode  'hs-minor-mode)
(add-hook 'python-mode  'hs-minor-mode)


(global-set-key (kbd "C-c h") 'hs-toggle-hiding)
(global-set-key (kbd "C-c C-h") 'hs-hide-level)

;;
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
;;(set-face-background 'evil-ex-lazy-highlight "red")
;;(set-face-foreground 'evil-ex-lazy-highlight "red")
;;(set-face-attribute 'region nil :background "#FFFFEF")
(evil-ex-define-cmd "nohl"
                          'evil-search-highlight-persist-remove-all)

;; markdown
(add-hook 'markdown-mode-hook
        (lambda ()
          (when buffer-file-name
            (add-hook 'after-save-hook
                      'check-parens
                      nil t))))

;; 设置c++缩进
(setq c-default-style "linux"
          c-basic-offset 4)


(require 'rtags) ;; optional, must have rtags installed
(add-to-list 'load-path "/Users/blacktulip/.emacs.d/lisp") 
(require 'levenshtein)
;; 自动补全括号
(electric-pair-mode 1)


;; latex
;;(load "preview-latex.el" nil t t)

;;关闭menu-bar
(menu-bar-mode -1)


;;关闭mode-line
;;(setq-default mode-line-format nil)



;;evil C-u
(require 'evil)
(setq evil-want-C-u-scroll t)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

;;python tab width
(add-hook 'python-mode-hook
      (lambda ()
        ;;(setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent-offset 4)))

;; replace tab by space
(setq-default indent-tabs-mode nil)
(put 'scroll-left 'disabled nil)

;; open files at last-edited position
(save-place-mode 1)

;; ipython
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Merge comment-line and comment-dwim
(defun xah-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://ergoemacs.org/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))
(global-set-key (kbd "M-;") 'xah-comment-dwim)



;; R highlighting

(setq ess-R-font-lock-keywords
  '((ess-R-fl-keyword:keywords   . t)
    (ess-R-fl-keyword:constants  . t)
    (ess-R-fl-keyword:modifiers  . t)
    (ess-R-fl-keyword:fun-defs   . t)
    (ess-R-fl-keyword:assign-ops . t)
    (ess-R-fl-keyword:%op%       . t)
    (ess-fl-keyword:fun-calls    . t)
    (ess-fl-keyword:numbers      . t)
    (ess-fl-keyword:operators    . t)
    (ess-fl-keyword:delimiters)
    (ess-fl-keyword:=)
    (ess-R-fl-keyword:F&T        . t)))
(add-hook 'ess-mode-hook 'turn-on-pretty-mode)
