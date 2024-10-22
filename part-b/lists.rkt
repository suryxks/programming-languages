#lang racket

(provide (all-defined-out))
; Empty list : null
; Constructor : cons
; Access head of list: car
; Access tail of list: cdr
; Check for empty: null?

; Sum all the elements in the list

(define (sum xs)
      (if (null? xs)
          0
          (+ (car xs) (sum (cdr xs)))))

; append

(define (my-append xs ys)
      (if (null? xs)
           ys
           (cons (car xs) (my-append (cdr xs) ys))))

(define (my-map f xs)
    (if (null? xs)
         xs
        (cons (f (car xs)) (my-map f (cdr xs)))))
