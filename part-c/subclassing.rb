class Point 
  attr_accessor :x,:y
  def initialize(x,y)
    @x=x
    @y=y
  end 

  def distancefromorigin
    Math.sqrt(x*x+y*y)
  end
end

class ColorPoint < Point
  attr_accessor :color 
  def initialize(x,y,c="clear")
    super(x,y)
    @color = c
  end
end

# Programmers often overuse subclassing in OOP languages

# Instead of creating ColorPoint , we could add methods to Point
# -- That could mess up the other users and subclassers of Point

class Point2
  attr_accessor :color
  def initialize(x,y,c = "clear")
    @x = x
    @y = y
    @color = c
  end
end

# Instead of subclassing Point , could copy/paste the methods 
#  -- Means the same thing if you dont use methods like is_a?
# and superclass , but of course code reuse is nice


# Instead of subclassing Point, could use  Point instance variable
# -- Define methods to send same message to the point
# -- Often OOP programmers overuse subclassing
# -- But for ColorPoint , subclassing makes sense: less work and can use 
#    a ClolorPoint wherever code expects a Point


class ColorPoint2 
  attr_accessor :color

  def initialize(x,y,c="clear")
    @pt = Point.new(x,y)
    @color = c
  end

  def x 
    @pt.x
  end

  def y 
    @pt.y
  end

  def distancefromorigin
    @pt.distancefromorigin
  end
end