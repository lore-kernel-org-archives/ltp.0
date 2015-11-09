From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2015 20:17:38 +0100
Subject: [LTP] [PATCH] controllers:new testcase blkio1
In-Reply-To: <1447070046-5455-1-git-send-email-sunyuan3@huawei.com>
References: <1447070046-5455-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <20151109191738.GD23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/runtest/blkio
> @@ -0,0 +1 @@
> +blkio1 blkio_test1.sh

We have runtest/controllers please use that one instead.

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

Please avoid useless comments as these. There is no added value in
comments as "function cleanup() does cleanup".

> +# Precaution:   Avoid system use by other applications/users to get fair and   #
> +#               appropriate results (avoid unnecessary killing of applicatio)  #

This is the only part that should stay here.

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
> +setup()
> +{
> +	if [ -e /dev/blkio ]; then
> +		echo "WARN:/dev/blkio already exist..overwriting"
> +		rmdir /dev/blkio/group*/group* 2> /dev/null
> +		rmdir /dev/blkio/group* 2> /dev/null
> +
> +        	umount /dev/blkio/ 2> /dev/null

Here are spaces before tabs. Please use consistent style for
indentation.

> +		rmdir /dev/blkio 2> /dev/null
> +		mkdir /dev/blkio
> +	else
> +		mkdir /dev/blkio
> +	fi

No cleanups in setup please.

> +	umount_blkio_mounted
> +	mount -t cgroup -oblkio none /dev/blkio 2> /dev/null
> +	if [ $? -ne 0 ]
> +	then
> +		echo "TFAIL: Could not mount cgroup filesystem"
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

Again please on cleanups in setup.

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

The name of file is not usefull at all, please remove it.

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

You should use test.sh, cmdlib has been retired. Have a look at our
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell

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

This are pretty much useless messages, besides you should use

tst_resm TINFO "..."

> +setup;
> +
> +ls /dev/sda > /dev/null
> +if [ $? -ne 0 ];then
> +	echo "/dev/sda is unavailable"
> +	exit 1
> +fi

Relying on existence of /dev/sda is simply wrong.

> +echo "TEST STARTED: Please avoid using system while this test executes";
> +
> +status=0
> +mkdir $cg_path/group_1 2> /dev/null

You should prefix the group_1 with ltp_ so that it's clear that it has
been created by LTP. Also please do not redirect the stderr to
/dev/null.

> +echo $$ > $cg_path/group_1/tasks
> +
> +if [ $? -ne 0 ]; then
> +	echo "TFAIL Not able to move a task to the cgroup"
> +	echo "Exiting Test"
> +	cleanup
> +	exit 1

You should use tst_brkm TBROK "..." here. Or even better if you look at
our docummentation we have ROD function that works as:

ROD echo $$ > $cg_path/group_1/tasks

You have to define CLEANUP variable to have the cleanup executed when
the echo fails but that is covered in the documentation as well.

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

Now the hardcoded minor and major numbers are wrong as well as the fact
that we use /dev/sda.

What we should do instead is to use tst_acquire_device shell function to
get a device allocated for the test and then get it's minor and major
number (hint use stat -c %t:%T).

Then we can do dd if=/dev/zero of=$device bs=1024 count=1024 and get the
speed from the last line of the dd output.

-- 
Cyril Hrubis
chrubis@suse.cz
