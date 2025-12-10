Bash script for the perfomance metrics CPU usage and Memory Usage 
To run first make the script an executable with chmod +x monitor.sh
Next run ./perf_metrics.sh & to run it. 

The script will run in the background waiting for a zeek or RITA process to start and will log their CPU and Memory metrics and save it in a CSV file. If a CSV file is not created yet it will create it for you. 
