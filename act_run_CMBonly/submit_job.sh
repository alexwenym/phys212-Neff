#!/bin/bash
#SBATCH --job-name=lcdm_neff         # This default will be overridden by --job-name when submitting
#SBATCH --output=lcdm_neff.out                  # %x = job name; %j = job ID.
#SBATCH --error=lcdm_neff.err
#SBATCH --time=12:00:00
#SBATCH --partition=test
#SBATCH --mem=50000
#SBATCH --nodes=1                              # Request 2 nodes (to accommodate 32 cores total if needed)
#SBATCH --ntasks=1                             # Total number of MPI tasks (8 independent chains)
#SBATCH --cpus-per-task=4                      # Number of CPU cores per MPI task (4 OpenMP threads per chain)
export OMP_NUM_THREADS=4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

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

if [ $# -gt 0 ]; then
    YAMLFILE="$1"
else
    YAMLFILE="cosmology_example.yaml"
fi

echo "Using YAML file: $YAMLFILE"


# Run cobaya using srun with MPI support
srun --mpi=pmi2 --export=ALL cobaya-run --resume "$YAMLFILE"


wait
