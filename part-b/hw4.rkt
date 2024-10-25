
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
        (if (> low high)
            null
            (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
        (map (lambda(x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
     (if (< n 0)
         (error "list-nth-mod: negative number")
         (if (= (length xs) 0)
             (error "list-nth-mod: empty list")
             (letrec ([rem (remainder n (length xs))]
                     [f (lambda(pos ls)(if (= pos rem)
                                           (car ls)
                                           (f (+ pos 1) (list-tail xs (+ pos 1)))))])
               (f 1 xs)))))

(define (stream-for-n-steps s n)
        (if (= n 0)
            null
           (cons (car(s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define (funny-number-stream)
        (letrec ([f (lambda(x) (if (= 0 (remainder x 5))
                                (cons (- 0 x) (lambda()(f (+ x 1))))
                                (cons x (lambda()(f (+ x 1))))))])
          (cons 1 (lambda()(f 2)))))

(define (dan-then-dog)
         (letrec ([f (lambda(x) (if (= 0 (remainder x 2))
                                (cons "dog.jpg" (lambda()(f (+ x 1))))
                                (cons "dan.jpg" (lambda()(f (+ x 1))))))])
          (cons "dan.jpg" (lambda()(f 2)))))

(define (stream-add-zero s)
        (lambda() (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
        (letrec ([f (lambda(lst n)(cons
                                   (list-ref lst (remainder (- n 1) (length lst)))
                                   (lambda()(f lst (+ n 1)))))]
                 [helper (lambda(x xs ys)(cons (cons (car (f xs x)) (car (f ys x)))
                                   (lambda()(helper (+ x 1) xs ys)))
                 )])
          (lambda()(helper 1 xs ys))))

(define (vector-assoc v vec)
        (letrec ([f (lambda(v vec pos)
                      (if (>= pos (vector-length vec))
                           #f
                           (let ([value (vector-ref vec pos)])
                                (if (equal? (car value) v)
                                 value
                                 (f v vec (+ pos 1))))))])
          (f v vec 0)))
                                              
(define (cached-assoc xs n)
    (let ([cache (make-vector n (cons #f #f))]
          [cache-index 0]
          )
        (lambda(v)(let* ([value (vector-assoc v cache)])
                       (if value
                           (cdr value)
                           (let ([assoc-value (assoc v xs)])
                                (if assoc-value
                                    (begin
                                       (vector-set! cache cache-index  (cons v assoc-value))
                                       (set! cache-index (remainder (+ 1 cache-index) n))
                                       assoc-value)
                                       assoc-value
                                    )))))))
                                  
                           
                    
  