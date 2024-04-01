# ALU
## Name: Pedro Mello (pgm15)

## Description of Design
I made it so that the design was as easy to follow as possible, therefore breaking it into as many files as possible, and enjoying the nice consequences of that abstraction and organization. All components of the ALU should be fairly obvious to comprehend, there are bit-wise muxes and bus muxes. Bit wise operations are accomplished by doing the operations in pairs of bits. Shifting is done just like in 250, have a 1, 2, 4, 8 and 16-bit shifter, and shifts in serial as necessary. The CLA is a carbon copy from the slides in class, this should be fairly evident given the structure of its .v file. I also broke it down further, into 8-bit cells and adder cells. Overflow, NE and LE logic was implemented via truth tables.

## Bugs: N/A
