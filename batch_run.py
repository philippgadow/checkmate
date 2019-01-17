import os, errno
from argparse import ArgumentParser
from slurmy import JobHandler, Type, SingularityWrapper


def mkdir(directory):
    """Make directory if it does not already exist"""
    try:
        os.makedirs(directory)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise
    return directory

def getArgs():
    """Get arguments from command line."""
    parser = ArgumentParser()
    parser.add_argument("-n", "-njobs", default=1, help="Number of jobs to be submitted.")
    return parser


def main():
    """Batch submission using slurmy."""
    ## Set up the JobHandler
    jh = JobHandler(local_max=8, local_dynamic=True, work_dir=mkdir('batch'), printer_bar_mode=True, wrapper=SingularityWrapper('docker://philippgadow/checkmate'))
    ## Define the run script content

    ## Add a job
    jh.add_job(run_script='/work/run_example_in_docker.sh', job_type=Type.LOCAL)
    ## Run all jobs
    jh.run_jobs()

if __name__ == '__main__':
    main()
