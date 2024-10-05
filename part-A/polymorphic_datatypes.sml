datatype 'a option = NONE | SOME of 'a

datatype 'a mylist = Empty | Cons of 'a * 'a mylist

datatype ('a,'b) tree = 
         Node of 'a * ('a,'b)tree * ('a,'b) tree
       | Leaf of 'b

(*
   Functions will be polymorphic or not based of how data is used
*)

fun sum_tree tr=
     case tr of
         Leaf i => i
      | Node(i,lft,rt)=> i +  sum_tree lft + sum_tree rt

fun sum_leaves tr =
     case tr of
     Leaf i => i
     | Node(i,left,right)=> sum_leaves left + sum_leaves right

(*
    so-far we used pattern-matching for one-of types because we needed a way
    to access the values

    Pattern matching can also be used for each-of types 
*)

fun sum_triple triple=
  case triple of
    (x,y,z) => x + y + z 

fun full_name r = 
   case r of
     {first =x , middle = y, last=z}=>x ^ " " ^ y ^ " " ^ z

(*
    variable bindings are special kind of patterns which matches against the 
    entire result  of evaluating the expression.

    Great for getting all pieces out of an each-of-type 
     -- Can also get only parts out
    
    Usually Poor style to put a constructor pattern in a val-binding
     -- Tests for the one variant and raises an exception if a different
      one is there (like hd,tl and valOf)
*)

fun sum_triple triple=
    let val  (x,y,z) = triple
    in 
        x + y + z 
    end

fun full_name r =
    let val {first = x, middle = y, last = z} = r
    in
      x ^ " " ^ y ^ " " ^ z
    end
 
(* 
   Function-argument patterns

   A function argument can also be a pattern
    - Match against the argument in a function call
*)

fun sum_triple (x,y,z) = 
    x + y + z 

fun full_name {first=x, middle=y,last=z}=
    x ^ " " ^ y ^ " " ^ z

(*
   1) In ML, every function takes exactly one argument 
   2) What we call multi-argument functions are just functions taking 
      one tuple argument , implemented with a tuple pattern in the function
      binding
      -- Elegant and flexible language desing
   3) Enables cute and useful things you cannot do in java 
   4) "Zero arguments" is the unit pattern () matching the unit value ()
  

*)
