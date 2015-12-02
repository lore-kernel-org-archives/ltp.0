From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Dec 2015 22:31:52 +0100
Subject: [LTP] [PATCH V2] controllers:new testcase blkio1
In-Reply-To: <1448940646-32392-1-git-send-email-sunyuan3@huawei.com>
References: <1448940646-32392-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <20151202213151.GB13131@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# The usage of the script file
> +usage()
> +{
> +	echo "Could not start blkio controller test";
> +	echo "usage: run_blkio_test.sh <TEST_NUM>";
> +	echo "Skipping the start blkio controller test...";
> +}

This function does not seem to be called from anywhere. Is it useful for
anything?

> diff --git a/testcases/kernel/controllers/blkio/blkio_test1.sh b/testcases/kernel/controllers/blkio/blkio_test1.sh
> new file mode 100755
> index 0000000..745b8d2
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkio_test1.sh
> @@ -0,0 +1,94 @@
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
> +        tst_brkm TCONF ignored \
> +		"Test should be run with kernel 2.6.30 or newer"
> +fi
> +
> +. test.sh
> +. blkio_setup.sh
> +
> +tst_resm TINFO "BLKIO CONTROLLER TESTING";
> +tst_resm TINFO "RUNNING SETUP.....";

Is this really necesarry? Please avoid producing useless output in the
testcases.

> +setup;
> +
> +tst_resm TINFO "TEST STARTED: Please avoid using system while this \
> +	test executes";
> +
> +ROD echo $$ > ${testpath}/tasks
> +
> +#Limit the speed within 1MB/s.
> +#echo "8:0  1048576" > $cg_path/ltp_group_1/blkio.throttle.read_bps_device

Just remove this commented line.

> +echo "`stat -c %t:%T ${TST_DEVICE}` 1048576" > \
> +	${testpath}/blkio.throttle.read_bps_device
> +
> +hdparm --direct -t ${TST_DEVICE} | grep 'Timing O_DIRECT disk reads' | \
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
> +tst_resm TINFO "speed=$speed"
> +result=`echo "$speed <= 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	cleanup
> +	tst_brkm TFAIL \
> +		"TFAIL the speed should be less than or equal to 1MB/s"
> +fi
> +
> +#Disable the speed limitation.
> +major_minor=`stat -c %t:%T ${TST_DEVICE}`

Here you are calling the stat for a second time. Couldn't you just store
it to the variable at the beginning of the test instead?

> +tst_resm TINFO "TST_DEVICE=${TST_DEVICE} major_minor=${major_minor}"

Another useless debug output, please remove this one as well.

> +echo "${major_minor} 0  1048576" > $testpath/blkio.throttle.read_bps_device
> +hdparm --direct -t ${TST_DEVICE} | grep 'Timing O_DIRECT disk reads' | \
> +	sed 's/^.*= //' > hdparm_log
> +speed=`awk '{print $1}' hdparm_log`
> +unit=`awk '{print $2}' hdparm_log | sed 's/\/sec//'`
> +
> +if [ "$unit" = "MB" ];then
> +	speed=`echo $speed \* 1024 | bc`
> +elif [ "$unit" = "GB" ];then
> +	speed=`echo $speed \* 1024 \* 1024 | bc`
> +fi

This output parsing is a mess and I fear that it will break with
slightest changes in the hdparm output. And even worse it's copied in
the test twice.

Maybe the best solution would be writing a short C program that would
measure the speed and would output just one number that we can compare
here.

This should be as easy as opening the device, measuring how long does
writing a few megabytes take and then priting division of these
numbers...

> +tst_resm TINFO "speed=${speed}"
> +
> +result=`echo "$speed > 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	cleanup

The cleanup is called automatically on tst_brkm()

> +	tst_brkm TFAIL "TFAIL the speed should be more than 1MB/s"
> +fi
> +
> +cleanup
> +tst_resm TPASS "${TCID} PASSED"

Call to tst_exit() is missing here. Also the cleanup is called
automatically on tst_exit(). Basically calling cleanup() manually in
test based on test.sh is always mistake.

-- 
Cyril Hrubis
chrubis@suse.cz
