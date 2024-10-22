#lang racket
(provide (all-defined-out))

; Thunks let you skip expensive computations if they are not needed

(define (slow-add x y)
    (letrec ([slow-id (lambda (y z)
                         (if (= 0 z)
                             y
                             (slow-id y (- z 1))))])
       (+ (slow-id x 500000000) y)))

(define (my-mult x y-thunk)
    (cond [(= x 0) 0]
          [(= x 1) (y-thunk)]
          [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

;; when you pass in a thunk it is never called when x = 0

#|
  Best of both worlds:

   Assuming some expensive computation has no side effects, ideally we would:
    - Not compute it unitl needed
    - Remember the answer so future uses complete immediately called lazy evaluation

   Languages where most constructs, including function arguments. work this way are lazy
   languages Ex: Haskell

   Racket predefines support for promises , but we can make our own
     - Thunks and mutable pairs are enough
 
 |#