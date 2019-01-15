#!/bin/bash

#SBATCH --job-name=dCALC.tadf.ANDBA-MeEt-MeCz.MOM_OPT.moms1opt_dcm.in
#SBATCH -t 3-0:00
#SBATCH -n 8
#SBATCH -N 1
#SBATCH --mem-per-cpu=2G
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
#xport QCTHREADS=8
#xport OMP_NUM_THREADS=8

# Go into Scratch
cd $SCRATCH
cp /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.in /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/*.mol .

# Backup old out file is existing 
[ -e /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.out ] && cp /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.out /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.out_OLD

# Execute the program
if [ "" = "yes" ] ; then
$QC/bin/qchem -save moms1opt_dcm.in /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.out moms1opt_dcm.out.plots
else
$QC/bin/qchem moms1opt_dcm.in /data/mewes1/CALC/tadf/ANDBA-MeEt-MeCz/MOM_OPT/moms1opt_dcm.out
fi

