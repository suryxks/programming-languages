# Blocks are almost closures

def t i 
  (0..i).each do |j|
    print "  " * j
    (j..i).each{|k| print k ; print " "}
    print "\n"
  end
end

class Foo 
  def initialize max
    @max = max
  end

  def silly 
    yield(4,5) + yield(@max,@max)
  end

  def count base
    if base > @max
      raise "reached max"
    elsif yield base
       1 
    else  
      1 + count(base+1){|i| yield i}
    end
  end
end