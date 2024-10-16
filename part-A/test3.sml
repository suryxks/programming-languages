use "hw3.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test4a = longest_string3 ["Ac","bc","C"] = "Ac"

val test4b = longest_string4 ["AB","B","C"] = "AB"

val test5 = longest_capitalized ["AD","bc","CA"] = "AD"

 val test6 = rev_string "abc" = "cba"

(* val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4 *)

 val test8 = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (TupleP[Variable("x"),Variable("y")]) = true

val test11 = match (Const(1), ConstP(1)) 

val test13 = match (Const(4),Variable("Surya")) = SOME [("Surya",Const(4))]

val test14 = match (Tuple[Const(4)],TupleP[Variable("Surya"),Variable("Jay")])
val test15 = match (Constructor("Surya",Const(4)),ConstructorP("Surya",ConstP(5)))
val values = Const(4)
 val test12 = first_match  (Const 4)  [UnitP]   
