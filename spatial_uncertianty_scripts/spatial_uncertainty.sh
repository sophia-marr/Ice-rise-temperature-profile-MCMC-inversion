#!/bin/bash

# Run python sampling code
python3 ice_rise_rand.py

mkdir sampled_points
mkdir ice_rise_ghf_uncertainties

for filename in ./rand_points/*_random_points.xy; do
	name=${filename##*/}
	ice_rise=${name%_random_points.xy}
	echo $ice_rise
	# Sample grids at random points
	gmt grdtrack $filename -Gmodel_output/HR24_GHF_mean_PS.grd -Gmodel_output/HR24_GHF_std_PS.grd -s+a \
	| awk '{print $1, $2, $3, $4, 1/($4^2)}' > sampled_HF_points_${ice_rise}.xyGuw
	
	# calculate mean and spatial deviation
	awk '{sum+=$3; sumsq+=$3^2}END{print "mean = "sum/NR, "spatial_std_dev = "sqrt((sumsq-sum^2/NR)/NR)}' sampled_HF_points_${ice_rise}.xyGuw > uncertainties_${ice_rise}.txt
	# calculate weighted mean and spatial deviation
	awk '{wsum+=$3*$5; wsumsq+=$3^2*$5; w+=$5}END{print "weighted_mean = "wsum/w, "weighted_spatial_std_dev = "sqrt((wsumsq-wsum^2/w)/w)}' sampled_HF_points_${ice_rise}.xyGuw >> uncertainties_${ice_rise}.txt
	
	# calculate mean local deviation
	awk '{sum+=$4; sumsq+=$4^2}END{print "mean_local_std_dev = "sum/NR}' sampled_HF_points_${ice_rise}.xyGuw >> uncertainties_${ice_rise}.txt
	# calculate weighted mean local deviation
	awk '{wsum+=$4*$5; wsumsq+=$4^2*$5; w+=$5}END{print "weighted_mean_local_stdev = "wsum/w}' sampled_HF_points_${ice_rise}.xyGuw >> uncertainties_${ice_rise}.txt
	
	# calculate mean total deviation
	awk '{sum+=$3; sumsq+=$3^2}END{print sqrt((sumsq-sum^2/NR)/NR)}' sampled_HF_points_${ice_rise}.xyGuw > out1.temp
	awk '{sum+=$4; sumsq+=$4^2}END{print sum/NR}' sampled_HF_points_${ice_rise}.xyGuw > out2.temp
	paste out1.temp out2.temp | awk '{print "total_std_dev = "sqrt($1^2+$2^2)}' >> uncertainties_${ice_rise}.txt
	
	# calculate weighted mean total deviation
	awk '{wsum+=$3*$5; wsumsq+=$3^2*$5; w+=$5}END{print sqrt((wsumsq-wsum^2/w)/w)}' sampled_HF_points_${ice_rise}.xyGuw > out1.temp
	awk '{wsum+=$4*$5; wsumsq+=$4^2*$5; w+=$5}END{print wsum/w}' sampled_HF_points_${ice_rise}.xyGuw > out2.temp
	paste out1.temp out2.temp | awk '{print "total_weighted_std_dev = "sqrt($1^2+$2^2)}' >> uncertainties_${ice_rise}.txt
	rm out*.temp
	
	mv sampled_HF_points_${ice_rise}.xyGuw sampled_points
	mv uncertainties_${ice_rise}.txt ice_rise_ghf_uncertainties
done
