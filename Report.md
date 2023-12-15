# User Guide

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

## Limitations
This calculator can only take positive 2-digit inputs and can only output integers between -127 and +127. If division by 0 is attempted overflow will occur and an incorrect result will be displayed.

# Files
## Components
### Binary2BCD
The goal of the Binary2BCD is to take a binary number and convert it into binary numbers that represent each digit individually. This component uses the Double Dabble algorithm to add 3 to the number if it is greater or equal to five and then shifts it to the output.
### IntRegister
The component IntRegister is used to store the integer values of up to 7 bits selected by the user. It also has a clear feature which will set all bits to 0.
### OpRegister
The OpRegister component stores a 2 bit value which represents the operator selected by the user. 00 is for addition, 01 is for subtraction, 10 is for multiplication, and 11 is for division. This register also has a clear function which resets the register bits to 0. 
### Prescale
The Prescale component of this design takes the 50MHz clock signal which is provided by the FPGA 
board and outputs a clock signal which has a frequency of $\frac{1}{2^{20}}$ of the original. This makes the clock signal much more suitable for human input. 
### SegDecoder
This component takes in a 4 bit Binary Coded Decimal (BCD) number and outputs a 7 bit logic vector which will control each of the 7 segments of a 7 segment display. This allows a seven-segment display to display any decimal 0 though 9. On the Altera DE2-115 board which this component is designed for, each of the segments is active low.

This is also programmed to consider and display binary value `1111` as `-`
### UintRegister
This component is the same as the IntRegister except is it is for holding unsigned binary numbers and thus has one less bit.
### OperatorEncoder
The operator uses hot encoding to make a 2 bit binary number out of 4 hot encoded inputs. This allows for the user to input with only 1 out of 4 switches being high a time and the output is a 2 bit binary number.
### Debouncer
The Debouncer component stabilizes the input from the key inputs and prevents unintended inputs by reducing the metastable state of the switch.
### FSM
The FSM (Finite State Machine) component controls the switching between the 6 states and outputs a 3 bit logic vector which holds the current state. 

### FullCalculator
The FullCalculator component combines the functionality of most other components. Depending on the state of the FSM it takes the required inputs from the user and maps them to the inputs of the other components such as registers and the calculator. 

### CalculatorTop
The CalculatorTop component maps the user interface components such as the switches, keys, 7 segment displays, and LEDs to the correct parts of the circuit.

### Divider
The divider component takes in an integer dividend and divisor and produces a quotient and remainder using integer division.

### Calculator
The Calculator component takes the 2 user input values as inputs as well as the selected operator and performs the required operation on the two input numbers. The output is the result of this operation which can include either a signal indicating the number is negative or a remainer if one is present. 

## Verification
### PreScale_tb
The PreScale_tb component is used by ModelSim to verify the functionality of the PreScale component.We have run a simulation and analyzed the waveforms to confirm that the scaled clock is only high when the 20th bit of the accumulator is a 1 which is the intended output for this component.

### FSM_tb 
The FSM_tb component is used by ModelSim to verify the functionality of the FSM component. The test bench file first tests that all states can switch sequentially and then tests the reset function from each state. We have run a simulation and analyzed the waveforms to confirm that the FSM switches states sequentially with the correct input and resets to the initial state when the reset is triggered from any state. 