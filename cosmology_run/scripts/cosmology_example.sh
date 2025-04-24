#!/bin/bash

#SBATCH -p arguelles_delgado,shared,intermediate                           # Partition (queue) name
#SBATCH --nodes=1                            # Number of nodes, adjust as needed
#SBATCH --ntasks=4                           # Total number of MPI tasks (chains)
#SBATCH --time=12:00:00                      # Walltime (hh:mm:ss)
#SBATCH --cpus-per-task=4                    # Number of OpenMP threads per task

# Change into the directory from which the job was submitted (adjust if necessary)
cd ./

# (Optional) Activate your conda environment, if needed.
# For example, if you use conda, uncomment the following:
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate cobaya_env

# Print job information for logging purposes
echo "JobID: $SLURM_JOB_ID"
echo "Running on: $(hostname)"
echo "Current directory: $(pwd)"
echo "Date: $(date)"
echo "Python executable: $(which python)"

# The placeholder mpirun -np 4 cobaya-run -r cosmology_example.yaml will be substituted by cobaya-run-job.
mpirun -np 4 cobaya-run -r cosmology_example.yaml

wait