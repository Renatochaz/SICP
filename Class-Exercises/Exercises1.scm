;;; 1.1

;;; Primitive expression
;;; Number

10

;;; Compound expression (combination)
;;; Combining primitive expression with a compound procedure ( + )
;;; Applicate the procedure to the numbers
;;; Leftmost element is the operator, and the other elements are operands
;;; Value of the combination is obtained by applying the procedure specified by the operator to the *arguments* that are the operands

(+ 5 3 4)
(- 9 1)
(/ 6 2)

;;; Combinations can be nested, the combination have elements that are themselves combinations
;;; The interpreter operates the same way:
;;; Reads an expression from the terminal -> evaluate the expression > print the result. the read-eval-print loop
;;; Nesting

(+ (* 2 4) (- 4 6))

;;; Naming
;;; Names identify a varible which the value is the object
;;; *define* is used to name things.

(define a 3)
a
;;; It is the simplies way of abstraction
;;; It is useful to name compound operations and later call them by names, instead of memorizing the procedures
;;; This way complex programs can be created incrementally
;;; Those values associated with symbols (names) are memorized to the *enviroment* or *global enviroment* since multiple enviroments can be used



