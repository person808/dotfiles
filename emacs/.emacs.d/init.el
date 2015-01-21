;; Load plugins
(load-file "~/.emacs.d/plugins.el")

;; Load filetype-specific plugins and settings
(defun my-load-all-in-directory (dir)
  "`load' all elisp libraries in directory DIR which are not already loaded."
  (interactive "D")
  (let ((libraries-loaded (mapcar #'file-name-sans-extension
                                  (delq nil (mapcar #'car load-history)))))
    (dolist (file (directory-files dir t ".+\\.elc?$"))
      (let ((library (file-name-sans-extension file)))
        (unless (member library libraries-loaded)
          (load library nil t)
          (push library libraries-loaded))))))

(my-load-all-in-directory "~/.emacs.d/ftplugins/")

;; Appearance
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(global-linum-mode t)
(global-hl-line-mode t)
(setq default-frame-alist
      '((width . 45)
	(height . 20)
	(font . "Monaco-9")))
(setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))

;; Misc settings
(defalias 'yes-or-no-p 'y-or-n-p)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil)
(setq backup-directory-alist `(("." . "~/.emacs.d/saves/"))
      backup-by-copying t)
(setq vc-follow-symlinks t)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Editing
(electric-pair-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(semantic-mode t)
