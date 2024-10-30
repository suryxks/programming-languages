#lang racket
(provide (all-defined-out))

(define (funny-sum xs)
  (cond [(null? xs ) 0]
        [(number? (car xs)) (+ (car xs) (funny-sum (cdr xs)))]
        [(string? (car xs)) (+ (string-length (car xs)) (funny-sum (cdr xs)))]))

(define (Const i) (list 'Const i))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2 ) (list 'Multiply e1 e2))

(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

(define (Const-int e) (car (cdr e)))
(define (Negate-e e) (car (cdr e)))
(define (Add-e1 e) (car (cdr e)))
(define (Add-e2 e) (car (cdr (cdr e))))
(define (Multiply-e1 e) (car (cdr e)))
(define (Multiply-e2 e) (car (cdr (cdr e))))

(define (eval-exp e)
    (cond [(Const? e) e]
          [(Negate? e) (Const (- (Const-int (eval-exp (Negate-e e)))))]
          [(Add? e) (let ([ v1 (Const-int (eval-exp (Add-e1 e)))]
                         [ v2 (Const-int (eval-exp (Add-e2 e)))])
                      (Const (+ v1 v2)))]
          [(Multiply? e) (let ([v1 (Const-int (eval-exp (Multiply-e1 e)))]
                         [v2 (Const-int (eval-exp (Multiply-e2 e)))])
                      (Const (* v1 v2)))]))


(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

(define (eval-exp2 e)
    (cond [(const? e) e]
          [(negate? e) (const (- (const-int (eval-exp2 (negate-e e)))))]
          [(add? e) (let ([ v1 (const-int (eval-exp2 (add-e1 e)))]
                         [ v2 (const-int (eval-exp2 (add-e2 e)))])
                      (const (+ v1 v2)))]
          [(multiply? e) (let ([v1 (const-int (eval-exp2 (multiply-e1 e)))]
                         [v2 (const-int (eval-exp2 (multiply-e2 e)))])
                      (const (* v1 v2)))]))





#|
  Why use structs approach:
    - Is better style and more concise for defining data types
    - Is about equally convenient for using data types
    - But much better at timely errors when misusing data types
      --> Cannot use accessor functions on wrong kind of data
      --> Cannot confuse tester functions

   read the code above once

   Struct is special
    Often we end up learning that some convineient feature could be coded up with other features

    NOt so with struct definitions
    - A function cannot introduce  multiple bindings
    - Neither functions nor macrs can create a new kind of data
      --> Result of constructor function returns #f for every other
          tester function: number? , pari? , other structs tester functions, etc
     
 |#

          