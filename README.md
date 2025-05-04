# f256_reset

Before I had a reset switch for my C64 the only way to reset the machine was to call the
ROM routine `SYS 64738`. I typed this so often that I still remembered it after about 30
years when my interest in retro computing reawakened some time ago. The Foenix F256
machines do come with a reset switch but I sometimes still feel the urge to simply type a 
command to reset the machine. This repo contains a flash resident program which allows
you to do just that: Do `SYS 64738` on your Foenix machine.

# How does it work

Here the excerpt from the system manual: A program can trigger a system reset. This can be done by 
writing the value 0xDE to 0xD6A2 and the value AD to 0xD6A3 to validate that a reset is really 
intended (see table: 17.3), setting the most significant bit (RESET) of 0xD6A0, and then clearing the 
RESET bit to actually trigger the reset.

That is exactly what this program does. It is packaged as a Kernel User Program or short a KUP
which can either be written to onboard flash or a flash cartridge. The program is freely relocatable
in flash memory, i.e. you can put it in any flash block which is available on your system. 

If you have stored the program in flash simply issue the command `/reset` at the BASIC prompt or
`reset` in DOS to make your Foenix perform a soft reset.

# How to build the software

You will need 64tass, a Python interpreter and GNU make to build this program. If you want to
write the program to flash by yourself simply type `make` and after that write the file `loader.bin` 
to the flash block of your desire.

If you want this the `makefile` can also write the binary to onbaord flash for you. Before that you
have to change the variable `BLOCK_HEX` to specify the number of the target flash block in hex (with a leading
zero if the number is smaller than 0x10). The default value is `0a`. **Be careful**: This is the location 
for the BASIC help system and you **must** change the block number to a block which is available on your system
if you use the BASIC help system. After having set the block number to a suitable value you also have to check
that the variable `PORT` references the COM port used by `FoenixMg` on your system. Finally you can issue
the command `make flash` to build and store the program in onboard flash in one go. You can use `make clean`
to delete all file which are created during the build process.

The name of the KUP is specified in line 14 of `flashloader.asm`. It currently is set to `reset`. You could
change it to `sys64738` for the total retro experience.
