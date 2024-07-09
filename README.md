# Ice-rise-temperature-profile-MCMC-inversion

Outline:

-	GHF_map  
o	The script ‘heatflow_maps.txt’ generates ‘heatflow_maps.png’, a series of maps of Antarctic heat flow, with close-ups of ice rise locations.
-	ice_rises  
o	This directory contains files of data pertaining to the 6 ice rises examined here: the lat/long coordinates (of the boreholes) (‘icerise_coords.txt’), their polar stereographic xy coordinates (km) (‘icerise_coords_ps.txt’), and the heat flow mean and standard deviation (mW) extracted from the grids from Hazzard & Richards (2024) at each of these locations (‘icerise_ghf.txt’).  
o	‘temperature_profiles’ contains the englacial temperature profiles of each ice rise, with columns of temperature (deg C) and height above bedrock (m).  
-	spatial_uncertainty_scripts  
o	Directory ‘model_output’ contains heat flow grids.  
o	The script ‘spatial_uncertainty.sh’ runs the python code ‘ice_rise_rand.py’ to select 50,000 random points within a 200km radius (the horizontal resolution of the seismic tomography from which the heatflow is derived) of each of the ice rises given with their polar stereographic coordinates in file ‘icerise_coords_ps.txt’.  
o	For each ice rise the script then samples the heat flow grid at each random point and calculates the spatial, local and total deviations.  
o	The larger value out of the total weighted and total unweighted deviations is used to set the prior in the inversion.  
-	MCMC_inversion    
o	The notebook ‘ice_rise_temperature_profile_MCMC_inversion.ipynb’ performs inversion of the ice rise temperature profiles. The code is adapted from Montelli & Kingslake (2023) and this original code is in ‘borehole_temperature_models’.  
o	An ice rise from each of three different areas in Antarctica is examined: Crary (Ross ice shelf), Skytrain (Ronne ice shelf) and Law Dome (East Antarctica). Code for three further ice rises (Siple Dome, Fletcher Promontory and Berkner Island) is also given.

