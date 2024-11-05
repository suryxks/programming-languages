;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; CHANGE (put your solutions here)
(define (racketlist->mupllist lst)
   (if (null? lst)
       (aunit)
       (apair (car lst) (racketlist->mupllist (cdr lst)))))

(define (mupllist->racketlist lst)
  (if (aunit? lst)
       null
       (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))))

;; Problem 2

                         
     
  
;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(aunit? e) e]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        [(int? e) e]
        [(mlet? e)
           (let* ([menv (list (cons (mlet-var e) (eval-under-env (mlet-e e) env)))])
                     (eval-under-env (mlet-body e) (append menv env)))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
            (if (and (int? v1) (int? v2) (> (int-num v1) (int-num v2)))
                (eval-under-env (ifgreater-e3 e) env)
                (eval-under-env (ifgreater-e4 e) env)))]
        [(fun? e)(closure env e)]
        [(closure? e) (closure (append env (closure-env e)) (closure-fun e))]
        [(call? e)
          (let ([v1 (eval-under-env  (call-funexp e) env)]
                [v2 (eval-under-env  (call-actual e) env)])
            (if (closure? v1)
                (eval-under-env
                  (fun-body (closure-fun v1))
                  (append
                   (list (cons (fun-nameopt (closure-fun v1)) v1))
                   (list (cons (fun-formal (closure-fun v1)) v2))
                   (closure-env v1)
                   env
                   ))
                (error "Not a closure")))]
        [(apair? e)
          (apair (eval-under-env (apair-e1 e) env) (eval-under-env (apair-e2 e) env))]
        [(fst? e)
         (let ([res (eval-under-env (fst-e e) env)])
           (if (apair? res)
               (apair-e1 res)
               (error "result does not evaluate to a pair")))]
        [(snd? e)
         (let ([res (eval-under-env (snd-e e) env)])
           (if (apair? res)
               (apair-e2 res)
               (error "result does not evaluate to a pair")))]
         [(isaunit? e)
         (let ([res (eval-under-env (isaunit-e e) env)])
           (if (aunit? res)
               (int 1)
               (int 0)))]              
        ;; CHANGE add more cases here
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3)
   (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (mlet (car (car lstlst)) (cdr (car lstlst)) (mlet* (cdr lstlst) e2))))

(define (ifeq e1 e2 e3 e4)
  (ifgreater (add e1 (ifgreater e1 e2 e1 e2)) (add e1 e1) e4 e3))
  

;; Problem 4

;(define mupl-map
; (closure '()
;     (fun "maper" "f" (closure '()
;       (fun "apply" "lst" 
;            (ifaunit (var "lst")
;                  (aunit)
;                  (apair
;                   (call (var "f") (fst (var "lst")))
;                   (call (call (var "maper") (var "apply")) (snd (var "lst"))))))))))

(define mupl-map
 (fun "map-fun" "fn"
      (fun "map-lst" "lst"
	   (ifeq (isaunit (var "lst")) (int 1)
		 (aunit)
		 (apair (call (var "fn") (fst (var "lst")))
			(call (var "map-lst") (snd (var "lst"))))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map
	(fun "mupl-fun-int" "i"
	     (fun "mupl-fun-list" "ml-int"
		  (call (call (var "map") (fun "add-i" "x" (add (var "x") (var "i"))))
			(var "ml-int"))))))
    
  
;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
