(*
   - A function body is not evaluated until the function is called
   - A function body is evaluated every time the function is called
   - A variable binding evaluates its expression when the binding is 
     evaluated , not every time it is used

    with closures , this means that we can avoid repeating computations that
    do not depend on function arguments
    - Not so worried about performance , but good example to emphasize 
      the semantics of functions and function closure
    

   
*)

fun filter (f,xs) = 
    case xs of 
      []=> []
      | x::xs' => if f x then x::filter(f,xs') else filter(f,xs')

fun allGreaterThan (xs,s)=
    filter(fn x => String.size(x) < String.size(s),xs)

fun allGreaterThan2 (xs,s)=
   let
      val i = String.size s
    in 
      filter(fn x => String.size(x) < i,xs)
    end
