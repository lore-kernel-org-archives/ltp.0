Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <khilman@linaro.org>) id 1WODpN-0002pG-7K
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 22:10:13 +0000
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WODpM-0004K0-3l
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 22:10:13 +0000
Received: by mail-pa0-f48.google.com with SMTP id hz1so1732076pad.35
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Mar 2014 15:10:06 -0700 (PDT)
From: Kevin Hilman <khilman@linaro.org>
References: <531DC318.7060504@gmail.com>
Date: Thu, 13 Mar 2014 15:10:04 -0700
In-Reply-To: <531DC318.7060504@gmail.com> (Mats Liljegren's message of "Mon,
	10 Mar 2014 14:50:16 +0100")
Message-ID: <7hsiqlkawz.fsf@paris.lan>
MIME-Version: 1.0
Subject: Re: [LTP] Testing absence of ticks with nohz_full
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>, Frederic Weisbecker <fweisbec@gmail.com>

Mats Liljegren <liljegren.mats2@gmail.com> writes:

> My company (Enea) wants to create test case(s) that verifies that you
> can run an application without having ticks going on the CPU that the
> application runs on. This would utilize the new nohz_full feature
> available from kernel version 3.10.
>
> I cannot find any existing test case in LTP in this area, so I assume
> I have to create the test case myself.

It's not in LTP, but I have a shell script[1] does some setup and load
generation that I use to validate nohz_full.  The setup and
prerequisites can be a bit tricky, but some of the things it does:

- disables the residual 1Hz (if my patch is applied)
- pinning the unbound "writeback" workqueue to CPU0
- force timer migration using hotplug
- sets up CPUsets and tries to migrate all tasks to CPU0
  (I think this part came from a script from you awhile ago)

It then uses 'stress' to generate load on specific CPUs and uses
trace-cmd to record the traces.

I currently look at the traces manually to see if it worked, but adding
other step to automatially look at the traces would be a good next step.

Kevin

[1]

#!/bin/bash

# Check that we have cpusets enabled in the kernel
if ! grep -q -s cpuset /proc/filesystems ; then
    echo "Error: Kernel is lacking support for cpuset!"
    exit 1
fi

# Try to disable sched_tick_max_deferment
if [ -e /sys/kernel/debug/sched_tick_max_deferment ]; then
    echo -1 > /sys/kernel/debug/sched_tick_max_deferment
else
    echo "WARNING: unable to set sched_tick_max_deferment"
fi

# if CONFIG_LOCKUP_DETECTOR is enabled, a periodic timer fires
# on *every* CPU, including idle ones.  Disable it.
if [ -e /proc/sys/kernel/watchdog ]; then
  echo 0 > /proc/sys/kernel/watchdog
fi

declare -a all_cpus=(`for file in /sys/devices/system/cpu/cpu*/online; do basename $(dirname $file); done`)
declare -a cpus=( ${all_cpus[@]/cpu0/} )  # without CPU0
max_cpu=$((${#all_cpus[@]} - 1))

#
# Force migration off of NO_HZ CPUs using hotplug
#   TODO: document what happens without this
#  
for cpu in ${cpus[@]}; do
  echo 0 > /sys/devices/system/cpu/$cpu/online
done
for cpu in ${cpus[@]}; do
  echo 1 > /sys/devices/system/cpu/$cpu/online
done

# TODO: document what happens without this
# pin the writeback workqueue to CPU0
echo 1 > /sys/bus/workqueue/devices/writeback/cpumask

# make sure that the /dev/cpuset dir exits
# and mount the cpuset filesystem if needed
[ -d /dev/cpuset ] || mkdir /dev/cpuset
[ -e /dev/cpuset/tasks ] || mount -t cpuset none /dev/cpuset

# Create 2 cpusets. One GP and one NOHZ domain.
[ -d /dev/cpuset/gp ] || mkdir /dev/cpuset/gp
[ -d /dev/cpuset/rt ] || mkdir /dev/cpuset/rt

# Assume a single memory node
echo 0 > /dev/cpuset/gp/mems
echo 0 > /dev/cpuset/rt/mems

# Setup the GP domain: CPU0
echo 0 > /dev/cpuset/gp/cpus

# Setup the NOHZ domain: CPU1+
echo 1-$max_cpu > /dev/cpuset/rt/cpus

# Try to move all processes in top set to the GP set.
for pid in `cat /dev/cpuset/tasks`; do
  if [ -d /proc/$pid ]; then 
    echo $pid > /dev/cpuset/gp/tasks 2>/dev/null
    if [ $? != 0 ]; then
      echo -n "Cannot move PID $pid: "  
      echo "$(cat /proc/$pid/status | grep ^Name | cut -f2)"
    fi
  fi
done

# Disable load balancing on top level (otherwise the child-sets' setting
# won't take effect.)
echo 0 > /dev/cpuset/sched_load_balance

# Enable load balancing withing the GP domain
echo 1 > /dev/cpuset/gp/sched_load_balance
#echo 1 > /dev/cpuset/rt/sched_load_balance

# But disallow load balancing within the NOHZ domain
echo 0 > /dev/cpuset/rt/sched_load_balance

DURATION=30
BACKOFF=$((DURATION / 8 * 1000000))

# Move self into GP domain
echo $$ > /dev/cpuset/gp/tasks
trace-cmd start -b 10000 -e sched -e irq -e timer -e signal
#trace-cmd start -b 100000 -e all

# GP domain
stress -q --cpu 2 --vm 2 --timeout $DURATION &
GP_PID=$!

# NOHZ domain
echo $$ > /dev/cpuset/rt/tasks || exit 1

# 2 temporarly overlapping tasks
stress -q --cpu 1 --timeout $[DURATION / 3] &
stress -q --cpu 1 --backoff $BACKOFF --timeout $[DURATION - 1] &
NOHZ_PID=$!

# start another busy task on the last CPU for >2 CPU machines
if [ $max_cpu > 1 ]; then
  taskset -c $max_cpu stress -q --cpu 1 --timeout $DURATION &
fi

# Switch back to GP
echo $$ > /dev/cpuset/gp/tasks

# Wait for GP task(s) to finish
wait $GP_PID
trace-cmd stop
trace-cmd extract
sync

exit 0

# 
# Cleanup
#

# Try to move all from GP back to root
for pid in `cat /dev/cpuset/gp/tasks`; do
  if [ -d /proc/$pid ]; then 
    echo $pid > /dev/cpuset/tasks 2>/dev/null
    if [ $? != 0 ]; then
      echo -n "Cannot move PID $pid: "  
      echo "$(cat /proc/$pid/status | grep ^Name | cut -f2)"
    fi
  fi
done

# Remove the CPUsets
rmdir /dev/cpuset/gp
rmdir /dev/cpuset/rt

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
