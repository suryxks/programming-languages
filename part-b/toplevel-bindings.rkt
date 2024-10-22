#lang racket
(provide (all-defined-out))

;; MUTATION WITH SET
(define b 3)
(define f (lambda (x) (* 1 (+ x b))))
(define c (+ b 4)); 7 evaluates with b=3
(set! b 5)
(define z (f 4)); 9 evaluates with b set to 5
(define w c) ; 7

#|
   - Environement for closure is determined when the function is defined, but the body
     is evaluated when function is called
   - Once an expression produces a value , it is irrelevant how the value was produced
     
  
  |#

(define b1 3)
(define f1
   (let ([b1 b1])
       (lambda (x) (* 1 (+ x b1)))))

(set! b1 5)

#|
  Mutating top-level definitions is particularly problematic
  - What if any code could do set! on anything
  - How could we defend against this?

  A General principle: if something you need not to change might change
  make a local copy of it . see the above f1 for ex


 cons just makes a pair
   - Often called a cons cell
   - By convention and standard library, lists are nested pairs that eventually
     end with null

   A proper list is a series of nested cons cells where the second element of the innermost
   cons cell is null
 |#

(define mpr (mcons 1 (mcons #t "hi")))
;; why mcons ? we cannot mutate lists or pairs created using set! so if one needs a mutable list or
;; pair mcons can be used

