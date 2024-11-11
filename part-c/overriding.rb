class Point 
  attr_accessor :x,:y
  def initialize(x,y)
    @x=x
    @y=y
  end 

  def distancefromorigin2
    Math.sqrt(x*x+y*y)
  end

  def distancefromorigin
    Math.sqrt(@x*@x+@Y*@y)
  end
end

class ThreeDPoint < Point
   attr_accessor :z
   def initialize(x,y,z)
     super(x,y)
     @z = z
   end

   def distancefromorigin
     d = super
     Math.sqrt(d*d + @z*@z)
   end

    def distancefromorigin2
     d = super
     Math.sqrt(d*d + z*z)
    end

end

class PolarPoint < Point
  def initialize(r,theta)
    @r = r
    @theta = theta
  end

  def x 
    @r * Math.cos(@theta)
  end

  def y 
    @r * Math.sin(@theta)
  end
  
  def x=a
    b =y
    @theta = Math.atan(b/a)
    @r = Math.sqrt(a*a+ b*b)
    self
  end

  def y=b
    a = y
    @theta=Math.atan(b/a)
    @r = Math.sqrt(a*a,b*b)
    self
  end
  def distancefromorigin
    @r
  end
end

# Dynamic dispatch
# --Call self.m2() in method m1 defined in class C 
#   can resolve to a method m2 defined in a subclass of C
# -- Also known as late binding or virtual methods
# -- Most unique characteristic of OOP
# 

# Need to define the sematics of method lookup as carefully as we defined 
# a variable lookup for out PLs

# Review: Variable lookup
# Rules for variable lookup is a key part of PL semantics
# 
# --> ML: Lool up variables in the appropriate environment
#      -- Lexical scope for closures
#   
# --> Racket: Like ML plus let,letrec
# --> Ruby:
#      -- Local variables and blocks mostly like ML and Racket
#      -- But also have instance variables, class variables, methods 
#          * Look up in terms of self , which is special

# Using self
# The semantics for method calls also known as message sends
#               e0.m(e1,...,en)
# 1) Evaluate e0 ,e1 ... en to objects obj0,obj1 ... objn
#    - As usual, may involve looking up self, variables, fields etc
# 2) Let C be the class of obj0
# 3) if m if defined in c , pick that method, else recur with the superclass
#    of C unless C is already Object
#    - If no m is found , call method_missing instead
#      * Definition of method_missing in object raises an error
# 4) Evaluate body of method picked
#    - with formal arguments bound to obj1,... objn
#    - with self bound to obj0 -- this implements dynamic dispatch 
#    


class A
  def even x
    puts "in even A"
    if x ==0 then true else odd(x-1) end
  end

  def odd x
    puts "in odd A"
    if x==0 then true else even(x-1) end
  end
end

a1= A.new.odd 7
puts "a1 is " + a1.to_s + "\n\n"

class B <A
  def even x 
    puts "in even B"
    x%2==0
  end
end

class C < A
   def even x
     puts "in even C"
     false
   end
end

a2= B.new.odd 7
puts "a2 is " + a2.to_s + "\n\n"

a3 = C.new.odd 7
puts "a3 is " + a3.to_s + "\n\n"




