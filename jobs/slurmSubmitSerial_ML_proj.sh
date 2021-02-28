#!/bin/bash

#SBATCH --partition=computeq
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --time=1-12:00:00
#SBATCH --job-name=ML_Project
#SBATCH --mail-user=mhssain9@memphis.edu
#SBATCH --output=[STDOUT]-%j.out
#SBATCH --error=[STDERR]-%j.err
#SBATCH --mem=4096



#################################################
#                                               #
#-----------------------------------------------#
# sbatch slurmSubmitSerial_ML_proj.sh           #
# scancel -n ML_Project			                #
#################################################
export LANG=en_US.UTF-8
export LC_ALL=C

cd $SLURM_SUBMIT_DIR

 
#################################################
# modules                                       #
#-----------------------------------------------#
# Any modules you need can be found with        #
# 'module avail'. If you compile something with #
# a particular compiler using a module, you     #
# probably want to call that module here.       #
#################################################
#module load [MODULE]
module load  miniconda/2.7.15/gcc.7.2.0

 
#################################################
# SLURM_JOB_ID                                  #
#-----------------------------------------------#
# You can use SLURM_JOB_ID environment variable #
# to get the current jobId.                     #
#'squeue -u [USERNAME]' lists user jobs with    #
# jobId in the left column.                     #
#################################################
# echo "$SLURM_JOB_ID"

#mkdir -p /home/mhssain9/virtualenv
#cd /home/mhssain9/virtualenv
#conda create --prefix=ML_Project  python=3.6

source activate /home/mhssain9/virtualenv/ML_Project

#conda install pip
#conda install ipykernel

#python -m ipykernel install --user --prefix ML_Project --display-name "Python (myenv)"

# conda install jupyter
# conda install pandas nltk scikit-learn

# conda install runipy 

#################################################
# Run your executable here                      #
#################################################
#[EXECUTABLE] [OPTIONS]
cd /home/mhssain9/workspace/ML_Project/
export XDG_RUNTIME_DIR=""

# runipy Sparse_Matrix_With_SVD.ipynb Output_Sparse_Matrix_With_SVD.ipynb
# runipy Dense_Matrix_With_PCA.ipynb Output_Dense_Matrix_With_PCA.ipynb

jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 --inplace Sparse_Matrix_With_SVD.ipynb 
# jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 --inplace Dense_Matrix_With_PCA.ipynb 

# jupyter $jupyter notebook --ip=0.0.0.0 --port=48189 --no-browser

# ssh -N -L localhost:48189:c073:48189 mhssain9@hpclogin
#################################################
source deactivate
module unload miniconda/2.7.15/gcc.7.2.0

seff "$SLURM_JOB_ID"
sacct -o jobid,maxvmsize,reqmem,maxrss,averss,elapsed -j "$SLURM_JOB_ID"
