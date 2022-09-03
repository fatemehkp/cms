#!/bin/bash
#set a job name  
#SBATCH --job-name=cms-icd-rc
#################  
#a file for job output, you can check job progress
#SBATCH --output=cms-icd-rc.out
#################
# a file for errors from the job
#SBATCH --error=cms-icd-rc.err
#################
#time you think you need; default is one day
#in minutes in this case, hh:mm:ss
#SBATCH --time=24:00:00
#################
#number of tasks you are requesting
#SBATCH -n 1
#SBATCH --exclusive
#SBATCH --mem=100G
################
#partition to use
#SBATCH --partition=short
#################
#number of nodes to distribute n tasks across
#SBATCH -N 1
#################

sas cms-icd-rc -work /scratch/fatemehkp/projects/CMS/code

cd $work


sas cms-icd-rc


