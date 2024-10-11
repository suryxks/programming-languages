(*
  Why even have functions which are anonymous
   Definitions unnecessarily at top-level are poor stype if its going to be
   used only once

   Most common use: Argument to a higher-order function 
    - Don't need a name just pass a function

*)
fun n_times(f,n,x) =
    if n = 0
    then x
    else f(n_times(f,n-1,x))

fun triple_n_times (n,x) =
    n_times(fn x => 3 * x ,n,x)

fun nth_tail(n,xs) = n_times(tl,n,xs)

(*

*)

fun map(f,xs)=
    case xs of
     []=> []
    |x::xs' => (f x ):: map(f,xs')

val x1 = map(fn x => x + 1,[1,2,3,4])
val x2 = map( hd ,[[1,2],[3,4],[5,6,7]])

fun filter(f,xs)=
    case xs of 
        []=>[]
       |x::xs' => if f x
                  then x::(filter(f,xs'))
                  else filter(f,xs')

fun is_even x = x mod 2 = 0           

fun all_even xs = filter(is_even,xs)

(*
   First class functions are useful anywhere for any kind of data
    -> Can pass several functions as arguments
    -> Can put functions in data structures (tuples,lists,etc)
    -> Can return functions as results
    -> Can write higher-order functions that traverse your own data
      structures
*)

fun double_or_triple f =
   if f 7
   then fn x => 2*x
   else fn x => 3*x

val double = double_or_triple(fn x => x -3 = 4)
val nine = (double_or_triple(fn x => x=42)) 3

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp 

fun true_of_all_constants(f,e) = 
    case e of
       Constant i => f i
      | Negate e1 => true_of_all_constants(e1)
      | Add(e1,e2) => true_of_all_constants(e1) andalso true_of_all_constants(e2)
      | Multiply(e1,e2) =>true_of_all_constants(e1) andalso true_of_all_constants(e2)

fun all_even e = true_of_all_constants(fn x => x mod 2 = 0,e)