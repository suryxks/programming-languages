(*
   Bindings we have seen so far 
     1) data bindings with val
     2) function bindings with fun

  
  DATATYPE BINDINGS:
     an awesome way to make one-of types:

      datatype mytype = TwoInts of int*int
                | Str of string
                | Pizza 
    
     The above expression:
        1) adds a new type mytype to the environment
        2) Adds constructors to the environment : TwoInts , Str and Pizza
        3) A constructor is a function that makes values of the new type
          (or) is a value of new type:
          --> TwoInts: int*int -> mytype
          --> Str : string -> mytype
          --> Pizza: mytype
  
*)

datatype mytype = TwoInts of int*int
                | Str of string
                | Pizza
(*
  --> any value of the type mytype is made from one of the constructors
  --> The value contains
      1) A tag for which constructor (eg TwoInts)
      2) The corresponding data (7,9)
*)
val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(1+2,3+4)
val e = a 



fun f (x:mytype)=
    case x of 
        Pizza => 3
      | Str s => 9
      | TwoInts(i1,i2) => i1+i2

val x = f(a);

(*
  Why Pattern matching is better

  0) You can use pattern matching to write your own testing and data-extractions
  functions if you must
  --> But do not do that
  1) You cannot forget a case (inexhaustive patter-match warning)
  2) You cannot duplicate a case (a type checking error)
  3) You will not forget to test the variant correctly and get an exception
     (like hd [])
  4) Pattern-matching can be generalized and made more powerful, leading 
     to elegant consise code.
   
*)

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

(* Alternate ways of identifying real-world things/prople *)
 
 datatype id = StudentNum of int 
             | Name of string *( string option)* string

(*
   Expression Types
   
   A more exciting (?) example of a datatype, using self-reference

*)

datatype exp = Constant of int
             | Negate of exp
             | Add of (exp*exp)
             | Multiply of (exp * exp)
(*
   An expression of type exp :
    Add(Constant (10+9), Negate(Constant 4))

   How to picture the resulting value in your head
                  Add
                  / \
          Constant  Negate
             |         |
             19     Constant
                        | 
                        4

*)     
fun eval(e:exp)=
   case e of 
        Constant i =>i
      | Negate e2 => ~ (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Multiply(e1,e2) => (eval e1) * (eval e2)

fun number_of_adds (e:exp) =
    case e of 
         Constant i => 0
       | Negate e2=> number_of_adds e2
       | Add(e1,e2)=> 1 + number_of_adds e1 + number_of_adds e2
       | Multiply (e1,e2)=> number_of_adds e1 + number_of_adds e2

val example_exp:exp= Add(Constant 19,  Negate(Constant 69))
val example_ans=eval example_exp

(*

   When a  langugage construct is "new and strange," there is more reason
   to define the evaluation rules precisely
   
   review of datatype bindings and case expressions "so far"

  
   DATATYPE BINDINGS
  
    datatype t = C1 of t1 | C2 of t2 | ... | Cn of tn

   1) Adds type t and constructors Ci of type ti-> t 
      -- Ci v is a value , ie the result "includes the tag"
   2) Omit "of t" for constructors that are just tags, no underlying data
    - Such a Ci is a value of type t
   3) Given an expression of type t, use case expressions to :
      - See which variant (tag) it has
      - Extract underlying data once you know which variant
   

*)

fun max_constant(e:exp)=
     case e of
        Constant e1 => e1
      | Negate e4=> max_constant(e4)
      | Add(e1,e2)=> Int.max(max_constant e1,max_constant e2)
      | Multiply(e1,e2)=> Int.max(max_constant e1,max_constant e2)
      
    

val ans=max_constant(example_exp)

type card = suit * card
type name_record={
   student_num: int option,
   first:string,
   middle: string option,
   last:string
}

