from pymonad.Reader import curry
from pymonad.Maybe import *
import math

@curry
def div(num, denom):
    if denom == 0:
        return Nothing
    return Just(num/denom)

def sqrt(x):
    if x < 0:
        return Nothing
    return Just(math.sqrt(x))


print(sqrt(100) >> (lambda x: div(x,2)))

