import sys

basestr = 'memory_initialization_radix=16;\nmemory_initialization_vector=\n'

mems = [list(), list(), list(), list()] 

with open(sys.argv[1], 'r') as f:
	lines = f.readlines() 
	for l in lines:
		l = l.strip('\n')
		mems[0].append(l[6:8])
		mems[1].append(l[4:6])
		mems[2].append(l[2:4])
		mems[3].append(l[0:2])

idx = 0
for m in mems:
	outfilestr = 'comptest' + str(idx) + '.coe'
	with open(outfilestr, 'w') as f:
		f.write(basestr)
		for b in m:
			f.write(b + '\n')
		f.write(';')
	idx += 1
