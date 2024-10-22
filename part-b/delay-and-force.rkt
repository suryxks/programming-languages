#lang racket
(provide (all-defined-out))

#|
  Assuming some expensive computation has no side effects, ideally
  we would:
      - Not compute it until needed
      - Remember the answer so future uses complete immediately
  called lazy evaluation
 |#

(define (my-delay th)
   (mcons #f th))

(define (my-force p)
   (if (mcar p)
       (mcdr p)
       (begin  (set-mcar! p #t)
               (set-mcdr! p ((mcdr p)))
               (mcdr p))))
#|
  An ADT represented by a mutable pair
  * #f in car means cdr is unevaluated thunk
    - Really a one-of type: Thunk or result-of-thunk
  * Ideally hide representation in a module
 |#

(define (my-mult x y-thunk)
    (cond [(= x 0) 0]
          [(= x 1) (y-thunk)]
          [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

(define (slow-add x y)
    (letrec ([slow-id (lambda (y z)
                         (if (= 0 z)
                             y
                             (slow-id y (- z 1))))])
       (+ (slow-id x 500000000) y)))

(define (tes x)
  (my-mult x (let ([p (my-delay (lambda () (slow-add 3 4)))])
             (lambda () (my-force p)))))

#|
   With thunking second argument:
     - Great if first argument 0
     - Okay if first argument 1
     - worse otherwise

   With precomputing second argument
    - Okay in all cases

   With thunk that uses a promise for second argument:
    - Great if first argumetn 0
    - Okay otherwise
    
 |#