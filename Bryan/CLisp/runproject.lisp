(require 'sb-bsd-sockets)
(load (compile-file "util.lisp" :verbose nil :print nil))
(load (compile-file "math-util.lisp" :verbose nil :print nil))
(format t "~%")
(defvar *input-command*)
(defvar *inputs*)
(defvar *input*)
(defvar *running-from-runner* t)
(defvar *project-description* "")
(defvar *start-time*)
(defvar *end-time*)
(defvar *result*)
(setf *input-command* 'yes)
(setf *inputs*
	  (list '(yes t)
			'(y t)
			'(n nil)
			'(no nil)))
(defun main () 1)


(while (cadr (assoc *input-command* *inputs*))
  (setf *project-description* "")
  (format t "Enter an integer: ")
  (finish-output)
  (setf *input* (read))
  (if (integerp *input*)
	  (progn
		(handler-case
			(progn
			  (load (compile-file (concatenate 'string (format nil "~a" *input*) "/" "main.lisp")
								  :verbose nil
								  :print nil))
			  (let ((-sep (string-multiply "-" 32)) (=sep (string-multiply "=" 32)))
				(format t "~%~%~a~%PROJECT DESCRIPTION~%~a~%~a~%" -sep -sep  *project-description*)
				(format t "~a~%RUNNING PROGRAM~%~a~%~%" -sep -sep)
				(setf *start-time* (get-nanoseconds-of-day))
				(setf *result* (main))
				(setf *end-time* (get-nanoseconds-of-day))
				(format t "~a~%~%~a~%" *result* =sep)
				(format t "Elapsed time: ~a ms~%" (/ (- *end-time* *start-time*) (expt 10.0 6)))
				(format t "~a~%" =sep)))
		  (error (e) (format t "~a~a"
							 "That project doesn't exist or something went wrong,"
							 " if it does exist, try debugging your solution.")))
		(format t "~%Would you like to repeat? [y/n] ")
		(setf *input-command* (get-valid-input-from-list
							   *inputs*
							   "Please select yes or no"))
		(format t "~%~%~%"))))
(quit)




