#!/bin/bash

#SBATCH --job-name=dCALC.TADF_OLD.Yersin.ADC_FINAL.tLE_tol.in
#SBATCH -t 5-0:00
#SBATCH -n 26
#SBATCH -N 1
#SBATCH --mem-per-cpu=19G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o /home/mewes/err/qchem-%j
#SBATCH --mail-user=janmewes@janmewes.de
#SBATCH -p bigmem

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

#module unload *
module add q-chem/intel/QCHEM_5.1.0_Trunk
#module load openmpi/intel/64/1.10.4-i8 
#module load intel/compiler/64/16.0.3/2016.3.210 
#module load gcc/5.2.0
#module load intel/mkl/64/11.3.3/2016.3.210
#export QC=/home/mewes/SOFTWARE/QCHEM_5
#export QCAUX=/home/mewes/SOFTWARE/QCHEM_AUX_5.0.2
export QCSCRATCH=$SCRATCH
export QCPLATFORM=LINUX_Ix86
#xport QCTHREADS=26
#xport OMP_NUM_THREADS=26

# Go into Scratch
cd $SCRATCH
cp /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.in /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/*.mol .

# Backup old out file is existing 
[ -e /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.out ] && cp /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.out /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.out_OLD

# Execute the program
if [ "" = "yes" ] ; then
$QC/bin/qchem -save tLE_tol.in /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.out tLE_tol.out.plots
else
$QC/bin/qchem tLE_tol.in /data/mewes/CALC/TADF_OLD/Yersin/ADC_FINAL/tLE_tol.out
fi
