#!/bin/bash

#SBATCH --job-name=orca_s1opt
#SBATCH -t 3-0:00
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o /home/mewes/err/orca-%j
#SBATCH --mail-user=janmewes@janmewes.de
#SBATCH -p short

echo "This job was submitted from the computer:"
echo "$SLURM_SUBMIT_HOST"
echo "and the directory:"
echo "$SLURM_SUBMIT_DIR"
echo ""
echo "It is running on the compute node:"
echo "$SLURM_CLUSTER_NAME"
echo ""
echo "The local scratch directory (located on the compute node) is:"
echo "$SCRATCH"
echo ""

module load orca/prebuilt_binaries/64/4.0.1 
module unload openmpi-2/gcc/64/2.0.2
module load openmpi-2/gcc/64/2.1.1-i8

# Go into Scratch
cd $SCRATCH
cp /home/mewes/CALC/TADF/Yersin/orca_s1opt.in /home/mewes/CALC/TADF/Yersin/*.hess /home/mewes/CALC/TADF/Yersin/*.gbw .

# Execute the program
$ORCA_PATH/orca orca_s1opt.in > /home/mewes/CALC/TADF/Yersin/orca_s1opt.out

#Remove temp files from crashed jobs and copy everything from Scratch back
rm *.tmp *.tmp0 *.tmp1
cp * $SLURM_SUBMIT_DIR