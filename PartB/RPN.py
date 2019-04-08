from pymonad.Maybe import *

# RPN (Reverse Polish Notation) Calculator
# Written by: Freddy Gutierrez
# Goal: Calculate the result of a given string of operators and operands 

# imitating reads from Haskell in the sense that we are taking the first integer and making sure the rest of the given string is empty
# returns a Maybe object depending on the given input
# should be given a string with composed of a single integer (i.e. readMaybe("1") = Just(1))
# if not (i.e. readMaybe("1 gibberish asdsd") = Nothing)
def readMaybe(input: str) -> Maybe:    
    res = input.split()
    if len(res) == 1 and res[0].isdigit():
        return Just(res[0])
    else:
        return Nothing   

# Similar to foldl exceot for Monads
# foldM does the same thing as foldl, except it takes a binary function that produces a monadic value and folds the list up with that. 
def foldM(f, acc, xs) -> Monad:
    if not(xs):
        # once we've exhausted the list, if the given RPN string was properly formed we should end up with a list of one item in acc
        # properly formed string should result in one value in the acc (i.e. [23])
        # improperly formed string will result in multiple values still left in acc (i.e. [23 45])        
        if len(acc) != 1:
            return Nothing    
        else:        
            return Just(acc)
    # as long as xs is not empty apply foldM to the acc and the current head of xs, then pass the unwrapped result to a lambda function making a recursive call to foldM with updated values            
    return f(acc,xs[0]) >> (lambda y: foldM(f,y,xs[1:]))

# foldingFunction is the function that handles all the calculations 
# performs specific calculation based on 
def foldingFunction(operands, operator: str) -> Maybe:
    if operator == "*": 
        return Just([operands[0] * operands[1]] + operands[2::])
    elif operator == "+":        
        return Just([operands[0] + operands[1]] + operands[2::])
    elif operator == "-":        
        return Just([operands[1] - operands[0]] + operands[2::])                    
    else:    
        # concat the two lists and convert each element to a string 
        res = [operator] + operands            
        # check that there would be no Nothing instances in res
        # if so return Nothing 
        # else return a Just object from res
        for i in res:
            # compares the result of readMaybe and a Maybe with i passed in
            # if everything is correct all results with match (i.e. Maybe.unit(str(10)) = Just(10) == readMaybe(str(10)) = 10 )
            # else you get Maybe.unit(str(10 sadsds)) = Just(10 sadsds) != readMaybe(str(10 sadsds)) = Nothing
            # convert i to a string because readMaybe uses string.split and if i is an int error occurs 
            if Maybe.unit(str(i)) != readMaybe(str(i)):
                return Nothing   
        # if there are no Nothing objects in res then cast operator to an int and concat with operands                     
        res = [int(operator)] + operands                                      
        return Just(res)

# starts the recursive foldM calls with foldingFunction, an empty list, and a split() of the input string
def solveRPN(st: str) -> Maybe:
    res = foldM(foldingFunction, [], st.split())
    return res
      
print(solveRPN("1 2 * 4 +"))
print(solveRPN("1 2 * 4 + 5 *"))
print(solveRPN("1 2 * 4"))      
print(solveRPN("1 2 * 4"))