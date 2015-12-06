From: Yuan Sun <sunyuan3@huawei.com>
Date: Sun, 6 Dec 2015 10:11:59 +0800
Subject: [LTP] [PATCH V3] controllers:new testcase blkio1
Message-ID: <1449367919-18578-1-git-send-email-sunyuan3@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 runtest/controllers                               |   2 +
 testcases/kernel/controllers/blkio/Makefile       |  29 ++++++
 testcases/kernel/controllers/blkio/blkio_setup.sh |  73 ++++++++++++++
 testcases/kernel/controllers/blkio/blkio_test1.sh |  68 +++++++++++++
 testcases/kernel/controllers/blkio/blkread.c      | 113 ++++++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 testcases/kernel/controllers/blkio/Makefile
 create mode 100755 testcases/kernel/controllers/blkio/blkio_setup.sh
 create mode 100755 testcases/kernel/controllers/blkio/blkio_test1.sh
 create mode 100644 testcases/kernel/controllers/blkio/blkread.c

diff --git a/runtest/controllers b/runtest/controllers
index 8033928..4fded75 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -367,3 +367,5 @@ cpuset_memory_spread	cpuset_memory_spread_testset.sh
 cpuset_regression_test cpuset_regression_test.sh
 
 cgroup_xattr	cgroup_xattr
+
+blkio1 blkio_test1.sh
diff --git a/testcases/kernel/controllers/blkio/Makefile b/testcases/kernel/controllers/blkio/Makefile
new file mode 100644
index 0000000..1617b70
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/Makefile
@@ -0,0 +1,29 @@
+#
+#    kernel/controllers/blkio test suite Makefile.
+#
+#    Copyright (c) Huawei Technologies Co., Ltd., 2015
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+
+INSTALL_TARGETS		:= blkio_setup.sh blkio_test1.sh blkread
+
+LDLIBS			+= -lm -lcontrollers
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/blkio/blkio_setup.sh b/testcases/kernel/controllers/blkio/blkio_setup.sh
new file mode 100755
index 0000000..a5cd7d8
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/blkio_setup.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+# usage ./blkio_setup.sh
+
+################################################################################
+#  Copyright (c) Huawei Technologies Co., Ltd., 2015                           #
+#                                                                              #
+#  This program is free software;  you can redistribute it and/or modify       #
+#  it under the terms of the GNU General Public License as published by        #
+#  the Free Software Foundation; either version 2 of the License, or           #
+#  (at your option) any later version.                                         #
+#                                                                              #
+#  This program is distributed in the hope that it will be useful,             #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of             #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                   #
+#  the GNU General Public License for more details.                            #
+#                                                                              #
+#  You should have received a copy of the GNU General Public License           #
+#  along with this program.                                                    #
+#                                                                              #
+################################################################################
+################################################################################
+# Precaution:   Avoid system use by other applications/users to get fair and   #
+#               appropriate results (avoid unnecessary killing of applicatio)  #
+#                                                                              #
+################################################################################
+
+mounted=1
+
+# The cleanup function
+cleanup()
+{
+	tst_resm TINFO "removing created directories"
+	rmdir $testpath
+	tst_release_device
+	if [ "$mounted" -ne 1 ]; then
+		tst_resm TINFO "Umounting blkio"
+		umount $mount_point
+		rmdir $mount_point
+	fi
+}
+
+setup()
+{
+	tst_require_root
+	tst_tmpdir
+
+	grep -q -w blkio /proc/cgroups
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "blkio not supported on this system"
+	fi
+
+	mount_point=`grep -w blkio /proc/mounts | cut -f 2 | \
+		cut -d " " -f2`
+	tst_resm TINFO "blkio: $mount_point"
+	if [ "$mount_point" = "" ]; then
+		mounted=0
+		mount_point=/dev/cgroup
+	fi
+
+	TST_CLEANUP=cleanup
+	testpath=$mount_point/ltp_$TCID
+	if [ -d $testpath ];then
+		rmdir $testpath
+	fi
+
+	if [ "$mounted" -eq "0" ]; then
+		ROD mkdir -p $mount_point
+		ROD mount -t cgroup -oblkio none $mount_point
+	fi
+	ROD mkdir $testpath
+
+	tst_acquire_device
+}
diff --git a/testcases/kernel/controllers/blkio/blkio_test1.sh b/testcases/kernel/controllers/blkio/blkio_test1.sh
new file mode 100755
index 0000000..a4fd99d
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/blkio_test1.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+#############################################################################
+#  Copyright (c) Huawei Technologies Co., Ltd., 2015                        #
+#                                                                           #
+#  This program is free software;  you can redistribute it and/or modify    #
+#  it under the terms of the GNU General Public License as published by     #
+#  the Free Software Foundation; either version 2 of the License, or        #
+#  (at your option) any later version.                                      #
+#                                                                           #
+#  This program is distributed in the hope that it will be useful,          #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of          #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                #
+#  the GNU General Public License for more details.                         #
+#                                                                           #
+#############################################################################
+#                                                                           #
+# Description: This case is to test blkio which restrict the speed to       #
+#               1MB/s.                                                      #
+#                                                                           #
+#############################################################################
+
+
+export TCID="blkio_test1";
+export TST_TOTAL=1;
+export TST_COUNT=1;
+
+tst_kvercmp 2 6 30  2> /dev/null
+if [ $? -eq 0 ]; then
+        tst_brkm TCONF ignored \
+		"Test should be run with kernel 2.6.30 or newer"
+fi
+
+. test.sh
+. blkio_setup.sh
+
+setup;
+major_minor=`stat -c %t:%T ${TST_DEVICE}`
+tst_resm TINFO "TEST STARTED: Please avoid using system while this \
+	test executes";
+
+ROD echo $$ > ${testpath}/tasks
+
+#Limit the speed within 1MB/s.
+echo "${major_minor} 1048576" > \
+	${testpath}/blkio.throttle.read_bps_device
+
+blkread ${TST_DEVICE} > hdparm_log
+speed=`tail -n1 hdparm_log | sed 's/KB\/s//'`
+
+result=`echo "$speed <= 1024.0" | bc`
+if [ $result -ne 1 ];then
+	cleanup
+	tst_brkm TFAIL \
+		"TFAIL the speed should be less than or equal to 1MB/s"
+fi
+
+#Disable the speed limitation.
+echo "${major_minor} 0  1048576" > $testpath/blkio.throttle.read_bps_device
+blkread ${TST_DEVICE} > hdparm_log
+speed=`tail -n1 hdparm_log | sed 's/KB\/s//'`
+
+result=`echo "$speed > 1024.0" | bc`
+if [ $result -ne 1 ];then
+	tst_brkm TFAIL "TFAIL the speed should be more than 1MB/s"
+fi
+
+tst_resm TPASS "${TCID} PASSED"
+tst_exit
diff --git a/testcases/kernel/controllers/blkio/blkread.c b/testcases/kernel/controllers/blkio/blkread.c
new file mode 100644
index 0000000..c76c38f
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/blkread.c
@@ -0,0 +1,113 @@
+
+#define _BSD_SOURCE     /* for strtoll() */
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#define __USE_GNU       /* for O_DIRECT */
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <ctype.h>
+#include <endian.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <sys/time.h>
+#include <sys/times.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sys/user.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/major.h>
+#include <asm/byteorder.h>
+
+/* direct disk access, not easily obtained from headers */
+#ifndef O_DIRECT
+#define O_DIRECT        040000
+#endif
+
+#define TIMING_BUF_MB           2
+#define TIMING_BUF_BYTES        (TIMING_BUF_MB * 1024 * 1024)
+
+static void *prepare_timing_buf(unsigned int len)
+{
+	unsigned int i;
+	__u8 *buf;
+
+	buf = mmap(NULL, len, PROT_READ|PROT_WRITE, \
+			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("could not allocate timing buf");
+		return NULL;
+	}
+
+	for (i = 0; i < len; i += 4096)
+		buf[i] = 0; /* guarantee memory is present/assigned */
+	if (-1 == mlock(buf, len)) {
+		perror("mlock() failed on timing buf");
+		munmap(buf, len);
+		return NULL;
+	}
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+	/* don't care if this fails on low-memory machines */
+	sync();
+
+	/* give time for I/O to settle */
+	sleep(3);
+	return buf;
+}
+
+static int read_big_block(int fd, char *buf)
+{
+	int i, rc;
+
+	rc = read(fd, buf, TIMING_BUF_BYTES);
+	if (rc != TIMING_BUF_BYTES) {
+		if (rc) {
+			if (rc == -1)
+				perror("read() failed");
+			else
+				fprintf(stderr, "read(%u) returned \
+						%u bytes\n", \
+						TIMING_BUF_BYTES, rc);
+		} else {
+			fputs("read() hit EOF - device too small\n", stderr);
+		}
+		return 1;
+	}
+	/* access all sectors of buf to ensure the read fully completed */
+	for (i = 0; i < TIMING_BUF_BYTES; i += 512)
+		buf[i] &= 1;
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int file_id;
+	struct timeval start;
+	struct timeval end;
+	double time_use = 0;
+	double speed = 0;
+	char *buf;
+
+	if (argc < 2) {
+		printf("error!\n");
+		return -1;
+	}
+
+	file_id = open(argv[1], O_RDONLY | O_NONBLOCK | O_DIRECT);
+
+	buf = prepare_timing_buf(TIMING_BUF_BYTES);
+	gettimeofday(&start, NULL);
+	read_big_block(file_id, buf);
+	gettimeofday(&end, NULL);
+	time_use = (end.tv_sec-start.tv_sec)*1000000+ \
+		   (end.tv_usec-start.tv_usec);
+	time_use = time_use/1000000.0;
+	printf("time_use is %f second\n", time_use);
+	speed = TIMING_BUF_BYTES/1024.0/time_use;
+	printf("%fKB/s\n", speed);
+	return 0;
+}
-- 
1.9.1

