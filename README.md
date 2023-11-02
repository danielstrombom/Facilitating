# Facilitating
Instructions for how to regenerate Figures 2A, 2B, and S1 from new simulations for review purposes of Strömbom et al. Facilitating the emergence … . Submitted to RSOS. Download all files and then follow instructions below.

REGENERATE FIGURES FROM NEW SIMULATIONS 
To regenerate Figure 2A from new simulations run labFig2.m. This will run 2000 simulations for each q values from 0 to 1 in increments of 0.01 for 80000 time steps and create the Cpvq.mat file. This simulation data file will then be used to plot the simulation parts of Figure 2A with the mathematical CBC equilibrium superimposed. 
To regenerate Figures 2B and S1 from new simulations run labFig3.m. This will run 5000 simulations for each q values from 0 to 1 in increments of 0.1 for 80000 time steps and create the eleven M0X.mat files. This simulation data files will then be used to plot the simulation parts of Figure 2B and S1 with the mathematical explicit solution for each q superimposed. 
Note that running these simulation lab files may take a very long time and generate very large .mat files. We have run these on MATLAB versions R2021a and R2018b without problems.
