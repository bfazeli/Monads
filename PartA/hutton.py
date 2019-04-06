from pymonad.Maybe import *
from pymonad.Reader import curry

@curry
def add(x, y):
    return x + y

# Partial fnxs applications
add7 = add(7)
print(add7(400))

def safediv(n, m):
    return n / m 

#def eval(n):
#    return Just(n)

def eval(x, y):
    return Just(x) >> (lambda n: Just(y) >> (lambda m: Just(safediv(n, m))))

print(eval(6, 2))

