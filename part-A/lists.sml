(*
  Lists 
    Despite nested tuples , the type of a variable still "commits" to a 
    particular amount of data

  IN contrast , a list:
    - can have any number of elements
    - But all list elements have the same type.
  
  
*)

fun sum_list(xs: int list)=
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

fun countdown (x:int)=
    if x=0
    then []
    else x::countdown(x-1)

fun firsts (xs: (int * int) list)=
    if null xs 
    then []
    else (#1 (hd xs))::firsts(tl xs)

fun seconds (xs: (int * int) list)=
    if null xs 
    then []
    else (#2 (hd xs))::seconds(tl xs)

fun sum_list_2(xs: (int * int) list)=
    sum_list(firsts(xs))+sum_list(seconds(xs))

(*
  Functions over lists are usually recursive
    -- Only way to get all elements
  
  Ask these questions while working with functions over lists
    1) what should the answer be for the empty-list?
    2) what should the answer for a non-empty list?
       -- Typically in terms of the answer for the tail of the list!
      
*)

