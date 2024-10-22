#lang racket
(provide (all-defined-out))

(define (max-of-list xs)
       (cond [(null? xs) (error "max-of-list given empty list")]
             [(null? (cdr xs)) (car xs)]
             [#t ( let ([tlans (max-of-list (cdr xs))])
                    (if (> tlans (car xs))
                    tlans
                    (car xs)))]))

#|
  Racket has 4 ways to define local variables
   - let
   - let *
   - letrec
   - define

   Variety is good: They have different semantics
   - Use the one most convenient for your needs, which hellps
     communicate your intent to people reading your code
      * If any wil work use let


  LET
   a let expression can bind to any number of local variables
    - Notice where all the parentheses are
   The expressions are all evaluated in the environment from before the let-expression
   - Except the body can use all the local variables of course
   - Convenient for things like (let ([x y][y x]))
   
 |#



(define (silly-double1 x)
    (let ([x (+ x 3)] ; x in x+3 is the parameter 
          [y (+ x 2)]) ; x in x+2 is not the binding created before this expression but the parameter 
      (+ x y -5)))

#|
  let * :
   The expressions are evaluated in the environment produced from the previous bindings
      - Can repeat bindings
      - This is how ML let-expressions work
 |#

 (define (silly-double2 x)
    ( let* ([x (+ x 3)]  ; x in x + 3 is the paramter
           [y (+ x 2)]) ; x in x+2 is the binding created in the previous line
       (+ x y -8)))
;; Try changing let* -> let to see the difference


#|

  Letrec
     The expressions are evaluated in the environment that includes all the bindings
     - Needed for mutual recursion
     - But expressions are still evaluated in order : accessing an uninitialized binding
      produce an error
     - Function bodies are not evalueated until called
 |#

 (define (silly-triple x)
    (let* ([y (+ x 2)]
           [w (+ x 7)]
          [f (lambda(z)(+ z y w x))]
          )
      (f -9)))


