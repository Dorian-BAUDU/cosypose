!/bin/sh -e
# Attempt to write the slurm script following /pfcalcul/tools/examples/gpu/cuda/pytorch example

echo "Running T-LESS test to reproduce Y. Labbé results on CosyPose"

EXEC="python -m cosypose.scripts.run_cosypose_eval --config tless-siso"
GPU_REQUIRED=true
#gpu=rtx_a6000

. /pfcalcul/tools/sbatchHelpers2.sh

jobMessage=$(
######################### SBATCH launcher
#########################     #SBATCH --option        # <= this is an enabled paramater
#########################     ##SBATCH --option       # <= this is a disabled parameter
sbatch ${sbatchopt} << eof
#!/bin/bash
#SBATCH --job-name=test_tless
#SBATCH --ntasks=1
#SBATCH --account=dept_rob
#SBATCH --partition=robgpu
#SBATCH --gres=gpu:${gpu}

#SBATCH --mail-type=ALL

#SBATCH --output=stdout.txt
#SBATCH --error=stderr.txt

. /pfcalcul/tools/sbatchHelpers2.sh

# Preparing conda environment
# source conda
. /pfcalcul/tools/softs/anaconda/anaconda3.sh
# activate env
conda activate /pfcalcul/work/tlasguigne/cosypose_env

time $EXEC

eof
)

showSubmitted
