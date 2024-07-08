import random
import math
import numpy as np

with open('icerise_coords_ps.txt') as input_file:
	for line in input_file:
		x, y, ice_rise = line.split(' ')
		x=float(x)
		y=float(y)
		ice_rise = str(ice_rise.strip())
		
		# radius of the circle (effective tomographic resolution [km])
		circle_r = 200
		
		# center of the circle (x, y) (coordinates of Crary in polar stereographic [km])
		#x_cr=-100.04
		#y_cr=-759.89
		
		# set number of points you wish to sample (10,000 should be sufficient)
		npoints=50000
		
		# set up output array
		outpoints=np.zeros((npoints,2))
		
		for i in range(npoints):
			# set random angle
			alpha = 2 * math.pi * random.random()
			
			# set random radius
			r = circle_r * math.sqrt(random.random())
			
			# calculate coordinates
			outpoints[i,0] = r * math.cos(alpha) + x
			outpoints[i,1] = r * math.sin(alpha) + y
			
		# save output
		np.savetxt('./rand_points/%s_random_points.xy' % ice_rise, outpoints)


