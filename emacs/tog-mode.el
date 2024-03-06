;;; tog-mode.el --- mode for editing .tog file.
;;
;; Copyright (C) 2023 jacoolee
;; Author: jacoolee
;; Version: 0.1
;; Keywords: convenience tools
;; URL: https://github.com/jacoolee/tog
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
;; (require 'tog-mode)
;; (add-to-list 'auto-mode-alist '(".tog" . tog-mode))
;;
;;; Code:

(defvar tog-font-lock-defaults
  `((
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     )))

(defface tog-face-status-todo
  '((t (:foreground "orange" :weight normal))) "")

(defface tog-face-status-doing
  '((t (:foreground "green" :weight normal))) "")

(defface tog-face-status-done
  '((t (:foreground "#aaaaaa" :weight normal))) "")

(defface tog-face-status-deprecated
  '((t (:foreground "gray" :weight normal))) "")

(defface tog-face-task-reference
  '((t (:foreground "purple3"))) "")

(defface tog-face-attribute
  '((t (:foreground "slategrey"))) "")

(defface tog-face-tag
  '((t (:foreground "darkseagreen"))) "")

(defface tog-face-emphase
  '((t (:foreground "red": :weight bold))) "")

(define-derived-mode tog-mode fundamental-mode "tog"
  "tog mode is a major mode for editing tog files, for more about tog, please checkout https://github.com/jacoolee/tog."
  (setq font-lock-defaults tog-font-lock-defaults)

  ;; highlights
  (font-lock-add-keywords nil '(("^= [0-9]+" . 'tog-face-status-todo)))
  (font-lock-add-keywords nil '(("^:=? [0-9]+" . 'tog-face-status-doing)))
  (font-lock-add-keywords nil '(("^\\x[=:]? [0-9]+" . 'tog-face-status-deprecated)))
  (font-lock-add-keywords nil '(("^\\.[=:]? [0-9]+" . 'tog-face-status-done)))

  (font-lock-add-keywords nil '(("@[0-9]+" . 'tog-face-task-reference)))
  (font-lock-add-keywords nil '(("@[-_A-z0-9]+:[^\s\n]+" . 'tog-face-attribute)))
  (font-lock-add-keywords nil '(("@[-_A-z0-9]+:\"[^\s\n\"]+" . 'tog-face-attribute)))
  (font-lock-add-keywords nil '(("#[^\s\n]+" . 'tog-face-tag)))
  (font-lock-add-keywords nil '(("\\*\\*[^\\*]+\\*\\*" . 'tog-face-emphase)))

  )

(provide 'tog-mode)
