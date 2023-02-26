;;; tlog-mode.el --- mode for editing .tlog file.
;;
;; Copyright (C) 2023 jacoolee
;; Author: jacoolee
;; Version: 0.1
;; Keywords: convenience tools
;; URL: https://github.com/jacoolee/tlog
;; Compatibility: GNU Emacs 22.x, GNU Emacs 23.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;;; Installation:
;;
;; Add the following to your .emacs file:
;; (add-to-list 'load-path "PATH_CONTAINS_THIS_FILE")
;; (require 'tlog-mode)
;; (add-to-list 'auto-mode-alist '(".tlog" . tlog-mode))
;;
;;; Code:

(defvar tlog-font-lock-defaults
  `((
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     )))

(defface tlog-face-status-todo
  '((t (:foreground "yellow" :weight bold))) "")

(defface tlog-face-status-doing
  '((t (:foreground "green" :weight bold))) "")

(defface tlog-face-status-done
  '((t (:foreground "#aaaaaa"))) "")

(defface tlog-face-status-deprecated
  '((t (:foreground "red"))) "")

(defface tlog-face-task-reference
  '((t (:foreground "orange"))) "")

(defface tlog-face-attribute
  '((t (:foreground "slategrey"))) "")

(defface tlog-face-tag
  '((t (:foreground "darkseagreen"))) "")

(define-derived-mode tlog-mode fundamental-mode "tlog"
  "tlog mode is a major mode for editing tlog files, for more about tlog, please checkout https://github.com/jacoolee/tlog."
  (setq font-lock-defaults tlog-font-lock-defaults)

  ;; highlights
  (font-lock-add-keywords nil '(("^=" . 'tlog-face-status-todo)))
  (font-lock-add-keywords nil '(("^+" . 'tlog-face-status-doing)))
  (font-lock-add-keywords nil '(("^x" . 'tlog-face-status-deprecated)))
  (font-lock-add-keywords nil '(("^\\.[=+]? [0-9]+" . 'tlog-face-status-done)))

  (font-lock-add-keywords nil '(("@[0-9]+" . 'tlog-face-task-reference)))
  (font-lock-add-keywords nil '(("@[-_A-z0-9]+:[^\s\n]+" . 'tlog-face-attribute)))
  (font-lock-add-keywords nil '(("#[^ ]+" . 'tlog-face-tag)))
  )

(provide 'tlog-mode)
