(*
   Nested Patterns
    1) We can nest patterns as deep as we want
      - Just like we can nest expressions as deep as we want
      - Often avoids hard-to-read , wordy nested case expressions
    2) So the full meaning of pattern-matching is to compare a pattern
       against a value for the "same shape" and bind variables to the 
       "right parts"
    
     -- More precise recursive definition comimg after examples


*)
exception ListLengthMismatch

fun zip3 list_triple=
     case list_triple of
     ([],[],[])=>[]
    |(hd1::tl1,hd2::tl2,hd3::tl3)=>(hd1,hd2,hd3)::zip3(tl1,tl2,tl3)
    | _ => raise ListLengthMismatch

fun unzip3 lst=
    case lst of
    []=>([],[],[])
    |(a,b,c)::tl => let val (l1,l2,l3) = unzip3 tl
                    in
                     (a::l1,b::l2,c::l3)
                     end
   

fun nondecreasing xs = 
    case xs of
       []=>true
     | _::[] => true 
     | head::(neck::rest)=> head<=neck andalso nondecreasing(neck::rest)
     

datatype sgn = P|N|Z 

fun mulsign (x1,x2)= 
   let 
     fun sign x = if x>0 then P else if x< 0 then N else Z 
    in
        case (sign x1,sign x2) of
        (Z,_)=> Z 
       |(_,Z)=> Z 
       |(P,P)=> P
       |(N,N)=> P
       |(N,P)=> N
       |(P,N)=> N
    end

(*
   STYLE

   Nested patterns can lead to very elegant, consise code
   -- Avoid nested case expressions if nested patterns are simpler
      and avoid unnecessary branches of let-expressions
        ex: unzip and nodecreasing
   -- A common idiom is matching against tuple of datatypes to compare them
      Ex: zip and mulsign

  
  wildcards are good style : use them instead of variable when you do not need
  the data
    -- Ex: len mulsign
*)
