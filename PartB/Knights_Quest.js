from typing import NewType
from pymonad.List import *
from pymonad.Reader import curry

# Knight's Quest
# Written by: Freddy Gutierrez
# Goal: find out if the knight can reach a certain position in three moves.
# Use a grid to represent knights position on the board 8x8 (col, row)

# Create a NewType for an int tuple to represent the current position of the knight 
KnightPos = NewType('KnightPos', (int, int))
# Assign a starting position and ending position to the knight
start = (6,2)
endF = (7,3)
endT = (6,1)
# create the knightPostions with start and end 
pos1 = KnightPos(start)
pos2 =KnightPos(endF)
# list of legal spaces on the board 
legalPos = [1,2,3,4,5,6,7,8]

@curry
# Checks all possible moves on the board for the current postion and filters out moves that don't exist on the board
def moveKnight(pos: KnightPos) -> [KnightPos]:
    moves = [(pos[0]+2,pos[1]-1),(pos[0]+2,pos[1]+1),(pos[0]-2,pos[1]-1),(pos[0]-2,pos[1]+1),(pos[0]+1,pos[1]-2),(pos[0]+1,pos[1]+2),(pos[0]-1,pos[1]-2),(pos[0]-1,pos[1]+2)]  
    # the filter used 
    legalMoves = [(x[0], x[1]) for x in moves if x[0] in legalPos and x[1] in legalPos]
    return legalMoves

# uses >> operator from pymonad.List to take the resulting list from each moveKnight call and apply moveKnight to each element in the list, returning a list of all possible moves for each move
# EXAMPLE FROM PyMonad
# But 'x' could also have more than one value...
# x = List(1, 2)
# x >> positive_and_negative        # returns List(1, -1, 2, -2)
def in3(pos: KnightPos) -> [KnightPos]:
    return List(pos) >> moveKnight >> moveKnight >> moveKnight

# Given a starting and ending position check to see if you can make it to the end position in three moves 
def canReachIn3(pos1: KnightPos, pos2: KnightPos) -> bool:
    return pos2 in in3(pos1)

# print(in3(pos1))
print(canReachIn3(pos1, pos2))