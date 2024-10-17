(*
  A signature is a type for a module
  - What bindings does it have and what are their types
  - Can include variables , types, datatypes, and exceptions defined in module

  A module will not type check unless it matches the signature,
  meaning it has all the bindings  at the right types

*)

(* signature MATHLIB =
sig
val fact:int -> int
val half_pi:real

end

structure  MymathLib :> MATHLIB =
struct
  fun fact x =
      if x=0 
      then 1 
      else x * fact(x-1)
  val half_pi= Math.pi/2.0
  fun doubler y = y+y
end *)

signature RATIONAL_A=
sig
  datatype rational = Whole of int| Frac of int*int
  exception BadFrac
  val make_frac: int*int -> rational
  val add: rational*rational-> rational
  val toString :rational-> string

end

signature RATIONAL_B=
sig
  type rational 
  exception BadFrac
  val make_frac: int*int -> rational
  val add: rational*rational-> rational
  val toString :rational-> string

end

structure Rational1:>RATIONAL_B =
struct
(*
   Invariant 1: all denominators > 0
   Invariant 2: rationals kept in reduced form
*)
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac

  fun gcd (x,y) = 
     if x = y
     then x
     else if x<y
     then gcd(x,y-x)
     else gcd(y,x)
  fun reduce r=
     case r of
       Whole _=> r
      |Frac(x,y)=> 
       if x=0 
       then Whole 0
       else 
         let 
           val d=gcd(abs x,y)
          in
            if d=y
            then Whole(x div d)
            else Frac(x div d , y div d)
         end
  
  fun make_frac(x,y)=
      if y=0 
      then raise BadFrac
      else if y<0
      then reduce(Frac(~x,~y))
      else reduce(Frac(x,y))
  
  fun add(r1,r2) = 
      case(r1,r2) of
      (Whole(i),Whole(j))=> Whole(i+j)
     |(Whole(i),Frac(j,k))=> Frac(j+k*i,k)
     |(Frac(j,k),Whole(i))=> Frac(j+k*i,k)
     |(Frac(a,b),Frac(c,d))=> reduce (Frac(a*d + b*c,b*d))
  fun toString r = 
      case r of
       Whole i => Int.toString i 
       |Frac(a,b)=> (Int.toString a) ^ "/" ^ (Int.toString b)
end
(*
  Key idea: An ADT must hide the concrete type definition so clients cannot
  create invariant-violating values of the type directly 
*)


(*
  Two key restrictions:

  So we have two powerful ways to use signatures for hiding:

  1) Deny bindings exist(val-bindings,fun-bindings,constructors)
  2) Make types abstract (so clients cannot create values of them or access 
  their pieces directly)
*)

