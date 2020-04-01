#!/usr/bin/python3
import sys 

iscoe = True if sys.argv[1] == 'coe' else False 
filename = 'os'

b = open(filename + '.bin', 'rb').read() 
i = 0 
ext = '.hex'
if (iscoe):
	ext = '.coe'
f = open(filename + ext, 'w')
if (iscoe):
	f.write('memory_initialization_radix=16;\nmemory_initialization_vector=\n')
while(i < len(b)):
	btmp = b[i:i+4]
	hexstr = ''
	for t in btmp:
		hexstr = f'{t:0{2}x}' + hexstr
		# hexstr = hex(t)[2:] + hexstr
	f.write(hexstr + '\n')
	i += 4 
if (iscoe):
	f.write(';')
f.close() 
