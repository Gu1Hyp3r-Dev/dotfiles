(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)
(require 'evil-setup)
(require 'buffer-move)
(require 'sweeprolog-setup)

(use-package general
  :config
  (general-evil-setup)
  
  ;; set up 'SPC' as the global leader key
  (general-create-definer gh/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC" ;; access leader in insert mode
    )
  
  (gh/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find File")
    "TAB TAB" '(comment-line :wk "Comment lines")
    )
  
  (gh/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b i" '(ibuffer :wk "Open IBuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    )

  (gh/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired")
    )
  
  (gh/leader-keys
    "e" '(:ignore t :wk "Eshell/Evaluate")
    
    ;; Evaluate Keybinds
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    
    ;; Eshell Keybinds
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e s" '(eshell :which-key "Eshell")
    )
  
  (gh/leader-keys
    "f" '(:ignore f :wk "files")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/README.org")) :wk "Edit emacs config")
    "f r" '(counsel-recentf :wk "Find recent files") 
    )
  
  
  (gh/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config")
    ;; "h r r" '(reload-init-file :wk "Reload emacs config")
    )
  
  (gh/leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" '(org-agenda :wk "Org agenda")
    "m e" '(org-export-dispatch :wk "Org export dispatch")
    "m i" '(org-toggle-item :wk "Org toggle item")
    "m t" '(org-todo :wk "Org todo")
    "m B" '(org-babel-tangle :wk "Org babel tangle")
    "m T" '(org-todo-list :wk "Org todo list")
    )
  
  (gh/leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" '(org-table-insert-hline :wk "Insert hline in table")
    )
  
  (gh/leader-keys
    "m d" '(:ignore t :wk "Date/deadline")
    "m d t" '(org-time-stamp :wk "Org time stamp")
    )

  (gh/leader-keys
    "p" '(:ignore t :wk "Prolog")
    "p b" '(prolog-consult-buffer :wk "Prolog consult buffer")
    "p f" '(prolog-consult-file :wk "Prolog consult file")
    "p k" '(prolog-restart-inferior-process :wk "Prolog restart process")
    "p p" '(prolog-consult-predicate :wk "Prolog consult predicate")
    "p r" '(prolog-consult-region :wk "Prolog consult region")
    "p RET" '(run-prolog :wk "Prolog run")
    )
  
  (gh/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t n" '(neotree-toggle :w "Toggle neotree")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle vterm")
    )

  (gh/leader-keys
    "T" '(:ignore t :wk "Themes")
    "T d" '(load-theme :wk "Load Doom Emacs Themes")
    )
  
  (gh/leader-keys
    "w" '(:ignore t :wk "Windows")
    
    ;; Windows splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    
    ;; Windows motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Windows right")
    "w w" '(evil-window-next :wk "Goto next window")
    
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
    )
  
  )

(use-package all-the-icons
  :ensure t
  :if
  (display-graphic-p)
  )

(use-package all-the-icons-dired
  :hook
  (dired-mode . (lambda () (all-the-icons-dired-mode t)))
  )

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .01) 
  (company-minimum-prefix-lenght 0)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t)
  )

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode)
  )

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs is more than a Text Editor!!")
  ;;(setq dashboard-startup-banner 'logo) ;; Uses a standart Emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/emacs-dash.png")
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents . 5)
			  (agenda . 5)
			  (bookmarks . 3)
			  (projects . 3)
			  (registers . 3)
			  )
	)
  (dashboard-modify-heading-icons '((recents . "file-text")
				    (bookmarks . "book")
				    )
				  )
  :config
  (dashboard-setup-startup-hook)
  )

(use-package diminish)

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
				("jpg" . "sxiv")
				("png" . "sxiv")
				("mkv" . "mpv")
				("mp4" . "mpv")
				)
	)
  )

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
  )

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode)
  )

(set-face-attribute 'default nil
		    :font "CaskaydiaCove Nerd Font Mono"
		    :height 100
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "CaskaydiaCove Nerd Font"
		    :height 100
		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
		    :font "CaskaydiaCove Nerd Font Mono"
		    :height 100
		    :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :slant 'italic)

;; This sets the default font on all graphical frames created after restarting E...
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fo...
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font Mono"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package counsel
  :after ivy
  :config (counsel-mode)
  )

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window)  
   )
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d)")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode)
  )

(use-package all-the-icons-ivy-rich
  :ensure t
  :init
  (all-the-icons-ivy-rich-mode t)
  )

(use-package ivy-rich
  :after ivy
  :ensure t
  :init
  (ivy-rich-mode 1) ;; this gets us description in M-x.
  :custom
  (ivy-virtual-abreviate 'full
			 ivy-rich-switch-buffer-align-virtual-buffer t
			 ivy-rich-path-style 'abbrev
			 )
  :config
  (ivy-set-display-transformer
   'ivy-switch-buffer
   'ivy-rich-switch-buffer-transformer
   )
  )

(use-package haskell-mode)
(use-package lua-mode)

(use-package neotree
  :config
  (setq neo-smart-open t
	neo-show-hidden-files t
	neo-window-width 55
	neo-window-fixed-size nil
	inhibit-compacting-font-caches t
	projectile-switch-project-action 'neotree-projectile-action
   )
  (add-hook 'neotree-after-create-hook
	    #'(lambda (_)
		(with-current-buffer (get-buffer neo-buffer-name)
		  (setq truncate-lines t)
		  (setq word-wrap nil)
		  (make-local-variable 'auto-hscroll-mode)
		  (setq auto-hscroll-mode nil)
		  )
	       )
	    )
  )

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable)
  )

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(require 'org-tempo)

;; (setq org-support-shift-select 'always)

(use-package projectile
  :config
  (projectile-mode 1)
  )

(use-package rainbow-mode
  :ensure t
  :hook org-mode prog-mode
  )

(use-package eshell-syntax-highlighting
  :after esh-mod
  :config
  (esheel-syntax-highlighting-global-mode +1)
  )

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-srcipt -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file-- sets an aliases file for the eshell.

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop"  "ssh" "top" "zsh")
      )

(use-package vterm
  :config
  (setq shell-file-name "/bin/fish"
        vterm-max-scrollback 5000
	)
  )

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toogle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 ;; (display-buffer-reuse-window display-buffer-in-direction)
                 ;; display-buffer-in-direction/direction/dedicated is added in emacs27
                 ;; (direction . bottom)
                 ;; (dedicated . t) ;dedicated is supported in emacs27
                 (reusable-frames . visible)
                 (window-height . 0.3)
                 )
	       )
  )

(use-package sudo-edit
  :config
  (gh/leader-keys
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit file")
    )
  )

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t
	)
  ;; (load-theme 'ghemacs-t1 t)
  ;; (load-theme 'dtmacs t)
  (load-theme 'doom-challenger-deep t)
  )

;; consult

(add-to-list 'default-frame-alist '(alpha-background . 90))

(use-package which-key
  :init
  (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-collumn-padding 1
	which-key-max-display-collumns nil
	which-key-min-display-lines 5
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.4
	which-key-idle-delay 0.8
	which-key-max-description-lenght 25
	which-key-allow-imprecise-window-fit nil
        which-key-separator " -> "
	) 
  )
