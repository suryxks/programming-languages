val x = 34;
val y = 54;

val z =(x+y)+(y+2);

(* 
  Every kind of expression has
  1. syntax
  2. Type-checking rules
     -> Produces a type or fails (with a bad error message)
  3. Evaluation rules (used only on things that type check)
     -> Produces a value (or exception or infinite-loop)

  Values
   --> All values are expressions
   --> Not all expressions are values
   --> Every value "evaluates to itself" in "zero steps"
   ex:
     - 34,17,42 have type int
     - true,false have type bool
     - () has type unit
    
    less than operator 
    e1 < e2
    syntax:
      e1 and e2 are expressions and we have < operator between the two expressoins
    type checking rules;
      e1 should be of type int and e2 should be of type int
      the type of the entire expression is bool
    Evalueation rules:
      e1 evaluates to v1 and e2 evaluates to v2 
      if v1<v2 the whole result of the expression is true
      else it is false

 *)
 
 val a = 10

 val b = (2 * a)
 val c = b-1;

 val a = 25;
 (* *)