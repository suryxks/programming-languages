fun sum_triple (x,y,z) = 
    x + y + z 

fun full_name {first=x, middle=y,last=z}=
    x ^ " " ^ y ^ " " ^ z

(*
   The "more general" rule

   Easy rule you (and the type-checker) can apply without thinking:

     A type t1 is more general than type t2 if you can take t1, 
      replace its type variables consistently and get t2

   Other rules
    --> Can combine the more rule with rules of equivalence
    --> Order of field names does not matter.

  Equality types 
   ''a list * ''a -> bool

   These are "equality types" that arise from using the = operator
    - The = operator works on lots of types: int , string, tuples
      containing all equality types

    The rules for more general are exatly the same except you have to 
    replace an equality type variable with a type that can be used with =
    -- A "strange" feature of ML because = is special
*)

