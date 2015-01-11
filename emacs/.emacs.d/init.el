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
  :commands (evil-leader-mode)
  :ensure t
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
      "h" (let ((map (make-sparse-keymap)))  ; Adding multiple keymaps to a prefix
	    (define-key map (kbd "s") 'git-gutter:stage-hunk)
	    (define-key map (kbd "r") 'git-gutter:revert-hunk)
	    map)
      "p" 'evil-prev-buffer
      "n" 'evil-next-buffer
      "b" 'new-buffer
      "u" 'undo-tree-visualize
      "sh" 'eshell
      )))

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
  :init
  (key-chord-mode 1)
  :config
  (progn
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
    ))

(use-package undo-tree
  :ensure t
  :config
  (progn
    (setq
     undo-tree-history-directory-alist `(("." . "~/.emacs.d/undo/"))
     undo-tree-auto-save-history t)))

;; Editing

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-default-setup))

(use-package aggressive-indent
  :ensure t
  :init
  (global-aggressive-indent-mode 1))

;; Autocomplete

(use-package company
  :ensure t
  :init
  (global-company-mode 1)
  :config
  (progn
    (setq company-idle-delay 0)

    (defun company-complete-common-or-cycle ()
      "Allows tab to complete the common prefix and cycle through completions."
      (interactive)
      (when (company-manual-begin)
	(let ((tick (buffer-chars-modified-tick)))
	  (call-interactively 'company-complete-common)
	  (when (eq tick (buffer-chars-modified-tick))
	    (let ((company-selection-wrap-around t))
	      (call-interactively 'company-select-next))))))

    (define-key company-active-map [tab] 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map  (kbd "TAB") nil))

(use-package anaconda-mode
  :ensure t
  :mode "\\.py\\'"
  :config
  (add-hook 'python-mode-hook 'eldoc-mode))

(use-package company-anaconda
  :ensure t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-anaconda)))

;; Addtional features

(use-package magit
  :ensure t
  :config
  (progn
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
      "k" 'magit-goto-previous-section)))

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode t)
  (git-gutter:linum-setup)
  :config
  (progn
    (setq git-gutter:modified-sign "~"
	  git-gutter:added-sign "+"
	  git-gutter:deleted-sign "_")
    (define-key evil-normal-state-map "]c" 'git-gutter:next-hunk)
    (define-key evil-normal-state-map "[c" 'git-gutter:previous-hunk)))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package helm
  :ensure t
  :init
  (helm-mode t)
  :config
  (progn
    (helm-autoresize-mode t)))

;; Appearance

(use-package ample-theme
  :ensure t
  :init
  (load-theme 'ample-flat t))

(use-package smooth-scrolling
  :ensure t
  :config
  (progn
    (setq scroll-margin 5
	  scroll-conservatively 10000
	  scroll-step 1)))

;; Non-plugin settings

;; Appearance
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(setq default-frame-alist
      '((width . 45)
	(height . 20)
	(font . "Monaco-9")))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil)

;; Misc settings
(defalias 'yes-or-no-p 'y-or-n-p)
(visual-line-mode 1)
(setq backup-directory-alist `(("." . "~/.emacs.d/saves/"))
      backup-by-copying t)
(setq vc-follow-symlinks t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Editing
(electric-pair-mode 1)
