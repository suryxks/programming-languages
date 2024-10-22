#lang racket
(provide (all-defined-out))

(define xs (list 4 5 6))
(define ys (list (list ( list 4  (list 5 0)) 6 7 (list 8) 9 2 3 (list 0 1))))

(define (sum1 xs)
    (if (null? xs)
         0
         (if (number? (car xs))
             (+ (car xs) (sum1 (cdr xs)))
             (+ (sum1 (car xs)) (sum1 (cdr xs))))))

(define (sum2 xs)
    (cond [(null? xs) 0]
          [(number? (car xs)) (+ (car xs) (sum2 (cdr xs)))]
          [(list? (car xs)) (+ (sum2 (car xs)) (sum2 (cdr xs)))]
          [#t (sum2 (cdr xs))]))

#|
    For both if and cond, test expression can evaluate to anytbing
        - It is not an error if the result is not #t or #f

    Semantics of if and cond
      - Treat anything other than #f as true
       
    
  
 |#