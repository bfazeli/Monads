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

# Here we take each indivi comp and feed it to a fnx to be applied on and safediving the final result if none of the indivi comp eval to Nothing
def eval(x, y):
    return Just(x) >> (lambda n: Just(y) >> (lambda m: Just(safediv(n, m))))

print(eval(6, 2))

