(*
   What is functional Programming ? 

    It can mean a few different things:
    1) Avoiding mutation in most/all cases 
    2) Using functions as values

  First-clas functions :
   can use them wherever we use values 
   --> Functions are values too
   --> Arguments , results, parts of tuples, bound to variables,
       Carried by datatype constructors or exceptions,...

   Most common use is an argument / result of another function
   - Other function is called a higher order function
   - Powerful way to factor out common functionality 
   
*)

(*
   Functions as arguments:

   --> We can pass one function as an argument to another function 
   --> Elegant strategy for factoring out commn code
       -- Replace N similar functions with calls to 1 function where 
          you pass in N differnt (short) functions as arguments 
*)

fun increment_n_times_lame(n,x) = 
    if n=0
    then x
    else 1 + increment_n_times_lame(n-1,x)

fun double_n_times_lame(n,x)=
    if n=0
    then x
    else 2 * double_n_times_lame(n-1,x)

fun nth_tail_lame(n,xs) = 
    if n=0
    then xs
    else tl (nth_tail_lame(n-1,xs))

fun n_times(f,n,x)=
    if n=0
    then x
    else f(n_times(f,n-1,x))

fun increment x = x + 1
fun double x = x + x

val x1 = n_times(double,4,7)
val x2 = n_times(increment,4,7)
val x3 = n_times(tl,2,[4,8,12,16])

fun addition(n,x) = n_times(increment,n,x)
fun double_n_times (n,x) = n_times(double,n,x)
fun n_tail(n,x) = n_times(tl,n,x)

fun triple x = 3 * x

(*
   1) Higher-order functions are often so "generic" and "reusable" that they 
   Have polymorphic types
   2) But there are higher-order functions that are not polymorphic
   3) And there are non-higher order functions that are not polymorphic
   4) Always a good idea to understand the type of a function, 
      especially a higher order function
*)
fun times_until_zero (f,x) =
    if x=0 then 0 else 1 + times_until_zero(f,f x)
