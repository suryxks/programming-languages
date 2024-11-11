# All a method can do with a block is yield to it
# - Cannot return it , store it in an object (eg. for a callback)
# - But can also turn blocks into real closures
# - Closures are instances of class Proc
#  * Called with methd call 

# * Blocks are "second class"
# * Procs are "first class expressions"


# FIRST CLASS === "can be pased/stored anywhere"


def proc_demo num
  a = Array.new(num){|i| i*2}
  b = a.map do |i|
    i/2
  end
  c= b.map {|x| (lambda {|i| x+i })}
  c
end

# First class makes closures more powerful than blocks
# But blocks are more convenient and cover most cases
# This helps understand what first class means

# LANGUAGE DESIGN QUESTION: When is convenience worth making something less
#  general and powerful?