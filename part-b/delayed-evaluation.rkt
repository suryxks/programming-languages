#lang racket
(provide (all-defined-out))

#|
    For each language construct, the semantics specifies when subexpressions ge evaluated
    In ML,Racket , Java, C :
                 - Function aruments are eager (call-by-value)
                     * Eavluated once before calling the fuction
                 - Conditional branches are not eager
  


  
  |#


(define (factorial-normal x)
     (if (= x 0)
         1
         (* x (factorial-normal (- x 1)))))

(define (my-if-bad e1 e2 e3)
      (if e1 e2 e3))


(define (factorial-bad x)
     (my-if-bad (= x 0)
         1
         (* x (factorial-bad (- x 1)))))

(define (my-if e1 e2 e3)
    (if e1 (e2) (e3)))

(define (fact x)
   (my-if (= x 0) (lambda() 1) (lambda() (* x (fact (- x 1))))))

