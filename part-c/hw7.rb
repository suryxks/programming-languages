# University of Washington, Programming Languages, Homework 7, hw7.rb 
# (See also ML code)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for 
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by 
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression  
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue 
  # do *not* change methods in this class definition
  # you can add methods if you wish

  private
  # some helper methods that may be generally useful
  def real_close(r1,r2) 
    (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2) 
    real_close(x1,x2) && real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2) 
    if real_close(x1,x2)
      VerticalLine.new x1
    else
      m = (y2 - y1).to_f / (x2 - x1)
      b = y1 - m * x1
      Line.new(m,b)
    end
  end

  public
  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end
end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)
  # However, you *may* move methods from here to a superclass if you wish to

  # Note: no initialize method only because there is nothing it needs to do
  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods

  # Note: You may want a private helper method like the local
  # helper function inbetween in the ML code
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def preprocess_prog
    self
  end
  def eval_prog env
    self
  end
  def shift(dx,dy)
    Point.new(x+dx,y+dy)
  end
  def intersect other
    other.intersectPoint(self)
  end
  def intersectNoPoints other
    NoPoints.new
  end
  def intersectPoint other
    if real_close_point(self.x,self.y,other.x,other.y)
      self
    else 
      NoPoints.new
    end
  end
  def intersectLine other
    if real_close(y,other.m*x + other.b)
      self
    else
      NoPoints.new
    end
  end
  def intersectVerticalLine other
    if real_close(x,other.x)
      self
    else 
     NoPoints.new
    end
  end
  def intersectWithSegmentAsLineResult other
    if inbetween(x,other.x1,other.x2)&&inbetween(y,other.y1,other.y2)
      Point.new(x,y)
    else NoPoints.new
    end
  end

  private
     def inbetween(v,end1,end2)
     a= (end1 - GeometryExpression::Epsilon <= v && v <= end2 + GeometryExpression::Epsilon )
		 b=(end2 - GeometryExpression::Epsilon  <= v && v <= end1 + GeometryExpression::Epsilon )
     a||b
     end
end

class Line < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :m, :b 
  def initialize(m,b)
    @m = m
    @b = b
  end
  def preprocess_prog
    self
  end
  def eval_prog env
    self
  end
  def shift(dx,dy)
    Line.new(m,b+dy-m*dx)
  end
  def intersect other
    other.intersectLine(self)
  end
  def intersectPoint other
   if real_close(other.y,m*other.x + b)
      self
   else
      NoPoints.new
   end 
  end
  def intersectLine other
    if real_close(m,other.m)
      if real_close(b,other.b)
        self
      else 
        NoPoints.new
      end
    else 
      x = other.b-b/m-other.m
      y= m*x + b
      Point.new(x,y)
    end
  end

  def intersectNoPoints other
    NoPoints.new
  end

  def intersectVerticalLine other
    Point.new(other.x, m * other.x + b)
  end
  def intersectWithSegmentAsLineResult other
     other
  end
end

class VerticalLine < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :x
  def initialize x
    @x = x
  end
  def preprocess_prog
    self
  end
  def eval_prog env
    self
  end
  def shift(dx,dy)
    VerticalLine.new(x+dx)
  end
  def intersect other
    other.intersectVerticalLine(self)
  end
  def intersectNoPoints other
    NoPoints.new
  end
  def intersectPoint other
    if real_close(x,other.x)
      other
    else 
      NoPoints.new
    end
  end

  def intersectLine other
    Point.new(x,other.m*x+other.b)
  end

  def intersectVerticalLine other
    if real_close(x,other.x)
      self
    else 
      NoPoints.new
    end
  end

  def intersectWithSegmentAsLineResult other
     self
  end 
end

class LineSegment < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: This is the most difficult class.  In the sample solution,
  #  preprocess_prog is about 15 lines long and 
  # intersectWithSegmentAsLineResult is about 40 lines long
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def preprocess_prog
    if real_close_point(x1,y1,x2,y2)
        Point.new(x1,y1)
    else 
       if y2<y1||x2<x1
         LineSegment.new(x2,y2,x1,y1)
       else self
       end
    end
  end
  def eval_prog env
    self
  end
  def shift(dx,dy)
    LineSegment.new(x1+dx,y1+dy,x2+dx,y2+dy)
  end
  def intersect other
    other.intersectLineSegment(self)
  end
  def intersectNoPoints other
    NoPoints.new
  end
  def intersectPoint other
    other.intersectLineSegment(self)
  end
  def intersectWithSegmentAsLineResult other
    if real_close(x1,x2)
       seg1 , seg2 = swapY(self,other)
       if real_close(seg1.y2,seg2.y1)
         Point.new(seg1.x2,seg2.y2)
       elsif seg1.y2<seg2.y1
         NoPoints.new
       elsif seg1.y2>seg2.y2
        LineSegment.new(seg2.x1,seg2.y1,seg2.x2,seg2.y2)
       else 
        LineSegment.new(seg2.x1,seg2.y1,seg1.x2,seg2.y2)
       end
    else
        seg1,seg2= swapX(self,other)
        if real_close(seg1.x2,seg1.x1)
          Point.new(seg1.x2,seg1.y2)
        elsif seg1.x2<seg2.x1
         NoPoints.new
        elsif seg1.x2>seg2.x2
        LineSegment.new(seg2.x1,seg2.y1,seg2.x2,seg2.y2)
        else 
        LineSegment.new(seg2.x1,seg2.y1,seg1.x2,seg2.y2)
        end
    end
  end
  private
  def swapX(seg1,seg2)
     if seg1.x1<seg2.x1
       [seg1,seg2]
     else 
       [seg2,seg1]
     end
  end
  def swapY(seg1,seg2)
     if seg1.y1<seg2.y1
       [seg1,seg2]
     else 
       [seg2,seg1]
     end
  end
  
end

# Note: there is no need for getter methods for the non-value classes

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end 
  def preprocess_prog
    self
  end
  def shift(dx,dy)
    self
  end
  def eval_prog env
    @e1.preprocess_prog.eval_prog(env).intersect(@e2.preprocess_prog.eval_prog(env))
  end
end

class Let < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: Look at Var to guide how you implement Let
  attr_reader :e1,:e2,:s
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    self
  end
  def eval_prog env
     eone= e1.preprocess_prog.eval_prog env
     is_value_present=env.assoc s
     env2=is_value_present ? env.map do |arr| 
                                 first,second = arr
                                 if s==first
                                   [s,eone]
                                 else
                                  arr
                                 end 
                            end : env.map(&:clone).push([s,eone])

     e2.preprocess_prog.eval_prog env2
  end
  def shift(dx,dy)
     self
  end
end

class Var < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize s
    @s = s
  end
  def eval_prog env # remember: do not change this method
    pr = env.assoc @s
    raise "undefined variable" if pr.nil?
    pr[1]
  end
  def preprocess_prog
    self
  end
  def shift(dx,dy)
    self
  end
end

class Shift < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  
  attr_accessor :dx,:dy,:e
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end
  def preprocess_prog
    self
  end

  def eval_prog env
    e.preprocess_prog.eval_prog(env).shift(dx,dy)
  end
end