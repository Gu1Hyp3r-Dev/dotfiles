;;; Code:

;; 1. Install and Configure sweeprolog
(use-package sweeprolog
  :ensure t
  :demand t
  :config
  ;; Tell Emacs to use the inferior Prolog mode
  (setq prolog-system 'swi)
  
  ;; Set up file associations for .pl and .pro files
  (add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
  (add-to-list 'auto-mode-alist '("\\.pro\\'" . prolog-mode))
  
  ;; Optional: Set the path to swipl if needed (usually not necessary on Arch)
  ;;(setq sweeprolog-swipl-path "/usr/bin/swipl")
  )

(provide 'sweeprolog-setup)

;;; sweeprolog-setup.el ends here
