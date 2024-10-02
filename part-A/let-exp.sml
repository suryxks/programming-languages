(*
  Let-expressions
  3-questions:
    1) Syntax: let b1 b2 ... bn in e end
      - Each bi is any binding and e is any expression

    2) Type-checking: type check each bi and e in a static
    environment that includes the previous bindings.
    Type of whole let-expressions is the type of e

    3) Evaluation: Evaluate each bi and e in a dynamic environment that
      includes the previous bindings.
      Result of the whole let-expression is the result of evaluating e
*)
fun silly1 (z:int)=
    let 
       val x=if z>0 then z else 34
       val y = x + z + 9
    in
      if x > y then x * 2 else y * y
    end

fun silly2 () =
    let 
       val x = 1
    in 
       (let val x = 2 in x + 1 end) + (let val y = x+2 in y+1 end)
    end



fun countup_from1(x:int)=
   let 
      fun count (from:int)=
          if from=x
          then x::[]
          else from::count(from+1)
   in
      count(1)
   end

(* 
 Nested functions: style
  --> Good style to define helper functions inside the functions they help if 
  they are:
    1) Unlikely to be useful elsewhere
    2) Likely to be misused if available elsewhere
    3) Likely to be changed or removed later
  
  A fundamental trade-off in code design: reusing code saves effort and avoids
  bugs , but makes the reused code harder to change later
  
*)

fun countdown (x:int)=
    if x=0
    then []
    else x::countdown(x-1)

fun countup (x:int,y:int)=
   if x=y
   then y::[]
   else x::countup(x+1,y)

fun bad_max(xs: int list)=
   if null xs
   then 0
   else if null (tl xs)
   then hd xs
   else if hd xs > bad_max(tl xs)
   then hd xs
   else bad_max(tl xs)

fun good_max(xs:int list)=
    if null xs 
    then 0
    else if null (tl xs)
    then hd xs
    else 
    let 
       val tl_ans=good_max(tl xs)
    in
      if hd xs>tl_ans
      then hd xs
      else tl_ans
    end
    