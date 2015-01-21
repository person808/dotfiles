;; Load package manager and MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Plugin settings

;; Evil-mode plugins
(use-package evil-leader
  :ensure t
  :demand t
  :init
  (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader ",")

    (defun new-buffer ()
      "Creates a new empty buffer."
      (interactive)
      (switch-to-buffer (generate-new-buffer "buffer")))

    (evil-leader/set-key
      "c" 'kill-buffer-and-window
      "h" 'evil-prev-buffer
      "l" 'evil-next-buffer
      "b" 'new-buffer
      "dv" 'describe-variable
      "df" 'describe-function
      "dk" 'describe-key
      "sh" 'eshell)))

(use-package evil
  :ensure t
  :init
  (evil-mode t)
  :config
  (progn
    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

(use-package key-chord
  :ensure t
  :defer t
  :init
  (key-chord-mode 1)
  :config
  (progn
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)))

(use-package undo-tree
  :ensure t
  :defer t
  :config
  (progn
    (diminish 'undo-tree-mode)
    (setq undo-tree-history-directory-alist `(("." . "~/.emacs.d/undo/"))
	  undo-tree-auto-save-history t
	  undo-tree-visualizer-diff t)

    (evil-leader/set-key "u" 'undo-tree-visualize)))

;; Editing

(use-package evil-commentary
  :ensure t
  :defer t
  :init
  (evil-commentary-default-setup))

(use-package aggressive-indent
  :ensure t
  :defer t
  :init
  (global-aggressive-indent-mode t)
  :config
  (progn
    (diminish 'aggressive-indent-mode)))

;; Autocomplete

(use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode t)
  :config
  (progn
    (setq company-idle-delay 0
	  company-minimum-prefix-length 1
	  company-global-modes '(not git-commit-mode))

    (defun company-mode/backend-with-yas (backend)
      "Adds yasnippet to company-backends."
      (if (or (not company-mode/enable-yas)
	      (and (listp backend)
		   (member 'company-yasnippet backend)))
	  backend
	(append (if (consp backend) backend (list backend))
		'(:with company-yasnippet))))

    (defvar company-mode/enable-yas t)
    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

    (define-key company-active-map [tab] 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

(use-package yasnippet
  :ensure t
  :defer t
  :init
  (yas-global-mode 1)
  :config
  (progn
    (diminish 'yas-minor-mode)

    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map  (kbd "TAB") nil)))

;; Git plugins

(use-package magit
  :ensure t
  :config
  (progn
    (diminish 'magit-auto-revert-mode)

    (evil-set-initial-state 'magit-mode 'normal)
    (evil-set-initial-state 'magit-status-mode 'normal)
    (evil-set-initial-state 'magit-diff-mode 'normal)
    (evil-set-initial-state 'magit-log-mode 'normal)
    (evil-define-key 'normal magit-mode-map
      "j" 'magit-goto-next-section
      "k" 'magit-goto-previous-section)
    (evil-define-key 'normal magit-log-mode-map
      "j" 'magit-goto-next-section
      "k" 'magit-goto-previous-section)
    (evil-define-key 'normal magit-diff-mode-map
      "j" 'magit-goto-next-section
      "k" 'magit-goto-previous-section)
    (evil-leader/set-key
      "gb" 'magit-blame-mode
      "gl" 'magit-log
      "gs" 'magit-status
      "gc" 'magit-commit)))

(use-package git-gutter
  :ensure t
  :defer t
  :init
  (global-git-gutter-mode t)
  (git-gutter:linum-setup)
  :config
  (progn
    (diminish 'git-gutter-mode)
    (add-hook 'magit-revert-buffer-hook 'git-gutter:update-all-windows)
    (setq git-gutter:modified-sign "~"
	  git-gutter:added-sign "+"
	  git-gutter:deleted-sign "_"
	  git-gutter:hide-gutter t)

    (evil-leader/set-key
      "ghn" 'git-gutter:next-hunk
      "ghp" 'git-gutter:previous-hunk
      "ghs" 'git-gutter:stage-hunk
      "ghr" 'git-gutter:revert-hunk)))

;; Error checking

(use-package flycheck
  :ensure t
  :defer t
  :init
  (global-flycheck-mode t)
  :config
  (progn
    (setq flycheck-indication-mode nil)

    (custom-set-faces '(flycheck-error ((t (:underline "Red1"))))
		      '(flycheck-info ((t (:underline "ForestGreen"))))
		      '(flycheck-warning ((t (:underline "orange")))))

    (evil-leader/set-key
      "ec" 'flycheck-clear
      "ef" 'flycheck-mode
      "el" 'flycheck-list-errors
      "en" 'flycheck-next-error
      "ep" 'flycheck-previous-error)))

;; Helm packages

(use-package helm
  :ensure t
  :defer t
  :init
  (helm-mode t)
  :config
  (progn
    (diminish 'helm-mode)
    (helm-autoresize-mode t)
    (setq helm-recentf-fuzzy-match t
	  helm-buffers-fuzzy-matching t
	  helm-locate-fuzzy-match t)

    (define-key helm-map (kbd "C-j") 'helm-next-line)
    (define-key helm-map (kbd "C-k") 'helm-previous-line)
    (define-key helm-map (kbd "C-h") 'helm-next-source)
    (define-key helm-map (kbd "C-l") 'helm-previous-source)))

(use-package helm-ag
  :ensure t
  :defer t
  :config
  (progn
    (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case"
	  helm-ag-command-option "--all-text"
	  helm-ag-insert-at-point 'symbol)

    (evil-leader/set-key "ha" 'helm-ag)))

;; Shows possible key combinations

(use-package guide-key
  :ensure t
  :defer t
  :init (guide-key-mode t)
  :config
  (progn
    (diminish 'guide-key-mode)
    (setq guide-key/guide-key-sequence '("C-x"))))

;; A better package menu

(use-package paradox
  :ensure t
  :defer t
  :config
  (progn
    (setq paradox-display-download-count t
	  paradox-execute-asynchronously t)))

;; Appearance

(use-package ample-theme
  :ensure t
  :defer t
  :init (load-theme 'ample-flat t))

(use-package adaptive-wrap
  :ensure t
  :defer t
  :init
  (global-visual-line-mode t)
  (diminish 'visual-line-mode)
  (setq-default truncate-lines nil)
  (define-globalized-minor-mode global-adaptive-wrap-mode adaptive-wrap-prefix-mode adaptive-wrap-prefix-mode)
  (global-adaptive-wrap-mode t))

(use-package fill-column-indicator
  :ensure t
  :defer t
  :init
  (define-globalized-minor-mode global-fci-mode fci-mode turn-on-fci-mode)
  (global-fci-mode t)
  :config
  (progn
    (setq fci-rule-column 80
	  fci-rule-color "grey20"
	  fci-rule-width 2
	  fci-handle-truncate-lines nil)))

(use-package smooth-scrolling
  :ensure t
  :defer t
  :config
  (progn
    (setq scroll-margin 5
	  scroll-conservatively 10000
	  scroll-step 1)))

(use-package vim-empty-lines-mode
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'vim-empty-lines-mode)
  :config
  (progn
    (diminish 'vim-empty-lines-mode)))
