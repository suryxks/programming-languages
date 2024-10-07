(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(s,sl)=

  let 
     fun helper(s,sl)= 
         case sl of 
              [] => []

             |(s'::sl')=> if same_string(s,s')
                              then sl'
                              else s'::helper(s,sl')
  in
  
       case sl of
          [] => NONE
         |(s'::sl') => if same_string(s,s')
                       then SOME(helper(s,sl))
                       else 
                         let 
                          val tl_ans=all_except_option(s,sl')
                         in 
                           case tl_ans of
                             NONE=> NONE
                            | SOME ls => SOME(s'::ls)
                         end
                       
 end
  

fun get_substitutions1(sl,s)=
    case sl of
         [] => []
        |(s'::sl') => 
              let 
                val tl_ans=get_substitutions1(sl',s)
              in
               case all_except_option(s,s') of
                              NONE => tl_ans
                            |(SOME ls) => ls @ tl_ans 
              end
   
fun get_substitutions2(sl,s)=
    let 
        fun aux(sl,s,acc) =
           case sl of
                [] => acc
               |(s'::sl') => 
                       case all_except_option(s,s') of
                               NONE => aux(sl',s,acc)
                              |(SOME ls) =>aux(sl',s,acc@ls)
                    
     in
         aux(sl,s,[])
     end
fun similar_names(sl,{first,middle,last})=
      let 
        val names=get_substitutions2(sl,first)
        fun helper(names,middle,last,acc)=
            case names of
              []=> acc
            | (x::xs')=>helper(xs',middle,last,acc@[{first=x,middle=middle,last=last}])
      in
         {first=first,last=last,middle=middle}::helper(names,middle,last,[])
      end
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove



(* put your solutions for problem 2 here *)

fun card_color(suit,rank)=
   case suit of
      Clubs => Black
    | Spades => Black
    | Diamonds => Red
    | Hearts => Red

fun card_value(card) =
    case card of
      (_, Num ans) => ans
     | (_,Ace)=> 11
     | _ => 10

fun remove_card (cs,c,e) =
    let 
         fun aux(cs,c,e,acc, arr)=
             case cs of
              [] => if acc=0 then raise e else arr
            | (c'::cs')=> if (c'=c andalso acc=0)
                          then aux(cs',c,e,acc+1,arr)
                          else aux(cs',c,e,acc,c'::arr)
    in
         aux(cs,c,e,0,[])
    end


fun all_same_color(cl)=
  case cl of
     [] => true
    | _::[]=>true
    | (c::(front::back))=> (card_color(c)=card_color(front) andalso all_same_color(front::back))

 
fun sum_cards(cs)=
    let 
       fun aux(cs,sum)=
        case cs of
         []=> sum
        | (xs::xs')=>aux(xs',card_value xs + sum)
    in 
      aux(cs,0)
    end

fun score(cs,goal) =
  let 
     val sum=sum_cards(cs)
     
  in
      case(sum>goal) of
      true => 3 * (sum-goal)
    | false => goal-sum
  end

fun officiate(cs,ms,goal)=
    let
      fun aux(cs,ms,goal,held,acc)=
        case (cs,ms) of
         ( _ ,[])=>acc
        |([],_)=>acc
        |(s'::cs',Draw::ms')=>

                    if sum_cards(held)>goal 
                    then acc 
                    else  
                      if (all_same_color(s'::held))
                      then aux(cs',ms',goal,s'::held,score(s'::held,goal) div 2)
                      else aux(cs',ms',goal,s'::held,score(s'::held,goal)) 
                    
        |(s'::cs',(Discard c)::ms')=>aux(cs',ms',goal,held,score(s'::remove_card(held,s',IllegalMove),goal))
    in
      aux(cs,ms,goal,[],0)
    end

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15);

(* val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
val test13=officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42) *)