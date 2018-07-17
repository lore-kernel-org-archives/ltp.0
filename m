From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 Jul 2018 17:41:21 +0800
Subject: [LTP] Question about Cpus_allowed_list
Message-ID: <5B4DB9C1.1040209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

With Intel(R) Core(TM)2 Duo CPU E7500, running cpuset_hotplug_test.sh
always got the following error:
-------------------------------------------------------------------------------------
cpuset_hotplug 1 TFAIL: task's allowed list isn't expected.(Result: 0-3,
Expect: 0-1)
-------------------------------------------------------------------------------------

No matter what is the number of cpu processors from /proc/cpuinfo
(specify 2 or 1 by offlining cpu),
the Cpus_allowed_list from /proc/<pid>/status is always 0-3.

Simple steps to reproduce this issue:
# /bin/cat /dev/zero > /dev/null 2>&1 &
[1] 15079
# nproc (or cat /proc/cpuinfo | grep processor | wc -l)
2
# cat /proc/15079/status | grep Cpus_allowed_list
Cpus_allowed_list: 0-3

We also tested cpuset_hotplug_test.sh with Core(TM) i3 CPU and Core(TM)
i5 CPU, it showed the
same Cpus_allowed_list as the number of cpu processors as expected.

Is this a known issue on Core(TM)2 Duo CPU, should we use taskset
command to change Cpus_allowed_list?

Thanks,
Xiao Yang


