module Doubler
  def double 
    self + self
  end
end

class Pt
  attr_accessor :x,:y
  include Doubler
  def + other 
    ans =Pt.new
    ans.x = self.x + other.x
    ans.y = self.y + other.y 
    ans
  end
end

class String
  include Doubler
end

# Mixins change our lookup rules slightly:
# when looking for a method m , look in obj's class, then mixins that class includes
# then obj's superclass , then the superclass mixins, etc

class Name
  attr_accessor :first,:middle,:last
  include Comparable
  def initialize(first,last,middle="")
    @first=first
    @last = last
    @middle = middle
  end
  def <=> other
    l= @last<=>other.last
    return l if l!=0
    f = @first <=> other.first
    return f if f!=0
    @middle <=> other.middle
  end

end

class Range 
  include Enumerable
  def initialize(low,high)
    @low = low
    @high = high
  end
  def each 
    i = @low
    while i <= @high
      yield i 
      i=i+1
    end
  end
end