exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)


fun only_capitals xs = List.filter (fn x => Char.isUpper(String.sub(x,0))) xs

fun longest_string1 xs = List.foldl (fn (x,acc) => 
                                          if String.size acc >= String.size x
                                          then acc
                                          else x
                                          ) "" xs
fun longest_string2 xs = List.foldl (fn (x,acc) => 
                                          if String.size x >= String.size acc
                                          then x
                                          else acc
                                          ) "" xs

fun longest_string_helper f = 
                         fn (xs)=> 
                            List.foldl (fn(x,acc)=>
                                          if f(String.size x,String.size acc)
                                          then acc
                                          else x
                                      ) "" xs      

val longest_string3 = longest_string_helper (fn(x,acc)=> acc>=x)
val longest_string4 = longest_string_helper (fn(x,acc)=> x<acc)

val longest_capitalized = fn xs=>((longest_string_helper (fn(x,y)=>y>=x)) o only_capitals) xs

fun rev_string str = (String.implode o List.rev o String.explode) str


fun first_answer f = fn xs =>( (fn (xs) => 
                                  case xs of
                                       [] => raise NoAnswer
                                       |x::xs'=> x) 
                                 o
                                 List.foldl (
                                     fn(x,acc)=> 
                                            case f(x) of
                                                   NONE=> acc
                                                 | SOME v => acc @ [v]
                                              ) []) xs 


fun all_answers f = 
          fn xs=> List.foldl (fn(x,acc)=> 
                               case  (f x,acc)  of
                                (NONE,_) => NONE
                               |(_,NONE) => NONE
                               | (SOME lst,SOME lst1) => SOME (lst1@lst) 
                                                   
                               ) (SOME []) xs
fun count_wildcards p = g (fn()=> 1) (fn(x)=> 1) p
fun count_wild_and_variable_lengths p = g (fn()=>1) (fn(x)=> String.size x) p


fun count_some_var(str,ptr) = g (fn()=> 0 ) (fn(x)=> if x = str then 1 else 0 ) ptr

fun check_pat p = 
  let
    fun extract_strs (p,acc)= 
        case p of
            Variable x        => x::acc
	        | TupleP ps         => acc @ List.foldl (fn(x,acc1)=> extract_strs(x,acc1))[] ps 
	        | ConstructorP(_,pt) => extract_strs(pt,acc)
          | _ => acc
    fun check_repeats xs = List.exists (fn(x)=>
       if length (List.filter (fn(y)=> y=x) xs) > 1
       then true
       else false
       ) xs
  in
    not (check_repeats (extract_strs(p,[])))
  end

  fun match (v,pat) =
         case (v,pat) of 
          (_,Wildcard)=> SOME []
        | (_,Variable s) => SOME [(s,v)] 
        | (Unit,UnitP)=> SOME []
        | (Const v,ConstP v1)=> if v=v1 then SOME [] else NONE
        | (Tuple vs,TupleP ps)=> if List.length vs = List.length ps 
                                 then all_answers match (ListPair.zip(vs,ps))
                                 else NONE
        | (Constructor(s2,v),ConstructorP(s1,p))=> if s1=s2 then match(v,p) else NONE
        | (_,_)=> NONE

  fun first_match v =fn(lstp)=> 
                  SOME (first_answer (fn(p)=>match(v,p)) lstp)  handle NoAnswer =>NONE
                      
               