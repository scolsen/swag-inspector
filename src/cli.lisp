(defpackage swag-inspector.cli 
    (:use :cl))

(print *args*)

(defmacro >> (fn &rest body) 
    "Convenience macro, mapcar operator."
    `(mapcar ,fn ,@body))

(defmacro .> (fn &rest arguments) 
    "Convenience macro, partially applied functions."
    (lambda (&rest arguments2) (apply fn (append arguments arguments2))))

(defmacro .< (fn &rest arguments)
    "Convenience macro, partially applied function right."
    (lambda (&rest arguments2) (apply fn (append arguments2 arguments))))

(defun string-to-sym (str) 
    (intern str))

(defun concat-prefix (prefix base) 
    (concatenate 'string prefix "-" base))

(setf option-prefix (.> concat-prefix "option"))

(defun make-alist (keys vals) 
    (>> #'list keys vals))

(>> #'print *args*)
(print (make-alist (>> #'string-to-sym (>> (.> concat-prefix "option") *args*)) *args*))
