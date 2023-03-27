;;; publish.el -- Publish org-roam -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 - present
;;
;; Author:  Martin Myrseth <mm@myme.no>
;; Maintainer:  Martin Myrseth <mm@myme.no>
;; Version: 0.0.1
;; Keywords: bib notes org outlines
;; Package-Requires: ((emacs "26.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:


(require 'org)
(require 'ox-publish)
(require 'org-re-reveal)


(defun publish ()
  "Publish slides."
  (let (
        (org-publish-timestamp-directory ".org-timestamps/")
        (org-publish-project-alist
         `(("slides"
            :base-directory "src"
            :publishing-directory "slides"
            :recursive t
            :publishing-function org-re-reveal-publish-to-reveal))))
    (message "Publishing slides")
    (org-publish "slides")))


(provide 'publish)
;;; publish.el ends here
