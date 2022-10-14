# Read the max CPU temp from sensors (lm-sensors) 
tempCpu=$(sensors|grep "high"|grep "Core"|cut -d "+" -f2|cut -d "." -f1|sort -nr|sed -n 1p)
# Define CPU limit

# Set variables
host="someipaddress"
user="someusername"
password="somepassword"

#define temperature bounds
minCpu="45"
medCpu="55"
maxCpu="60"

if [ $tempCpu -le $minCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x3 >> /dev/null
    # Set to 2040 RPM (0x3)

elif [ $tempCpu -le $medCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x17 >> /dev/null
	# Set to 3600 RPM (0x17)

elif [ $tempCpu -le $maxCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x20 >> /dev/null
	# Set to 5000 RPM (0x20)

else

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x01 >> /dev/null
    # Set to automatic control
    
fi