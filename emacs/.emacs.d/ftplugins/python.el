;; Python-specific plugins and settings

(use-package anaconda-mode
  :ensure t
  :defer t
  :init (add-hook 'python-mode-hook 'anaconda-mode)
  :config
  (add-hook 'python-mode-hook 'eldoc-mode)

  (evil-leader/set-key-for-mode 'python-mode
    "mhd" 'anaconda-mode-view-doc
    "mg"  'anaconda-mode-goto))

(use-package company-anaconda
  :ensure t
  :defer t
  :if (boundp 'company-backends)
  :init (add-to-list 'company-backends 'company-anaconda))

(use-package pyvenv
  :ensure t
  :defer t
  :init (add-hook 'python-mode-hook 'pyvenv-mode))

(use-package python
  :defer t
  :config
  (progn
    (setq mode-name "Python"
	  tab-width 4
	  electric-indent-chars (delq ?: electric-indent-chars))

    (if (executable-find "ipython")
	(setq python-shell-interpreter "ipython"
	      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
	      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
	      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
	      python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
	      python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
      (setq python-shell-interpreter "python"))

    (defun python-shell-send-buffer-switch ()
      "Send buffer content to shell and switch to it in insert mode."
      (interactive)
      (python-shell-send-buffer)
      (python-shell-switch-to-shell)
      (evil-insert-state))

    (defun python-shell-send-defun-switch ()
      "Send function content to shell and switch to it in insert mode."
      (interactive)
      (python-shell-send-defun nil)
      (python-shell-switch-to-shell)
      (evil-insert-state))

    (defun python-shell-send-region-switch ()
      "Send region content to shell and switch to it in insert mode."
      (interactive "r")
      (python-shell-send-region start end)
      (python-shell-switch-to-shell)
      (evil-insert-state))

    (defun python-start-or-switch-repl ()
      "Start and/or switch to the REPL."
      (interactive)
      (python-shell-switch-to-shell)
      (evil-insert-state))

    (evil-leader/set-key-for-mode 'python-mode
      "mB"  'python-shell-send-buffer-switch
      "mb"  'python-shell-send-buffer
      "mdb" 'python-toggle-breakpoint
      "mF"  'python-shell-send-defun-switch
      "mf"  'python-shell-send-defun
      "mi"  'python-start-or-switch-repl
      "mR"  'python-shell-send-region-switch
      "mr"  'python-shell-send-region)))
