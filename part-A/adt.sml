(*
    A key purpose of abstraction is to allow different implementations to
    be equivalent
      - No client can tell which you are using
      - SO can improve/replace /choose implementations later
      - Easier to do if you start with more abstract signatures(reveal only 
      what you must)

    we can't mix-and-match module bindings

    Modules with the same signatures still define different types

    This is a crucial feature for type system and module properties:
     - Different modules have different internal invariants
     - In fact, they have different type definitions  
*)

(*
    what "two pieces of code are equivalent means"

    - Fundamental software-engineering idea
    - Made easier with 
      1) Abstraction (hiding things)
      2) Fewer side effects
________________________________________________________________________________
    Equivalence :

       Must reason about "are these equivalent" all the time 
           - The more precisely you think about it the better

      1) Code maintenance: Can i simplify this code?
      2) Backward compatibility: Can i add new features without changing
         how any old features work?
      3) Optimization: Can i make this code faster?
      4) Abstraction: can an external client tell i made this change

      when can we say two functions are quivalent ,even without looking 
      at all calls to them?

      two functions are equivalent if they have the same "observeable behavior"
      no matter how they are used anywhere in the program

      Given equivalent arguments , they:
       - Produce equivalent results
       - Have the same (non-)termination behavior
       - Mutate (non-local) memory in the same way
       - Do the same input/output
       - Raise the same exceptions

      Notice it is much easier to be equivalent if:
        --> There are fewer possible arguments eg with type system and abstractions
        --> We avoid side-effects: mutation, input/output and exceptions
*)