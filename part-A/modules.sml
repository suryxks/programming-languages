(*
   Modules

   For larger programs , one "top-level" sequence of bindings is poor
     - especially because a binding can use all earlier (non-shadowed) bindings

   So ML has structures to define modules  
*)
structure  MymathLib =
struct
  fun fact x =
      if x=0 
      then 1 
      else x * fact(x-1)
  val half_pi= Math.pi/2.0
  fun doubler y = y+y
end

val pi= MymathLib.half_pi + MymathLib.half_pi
val twenty_eight= MymathLib.doubler 14
(*
  Namespace management

  So far, this is just namespace management
    - Giving a hierarchy to names to avoid shadowing
    - Allows different modules to reuse names eg. map
    - Very Importat but not very interesting
*)
