val x = 7

fun pow(x:int ,y:int)=
    if y=0
    then 1
    else x * pow(x,y-1)

fun cube(x:int) = pow(x,3)

val sixtyFour = cube(4)

val fortytwo = pow(2,2+2) + pow(4,2) + cube(2) + 2

(*
  in expressions * means multiplication
  in types * used for seperating types of different argumenrs eg: int*int denotes
  two values of type int

  in ML you cannot refer to later function bindings
  --> helper functions should come before their uses
  --> Need special construct for mututal recursion
*)

(*
  FUNCTION BINDINGS: 3 QUESTIONS

   1) Syntax:
   2) Evaluation
   3) Type-checking
*)