#!/bin/bash

#SBATCH --job-name=dCALC.TADF.ANDBA-OMe.TOPT_FROMGS.t4opt.in
#SBATCH -t 3-0:00
#SBATCH -n 8
#SBATCH -N 1
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o /home/mewes/err/qchem-%j
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

module add q-chem/intel/QCHEM_5.0.1_Trunk
#module load openmpi/intel/64/1.10.1 
#module load intel/compiler/64/16.0.3/2016.3.210 
#module load gcc/5.2.0
#module load intel/mkl/64/11.3.3/2016.3.210
#export QC=/home/mewes/SOFTWARE/QCHEM_5
#export QCAUX=/home/mewes/SOFTWARE/QCHEM_AUX
export QCSCRATCH=$SCRATCH
export QCPLATFORM=LINUX_Ix86
export QCTHREADS=8
export OMP_NUM_THREADS=8

# Go into Scratch
cd $SCRATCH
cp /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.in /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/*.mol .

# Backup old out file is existing 
[ -e /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.out ] && cp /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.out /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.out_OLD

# Execute the program
if [ "" = "yes" ] ; then
$QC/bin/qchem -save -np 1 t4opt.in /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.out t4opt.out.plots
else
$QC/bin/qchem -np 1 t4opt.in /data/mewes/CALC/TADF/ANDBA-OMe/TOPT_FROMGS/t4opt.out
fi

