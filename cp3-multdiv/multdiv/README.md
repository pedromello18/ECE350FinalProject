# MultDiv
## Name: Pedro Mello (pgm15)

## Description of Design
<h3>Multiplier</h3>
The multiplier module implements the Modified Booth's Algorithm. The most challenging aspect of this design is to time everything correctly, as the general hardware description was given in the lecture slides, although some additional multiplexers were necessary to make sure control logic was effective. All multiplication steps are computed in 16 clock cycles, when the multiplier module signals it's done.
<h3>Divider</h3>
The divider module implements Non-Restoring Division. There's no necessity to adjust or store the remainder, at least for now, so the adjustment step of the AQ register at the end was skipped, although it will be easy to implement if necessary. The only necessary control was the counter.

## Bugs: N/A