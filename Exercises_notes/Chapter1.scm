;;; This file make notes about the sub-chapters
;;; And do the exercises of the chapters associated with the sub-chapters within the named sub-section

;;; 1.1.1 - Expressions

;;; Primitive expression - number

;;;Exercise 1.1

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

;;; 1.1.2 - Naming and the Environment

;;; Names identify a varible which the value is the object
;;; *define* is used to name things.

;;;Exercise 1.1
(define a 3)

a

;;; It is the simplies way of abstraction
;;; It is useful to name compound operations and later call them by names, instead of memorizing the procedures
;;; This way complex programs can be created incrementally
;;; Those values associated with symbols (names) are memorized to the *enviroment* or *global enviroment* since multiple enviroments can be used

;;; 1.1.3 - Evaluating Combinations

;;; The evaluation rule is such as:
;;; Evaluate the subexpressions of the combination and
;;; apply the procedure that is the leftmost subexpression (operator) to the arguments that are the value of the subexpressions
;;; And we take note that: The value of numerals are the numbers they name
;;; The value of built-in operators (like + or -) are the machine instructions sequence that carry the operation and
;;; The value of other names are the *objects* associated with those names in the environment (enviro)

;;; Special forms are exceptions to this rule, like *define* :
;;; (Define a 3) does not apply define to a and 3, since the purpose to define is to associate a to a value (in this case, 3)
;;; Each special form has its own evaluation rule.
;;; The syntax of this programming language (LISP) is very symple, with the general rule defined above and some special forms own evaluation rules.

;;; 1.1.4 Compound procedures

;;; A compound procedure can be named, and this name represent the body of the procedure named
;;; the form is: (define (<name> <formal parameters>) <body>)

(define square (lambda (x) (* x x)))

(square 2)

;; It is a compound procedure named square

;;;Exercise 1.1

(define b (+ a 1))

(+ a b (* a b))

(= a b)

;;;1.1.5 - Substitution model for procedure application
;;; Nota that the substitution model is just a preliminar model to start thinking about procedure application
;;; Later on more complicated models will be introduced that are in pair with the interpreter functionality
;;; Now let an example take place, defining some stuff:

;;; First compound procedure

(define square (lambda (x) (* x x)))

;square is now a operator, definied with the formal parameter x, and body (* x x), this is a compound procedure

(define sum-of-squares (lambda (x y) (+ (square x) (square y))))
;compound procedure that uses other compond procedure

(define f (lambda (a) (sum-of-squares (+ a 1) (* a 2))))

(f 5)
; value 136

;;; To evaluate (f a), the substitution model will evaluate the body of the
;;; procedure f (sum-of-squares (+ a 1) (* a 2)), and replacete with
;;; the formal parameters for a: (sum-of-squares (+ 5 1) (* 5 2))
;;; Evaluating this leads to 6 and 10, so now the model will evaluate again
;;; with the new values and the body of the left operator (sum of squares)
;;; this leads to (+ (square 6) (square 10)), and this reduces to:
;;; (+ (* 6 6) (* 10 10)), that finally evaluates to 136

;;; An alternative method is the normal order, which woudn't evaluate the operands till their values were needed
;;; In this case, it would substitute operands until only primitive expressions remains, and then evaluate
;;; (f 5) would reduce to > (sum-of-squares (+ 5 1) (* 5 2)) > (+ (square (+ 5 1) square (* 5 2))) >
;;; (+ (* (+ 5 1) (+ 5 1)) (* (*5 2) (*5 2))), and then evaluate to > (+ (* 6 6) (* 10 10)) > (+ 36 100) > 136
;;; there are some cases where normal order and substitution doesn't yied equivalent values.
;;; normal order loses efficiency to some redudance of evaluation, but is valuable in some cases (later apresented)

;;; 1.1.6 - Conditional expressions and predicates

;;; General form of a conditional expression (cond):
;;; (cond (<p1> <e1>))
;;;       (<p2> <e2>))
;;;   ... (<pn> <en>))

;;; (<p> <e>) is the clause, with <p> being the predicate and <e> the consequent expression if the predicate <p> =true
;;; the cond expression evaluates the first predicate <p1>, if its true returns <e1>,if false evaluates <p2>
;;; this goes on until a predicate is TRUE, then it stops after returning the consequent expression.
;;; if no predicate is true, the cond is undefined
;;; Else can be used at the last predicate to always return a value if all predicates are false (or any expression that
;;; always evaluate to true instead of else).
;;; If expressions can be used in almost the same way, but without else with the general form (if <p> <e> <alternative>)
;;; that always returns the alternative if p is FALSE :
;;; (if ( < x 0)
;;;     (- x)
;;;     x)

;;; There is also logical compositions operators, such as: and, or and not.
;;; not inverse the evaluation (both ways from true to false)
;;; not is a ordinary procedure, or & and are special forms, since subexpressions are not necessarily evaluated
;;; examples:

; 5 < x < 10
(define test (lambda (x) (and (> x 5) (< x 10))))
(test 3)
(test 7)

;number greater or equal to another
(define >= (lambda (x y) (or (> x y) (= x y))))
(>= 3 4)
(>= 4 3)

(define >= (lambda (x y) (not (< x y))))
(>= 3 4)
(>= 4 3)

;;; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 3))))) (* 3 (* (- 6 2) (- 2 7))))
; -43/180

;;; Exercise 1.3

(define square (lambda (x) (* x x)))

(define sum-of-squares (lambda (x y) (+ (square x) (square y))))

(define larger (lambda (x y z)
		 (cond ((and (< x y) (< x z)) (sum-of-squares y z))
		       ((and (< y x) (< y z)) (sum-of-squares x z))
		       (else (sum-of-squares x y)))))

(larger 1 2 3) ;13
(larger 3 2 4) ;25
(larger 4 5 1) ;41

;;; Exercise 1.4

(define a-plus-abs-b (lambda (a b)
		       ((if (> b 0) + -) a b)))
; Since we can use compound expressions as operators, this functions uses
; this property to make a if statement as operator, if b is a negative value
; the if will return the primitive operator (-) which will turn the
; -b in +b, (the absolute value of b)


