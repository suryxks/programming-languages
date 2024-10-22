#lang racket
(provide (all-defined-out))
; Racket has an amazingly simple syntax

#|

    A term (anything in the language) is either
     - An atom, eg #t, #f ,34,,"hi",null ,4.0
     - A special form eg: define , lambda , if
        * Macros will let us define our own
     - A sequence of terms in parens : (t1 t2 ..tn)
        * If t1 is a special form , semantics of the sequence is special
        * Else a function call

   WHY IS THIS GOOD ?
      By parentesizing everything, converting the program text into a tree representing
     the program (parsing) is trivial and unambiguous
       - Atoms are leaves
       - Sequences are nodes with elements as children
       - (No other rules)

     example:

    |------------------|                     define
    |  (define cube    |                      /  \
    |   (lambda (x)    |                   cube   lambda
    |      (* x x x))) |                           /   \
    |------------------|                          x     *
                                                       /|\
                                                      x x x


  PARENTHESES MATTER:

     - Do not add/remove parens because you feel like it
       * Parens are never optional or meaningless
     - In most places (e) means call e with zero arguments
     - So ((e)) means call e with zero arguments and call the result with zero arguments

  without static typing , often get hard-to-diagnose run-time errors
   
|#

(define xs (list 4 5 6))
(define ys (list (list ( list 4  (list 5 0)) 6 7 (list 8) 9 2 3 (list 0 1))))

(define (sum1 xs)
    (if (null? xs)
         0
         (if (number? (car xs))
             (+ (car xs) (sum1 (cdr xs)))
             (+ (sum1 (car xs)) (sum1 (cdr xs))))))