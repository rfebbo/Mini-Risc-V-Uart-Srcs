#!/usr/bin/python3
import os 
import argparse 

#usage: ./pydecompile.py file.elf

def runbash(cmd):
	exitCode = os.system(cmd)
	if (exitCode > 0):
		print("ERROR :(")
		exit()

parser = argparse.ArgumentParser()
parser.add_argument('file', help='ELF File Name (*.elf')
args = parser.parse_args()

cmd = 'riscv32-unknown-elf-objdump --disassemble ' + args.file
#/home/bsergent/gra/toolchain/riscv32-unknown-elf/bin/objdump --disassemble

runbash(cmd)

