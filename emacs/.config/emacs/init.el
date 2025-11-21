;; Emacs Settings

(setq inhibit-startup-message t)

(scroll-bar-mode -1)

(tool-bar-mode -1)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Menlo" :weight bold)))))

(flyspell-mode t)

(electric-pair-mode t)

(which-key-mode 1)

(global-visual-line-mode 1)

(setq mac-right-option-modifier 'none) ; Ignore the right option key. Allow to type symbols (#€¡...)

(fido-vertical-mode 1) ; F-IDO

;; End Emacs Settings

;; Backups Settings
;; keep emacs folder clean
(defvar backups-dir (expand-file-name "backups/" user-emacs-directory))

;; Create the directory if it doesn't exist
(unless (file-exists-p backups-dir)
  (make-directory backups-dir t))

;; Tell Emacs to use this directory for backups
(setq backup-directory-alist `(("." . ,backups-dir)))
;; End Backups Settings

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; End Packages

;; Evil
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "C-g") 'evil-normal-state)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-leader 'normal (kbd "<SPC>"))

  (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>sf") 'find-file))

;; More evil keybinds (e.g. vim keybind in magit)
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Surround
 (use-package evil-surround
   :after evil
   :config
   (global-evil-surround-mode 1))

(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo"))))
   (global-undo-tree-mode 1))
;; End Evil

;; Git Packages
(use-package magit
  :after transient
  :config
  (setq git-commit-use-local-message-ring t))

;; Git gutter
(use-package git-gutter
  :config
  (global-git-gutter-mode +1))
;; End Git Packages

;; Misc Packages
(use-package nerd-icons)
;; End Misc Packages


;; Theme
;; Modeline (the status line at the bottom)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(setq theme1 'doom-zenburn
      theme2 'doom-plain
      theme3 'doom-plain-dark)

(use-package doom-themes
   :config
   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
         doom-themes-enable-italic t) ; if nil, italics is universally disabled
   (load-theme theme1 t))
   ;; Corrects (and improves) org-mode's native fontification.
   ;;(doom-themes-org-config)

(defun toggle-theme ()
  (interactive)
  (if (eq (car custom-enabled-themes) theme1)
      (disable-theme theme1)
    (enable-theme theme1)))

(global-set-key [f5] 'toggle-theme)
;; End Theme

;; Common Lisp
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))
;; End Common Lisp

;; Perspective
(use-package perspective
  :bind
  ("<leader><SPC>" . switch-to-buffer)
  :custom
  (persp-mode-prefix-key (kbd "C-SPC"))  ; pick your own prefix key here
  (persp-sort 'created)
  (persp-show-modestring t)
  :init
  (persp-mode))
;; End Perspective

;; Projectile
(use-package projectile
  :init
  (setq projectile-project-search-path '("~/Documents/accounting/finance/"
					 "~/Documents/coding/playground/lisp-playground/"
					 "~/Documents/notes/personal/"))
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (setq projectile-switch-project-action #'projectile-find-file)
  (setq projectile-completion-system 'default)
  (projectile-mode +1))
;; End Projectile

;; Org
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((lisp . t)
;;    (shell . t)))

;; (setq org-confirm-babel-evaluate nil)
;; (setq org-return-follows-link t)

;; (use-package org-appear
;;   :ensure (:wait t))

;; (defun ch/org-mode-setup ()
;;   (org-indent-mode)
;;   (org-appear-mode))

;; (use-package org
;;   :ensure (:wait t)
;;   :hook (org-mode . ch/org-mode-setup))

;; (defun ch/org-mode-visual-fill ()
;;   (setq visual-fill-column-width 80
;; 	visual-fill-column-center-text t)
;;   (visual-fill-column-mode 1))

;; visual fill column
;; (use-package visual-fill-column
;;   :ensure t
;;   :hook (org-mode . ch/org-mode-visual-fill))

;; End Org

;; Completion (untested)
;; (setf completion-styles '(basic flex)
;;       completion-auto-select t ;; Show completion on first call
;;       completion-auto-help 'visible ;; Display *Completions* upon first request
;;       completions-format 'one-column ;; Use only one column
;;       completions-sort 'historical ;; Order based on minibuffer history
;;       completions-max-height 20 ;; Limit completions to 15 (completions start at line 5)
;;       completion-ignore-case t)

;; End Completion

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection evil-surround git-gutter magit nerd-icons
		     perspective projectile slime undo-tree)))
