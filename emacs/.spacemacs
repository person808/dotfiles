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
                                       c-c++
                                       clojure
                                       colors
                                       deft
                                       evil-commentary
                                       (evil-snipe :variables
                                                   evil-snipe-enable-alternate-f-and-t-behaviors t)
                                       (git :variables
                                            git-enable-github-support t
                                            git-gutter-use-fringe nil)
                                       gtags
                                       markdown
                                       org
                                       python
                                       semantic
                                       shell-scripts
                                       syntax-checking)
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
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progess in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to a .PNG file.
   ;; If the value is nil then no banner is displayed.
   ;; dotspacemacs-startup-banner 'official
   dotspacemacs-startup-banner 'official
   ;; t if you always want to see the changelog at startup
   dotspacemacs-always-show-changelog t
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
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
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key nil
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil the paste micro-state is enabled. While enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state t
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
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode t
   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'current
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   )
  ;; User initialization goes here
  (setq-default evil-escape-key-sequence "jj"
                evil-escape-delay 0.2)
  (push '(height . 24) default-frame-alist)
  (push '(width . 55) default-frame-alist)
  )

(defun dotspacemacs/config ()
  "Configuration function.
   This function is called at the very end of Spacemacs initialization after
   layers configuration."
  ;; Modes
  (aggressive-indent-global-mode t)
  (blink-cursor-mode t)
  (global-company-mode t)
  (with-eval-after-load 'helm
    (helm-mode t)
    (helm-autoresize-mode t))
  (add-hook 'prog-mode-hook 'visual-line-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (diminish 'visual-line-mode)
  (with-eval-after-load 'highlight-parentheses
    (diminish 'highlight-parentheses-mode))

  ;; Settings
  (setq evil-escape-excluded-major-modes '(help-mode)
        hs-isearch-open t
        powerline-default-separator 'bar
        vc-follow-symlinks t
        ;; Backup/Undo
        undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo")))
        ;; Git
        git-gutter:modified-sign "~"
        git-gutter:deleted-sign "_"
        ;; Helm
        helm-recentf-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-locate-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-apropos-fuzzy-match t
        helm-lisp-fuzzy-completion t
        helm-move-to-line-cycle-in-source t
        helm-display-header-line nil
        helm-for-files-preferred-list '(helm-source-buffers-list helm-source-recentf helm-source-file-cache helm-source-findutils)
        ;; Autocomplete
        company-quickhelp-max-lines 40
        ;; Flycheck
        flycheck-flake8-maximum-line-length 99
        flycheck-check-syntax-automatically '(save new-line mode-enabled)
        ;; Org
        org-bullets-bullet-list '("•" "⚪" "⬥" "⬦")
        ;; Notes
        deft-directory "~/Documents/notes"
        deft-extension "md"
        deft-text-mode 'markdown-mode)
  ;; Autocomplete
  (push 'initials completion-styles)
  ;; Backups/Undo
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))
  ;; Helm
  (with-eval-after-load 'helm
    (defvar helm-source-header-default-background (face-attribute 'helm-source-header :background))
    (defvar helm-source-header-default-foreground (face-attribute 'helm-source-header :foreground))
    (defvar helm-source-header-default-box (face-attribute 'helm-source-header :box))
    (push '(cd . ido) helm-completing-read-handlers-alist)
    (push '(dired . ido) helm-completing-read-handlers-alist))

  ;; Functions
  ;; Helm
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

  ;; Keybindings
  ;; Misc
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map (kbd "SPC SPC") 'hs-toggle-hiding)
  ;; Buffers/Windows/Splits
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "H") 'spacemacs/previous-useful-buffer)
  (define-key evil-normal-state-map (kbd "L") 'spacemacs/next-useful-buffer)
  (define-key evil-motion-state-map (kbd "H") 'spacemacs/previous-useful-buffer)
  (define-key evil-motion-state-map (kbd "L") 'spacemacs/next-useful-buffer)
  ;; Helm
  (evil-leader/set-key
    "ff" 'helm-for-files)
  ;; Autocomplete
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
    (define-key company-active-map [tab] 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle))

  ;; Hooks
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)
  (add-hook 'kill-emacs-hook 'recentf-cleanup)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
