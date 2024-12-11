# Morse Code Translator

Team 14: Lauren Monahan, Nandana Alwarappan, Sterling Wodzro, Aidan Born

Project Demo Link: *ADD*

For our project, we implemented a morse code translator, where the user can push a sequence of buttons either representing a dot, dash, space, enter, or reset on the fpga board as ASCII text appears on the host computer screen. 

---

## How to Run

You can run this project on Verilog, assigning vga_top as the top module. Ensure the fpga board is connected to the monitor and turn on the VGA switch. The translator operates by the use of five buttons: a dot, dash, enter, space, and reset. These should be pre-set to P17, N17, P18, M17, and M18, respectively. You can confirrm which buttons correspond to which pins on the board in the contraints.xdc file. Reference the international morse code alphabet when inputting dot/dash combinations. When you have finished one input combination of dots/dashes/spaces, click the enter button on the fpga and you will see the corresponding letter appear on the screen. Click reset when you want to clear the screen. 

---

## **Code Overview**
top_2:

The top_2 module is responsible for matching the user's morse code input to an ASCII letter. For example, it is here that a "dot, dash, enter" input assigns "A" to our letter variable. 

We represent the input as a 6 bit binary value, where a 1 represents a dash and a 0 represents a dot. Initalized as 0, the morse code variable shifts to the left as the binary input is inserted at its end. The input can be any number betweenn 0-4 button presses. Each user input will have a unique morse_code and code_length identifier. These are used to to form a dictionary, of sorts, where each identifier corresponds to a different, 8 bit, letter.   

Note, also, that each input (dot, dash, space, enter) is debounced.   

morse_code_translator_tb:

This testbench is used in pairing with the top_2 module. Here, we simulated different morse code sequences to verify the input was paired with the correct ASCII value. 

debounce:
The debouncer module handles noisy button inputs, ensuring only a single input is processed. A button press is triggered by the positive edge of the debounced signal. 

debounce_tb:
This module was used to test our debouncer with varying inputs. 

ascii_rom:
The ascii_rom module provides us with defined bit patterns for each ASCII character, used for our vga display.  

vga_controller:
Here, we assign a letter input to its corresponding bit pattern defined in ascii_rom. Each user input is stored in memory so they remain on the screen until the reset button is pressed.

vga_top:
Here, we instantiate the top_2 module, which translates the user input to a letter. This translated ASCII letter is then sent to vga_controller, which configures the display. 

In this module we also establish a black background with white text for the screen display. 

---

##**What To Expect From Bitstream**
When pushing the bitstream to the FPGA, you should expect to see the eight righmost LEDs display the 8-bit ASCII value that corresponds to the letter input. After you input you morse code sequence and press the enter button, you will see the equivalen text appear on the VGA screen.  

## **References**
https://github.com/FPGADude/Digital-Design/tree/main/FPGA%20Projects/VGA%20Projects/VGA%20Text%20Generation

ADD
---

