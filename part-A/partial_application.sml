(*
      1) Previosly used currying to simulate multiple arguments
      2) But if caller provides "too few" arguments , we get back a 
        closure "waiting for the remaining arguments"
          -- Called Partial application
          -- Convenient and useful
          -- Can be done with any curried function
*)
fun fold f acc xs = 
    case xs of
     []=>acc
    | x::xs' => fold f (f(acc,x)) xs'

val sorted3= fn x => fn y => fn z => z >= y andalso y>=x

val is_nonnegative = sorted3 0 0

val sum = fold (fn (x,y)=> x+y) 0

fun range i j = if i>j then [] else i:: range (i+1) j

val countup = range 1

val removeZeros = List.filter (fn x => x <> 0)

val xs = countup 7

fun curry f = fn x=> fn y=> f(x,y)

val curried_range = curry