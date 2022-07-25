#!/bin/bash
#set a job name  
#SBATCH --job-name=cms_correction
#################  
#a file for job output, you can check job progress
#SBATCH --output=cms_correction.out
#################
# a file for errors from the job
#SBATCH --error=cms_correction.err
#################
#time you think you need; default is one day
#in minutes in this case, hh:mm:ss
#SBATCH --time=24:00:00
#################
#number of tasks you are requesting
#SBATCH -n 50
#SBATCH --exclusive
#SBATCH --mem=100G
################
#partition to use
#SBATCH --partition=short
#################
#number of nodes to distribute n tasks across
#SBATCH -N 1
#################

sas cms_correction -work /scratch/fatemehkp/projects/code

cd $work


sas cms_correction


