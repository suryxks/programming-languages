#lang racket
(provide (all-defined-out))

#|

  - Interpreter can assume input as a legal AST for B
     * Okay to give wrong answer or inscrutable error otherwise
  - Interpreter must check that recursive results are the right kind of value
     * Give a good error message otherwise 
  
 |#

(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

