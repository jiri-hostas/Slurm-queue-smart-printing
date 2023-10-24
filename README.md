# Smart printing of queue within slurm scheduler
A simple bash script to display jobs' locations on compute canada grid. Sorted according to jobtype. Small modification needed for each cluster! More information about slurm job scheduler at [compute canada webpage](https://docs.alliancecan.ca/wiki/Running_jobs). This script is not meant for user job queues larger than 100.

Default output of `squeue -u $USER` command:
<p align="center">
  <img src="https://github.com/jiri-hostas/Slurm-queue-smart-printing/blob/main/graphics/Example.jpg" width=85% height=85%>
</p>

**A script output example:**
<p align="center">
  <img src="https://github.com/jiri-hostas/Slurm-queue-smart-printing/blob/main/graphics/Output.jpg" width=75% height=50%>
</p>

Things to work on:
- make a single version to work for all compute canada clusters
- add a maximum number of jobs to be printed as a script input parameter
- include different job metrics than job location

![](https://komarev.com/ghpvc/?username=jiri-hostas)
