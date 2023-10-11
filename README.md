# Smart printing of queue within slurm scheduler
A simple bash script for visualization of job location on compute canada grid. Sorted according to jobtype but a small modifications needed for each cluster. More information about slurm job scheduler at [compute canada webpage](https://docs.alliancecan.ca/wiki/Running_jobs). This script is not meant for user job queues larger than 100.

Default output of `squeue -u $USER` command:
<p align="center">
  <img src="https://github.com/jiri-hostas/Slurm-queue-smart-printing/blob/main/graphics/Example.jpg" width=85% height=85%>
</p>

**A clean script output example:**
<p align="center">
  <img src="https://github.com/jiri-hostas/Slurm-queue-smart-printing/blob/main/graphics/Output.jpg" width=50% height=25%>
</p>

Things to work on:
- making a single version working for all compute canada clusters
- include different job metrics than job location

![](https://komarev.com/ghpvc/?username=jiri-hostas)
