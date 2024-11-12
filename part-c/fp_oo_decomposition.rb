class Exp 
end

class Value<Exp 
  
end

class Int<Value
  attr_accessor :i 
  def initialize i 
     @i = i 
  end
  def eval
    self
  end

  def toString
    @i.to_s
  end

  def hasZero
    @i==0
  end
  
  def noNegConstants
    if i<0
      Negate.new(Int.new(-i))
    else 
      self
    end
  end
end

class Negate <Exp
  attr_accessor :e

  def initialize e
    @e = e
  end

  def eval e 
    Int.new(-e.eval.i)
  end
  
  def toString 
    "-(" + e.toString + ")"
  end

  def hasZero
    e.hasZero
  end
  def noNegConstants
    Negate.new(e.noNegConstants)
  end
end

class Add < Exp
  attr_accessor :e1 ,:e2

  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    e1.eval.add_values e2.eval
  end

  def toString
    "(" + e1.toString+ " + " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero||e2.hasZero
  end
  def noNegConstants
    Add.new(e1.noNegConstants,e2.noNegConstants)
  end
end

class Mult <Exp
  attr_accessor :e1, :e2
  def initialize(e1,e2)
    @e1 = e1 
    @e2 = e2
  end
  def eval
    Int.new(e1.eval.i * e2.eval.i)
  end
  def toString
   "(" + e1.toString+ " * " + e2.toString + ")" 
  end
  def hasZero
    e1.hasZero || e2.hasZero
  end

  def noNegConstants
    Mult.new(e1.noNegConstants,e2.noNegConstants)
  end
end

class MyString < Value
  attr_reader :s

  def initialize s
    @s = s 
  end

  def eval
    self
  end

  def toString
    s 
  end

  def hasZero
    false
  end

  def noNegConstants
    self
  end
  def add_values v 
    v.addString self
  end

end

class MyRational < Value
  attr_reader :i, :j
  def initialize(i,j)
    @i = i
    @j = j
  end
  def eval
    self
  end
  def toString
    i.to_s + "/" + j.to_s
  end
  def hasZero
    i ==0
  end
  def noNegConstants
    if i<0&&j<0
      MyRational.new(-i,-j)
    elsif j < 0 
      Negate.new(MyRational.new(i,-j)) 
    elsif i < 0
      Negate.new(MyRational.new(-i,j))
    end
  end
end


# what is dynamic dispatch?
# lets say we have an object obj1 and it calls passes a message obj1.m(obj2,obj3)
# lets also assume that  obj1 is of class B which is a sub class of another class A
# lets also assume that  method m is not defined in B but defined in A 
#  
# while evaluating the method m's body with obj2 and obj3 m can call other method self.m2 
# and if both class A and Class B has method m2 then which m2 does the obj1 call
# it turns out that it calls m2 from the class  B to which obj1 is an instance of 
# note that m1 is evaluated from class A and m2 which is called inside m2 is evaluaed
# from class B which is a sub class of A.
# 
# 
