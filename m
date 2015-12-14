From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Dec 2015 17:11:10 +0100
Subject: [LTP] [PATCH V3] controllers:new testcase blkio1
In-Reply-To: <1449367919-18578-1-git-send-email-sunyuan3@huawei.com>
References: <1449367919-18578-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <20151214161110.GA19354@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  runtest/controllers                               |   2 +
>  testcases/kernel/controllers/blkio/Makefile       |  29 ++++++
>  testcases/kernel/controllers/blkio/blkio_setup.sh |  73 ++++++++++++++
>  testcases/kernel/controllers/blkio/blkio_test1.sh |  68 +++++++++++++
>  testcases/kernel/controllers/blkio/blkread.c      | 113 ++++++++++++++++++++++

It would be much better if the C program would be called blkio_blkread.c
but that is minor.

> +LDLIBS			+= -lm -lcontrollers
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/controllers/blkio/blkio_setup.sh b/testcases/kernel/controllers/blkio/blkio_setup.sh
> new file mode 100755
> index 0000000..a5cd7d8
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkio_setup.sh
> @@ -0,0 +1,73 @@
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
> +# Precaution:   Avoid system use by other applications/users to get fair and   #
> +#               appropriate results (avoid unnecessary killing of applicatio)  #
> +#                                                                              #
> +################################################################################
> +
> +mounted=1
> +
> +# The cleanup function
> +cleanup()
> +{
> +	tst_resm TINFO "removing created directories"
> +	rmdir $testpath
> +	tst_release_device
> +	if [ "$mounted" -ne 1 ]; then
> +		tst_resm TINFO "Umounting blkio"
> +		umount $mount_point
> +		rmdir $mount_point
> +	fi
> +}
> +
> +setup()
> +{
> +	tst_require_root
> +	tst_tmpdir
> +
> +	grep -q -w blkio /proc/cgroups
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TCONF "blkio not supported on this system"
> +	fi
> +
> +	mount_point=`grep -w blkio /proc/mounts | cut -f 2 | \
> +		cut -d " " -f2`
> +	tst_resm TINFO "blkio: $mount_point"
> +	if [ "$mount_point" = "" ]; then
> +		mounted=0
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	TST_CLEANUP=cleanup
> +	testpath=$mount_point/ltp_$TCID
> +	if [ -d $testpath ];then
> +		rmdir $testpath
> +	fi
> +
> +	if [ "$mounted" -eq "0" ]; then
> +		ROD mkdir -p $mount_point
> +		ROD mount -t cgroup -oblkio none $mount_point
> +	fi
> +	ROD mkdir $testpath
> +
> +	tst_acquire_device
> +}
> diff --git a/testcases/kernel/controllers/blkio/blkio_test1.sh b/testcases/kernel/controllers/blkio/blkio_test1.sh
> new file mode 100755
> index 0000000..a4fd99d
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkio_test1.sh
> @@ -0,0 +1,68 @@
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
> +setup;
> +major_minor=`stat -c %t:%T ${TST_DEVICE}`
> +tst_resm TINFO "TEST STARTED: Please avoid using system while this \
> +	test executes";
> +
> +ROD echo $$ > ${testpath}/tasks
> +
> +#Limit the speed within 1MB/s.
> +echo "${major_minor} 1048576" > \
> +	${testpath}/blkio.throttle.read_bps_device
> +
> +blkread ${TST_DEVICE} > hdparm_log
> +speed=`tail -n1 hdparm_log | sed 's/KB\/s//'`
> +
> +result=`echo "$speed <= 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	cleanup
> +	tst_brkm TFAIL \
> +		"TFAIL the speed should be less than or equal to 1MB/s"
> +fi
> +
> +#Disable the speed limitation.
> +echo "${major_minor} 0  1048576" > $testpath/blkio.throttle.read_bps_device
> +blkread ${TST_DEVICE} > hdparm_log
> +speed=`tail -n1 hdparm_log | sed 's/KB\/s//'`
> +
> +result=`echo "$speed > 1024.0" | bc`
> +if [ $result -ne 1 ];then
> +	tst_brkm TFAIL "TFAIL the speed should be more than 1MB/s"
> +fi
> +
> +tst_resm TPASS "${TCID} PASSED"
> +tst_exit
> diff --git a/testcases/kernel/controllers/blkio/blkread.c b/testcases/kernel/controllers/blkio/blkread.c
> new file mode 100644
> index 0000000..c76c38f
> --- /dev/null
> +++ b/testcases/kernel/controllers/blkio/blkread.c
> @@ -0,0 +1,113 @@
> +
> +#define _BSD_SOURCE     /* for strtoll() */
                              ^
			      Comments like this are frowned upon.
			      Please remove it.

Moreover the strtoll() is not used in the source code at all. So the
whole define is useless.

> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#define __USE_GNU       /* for O_DIRECT */

Shouldn't this be _GNU_SOURCE instead? And moreover these macros must be
defined before any of the system headers are included, otherwise they
just don't work.

> +#include <string.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <ctype.h>
> +#include <endian.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include <sys/time.h>
> +#include <sys/times.h>
> +#include <sys/types.h>
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +#include <sys/user.h>
> +#include <linux/types.h>
> +#include <linux/fs.h>
> +#include <linux/major.h>
> +#include <asm/byteorder.h>

Looks like half of these are not used at all. I do not see anything from
byteorder.h fs.h major.h user.h used here...

> +/* direct disk access, not easily obtained from headers */
> +#ifndef O_DIRECT
> +#define O_DIRECT        040000
> +#endif

Was this really missing?

There are a few testcases in LTP that use O_DIRECT and do not have any
fallback definitions like this (but they define _GNU_SOURCE properly).

> +#define TIMING_BUF_MB           2
> +#define TIMING_BUF_BYTES        (TIMING_BUF_MB * 1024 * 1024)
> +
> +static void *prepare_timing_buf(unsigned int len)
> +{
> +	unsigned int i;
> +	__u8 *buf;

The __u8 is kernel type, just use char instead.

> +	buf = mmap(NULL, len, PROT_READ|PROT_WRITE, \
> +			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("could not allocate timing buf");
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < len; i += 4096)
> +		buf[i] = 0; /* guarantee memory is present/assigned */
                                ^
				Refrain from adding useless comments
				like this one.

And do not reinvent memset() yourself.

> +	if (-1 == mlock(buf, len)) {

This is not really wrong but nearly all the code I've seen around has
constants on the right side of the '=='. I.e. if (mlock(buf, len) == -1)

I guess that is because people usually thing in a way 'Do something and
check if that has failed' and not otherwise.

> +		perror("mlock() failed on timing buf");
> +		munmap(buf, len);
> +		return NULL;
> +	}
> +	mlockall(MCL_CURRENT|MCL_FUTURE);
> +	/* don't care if this fails on low-memory machines */

This comment should be before the mlockall() call, right?

There are two common ways of commenting code (and anything else is
confusing)

/* comment above statement */
statement();

and

statement(); /* comment after statement */

> +	sync();

Do we really need to sync() whole machine here? Why?

Shouldn't you rather fsync() the device file?

> +	/* give time for I/O to settle */
> +	sleep(3);

Using sleep in tests is frowned upon. Why is this important?

> +	return buf;
> +}
> +
> +static int read_big_block(int fd, char *buf)
> +{
> +	int i, rc;
> +
> +	rc = read(fd, buf, TIMING_BUF_BYTES);

Hmm, I'm not sure that reading 2MB in one read() will always succeed, it
probably will for block devices though.

> +	if (rc != TIMING_BUF_BYTES) {
> +		if (rc) {
> +			if (rc == -1)
> +				perror("read() failed");
> +			else
> +				fprintf(stderr, "read(%u) returned \
> +						%u bytes\n", \
> +						TIMING_BUF_BYTES, rc);
> +		} else {
> +			fputs("read() hit EOF - device too small\n", stderr);
> +		}
> +		return 1;
> +	}
> +	/* access all sectors of buf to ensure the read fully completed */
> +	for (i = 0; i < TIMING_BUF_BYTES; i += 512)
> +		buf[i] &= 1;

What is this supposed to do?

> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int file_id;
> +	struct timeval start;
> +	struct timeval end;
> +	double time_use = 0;
> +	double speed = 0;
> +	char *buf;
> +
> +	if (argc < 2) {
                 ^
		 != 2 right?
> +		printf("error!\n");

		Can you please be more specific in error messages like
		this one? The usuall practice is to print usage,
		something like:

		printf("Error\nusage: %s /path/to/file\n", argv[0]);

> +		return -1;
> +	}
> +
> +	file_id = open(argv[1], O_RDONLY | O_NONBLOCK | O_DIRECT);
> +
> +	buf = prepare_timing_buf(TIMING_BUF_BYTES);
> +	gettimeofday(&start, NULL);
> +	read_big_block(file_id, buf);
> +	gettimeofday(&end, NULL);

Please do not use gettimeofday() for measuring elapsed time. The time
from this call is subjected to NTP adjustements etc. We have API for
measuring time in LTP allready.

Have a look at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2221-measuring-elapsed-time-and-helper-functions

> +	time_use = (end.tv_sec-start.tv_sec)*1000000+ \
> +		   (end.tv_usec-start.tv_usec);
> +	time_use = time_use/1000000.0;
> +	printf("time_use is %f second\n", time_use);
> +	speed = TIMING_BUF_BYTES/1024.0/time_use;
> +	printf("%fKB/s\n", speed);
> +	return 0;
> +}
> -- 
> 1.9.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
