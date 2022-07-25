#!/bin/bash
#set a job name  
#SBATCH --job-name=cmstotal
#################  
#a file for job output, you can check job progress
#SBATCH --output=cmstotal.out
#################
# a file for errors from the job
#SBATCH --error=cmstotal.err
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

sas cmstotal -work /scratch/fatemehkp/projects/CMS/code

cd $work


sas cmstotal


