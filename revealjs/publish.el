;;; publish.el -- Publish reveal.js slides -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024
;;
;; Author:  Martin Myrseth <mm@myme.no>
;; Maintainer:  Martin Myrseth <mm@myme.no>
;; Created: May 31, 2024
;; Modified: May 31, 2024
;; Version: 0.0.1
;; Keywords: bib notes org outlines
;; Homepage: https://github.com/myme/nix-templates
;; Package-Requires: ((emacs "26.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(require 'doom-themes)
(require 'ob-mermaid)
(require 'org)
(require 'org-re-reveal)
(require 'ox-publish)


(defun publish-setup ()
  "Configurations, themes, ++"
  ;; Org Babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t)))
  (setq org-confirm-babel-evaluate nil)
  (setq org-export-use-babel t)
  ;; Org Publish
  (setq org-publish-timestamp-directory ".org-timestamps/")
  (setq org-html-head "<link rel=\"stylesheet\" href=\"styles.css\" />")
  ;; (setq org-html-htmlize-output-type 'css)
  (setq org-publish-project-alist
        `(("slides"
           :base-directory "src"
           :publishing-directory "slides"
           :base-extension "org"
           :recursive t
           :publishing-function org-re-reveal-publish-to-reveal)
          ("static"
           :base-directory "src"
           :publishing-directory "slides"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg\\|pdf\\|mp3\\|ogg\\|swf\\|webm"
           :exclude ".\\*site$"
           :recursive t
           :publishing-function org-publish-attachment)))
  ;; Theme
  (load-theme 'doom-dracula t))

(defun publish ()
  "Publish slides."
  (princ "Publishing slides")
  (publish-setup)
  (org-publish "slides")
  (org-publish "static"))


(provide 'publish)
;;; publish.el ends here
