(setq package-enable-at-startup nil)

;; Force-load init.el immediately (last-resort fallback)
(load-file (expand-file-name "init.el" user-emacs-directory))
