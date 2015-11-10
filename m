From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 19:45:38 +0100
Subject: [LTP] [PATCH V2] controllers/cpuacct: rewrote testcases
In-Reply-To: <1447175033-19689-1-git-send-email-chnyda@suse.com>
References: <1447175033-19689-1-git-send-email-chnyda@suse.com>
Message-ID: <20151110184538.GA4311@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#!/bin/bash

LTP aims to work on embedded hardware as well (where bash may not be
installed at all), so this should rather be pointing to #!/bin/sh.

> +# Usage
> +# ./cpuacct.sh nbsubgroup nbprocess
> +#
> +# 1) nbsubgroup : number of subgroup to create
> +# 2) nbprocess : number of process to attach to each subgroup
> +#
> +# Description
> +#
> +# 1) Find if cpuacct is mounted, if not mounted, cpuacct will be mounted
> +# 2) Create a subgroup ltp_test in cpuacct
> +# 3) Create nbsubgroup subgroup in ltp_test and attach them nbprocess process
> +# 4) Check that ltp_test/subgroup*/cpuacct.usage != 0 (test1)
> +# 5) Check that sum ltp_test/subgroup*/cpuacct.usage = ltp_test/cpuacct.usage
> +# (test2)
> +# 6) cleanup

No need to comment the setup and cleanup here. Keep just the part that
is not obvious, i.e. points 2 - 5.

> +mounted=1
> +mount_point=""
> +max=$1
> +nbprocess=$2
> +
> +cd $LTPROOT/testcases/bin

What is this needed for?

I do not see that you are working with files in this directory.

(I've missed this in the first review)

> +export TCID="cpuacct_$1_$2"
> +export TESTROOT=`pwd`

What is this used for?

> +export TST_TOTAL=3;
                     ^
		     Useless semicolon

> +export TST_COUNT=1;

The TST_COUNT is handled by test.sh library, you shouldn't define it
here.

> +status=0

The status is not used now, please remove it.

> +. test.sh
> +
> +verify_result()
> +{
> +	result=$1
> +	expected=$2
> +	message=$3
> +	if [ "$result" -ne "$expected" ]; then
> +		tst_resm TINFO "expected $expected, got $result"
> +		cleanup;
> +		tst_brkm TBROK NULL $message
> +	fi
> +}
> +
> +mount_cpuacct()
> +{
> +	ROD mount -t cgroup -o cpuacct none $mount_point

Now that it's just single line it does not deserve to be in separate
funciton, doesn't it?

> +}
> +
> +umount_cpuacct()
> +{
> +	tst_resm TINFO "Umounting cpuacct"
> +	umount $mount_point
> +	verify_result $? 0 "Error occured while umounting cgroup"

Now this can be done using ROD as well. If you have a look at our
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#233-cleanup

You can setup TST_CLEANUP to point to a cleanup function and have it
executed on tst_brkm (which is called by ROD) and on tst_exit.

So all you need to do is to set TST_CLEANUP in the setup() right after
you mount the cpuacct and create the directory and you have guaranteed
that the cleanup will be called if you call library function that causes
test exit.

> +}
> +
> +do_mkdir()
> +{
> +	mkdir -p $1
> +	verify_result $? 0 "Error occured with mkdir"
> +}
> +
> +do_rmdir()
> +{
> +	rmdir $1
> +	verify_result $? 0 "Error occured with rmdir"
> +}

These as well. You can just do ROD rmdir foo in the code instead of
defining new functions...

> +setup()
> +{
> +	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
> +	tst_resm TINFO "cpuacct: $mount_point"
> +	if [ "$mount_point" = "" ]; then
> +		mounted=0
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	testpath=$mount_point/ltp_$TCID
> +
> +	if [ "$mounted" -eq "0" ]; then
> +		do_mkdir $mount_point
> +		mount_cpuacct
> +	fi
> +	do_mkdir $testpath
> +}
> +
> +cleanup()
> +{
> +	tst_resm TINFO "removing created directories"
> +	rmdir $testpath/subgroup_*;
> +	rmdir $testpath;
> +	if [ "$mounted" -ne 1 ] ; then
> +		umount_cpuacct
> +		do_rmdir $mount_point
> +	fi
> +}
> +
> +setup;
> +
> +# create subgroups
> +for i in `seq 1 $max`
> +do
> +	do_mkdir $testpath/subgroup_$i
> +done
> +
> +# create and attach process to subgroups
> +for i in `seq 1 $max`
> +do
> +	for j in `seq 1 $nbprocess`
> +	do

The prefered style for bash for loops is:

for foo; do

done

> +		cpuacct_task $testpath/subgroup_$i/tasks &
> +	done
> +done
> +
> +for job in `jobs -p`
> +do
> +	wait $job
> +done
> +
> +acc=0
> +error=0
> +for i in `seq 1 $max`
> +do
> +	tmp=`cat $testpath/subgroup_$i/cpuacct.usage`
> +	if [ "$tmp" -eq "0" ]; then
> +		error=1
> +		status=1

Now the status is not used at all, right?

Also the error should rather be named as fail.

And maybe we can do better naming it fails and incrementing for each
zero value and then print how many of them were zero in the FAIL message
below.

> +	fi
> +	((acc = acc + tmp))

This is bashism (does not work with portable shell, i.e. on debian dash
shell)

Portable way is acc=$((acc + tmp))

> +done
> +
> +## check that cpuacct.usage != 0 for every subgroup
> +if [ "$error" -eq "1" ]; then
> +	tst_resm TFAIL "cpuacct.usage should not be equal to 0"
> +else
> +	tst_resm TPASS "cpuacct.usage is not equal to 0 for every subgroup"
> +fi
> +
> +## check that ltp_subgroup/cpuacct.usage == sum ltp_subgroup/subgroup*/cpuacct.usage
> +ref=`cat $testpath/cpuacct.usage`
> +if [ "$ref" != "$acc" ]; then
> +	tst_resm TFAIL "ltp_test/cpuacct.usage not equal to ltp_test/subgroup*/cpuacct.usage"
> +	status=1

Here status is unused as well.

> +else
> +	tst_resm TPASS "ltp_test/cpuacct.usage equal to ltp_test/subgroup*/cpuacct.usage"
> +fi
> +
> +cleanup;
          ^
	  There is no need for semicolon here.

Also if you set the TST_CLEANUP there si no need to call it here.

> +tst_exit


> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task.c b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
> new file mode 100644
> index 0000000..eab6356
> --- /dev/null
> +++ b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +/*
> +* Description:
> +* Attach the current process to argv[1]
> +*/
> +
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char **argv)
> +{
> +	char cmd[512];
> +	long pid = getpid();
> +
> +	sprintf(cmd, "echo %lu >> %s", pid, argv[1]);
> +	system(cmd);

This is kind of ugly way to write to a file from C.

You can either open the file and then print to it as:

	FILE *f;

	f = fopen(argv[1], "w");

	if (f)
		... handle error

	fprintf(f, "%i\n", getpid());
	fclose(f);


Or use FILE_PRINTF(argv[1], "%i\n", getpid()) from the LTP test library.

> +	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 10000}};
> +
> +	setitimer(ITIMER_VIRTUAL, &it, NULL);
> +	for (;;);
> +	return 0;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
