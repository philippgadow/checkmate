## CheckMATE setup for Dark Higgs model

Reference: CheckMATE 2 paper (https://arxiv.org/abs/1611.09856)

The idea is to check with existing LHC analyses which model points are already excluded to avoid those for our signal grid.
A similar approach is taken by https://contur.hepforge.org/ (https://arxiv.org/abs/1606.05296)

### How to use this project

The whole code is provided as a Docker container. This avoids the nasty installation and guarantees the code to run.
If you are not familiar with Docker, please have a look here: https://docker-curriculum.com/
Make sure that you have Docker installed before you continue. You can install Docker following this link: https://docs.docker.com/install/

The image is hosted here: https://hub.docker.com/r/philippgadow/checkmate/

### First run

The project is configured to run out of the box for a single point in the mass grid that has been chosen as an example:

Please enter:
```
source run.sh
```

This will run the Docker image as a container and within the container it will call `work/run_example_in_docker.sh`.
