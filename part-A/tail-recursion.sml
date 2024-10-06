fun fact n =
    let fun aux(n,acc)=
            if n = 0
            then acc
            else aux(n-1 , acc*n)
    in
      aux(n,1)
    end
val x = fact 3

(*
     It is unncessary to keep around a stack-frame just so it can get a 
     callee's result and return it without any further evaluation

     ML recognizes these tail calls in the compiler and treats them 
     differntly:
      - Pop the caller before the call, allowing calle to reuse the same stack
      space
      - (Along with other optimizations), as efficient as a loop

*)


fun sum xs =
    let fun aux(xs,acc)=
          case xs of
           [] => acc
         | x::xs' => aux(xs',x+acc)
    in
       aux(xs,0)
    end

fun rev xs =
   let fun aux(xs,acc)=
       case xs of
       []=>acc
      | (x::xs')=> aux(xs',x::acc)
   in
     aux(xs,[])
   end
