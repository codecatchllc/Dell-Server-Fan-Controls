# Read the max CPU temp from sensors (lm-sensors) 
tempCpu=$(sensors|grep "high"|grep "Core"|cut -d "+" -f2|cut -d "." -f1|sort -nr|sed -n 1p)
# Define CPU limit

# Set variables
host="someipaddress"
user="someusername"
password="somepassword"

#define upper and lower limits
idle="45"
minCpu="48"
medCpu="55"
maxCpu="60"

if [ $tempCpu -le $idle ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x04 >> /dev/null
    # Set to 1680 RPM (0x04)

elif [ $tempCpu -le $minCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x0C >> /dev/null
	# Set to 2520 RPM (0x0C)

elif [ $tempCpu -le $medCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x14 >> /dev/null
	# Set to 3480 RPM (0x14)

elif [ $tempCpu -le $maxCpu ] ; then

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x00 >> /dev/null
	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x02 0xff 0x18 >> /dev/null
	# Set to 3840 RPM (0x)

else

	ipmitool -I lanplus -H $host -U $user -P $password raw 0x30 0x30 0x01 0x01 >> /dev/null
    # Set to automatic control

fi