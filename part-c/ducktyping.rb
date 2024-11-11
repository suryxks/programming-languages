# DUCK TYPING
# "If it walks like a duck and quacks like a duck , it is a duck"
#  -- OR dont worry that it may not be a duck

# When writing a method we might think that the argument passed must be a Foo
# but what we really care or want is something which has all the methods 
# implemented in Foo and does not really care if its an instance of Foo
# --> Embracing duck typing is always making method calls rather than assuming 
#     or testing the class of arguments


def mirror_update pt 
  pt.x = pt.x * (-1)
end

# Natural thought: "Takes a point object and negates the x value"
# Closer: "Takes anything with getter and setter methods for @x"
# 
# Duck Typing: Takes anything with the method x= and x where result of 
# x has a * method that can take -1 . sends result of calling x the * message 
# with -1 and sends that result to x=


