!/bin/bash 
#   Author: Jan Qara Kula

echo "____________________________________________" 
echo "           SERVER PERFORMANCE STATS" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
echo "Date & Time: $(date)" 
echo "Hostname: $(hostname)" 
echo "____________________________________________" 


echo "  CPU Usage:" 
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2"% | System: " $4"% | Idle: " $8"%"}' 
echo 
 
echo "  Memory Usage:" 
free -h | awk '/Mem:/ { 
    total=$2; used=$3; free=$4; 
    used_perc=(used/total)*100; 
    printf("Total: %s | Used: %s | Free: %s | Used: %.2f%%\n", total, used, free, used_perc) 
}' 
echo 
 
echo "  Disk Usage:" 
df -h --total | grep total | awk '{print "Total: " $2 " | Used: " $3 " | Free: " $4 " | Used: " $5}' 
echo 
 
echo "  Top 5 Processes by CPU Usage:" 
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 
echo 
 
echo "  Top 5 Processes by Memory Usage:" 
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 
echo 
 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
echo "               ADDITIONAL SERVER INFO" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 

 
echo "  OS Version:" 
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"' 
echo 
 
echo "  Uptime:" 
uptime -p 
echo 
 
echo "  Load Average:" 
uptime | awk -F'load average:' '{ print $2 }' 
echo 
 
echo "  Logged in Users:" 
who | awk '{print $1}' | sort | uniq 
echo 
 
if [ "$(id -u)" -eq 0 ]; then 
  echo "  Failed Login Attempts:" 
  lastb | head -n 10 
else 
  echo "  Failed Login Attempts: (Run as root to view)" 
fi 
 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "   Stats collection complete." 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"