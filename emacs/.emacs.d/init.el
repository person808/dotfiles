;; -*- eval: (hs-hide-all) -*-

(defun package-manager ()
  "Load the package manager."
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  (require 'req-package))

(defun evil-mode-settings ()
  "Settings for evil mode and related packages."
  (req-package evil
    :ensure t
    :init (evil-mode t))

  (req-package evil-escape
    :ensure t
    :init (progn
	    (evil-escape-mode t)
	    (diminish 'evil-escape-mode)))

  (req-package evil-leader
    :ensure t
    :demand t
    :init (progn
	    (global-evil-leader-mode t)
	    (evil-leader/set-leader ","))))

(defun misc-settings ()
  "Miscellaneous settings."
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq inhibit-startup-screen t
	enable-local-eval t
	vc-follow-symlinks t)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

(defun misc-plugins ()
  "Miscellaneous plugins."
  (req-package aggressive-indent
    :ensure t
    :init (progn
	    (global-aggressive-indent-mode t)
	    (diminish 'aggressive-indent-mode)))

  (req-package evil-commentary
    :ensure t
    :init (progn
	    (evil-commentary-mode t)
	    (diminish 'evil-commentary-mode)))

  (req-package hideshow
    :init (progn
	    (add-hook 'prog-mode-hook 'hs-minor-mode)
	    (diminish 'hs-minor-mode))
    :config (progn
	      (define-key evil-normal-state-map (kbd "SPC") 'hs-toggle-hiding)))

  (req-package smooth-scrolling
    :ensure t))

(defun misc-keybindings ()
  "Miscellaneous keybindings."
  (req-package key-chord
    :ensure t
    :init (key-chord-mode t)
    :config (progn
	      (key-chord-define evil-insert-state-map "jj" 'evil-normal-state))))

(defun buffers-splits ()
  "Buffer and split settings."
  (with-eval-after-load "evil"
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "C-w q") 'evil-window-delete))
  (evil-leader/set-key
    "c" 'kill-this-buffer))

(defun backup-undo ()
  "Backup file and undo settings."
  (setq backup-by-copying t
	backup-directory-alist `((".*" . ,temporary-file-directory))
	auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
	delete-old-versions t
	kept-new-versions 6
	kept-old-versions 2
	version-control t)

  (req-package undo-tree
    :init (progn
	    (diminish 'undo-tree-mode))
    :config (progn
	      (evil-leader/set-key "u" 'undo-tree-visualize))))

(defun text-display ()
  "Text display settings."
  (global-linum-mode t)
  (global-visual-line-mode t)
  (diminish 'visual-line-mode)
  (setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))
  (setq default-frame-alist
	'((width . 50)
	  (height . 20)
	  (font . "Monaco-9")))

  (req-package adaptive-wrap
    :ensure t
    :init (add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode))

  (req-package atom-dark-theme
    :ensure t
    :init (load-theme 'atom-dark t)
    :config (progn
	      (set-face-attribute 'region nil
				  :background "#403D3D")))

  (req-package rainbow-delimiters
    :ensure t
    :require (cl-lib color)
    :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    :config (progn
	      (cl-loop
	       for index from 1 to rainbow-delimiters-max-face-count
	       do
	       (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
		 (cl-callf color-saturate-name (face-foreground face) 20)))))

  (req-package smartparens
    :ensure t
    :require (smartparens-config)
    :init (progn
	    (smartparens-global-mode t)
	    (show-smartparens-global-mode t)
	    (diminish 'smartparens-mode))))

(defun autocomplete ()
  "Autocomplete settings."
  (add-hook 'prog-mode-hook 'eldoc-mode)
  (with-eval-after-load "eldoc" (diminish 'eldoc-mode))

  (req-package company
    :ensure t
    :init (global-company-mode t)
    :config (progn
	      (setq company-idle-delay 0
		    company-minimum-prefix-length 2
		    company-require-match nil)

	      (defvar company-mode/enable-yas t
		"Enable yasnippet for all backends.")

	      (defun company-mode/backend-with-yas (backend)
		(if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
		    backend
		  (append (if (consp backend) backend (list backend))
			  '(:with company-yasnippet))))

	      (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

	      (define-key company-active-map [tab] 'company-complete-common-or-cycle)
	      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
	      (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

  (req-package company-quickhelp
    :ensure t
    :init (company-quickhelp-mode t))

  (req-package company-ycmd
    :ensure t
    :require (company)
    :init (progn
	    (ycmd-setup)
	    (add-to-list 'company-backends (company-mode/backend-with-yas 'company-ycmd)))
    :config (progn
	      (set-variable 'ycmd-server-command '("python2" "/usr/local/bin/ycmd/ycmd"))))

  (req-package yasnippet
    :ensure t
    :init (progn
	    (yas-global-mode t)
	    (diminish 'yas-minor-mode))))

(defun git-settings ()
  "Settings for using git."
  (setq vc-handled-backends ())

  (req-package git-gutter
    :ensure t
    :init (progn
	    (global-git-gutter-mode t)
	    (git-gutter:linum-setup)
	    (with-eval-after-load "git-gutter" (diminish 'git-gutter-mode)))
    :config (progn
	      (setq git-gutter:modified-sign "~"
		    git-gutter:deleted-sign "_")
	      (set-face-attribute 'git-gutter:modified nil
				  :foreground "yellow")

	      (define-key evil-normal-state-map "ghn" 'git-gutter:next-hunk)
	      (define-key evil-normal-state-map "ghp" 'git-gutter:previous-hunk)
	      (define-key evil-normal-state-map "ghs" 'git-gutter:stage-hunk)
	      (define-key evil-normal-state-map "ghr" 'git-gutter:revert-hunk)))

  (req-package magit
    :ensure t
    :init (diminish 'magit-auto-revert-mode)
    :config (progn
	      (evil-leader/set-key
		"gb" 'magit-blame-mode
		"gl" 'magit-log
		"gs" 'magit-status
		"gc" 'magit-commit))))

(defun helm-settings ()
  "Settings for helm."
  (req-package helm
    :ensure t
    :init (progn
	    (helm-mode t)
	    (helm-adaptive-mode t)
	    (helm-autoresize-mode t)
	    (diminish 'helm-mode))
    :config (progn
	      (setq helm-recentf-fuzzy-match t
		    helm-buffers-fuzzy-matching t
		    helm-locate-fuzzy-match t
		    helm-M-x-fuzzy-match t
		    helm-imenu-fuzzy-match t
		    helm-apropos-fuzzy-match t
		    helm-lisp-fuzzy-completion t
		    helm-move-to-line-cycle-in-source t)
	      (set-face-attribute 'helm-action nil
				  :underline nil)
	      (set-face-attribute 'helm-candidate-number nil
				  :foreground nil
				  :background nil)

	      (defadvice helm-display-mode-line (after undisplay-header activate)
		"Avoid help message."
		(setq header-line-format nil))

	      (global-set-key (kbd "M-x") 'helm-M-x)
	      (evil-leader/set-key
		"s" 'helm-semantic-or-imenu
		"f" 'helm-find)))

  (req-package hydra
    :ensure t
    :config (progn
	      (setq hydra-is-helpful nil)

	      (defhydra helm-like-unite (:pre
					 (set-cursor-color "#96CBFE")
					 :post
					 (set-cursor-color "White"))
		"Vim movement in helm."
		("?" helm-help "help")
		("<escape>" keyboard-escape-quit "exit")
		("<SPC>" helm-toggle-visible-mark "mark")
		("a" helm-toggle-all-marks "(un)mark all")
		("/" (lambda ()
		       (interactive)
		       (execute-kbd-macro [?\C-s]))
		 "search")
		("v" helm-execute-persistent-action)
		("g" helm-beginning-of-buffer "top")
		("G" helm-end-of-buffer "bottom")
		("j" helm-next-line "down")
		("k" helm-previous-line "up")
		("i" nil "cancel"))

	      (define-key helm-map (kbd "<escape>") 'helm-like-unite/body)
	      (key-chord-define helm-map "jj" 'helm-like-unite/body))))

(defun language-specific ()
  "Language specific settings."
  (defun python-settings ()
    "Python settings."
    (req-package anaconda-mode
      :ensure t
      :init (progn
	      (add-hook 'python-mode-hook 'anaconda-mode)
	      (diminish 'anaconda-mode))))

  (python-settings))

(defun load-settings ()
  "Load settings from previous functions."
  (package-manager)
  (evil-mode-settings)
  (misc-settings)
  (misc-plugins)
  (misc-keybindings)
  (buffers-splits)
  (backup-undo)
  (text-display)
  (autocomplete)
  (git-settings)
  (helm-settings)
  (language-specific)
  (req-package-finish))

(load-settings)
