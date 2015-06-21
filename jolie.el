;;; jolie.el --- Major mode for the Jolie language

;; Copyright (C) 2015 Martin Wolf <mw@martinwolf.eu>

;; Author: Martin Wolf
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:
(eval-when-compile
  (require 'regexp-opt))

(defconst jolie-keywords
  (eval-when-compile
    (regexp-opt
     '("global" "constants" "cH" "instanceof" "interface" "Protocol" "Interfaces" "define" "Location" "Aggregates" "inputPort" "service" "outputPort" "OneWay" "RequestResponse" "execution" "comp" "concurrent" "nullProcess" "single" "sequential" "main" "init" "cset" "Redirects" "csets" "is_defined" "embedded" "extender" "Java" "Jolie" "JavaScript" "courier" "forward" "install" "undef" "include" "synchronized" "throws" "while" "for" "foreach" "with" "in" "spawn" "over" "type" "if" "else")))
  "Jolie keywords.")

(defconst jolie-types
  (eval-when-compile
    (regexp-opt
     '("string" "int" "long" "bool" "undefined" "raw" "double" "void" "any")))
  "Jolie types.")

(defconst jolie-operation-reference-regex
  (rx "@" (0+ space) (group (1+ (or word (syntax symbol))))))

(defconst jolie-font-lock-keywords
  (list
   (cons (concat "[^_$]?\\<\\(" jolie-keywords "\\)\\>[^_]?") '(1 font-lock-keyword-face))
   (cons (concat "[^_$]?\\<\\(" jolie-types "\\)\\>[^_]?") '(1 font-lock-type-face))
   (list jolie-operation-reference-regex 1 'font-lock-function-name-face)))

(defconst jolie-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; ' is a string delimiter
    (modify-syntax-entry ?' "\"" table)
    ;; " is a string delimiter too
    (modify-syntax-entry ?\" "\"" table)

	;; support one and multi line comments
	(modify-syntax-entry ?/ ". 124b" table)
	(modify-syntax-entry ?* ". 23" table)
	(modify-syntax-entry ?\n "> b"  table)
	(modify-syntax-entry ?\^m "> b" table)
	
    table))

(define-derived-mode jolie-mode fundamental-mode
  :syntax-table jolie-mode-syntax-table
  (setq font-lock-defaults '(jolie-font-lock-keywords))
  (setq mode-name "jolie lang mode")
  (font-lock-fontify-buffer) )

;;; jolie.el ends here
