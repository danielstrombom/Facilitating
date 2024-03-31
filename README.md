# Facilitating
Code for Strömbom et al. 2024 Modelling the emergence of social-bird biological controls to combat the spotted lanternfly and similar invasive pests. Royal Society Open Science 11 (2), 231671. (https://royalsocietypublishing.org/doi/10.1098/rsos.231671). Download all files and then follow instructions below.

REGENERATE FIGURES FROM NEW SIMULATIONS 

To regenerate Figure 2A from new simulations run labFig2.m. This will run 2000 simulations for each q values from 0 to 1 in increments of 0.01 for 80000 time steps and create the Cpvq.mat file. This simulation data file will then be used to plot the simulation parts of Figure 2A with the mathematical CBC equilibrium superimposed. 

To regenerate Figures 2B and S1 from new simulations run labFig3.m. This will run 5000 simulations for each q values from 0 to 1 in increments of 0.1 for 80000 time steps and create the eleven M0X.mat files. This simulation data files will then be used to plot the simulation parts of Figure 2B and S1 with the mathematical explicit solution for each q superimposed. 

Note that running these simulation lab files may take a very long time and will generate large .mat files (about 1.93GB). We used MATLAB R2020b for these analyses.
