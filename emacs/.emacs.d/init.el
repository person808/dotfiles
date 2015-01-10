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
(use-package evil-leader
  :commands (evil-leader-mode)
  :ensure t
  :init
  (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader ",")  ; Map <Leader> to ,
    (evil-leader/set-key "c" 'kill-buffer-and-window)  ; <Leader>c closes buffer
    (evil-leader/set-key "h" 'evil-prev-buffer)  ; <Leader>h goes to previous buffer
    (evil-leader/set-key "l" 'evil-next-buffer)  ; <Leader>l goes to next buffer
    )
  )

(use-package evil
  :ensure t
  :init
  (evil-mode t)
  :config
  (progn
    ;; Make j and k respect line wrapping
    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    ;; Better split navigation
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    )
  )

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-default-setup)
  )

(use-package undo-tree
  :ensure t
  :init
  ;; (global-undo-tree-mode 1)
  :config
  (progn
      ;; (undo-tree-auto-save-history t)
    )
  )

(use-package aggressive-indent
  :ensure t
  :init
  (global-aggressive-indent-mode 1)
  )

(use-package key-chord
  :ensure t
  :init
  (key-chord-mode 1)
  :config
  (progn
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)  ; Map jj to <Esc>
    )
  )

(use-package company
  :ensure t
  :init
  (global-company-mode 1)
  :config
  (progn
    (setq company-language-backends
	  '(company-bbdb
	    company-nxml
	    company-css
	    company-eclim
	    company-semantic
	    company-clang
	    company-xcode
	    company-ropemacs
	    company-cmake
	    company-capf
	    ))
    
    ;; Set default company backends
    (setq company-backends '((company-yasnippet
			      company-dabbrev-code
			      company-gtags
			      company-etags
			      company-keywords)
			     company-oddmuse
			     company-files
			     company-dabbrev))
    (add-hook 'after-init-hook (add-to-list 'company-backends 'company-language-backends))
    (setq company-idle-delay 0)  ; No delay for autocomplete
    
    ;; TAB completes common prefix and cycles through completions
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
    ;; <backtab> goes backwards through completions
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
    )
  )

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  ;; Disable normal expansions so snippets only expand from company-mode
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  )

(use-package magit
  :ensure t
  :config
  (progn
    ;; Better integration with evil-mode
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
      "k" 'magit-goto-previous-section))
  )

(use-package anaconda-mode
  :ensure t
  :mode "\\.py\\'"
  :interpreter ("anaconda-mode" . python-mode)
  )
(use-package company-anaconda
  :ensure t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-language-backends 'company-anaconda)
    )
  )

(use-package ample-theme
  :ensure t
  :init
  (load-theme 'ample-flat t)  ; Colorscheme
  )

;; Non-plugin settings

;; Appearance
;; No splash screen
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)
(menu-bar-mode -1)  ; Disable menu bar
(tool-bar-mode -1)  ; Disable tool bar
(setq default-frame-alist
      '(
	(width . 45)  ; Window width
	(height . 20)  ; Height width
	(font . "Monaco-9")  ; Font
	))

;; Misc settings
(defalias 'yes-or-no-p 'y-or-n-p)  ; Use y-n instead of yes-no for prompts
(visual-line-mode 1)  ; Word wrap
