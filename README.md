# Scoreboard on FPGA

Implementing a chronometer on a FPGA.

## Board

Tested on an *Altera Cyclone V* and developed in the *Quartus* environment.

## Sources explained

> FDIV.vhd : Clock divider to synchronise clock events with seconds, deciseconds and centiseconds

> afficheur_7.vhd : Hardware coding of the 7 segments display

> counter.vhd : Modulo 9 counter (4 bits, goes back to 0 when you reach 1001)  ; Restart/Rewind/Memory options

> memory.vhd : stocks a 4 bits number between 0000 and 1001 to display a saved data

> main_chronometer.vhd : main code joining every components

## _TB files

Testbench arbitrary files for simulations on a defined clock span.

## License

[BSD 3-Clause License](https://github.com/Guilyx/scoreboard-fpga/blob/master/LICENSE)
