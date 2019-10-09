# Mini Risc-V with UART

This is an FPGA implementation of a RISC-V processor, reprogrammable via serial communication. Instructions and scripts for programming it can be found in my other repository [here](https://github.com/gbruner7607/Mini-Risc-V-gcc)
<br>
The original Mini-Risc-V Core was designed by Md Badruddoja Majumder. I've made some modifications including implementing a reprogrammable instruction memory, as well as restructuring the memory module to pave the way for a more complex and comprehensive memory hierarchy. This is a work in progress.
<hr>
As with the original Mini-Risc-V, instruction memory is currently implemented using a Vivado IP core. Use the Block Memory Generator from the Vivado IP catalog, and configure it as follows:

```
Basic:
  Interface Type: Native
  Memory Type: Single Port RAM
  No ECC
  Byte Write Enable
  Byte Size: 8 bits
  Algorithm Options: default
Port A Options:
  Write Width: 32
  Read Width: 32
  Write Depth: 1024
  Read Depth: 1024
  Operating Mode: Write First
  Enable Port Type: Use ENA Pin
  Uncheck all following options
Other Options:
  Load Init File: <choose from coe/*.coe>
  Fill Remaining Memory Locations: 0
```
