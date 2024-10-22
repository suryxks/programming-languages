#lang racket
(provide (all-defined-out))

#|

   STREAMS:
         A stream is an infinite sequence of values
          - So cannot make a stream by making all the values
          - Key idea: Use a thunk to dealy creating most of the sequence
          - Just a programming idiom

        A powerful concept for division of labor:
          - Stream producer kows how to create any number of values
          - Stream consumer decides how many values to ask for

    we will represent streams using pairs and thunks
    
 |#

(define two-pows
  (letrec ([f (lambda(x)(cons x (lambda() (f (* x 2)))))])
       (lambda()(cons 2 (lambda() (f 4))))))

(define (number-until stream tester)
    (letrec ([f (lambda (stream ans)
                   ( let ([pr (stream)])
                      (if (tester (car pr))
                          ans
                          (f (cdr pr) (+ ans 1)))))])
      (f stream 1)))


(define ones (lambda() (cons 1 ones)))

 
