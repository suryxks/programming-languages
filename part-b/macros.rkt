#lang racket
(provide (all-defined-out))

#|

  A macro definition describes how to transform some new syntax into different syntax in the source
  language

  A macro is one way to implement syntactic sugar

  A macro system is a language (or part of  a larger language) for defining macros

  Macro expansion is the process of rewriting the syntax for each macro use
  - Before a program is run (or even compiled)


 If you define a macro m in Racket, then m becomes a new special form:
 - Use (m ...) gets expanded according to definition

 Example definitions
  - Expand (my-if e1 then e2 else e3)
    to (if e1 e2 e3)
 
 |#

(define-syntax my-if
   (syntax-rules (then else)
     [(my-if e1 then e2 else e3)
      (if e1 e2 e3)]))

(define-syntax comment-out
  (syntax-rules ()
    [(comment-out ignore instead)
      instead]))

#|
  A macro can put an expression under a thunk
  - Delays evaluation without explicit thunk
  - Cannot implement this with a function
 
  Now client then should not use a thunk (that would double-thunk)
  - Racket's pre-defined delay is a similar macro 
 |#

(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e) (mcons #f (lambda() e))]))