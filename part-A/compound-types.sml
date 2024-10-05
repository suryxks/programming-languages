(*
  
  Base types : int bool unit char
  compound types: tuples , lists , options

  3 most important type building-blocks in any language
  --> "Each of": A t value contains values of each of t1 t2 ...tn
  --> "One of": A t value contains one of t1,t2 t3 ...tn
  --> "Self refernce": A t value can refer to other t values

  
  A lot of data can be described with just these building blocks

  
*)

(*
  Records 
Syntax:
  Record values have fields holding values
    {f1=v1,... fn=vn}
  Record types have fields holding types
   {f1:t1,... fn:tn}

  Accessing pieces of records
  #fieldname e

  ---- Syntactic Sugar ----
  Syntactic: because we can describe the semantics (evaluation rules and typing
  rules) of one interm of other 

  Sugar: They make the language sweeter

    -- They simplify understanding the language
    -- They simplify implementing the language

    why? Because there are fewer semantics to worry about even though we have
    the syntactic convinence of tuples
*)

val a_pair=(3,5)
val a_record={second=5,first=3};
val another_record={2=5,1=6};

(*
  Static environment
    a_pair: int*int
    a_record : {first:int , second:int }
    another_record: int*int

  Dynamic environment
    a_pair=(3,5)
    a_record={first=3,second=5}
    another_record = (6,5)
*)


