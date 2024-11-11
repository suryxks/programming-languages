# OBJECTS HAVE STATE 
#  An objects state persists 
#  --> Can grow and change from the time object is created
#  
# State only directly accessible from objects methods
# --> Can read, write , extend the state
# --> Effects persist for next method call


# State Consists of instance variables (also known as fields)
# - Syntax : Starts with @ eg: @foo
# - Spring into being with assignment
#   !!! SO mis-spellings silently add new state
# - Using one not in state not an error; produces nil object

class A
  def initialize(f=0)
    @foo = f
  end
   def m1
     @foo = 0
   end

   def m2 x
     @foo+=x
   end
   def foo
     @foo
   end
end

# Alasing
# -> Creating an object returns a reference to a new object 
#    *-> Different state from every object
# -> Variable assignment creates an alias
#    *-> Aliasing means same object which means same state

# Unlike OOP languages that make "what fields an object has" a fixed part of
# the class definition 
# -> In ruby , different instances of same class can have different instance
#    variables


# CLASS VARIABLES
# -> There 



class C
  Suryas_age = 0

  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo = f
  end

  def m2 x
    @foo +=x
    @@bar +=1
  end
   
   def foo
     @foo
   end

   def bar
     @@bar 
   end

end