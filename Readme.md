This is an optional project that we made for the course ENSC 252 - Introduction to Digital Logic & Design. The goal of our project was to build a calculator that can perform Integer Addition, Subtraction, Multiplication, and Division.

# User Guide

**To read full documentation, see [Report.md](Report.md)**

The operation of this calculator requires cycling between 6 different states. The control of these states 

use the following keys:
Key | Description
--|--
Key 0 | Select
Key 1 | Clear memory
Key 2 | Move to next state
Key 3 | Restart components and move back to idle state

The six states of the calculator are as follows:
State | Description
--|--
Idle | All selections and displays are cleared
Select calculator input 1 | Use input selection switches to select desired number, then push select key to input number
Select operator | Use operator select switches to select desired operator, then push sleect key to input operator
Select calculator input 2 | Use input selection switches to select desired number, then push select key to input number.
Calculate Result | Result of calculation will be calculated but will not be displayed.
Display Result | Result will be displayed.

Input numbers can be chosen using the 7 rightmost switches (SW 6 downto 0), the input number is selected in binary where an upwards switch is a 1 and a downwards switch is a 0. Operators can be selected using the 4 leftmost switches (SW17 downto 14), only 1 switch may be high at a time. Each switch represents an operator:

Switch | Operator
--|--
SW 17 | Divide
SW 16 | Multiply
SW 15 | Subtraction
SW 14 | Addition

During any state memory can be cleared using Key 1, this will clear the selection of input number 1, the operator, input number 2, and the calculated result. 

When the division function is used and the result of the division includes a remainder, LEDG8 will be illuminated and the quotient will be displayed on the first two segments with the remainder in the second two.

# Credits
Adam Spelrem

Roberto Selles

Zach Spencer