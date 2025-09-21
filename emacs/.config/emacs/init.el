;; Step 1: Generate the .el file with a custom name (e.g., "config.el")
(let ((org-file (expand-file-name "README.org" user-emacs-directory))
      (output-file (expand-file-name "config.el" user-emacs-directory)))
  (unless (file-newer-than-file-p output-file org-file)
    (org-babel-tangle-file org-file output-file)))

;; Step 2: Load the custom-named .el file
(load-file (expand-file-name "config.el" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
