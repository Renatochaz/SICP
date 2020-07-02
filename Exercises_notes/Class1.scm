;;; Class 1

;; Means of abstraction

;Defining simple operation

(define A (* 5 5))

A

(* A A)

;Defining B

(define B (+ A (* 5 A)))

B

;Operation

(+ A (/ B 5))


;; Defining a general idea

; Defining a Square

(define (square x) (* x x))

(square 10)

; Defining with the correct notation to make clear what i'm namming

;lambda is LISP way of saying "make a procedure", in this case it is: make a procedure with an argument named x, that returns the result of X * X, and name it square
(define square (lambda (x) (* x x)))

(square 10)

(square (+ 10 6))

(+ (square 2) (square 3))

(square (square (square (square 1001))))

;Defining average function
(define average (lambda (x y) (/ (+ x y) 2)))

(average 5 10)

;Defining mean-square function
(define mean-square (lambda (x y) (average (square x) (square y))))

(mean-square 2 4)

(mean-square 2 3)

;Defining absolute value
;Cond works similar to a IF statement, with the first argument () being evaluated if true, if false evaluate next argument

(define abs (lambda (x)
  (cond ((> x 0) x)
	((= x 0) 0)
	((< x 0) (- x)))))


(abs 0)
(abs 2)
(abs -3)

;; Defining a function for square root
;; The basic idea is as follow:
;; To find an aprroximation to sqrt(x)
;; Make a guess G (use 1 as initial guess)
;; Improve the guess by averaging G and X/G
;; Keep improving the guess until it is good enough
;; Use an arbitrary definition of good enough, how close it is from
;; the correct square root

(define sqrt (lambda (x)
	       (define improve (lambda (guess)
				 (average guess (/ x guess))))
	       (define good-enough? (lambda (guess)
				      (< (abs (- (square guess) x))
					.001)))
	       (define try (lambda (guess)
			     (if (good-enough? guess)
				 guess
				 (try (improve guess)))))
	       (try 1)))
(sqrt 2)
