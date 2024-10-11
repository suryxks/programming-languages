(*
   Much of sofware develop ment is designing precise interfaces; what a pl means
   is a really good example
*)

(*
     ------------------- Lexical Scope---------------------------------

    We know that function bodies can use any bindings in scope 
    But now that functions can be passed around: In scope where?

        where the function was defined (not where it was called)
    

    CLOSURES :
        How can functions be evaluated in old environments that aren't around
        anymore?
         - The language implementation keeps them around as necessary
        
        Can define the semantics of functions as follows:
    --> A function value has two parts
        1) The code
        2) The environment that was current when the function was defined 
val sorted3= fn x => fn y => fn z => z >= y andalso y>=x
    --> This is a pair but unlike ML pairs , you cannot access the pieces
    --> All you can do is call this pair
    --> This pair is called function closure


*)
val x = 1

fun f y =
    let val x = y+1
    in 
       fn z => x +y +z
    end

val x = 3
val g = f 4
val y = 5

val z = g 6


fun f g =
     let
       val x = 3
     in
       g 2
     end
(* val x =4 *)
fun h y = x + y

val z = f h

(*
   Lexical Scope : 
     To look up variables in the environment where the function was defined
   Dynamic Scope :
     To look up variables in the environment where the function was called
*)

(*
-------------------------------Why Lexical Scope---------------------------
  1) Function meaning does not depend on variable names used

  Example: Can change body of f to use q everywhere instead of x in the below example
    - Lexical scope: It cannot matter
    - Dynamic sope: It depends on how result is used

  2) Functions can be typechecked and reasoned about where defined
  3) Closures can easily store the data they need 

*)

fun f1 y =
    let
      val x = y + 1
    in
      fn z => x + y + z
    end

fun f2 y =
    let
      val q = y + 1
    in
      fn z => q + y + z
    end

val x = 99
val a1 = (f1 7)(4)
val a2 = (f2 7)(4) 

(*
   Here the value of x does not matter both a1 and a2 evaluated to 19 
   If it were to use dynamic scoping a1 would have evaluated to 19
   and a2 would throw an error 
*) 

fun filter (f,xs) = (f,xs)
    case xs of 
      []=> []
      | x::xs' => if f x then x::filter(f,xs') else filter(f,xs')

fun greaterThanx x = fn y => y > x

fun nonegatives xs = filter(greaterThanx ~1 , xs)

fun allGreater (xs,n) = filter(fn x => x>n, xs)

(*
   Does dynamic scope exist?
   1) Lexical scope for variables is definitely the right  default
     - Very common across languages
   2) Dynamic scope is occasionally convinient in some situations
      - So some languages (eg: racket) have special ways to do it
      - But most do not bother
   3) Exception handling is more like dynamic scope:
     - raise e transfers control to current innermost handler
     - Does not have to be sytactically inside a handlr expression

*)