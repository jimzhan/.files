(add-to-list 'load-path "~/.emacs.d")
;(add-to-list 'load-path "~/.emacs.d/python")
;(add-to-list 'load-path "~/.emacs.d/yasnippet")

; Keymaps

; multilingual & coding
(setq current-language-environment "UTF-8")
(set-clipboard-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

; text mode
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)

; indent
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq indent-tabs-mode nil)

; look & feel
(require 'color-theme)
(color-theme-initialize)
(color-theme-ir-black)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(set-default-font "Monaco-12")
(if window-system (load "fonts.el"))
(setq frame-title-format (list (getenv "USER") "@%b" ))

; datetime
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

; backup
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
;(setq semanticdb-default-save-directory "~/.emacs.d/semantic")

; misc (shortcuts etc.)
;(set-scroll-bar-mode nil)
(mouse-avoidance-mode 'animate)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key [C-return] `set-mark-command)
(global-set-key [f10] 'undo) 
(setq x-select-enable-clipboard t)
; keep the cursor at the end of each line when moving cursor
(setq track-eol t)
