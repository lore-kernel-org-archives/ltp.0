From: Cedric Hnyda <chnyda@suse.com>
Date: Mon, 9 Nov 2015 15:35:35 +0100
Subject: [LTP] [PATCH] controllers:new testcase blkio1
In-Reply-To: <1447070046-5455-1-git-send-email-sunyuan3@huawei.com>
References: <1447070046-5455-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <5640AF37.8090805@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 11/09/2015 12:54 PM, Yuan Sun wrote:
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>   runtest/blkio                                     |   1 +
>   testcases/kernel/controllers/blkio/Makefile       |  28 ++++++
>   testcases/kernel/controllers/blkio/blkio_setup.sh |  97 +++++++++++++++++++
>   testcases/kernel/controllers/blkio/blkio_test1.sh | 113 ++++++++++++++++++++++
>   4 files changed, 239 insertions(+)
>   create mode 100644 runtest/blkio
>   create mode 100644 testcases/kernel/controllers/blkio/Makefile
>   create mode 100755 testcases/kernel/controllers/blkio/blkio_setup.sh
>   create mode 100755 testcases/kernel/controllers/blkio/blkio_test1.sh
>
> diff --git a/runtest/blkio b/runtest/blkio
> new file mode 100644
> index 0000000..a2fd9a3
> --- /dev/null
> +++ b/runtest/blkio
> @@ -0,0 +1 @@
> +blkio1 blkio_test1.sh
> diff --git a/testcases/kernel/controllers/blkio/Makefile b/testcases/kernel/controllers/blkio/Makefile
> new file mode 100644
> index 0000000..f256943
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/Makefile
> @@ -0,0 +1,28 @@
> +#
> +#    kernel/controllers/blkio test suite Makefile.
> +#
> +#    Copyright (c) Huawei Technologies Co., Ltd., 2015
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program.
> +#
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../Makefile.inc
> +
> +INSTALL_TARGETS		:= *.sh
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/controllers/blkio/blkio_setup.sh b/testcases/kernel/controllers/blkio/blkio_setup.sh
> new file mode 100755
> index 0000000..a59481a
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkio_setup.sh
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +# usage ./blkio_setup.sh
> +
> +################################################################################
> +#  Copyright (c) Huawei Technologies Co., Ltd., 2015                           #
> +#                                                                              #
> +#  This program is free software;  you can redistribute it and/or modify       #
> +#  it under the terms of the GNU General Public License as published by        #
> +#  the Free Software Foundation; either version 2 of the License, or           #
> +#  (at your option) any later version.                                         #
> +#                                                                              #
> +#  This program is distributed in the hope that it will be useful,             #
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of             #
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                   #
> +#  the GNU General Public License for more details.                            #
> +#                                                                              #
> +#  You should have received a copy of the GNU General Public License           #
> +#  along with this program.                                                    #
> +#                                                                              #
> +################################################################################
> +################################################################################
> +# Name Of File: setup.sh                                        	       #
> +#                                                                              #
> +#  Description: This file has functions for the setup for testing blkio        #
> +#               controller. Setup includes creating controller device,         #
> +#               mounting it with cgroup filesystem with option blkio           #
> +#		and creating groups in it.                                     #
> +#                                                                              #
> +#  Functions:   setup(): creaes /dev/blkio, mounts cgroup fs on it, creates    #
> +#               groups in that etc.                                            #
> +#               usage(): Shows the usage of this file.                         #
> +#               cleanup(): Does full system cleanup                            #
> +#                                                                              #
> +# Precaution:   Avoid system use by other applications/users to get fair and   #
> +#here it is
>
> and mount it only if it is needed?               appropriate results (avoid unnecessary killing of applicatio)  #
> +#                                                                              #
> +################################################################################
> +
> +# umount blkio if it has been mounted.
> +umount_blkio_mounted()
> +{
> +	dir=`grep blkio /proc/mounts | awk '{print $2}'`
> +	if [ -n "$dir" ]; then
> +		umount "$dir" 2> /dev/null
> +	fi
> +}
> +
> +# The cleanup function
> +cleanup()
> +{
> +	echo "Cleanup called"
> +	rmdir /dev/blkio/group*/group* 2> /dev/null
> +	rmdir /dev/blkio/group* 2> /dev/null
> +	umount /dev/blkio/ 2> /dev/null
> +	umount_blkio_mounted
> +	rmdir /dev/blkio 2> /dev/null
> +}
> +
This can fail in some cases.
Why not keeping the cgroup mounted where it is
and mount it only if it is needed so that we can avoid this risk?
And couldn't we keep blkio mounted at the end of the test if it
was mounted before?

> +setup()
> +{
> +	if [ -e /dev/blkio ]; then
> +		echo "WARN:/dev/blkio already exist..overwriting"
> +		rmdir /dev/blkio/group*/group* 2> /dev/null
> +		rmdir /dev/blkio/group* 2> /dev/null
> +        	umount /dev/blkio/ 2> /dev/null
> +		rmdir /dev/blkio 2> /dev/null
> +		mkdir /dev/blkio
> +	else
> +		mkdir /dev/blkio
> +	fi
> +	umount_blkio_mounted
> +	mount -t cgroup -oblkio none /dev/blkio 2> /dev/null
> +	if [ $? -ne 0 ]
> +	then
> +		echo "TFAIL: Could not mount cgroup filesystem"
"tst_resm FAIL ..." can be used
> +		echo "Exiting test"
> +		cleanup
> +		exit 1
> +	fi
> +
> +	# Group created earlier may again be visible if not cleaned properly.
> +	#so clean them
> +	if [ -e /dev/blkio/group_1 ]; then
> +		rmdir /dev/blkio/group*/group* 2> /dev/null
> +		rmdir /dev/blkio/group* 2> /dev/null
> +		echo "WARN: Earlier groups found and removed...";
> +	fi
> +
> +}
> +
> +# The usage of the script file
> +usage()
> +{
> +	echo "Could not start blkio controller test";
> +	echo "usage: run_blkio_test.sh <TEST_NUM>";
> +	echo "Skipping the start blkio controller test...";
> +}
> diff --git a/testcases/kernel/controllers/blkio/blkio_test1.sh b/testcases/kernel/controllers/blkio/blkio_test1.sh
> new file mode 100755
> index 0000000..3306ee6
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkio_test1.sh
> @@ -0,0 +1,113 @@
> +#!/bin/bash
> +#############################################################################
> +#  Copyright (c) Huawei Technologies Co., Ltd., 2015                        #
> +#                                                                           #
> +#  This program is free software;  you can redistribute it and/or modify    #
> +#  it under the terms of the GNU General Public License as published by     #
> +#  the Free Software Foundation; either version 2 of the License, or        #
> +#  (at your option) any later version.                                      #
> +#                                                                           #
> +#  This program is distributed in the hope that it will be useful,          #
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of          #
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                #
> +#  the GNU General Public License for more details.                         #
> +#                                                                           #
> +#############################################################################
> +# Name Of File: blkio_test1.sh                                              #
> +#                                                                           #
> +# Description: This case is to test blkio which restrict the speed to       #
> +#               1MB/s.                                                      #
> +#                                                                           #
> +#############################################################################
> +
> +
> +export TCID="blkio_test1";
> +export TST_TOTAL=1;
> +export TST_COUNT=1;
> +
> +tst_kvercmp 2 6 30  2> /dev/null
> +if [ $? -eq 0 ]; then
> +        tst_brkm TCONF ignored "Test should be run with kernel 2.6.30 or newer"
> +        exit 0
> +fi
> +
> +. cmdlib.sh
> +
> +tst_require_root
> +
> +. blkio_setup.sh
> +
> +cleanup
> +
> +mes="Block Io Controller"
> +cg_path="/dev/blkio";
> +
> +echo "BLKIO CONTROLLER TESTING";
> +echo "RUNNING SETUP.....";
> +setup;
> +
> +ls /dev/sda > /dev/null
> +if [ $? -ne 0 ];then
> +	echo "/dev/sda is unavailable"
> +	exit 1
> +fi
> +
> +echo "TEST STARTED: Please avoid using system while this test executes";
> +
> +status=0
> +mkdir $cg_path/group_1 2> /dev/null
> +echo $$ > $cg_path/group_1/tasks
> +
> +if [ $? -ne 0 ]; then
> +	echo "TFAIL Not able to move a task to the cgroup"
Same.
> +	echo "Exiting Test"
> +	cleanup
> +	exit 1
> +fi
> +
> +#Limit the speed within 1MB/s.
> +echo "8:0  1048576" > $cg_path/group_1/blkio.throttle.read_bps_device
> +hdparm --direct -t /dev/sda | grep 'Timing O_DIRECT disk reads' | \
> +	sed 's/^.*= //' > hdparm_log
> +speed=`awk '{print $1}' hdparm_log`
> +unit=`awk '{print $2}' hdparm_log | sed 's/\/sec//'`
> +
> +if [ "$unit" = "MB" ];then
> +	speed=`echo $speed \* 1024 | bc`
> +elif [ "$unit" = "GB" ];then
> +	speed=`echo $speed \* 1024 \* 1024 | bc`
> +fi
> +
> +echo speed=$speed
> +result=`echo "$speed <= 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	echo "TFAIL the speed should be less than or equal to 1MB/s"
Same.
> +	cleanup
> +	exit 1
> +fi
> +
> +#Disable the speed limitation.
> +echo "8:0 0  1048576" > $cg_path/group_1/blkio.throttle.read_bps_device
> +hdparm --direct -t /dev/sda | grep 'Timing O_DIRECT disk reads' | \
> +	sed 's/^.*= //' > hdparm_log
> +speed=`awk '{print $1}' hdparm_log`
> +unit=`awk '{print $2}' hdparm_log | sed 's/\/sec//'`
> +
> +if [ "$unit" = "MB" ];then
> +	speed=`echo $speed \* 1024 | bc`
> +elif [ "$unit" = "GB" ];then
> +	speed=`echo $speed \* 1024 \* 1024 | bc`
> +fi
> +
> +echo speed=$speed
> +
> +result=`echo "$speed > 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	echo "TFAIL the speed should be more than 1MB/s"
> +	cleanup
> +	exit 1
> +fi
> +
> +cleanup
> +echo "TPASS PASSED"
Same here.

You should also add your testcases in the runtestfile for controllers.

Best,
Cedric

-- 
Cedric Hnyda

