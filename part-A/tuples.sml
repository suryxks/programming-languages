(*
  Pairs 
    We need a way to build paris and a way to access the pieces

    Build:
      --> Syntax (e1,e2)
      --> Evaluation: Evaluate e1 to v1 and e2 to v2; result is (v1,v2)
          a pair of values is a value
      --> Type checking: if e1 has type ta and t2 has tb , then the pair
          expression has type ta * tb
          - A new kind of type
    
    Acces:
       --> Syntax: #1 e and #2 e
       --> Evaluation: Evaluate e to a pair of values and return first or 
           second piece 
           ex: if e is a variable x , then look up x in environment
       --> Type-checking: if e has type ta * tb then #1 e has type ta and 
           #2 e has type tb
         
*)

fun swap(pr : int*bool)=
        (#2 pr, #1 pr)

fun sum_two_pairs (pr1: int * int, pr2: int * int ) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2)

fun div_mod(x: int , y: int)=
    (x div y, x mod y)

fun sort_pair(pr: int * int)=
    if (#1 pr) < (#2 pr)
    then pr
    else (#2 pr, #1 pr)