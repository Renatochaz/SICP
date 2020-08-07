;;; 1.2.1 Linear recursion and iteration

;;; Linear recursive process
(define factorial (lambda (n)
		    (if (= n 1)
			1
			(* n (factorial (- n 1))))))
(factorial 4)

;;; Visualizing the process with substitution model
;;; (factorial 4)
;;; (* 4 (factorial 3))
;;; (* 4 (* 3 (factorial 2)))
;;; (* 4 (* 3 (* 2 1)))
;;; (* 4 (* 3 2))
;;; (* 4 6)
;;; 24

;;; Linear iterative process
(define factorial (lambda (n)
		    (fact-iter 1 1 n)))

(define fact-iter (lambda (product counter max-count)
		    (if (> counter max-count)
			product
			(fact-iter (* counter product) (+ counter 1) max-count))))
(factorial 4)
;;; Same result, but now with a process that goes
;;; (factorial 4)
;;; (fact-iter 1 1 4)
;;; (fact-iter 1 2 4)
;;; (fact-iter 2 3 4)
;;; (fact-iter 6 4 4)
;;; (fact-iter 24 5 4)
;;; 24

;;; Although the time is proportional to "n" (same number of steps), the recursive process
;;; occupy a space proportional to "n", the machine have to keep track of more information
;;; the iterative process occupy a space of "1" since the machine always have only 1 information to track
;;; Dont confund recursive procedure (a procedure that calls itself)
;;; to a recursive process
;;; Even a recursive procedure can generate a iterative process
;;; (the state of the process is captured entirely by its variables, and only needs to keep track of then
