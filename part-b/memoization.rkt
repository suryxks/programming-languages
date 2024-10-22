#lang racket
(provide (all-defined-out))
#|
   MEMOIZATION:
    If a fuction has no side effects and does not read mutable memory, no point in computing
  it twice for the same arguments
    - Can keep a cache of previous results
    - Net win if maintaining cache is cheaper than recomputing and cached results are reused

   Similar to promises , but if the function takes arguments , then there are multiple
   "previoud results"

   For recursive functions , this memoization can lead to exponentially faster programs
     - Related to algorithmic technique of dynamic programming
|#

(define fibonacci
        (letrec ([memo null]
                 [f (lambda(x)
                           (let ([value (assoc x memo)])
                               (if value
                                   (cdr value)
                                   (let ([ans
                                            (if (or (= x 1) (= x 2))
                                             1
                                            (+ (f (- x 1)) (f (- x 2))))
                                              ])
                                     (begin
                                        (set! memo (cons (cons x  ans) memo))
                                        ans)))))])
          f))
                               