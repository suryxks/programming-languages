(*
  The idea is to traverse a list and produce a single result
*)

(*fn: 'a *'b -> 'a , 'a , 'b list *)
fun fold(f,acc,xs)=
    case xs of
     []=> acc
    | x::xs => fold(f,f(acc,x),xs)

(*
  Accumulates an answer by repeatedly applying f to answer so far 
    - fold(f,acc,[x1,x2,x3,x4]) computes
      f(f(f(f(acc,x1),x2),x3),x4)
    - The above version folds left ; another version folds right
    - Whether the direction matters depends on f
*) 

(*
  Why Iterators again?

  This pattern seperates recursive traversal from data processing
    - Can reuse same traversal for differnt data prcessing
    - Can reuse same data processing for different data
    - In both cases, using common vocabulary concisely communicates intent
*)

fun sum xs = fold((fn (x,y) => x + y),0,xs)

fun is_all_positive xs = fold((fn (x,y)=> x andalso y >= 0), true ,xs)

fun f3 (xs,lo,hi) = 
    fold((fn(x,y)=>
            x + (if y>=0 lo andalso y<=hi then 1 else 0) 
            ),0,xs)

(*
  --> Functions like map,filter and fold are much powerful thanks to closures and
   lexical scope
  --> Function passed in can use any "Private" data in its environment
  --> Irerator "does not even know the data is there" or what type it has
*)


