#!/bin/bash

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]; then

memTotal_b=`free -b |grep Mem |awk '{print $2}'`
memFree_b=`free -b |grep Mem |awk '{print $7}'`
memBuffer_b=`free -b |grep Mem |awk '{print $6}'`
memCache_b=`free -b |grep Mem |awk '{print $7}'`

memTotal_m=`free -m |grep Mem |awk '{print $2}'`
memFree_m=`free -m |grep Mem |awk '{print $4}'`
memBuffer_m=`free -m |grep Mem |awk '{print $6}'`
memCache_m=`free -m |grep Mem |awk '{print $7}'`

memUsed_b=$(($memTotal_b-$memFree_b))
memUsed_m=$(($memTotal_m-$memFree_m))

multi=$((($memUsed_b*100)/$memTotal_b))
#multi=$((memUsedPrc*100))

if [ "$multi" -ge "$4" ]; then
echo "Memory: CRITICAL Total: $multi%"
$(exit 2)
elif [ "$multi" -ge "$2" ]; then
echo "Memory: WARNING Total: $multi%"
$(exit 1)
else
echo "Memory: OK Total: $multi%"
$(exit 0)
fi

else
echo "check_mem v1.1"
echo ""
echo "Usage:"
echo "check_mem.sh -w -c "
echo ""
echo "warnlevel and critlevel is percentage value without %"
echo ""
echo "Copyright (C) 2012 Lukasz Gogolin (lukasz.gogolin@gmail.com)"
exit
fi
