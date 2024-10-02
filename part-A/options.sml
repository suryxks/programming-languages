(* 
fun old_max(xs:int list)=
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
    end *)

(*
  Having max retrun 0 for the empty list is awful
  -- Could raise an exception
  -- could return zero element or one element list
      

  OPTIONS

    t option is a type for any type t
      -(much like t list, but a different type , not a list)

    Building:
      --> NONE has type a' option (much like [] has type a' list)
      --> SOME e has type t option if e has type t (much like e::[])
*)

fun max1(xs:int list)=
    if null xs
    then NONE
    else 
        let val tl_ans=max1(tl xs)
        in
          if isSome tl_ans andalso valOf(tl_ans) >hd xs
          then tl_ans
          else SOME(hd xs)
        end

fun max2(xs:int list)=
    if null xs
    then NONE
    else 
        let
           fun max_nonempty(xs : int list)=
               if null (tl xs)
               then hd xs
               else
                   let 
                      val tl_ans=max_nonempty(tl xs)
                    in
                       if hd xs > tl_ans
                       then hd xs
                       else tl_ans
                    end
        in
           SOME(max_nonempty xs)
        end

