;; -*- mode: dotspacemacs -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all'instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers '((auto-completion :variables
                                                        auto-completion-enable-company-help-tooltip t)
                                       clojure
                                       colors
                                       evil-commentary
                                       (evil-snipe :variables
                                                   evil-snipe-enable-alternate-f-and-t-behaviors t)
                                       (git :variables
                                            git-gutter-use-fringe nil)
                                       markdown
                                       python
                                       shell-scripts
                                       themes-megapack)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(ace-jump-mode
                                    ag
                                    evil-exchange
                                    evil-indent-textobject
                                    evil-org
                                    evil-search-highlight-persist
                                    evil-tutor
                                    google-translate
                                    helm-swoop
                                    neotree
                                    vi-tilde-fringe
                                    wdired)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Specify the startup banner. If the value is an integer then the
   ;; banner with the corresponding index is used, if the value is `random'
   ;; then the banner is chosen randomly among the available banners, if
   ;; the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(darktooth
                         soothe
                         gotham)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Monaco"
                               :size 24
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`
   dotspacemacs-major-mode-leader-key nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode t
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now .
   dotspacemacs-default-package-repository nil)
  ;; User initialization goes here
  (setq-default evil-escape-key-sequence "jj"
                evil-escape-delay 0.2)
  (add-to-list 'default-frame-alist '(height . 24))
  (add-to-list 'default-frame-alist '(width . 55))
  )

(defun dotspacemacs/config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."
  ;; Misc settings
  (setq powerline-default-separator 'bar
        hs-isearch-open t)

  ;; Misc keybindings
  (setq evil-escape-excluded-major-modes '(help-mode))
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map (kbd "SPC SPC") 'hs-toggle-hiding)

  ;; Text display/editing
  (aggressive-indent-global-mode t)
  (blink-cursor-mode t)
  (add-hook 'prog-mode-hook 'visual-line-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (diminish 'visual-line-mode)

  ;; Buffers/Splits
  (defvar *interesting-buffers* '("*eshell*" "*scratch*"))

  (defun boring-buffer-p (buffer-name)
    (catch 'found
      (mapc (lambda (regexp)
              (when (and (not (member buffer-name *interesting-buffers*))
                         (string-match regexp buffer-name))
                (throw 'found t)))
            helm-boring-buffer-regexp-list)
      nil))

  (defun next-useful-buffer ()
    (interactive)
    (next-buffer)
    (while (boring-buffer-p (buffer-name (current-buffer)))
      (next-buffer)))

  (defun previous-useful-buffer ()
    (interactive)
    (previous-buffer)
    (while (boring-buffer-p (buffer-name (current-buffer)))
      (previous-buffer)))

  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "H") 'previous-useful-buffer)
  (define-key evil-normal-state-map (kbd "L") 'next-useful-buffer)
  (define-key evil-motion-state-map (kbd "H") 'previous-useful-buffer)
  (define-key evil-motion-state-map (kbd "L") 'next-useful-buffer)

  ;; Backups/Undo
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

  ;; Helm settings
  (helm-mode t)
  (helm-autoresize-mode t)
  (setq helm-recentf-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-locate-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-apropos-fuzzy-match t
        helm-lisp-fuzzy-completion t
        helm-move-to-line-cycle-in-source t
        helm-display-header-line nil
        helm-for-files-preferred-list '(helm-source-buffers-list helm-source-recentf helm-source-file-cache helm-source-findutils))
  (add-to-list 'helm-completing-read-handlers-alist '(cd . ido))
  (add-to-list 'helm-completing-read-handlers-alist '(dired . ido))
  (add-to-list 'helm-boring-buffer-regexp-list '"\\*")

  (defvar helm-source-header-default-background (face-attribute 'helm-source-header :background))
  (defvar helm-source-header-default-foreground (face-attribute 'helm-source-header :foreground))
  (defvar helm-source-header-default-box (face-attribute 'helm-source-header :box))

  (defun helm-toggle-header-line ()
    "Hide header line in helm if there is more than 1 source."
    (if (> (length helm-sources) 1)
        (set-face-attribute 'helm-source-header nil
                            :foreground helm-source-header-default-foreground
                            :background helm-source-header-default-background
                            :box helm-source-header-default-box
                            :height 1.0)
      (set-face-attribute 'helm-source-header nil
                          :foreground (face-attribute 'helm-selection :background)
                          :background (face-attribute 'helm-selection :background)
                          :box nil
                          :height 0.1)))
  (add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)

  (evil-leader/set-key
    "hf" 'helm-for-files)

  ;; Autocomplete
  (setq company-quickhelp-max-lines 40
        company-idle-delay 0.15)
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
    (define-key company-active-map [tab] 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle))

  ;; Flycheck
  (setq flycheck-flake8-maximum-line-length 99)
  (setq flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
