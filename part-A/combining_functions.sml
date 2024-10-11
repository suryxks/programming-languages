(* ('b -> 'c ) * ('a -> 'b) -> ('a -> 'c) *)

fun compose(f,g)= fn x => f(g x)

fun sqrt_of_abs i = Math.sqrt(Real.fromInt (abs i))
fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i
(* infix !>
fun sqrt_of_abs i = i |> abs |> Real.fromInt |> Match.sqrt *)

fun backup1(f,g) = fn x => case f x of 
                                 NONE => g x
                               | SOME y => y

(*
  
   
*)

fun sorted3_tuple (x,y,z) =  z >= y andalso y >= x
val t1 = sorted3_tuple(7,9,11)

val sorted3= fn x => fn y => fn z => z >= y andalso y>=x

val t2= sorted3 7 12 11

fun sorted3_nicer x y z = z>=y andalso y>=x

(* both sorted3 and sorted3_nicer are the same sml treats multiple arguments
  like in sorted3 the nicer one is just syntactic sugar
*)

fun fold f acc xs = 
    case xs of
     []=>acc
    | x::xs' => fold f (f(acc,x)) xs'

fun sum xs = fold (fn(x,acc) => x+acc) 0 xs  