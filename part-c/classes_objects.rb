class A
  def m1
    34
  end
  def m2 (x,y)
    z=7
    if x>y
      false
    else
        x+y*z
    end
  end
end


class B
  def m1
    4
  end

  def m3 x
    x.abs*2 + self.m1
  end
end

# ClassName.new creates a new object whose class is ClassName
# e.m evaluates to an object and then calls its m method
#  -- also known as "sends the m message"
#  Can also write e.m()



# OBJECTS HAVE STATE
# 
