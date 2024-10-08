#!/bin/bash
#SBATCH --job-name=wat_oct
#SBATCH --account=Project_2004855
#SBATCH --partition=medium
#SBATCH --time=01:00:00
# #SBATCH --ntasks-per-node=6
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --array=601-800

# Program environment variables
#module load intelmpi
#module load fftw
#module load iccifort/2017.4.196-GCC-6.4.0-2.28
#module load impi/2017.3.196
#module load GROMACS/2019.3



# environment variable setup
export Project=$SBATCH_JOB_NAME                 # Name of the polaris input file
export CurrDir=$SLURM_SUBMIT_DIR          # directory with input and output files
#source settmpdir

#LANG=C                          # some programs just don't like
#LC_ALL=C                        # internationalized environments!
#export LANG LC_ALL




#printenv                       # uncomment to see all environment variables
#set -x                         # uncomment to get all commands echo'ed

#export MKL_NUM_THREADS=1
#export OMP_NUM_THREADS=1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load gcc/9.1.0  hpcx-mpi/2.4.0
#module load gromacs/2021.2
module load gromacs/2018.6
#export GMX_MAXCONSTRWARN = -1
#export NPROCS=`cat $PBS_NODEFILE | wc -l`
#export NHOSTS=`cat $PBS_NODEFILE | uniq | wc -l`
#cat $PBS_NODEFILE | uniq > $CurrDir/mpd.hosts
echo "#--- Gromacs calculation running with $SLURM_NTASKS CPUs:"
cat $SLURM_NTASKS
 #(( ncores = SLURM_NNODES * 16 ))
# Here the real job starts
#
echo "#--- Job started at `date`"

# create the temporary directory and make sure the input directory is
# accessible
#cd $CurrDir || exit 2

# copy all necessary files (input, source, programs etc.) to the execution
# host
#cp * $TMPDIR/

# Run calculation
#cd $TMPDIR
echo "Gromacs calculation"

srun gmx_mpi mdrun -deffnm ener_dist_${SLURM_ARRAY_TASK_ID} -rerun trr1.trr #-maxh 0.2 -dlb yes
# copy all output files from the execution host back to $CurrDir
#cp * $CurrDir/

# remove the temporary directory if $CurrDir is accessible

#cd $CurrDir && rm -rf $TMPDIR # uncomment this for automatic cleanup

echo "$SLURM_NTASKS"
