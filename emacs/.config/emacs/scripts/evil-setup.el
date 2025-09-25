;;; Code:

(use-package evil
  :ensure t ; Ensure the package is installed
  :init
  ;; Tweak evil's configuration before loading it
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-vsplit-window-right t
        evil-split-window-below t)
  :config
  ;; Evil-mode is loaded now, so we can call it.
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor
  :ensure t)

(provide 'evil-setup)

;;; evil-setup.el ends here
