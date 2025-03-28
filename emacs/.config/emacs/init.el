(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar

(custom-set-faces
   '(default ((t (:height 160 :family "Menlo" :weight bold)))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defvar elpaca-installer-version 0.10)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;; (elpaca example-package)

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)

(use-package evil
    :ensure t
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
    (evil-define-key 'normal 'global (kbd "<leader>sf") 'find-file)
    (evil-define-key 'normal 'global (kbd "<leader>x") 'eval-buffer))

(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo"))))
  (global-undo-tree-mode 1))

(use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

;;Completion
(setf completion-styles '(basic flex)
      completion-auto-select t ;; Show completion on first call
      completion-auto-help 'visible ;; Display *Completions* upon first request
      completions-format 'one-column ;; Use only one column
      completions-sort 'historical ;; Order based on minibuffer history
      completions-max-height 20 ;; Limit completions to 15 (completions start at line 5)
      completion-ignore-case t)

;;Modeline (the status line at the bottom)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons :ensure t)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
)

;;Surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(which-key-mode 1)

(global-visual-line-mode t)

(setq mac-right-option-modifier 'none)

;;Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Documents/lunatech/" "~/Documents/accounting" "~/Documents/coding/" "~/Documents/notes/"))
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (setq projectile-switch-project-action #'projectile-find-file)
  (setq projectile-completion-system 'default)
  (projectile-mode +1))

;;F-IDO
(fido-vertical-mode 1)

;;Perspective
(use-package perspective
  :ensure t
  :bind
  ("<leader><SPC>" . switch-to-buffer)
  :custom
  (persp-mode-prefix-key (kbd "C-SPC"))  ; pick your own prefix key here
  (persp-sort 'created)
  (persp-show-modestring 'header)
  :init
  (persp-mode))

;;org
(defun ch/org-mode-setup ()
  (org-indent-mode))

(use-package org
  :ensure t
  :hook (org-mode . ch/org-mode-setup)
  :config
  (setq org-agenda-files
	'("~/Documents/notes/personal/journal.org"
	  "~/Documents/lunatech/notes/work-logs.org"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'note)
  (setq org-log-into-drawer t)
  (setq org-ellipsis " ▼"))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "<leader>st") (lambda () (interactive) (call-interactively 'org-show-todo-tree)))

;; dired
(global-set-key (kbd "<leader>sd") #'dired-jump)

;; keep emacs folder clean
;; backup
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; autosave
(make-directory (expand-file-name "auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t)))
