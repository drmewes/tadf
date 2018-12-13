#!/bin/bash

#SBATCH --job-name=.data.mewes1.CALC.tadf.DONORS.DiEt_PXZ_kat_tol.in
#SBATCH -t 0-12:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o /home/mewes1/err/qchem-%j
#SBATCH --mail-user=stefaniemewes@janmewes.de
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

module unload *
module add q-chem/intel/QCHEM_5.1.0_Trunk
#module load openmpi/intel/64/1.10.4-i8 
#module load intel/compiler/64/16.0.3/2016.3.210 
#module load gcc/5.2.0
#module load intel/mkl/64/11.3.3/2016.3.210
#export QC=/home/mewes/SOFTWARE/QCHEM_5
#export QCAUX=/home/mewes/SOFTWARE/QCHEM_AUX_5.0.2
export QCSCRATCH=$SCRATCH
export QCPLATFORM=LINUX_Ix86
#xport QCTHREADS=4
#xport OMP_NUM_THREADS=4

# Go into Scratch
cd $SCRATCH
cp /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.in /data/mewes1/CALC/tadf/DONORS/*.mol .

# Backup old out file is existing 
[ -e /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.out ] && cp /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.out /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.out_OLD

# Execute the program
if [ "" = "yes" ] ; then
$QC/bin/qchem -save DiEt_PXZ_kat_tol.in /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.out DiEt_PXZ_kat_tol.out.plots
else
$QC/bin/qchem DiEt_PXZ_kat_tol.in /data/mewes1/CALC/tadf/DONORS/DiEt_PXZ_kat_tol.out
fi

