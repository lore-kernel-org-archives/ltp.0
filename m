From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 8 Oct 2015 16:27:35 +0800
Subject: [LTP] [PATCH v3] sched_getattr/sched_getattr01: Add new testcase to
 test sched_getattr
In-Reply-To: <20150929163350.GB32435@rei.suse.cz>
References: <20150929163350.GB32435@rei.suse.cz>
Message-ID: <561628F7.3010902@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add testcase 'sched_getattr01' to test sched_getattr function

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
V3: * Include stdint.h and inttypes.h to get the int32_t and uint64_t types
        defined and to get PRIu64 defined;
    * Add "sched_getattr01 sched_getattr01" to runtest/syscalls;
    * Change "-lpthread" to "-pthread" in testcases/kernel/syscalls/sched_getattr/Makefile;
    * Use PRIu64 to print uint64_t;


V2: * Add the test to syscalls/sched_getattr and rename it to "sched_getattr01";
    * Change "LDLIBS" to "CFLAGS" in sched_getattr/Makefile;
    * Delete "#define gettid() ..." which is not need in case;
    * Add "__NR_sched_setattr" and "__NR_sched_getattr" to arm.in,i386.in,x86_64.in
	in testcases/kernel/include/;
    * Create lapi/sched.h and add "struct sched_attr" and "sched_setattr", "sched_getattr"
	to it;
    * uint32_t/uint64_t/int32_t instead of __u32/__u64/__s32;
    * Delete printf() in case and change "TFAIL" to "TFAIL | TERRNO" in tst_brkm();
    * define RUNTIME_VAL PERIOD_VAL DEADLINE_VAL for comparing and split one if to three ifs;
    * Delete sleep(1) and tst_resm(TPASS,..) in main.

 include/lapi/sched.h                               |   59 +++++++++++++
 runtest/sched                                      |    2 +
 runtest/syscalls                                   |    2 +
 testcases/kernel/include/arm.in                    |    2 +
 testcases/kernel/include/i386.in                   |    2 +
 testcases/kernel/include/x86_64.in                 |    2 +
 testcases/kernel/syscalls/.gitignore               |    1 +
 testcases/kernel/syscalls/sched_getattr/Makefile   |   25 ++++++
 .../syscalls/sched_getattr/sched_getattr01.c       |   92 ++++++++++++++++++++
 9 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 include/lapi/sched.h
 create mode 100644 testcases/kernel/syscalls/sched_getattr/Makefile
 create mode 100644 testcases/kernel/syscalls/sched_getattr/sched_getattr01.c

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
new file mode 100644
index 0000000..189c2de
--- /dev/null
+++ b/include/lapi/sched.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __SCHED_H__
+#define __SCHED_H__
+
+#include "linux_syscall_numbers.h"
+#include <stdint.h>
+#include <inttypes.h>
+
+struct sched_attr {
+	uint32_t size;
+
+	uint32_t sched_policy;
+	uint64_t sched_flags;
+
+	/* SCHED_NORMAL, SCHED_BATCH */
+	int32_t sched_nice;
+
+	/* SCHED_FIFO, SCHED_RR */
+	uint32_t sched_priority;
+
+	/* SCHED_DEADLINE (nsec) */
+	uint64_t sched_runtime;
+	uint64_t sched_deadline;
+	uint64_t sched_period;
+};
+
+int sched_setattr(pid_t pid,
+	const struct sched_attr *attr,
+	unsigned int flags)
+{
+	return syscall(__NR_sched_setattr, pid, attr, flags);
+}
+
+int sched_getattr(pid_t pid,
+	struct sched_attr *attr,
+	unsigned int size,
+	unsigned int flags)
+{
+	return syscall(__NR_sched_getattr, pid, attr, size, flags);
+}
+
+#endif /* __SCHED_H__ */
diff --git a/runtest/sched b/runtest/sched
index 16877a3..10a1648 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -9,6 +9,8 @@ trace_sched01		trace_sched -c 1
 hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000

+sched_getattr01 sched_getattr01
+
 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
 sched_stress sched_stress.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 5d4a06d..c54a637 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -915,6 +915,8 @@ sched_yield01 sched_yield01
 sched_setaffinity01 sched_setaffinity01
 sched_getaffinity01 sched_getaffinity01

+sched_getattr01 sched_getattr01
+
 select01 select01
 select02 select02
 select03 select03
diff --git a/testcases/kernel/include/arm.in b/testcases/kernel/include/arm.in
index eb130b7..d957f98 100644
--- a/testcases/kernel/include/arm.in
+++ b/testcases/kernel/include/arm.in
@@ -333,5 +333,7 @@ accept4 (__NR_SYSCALL_BASE+366)
 fanotify_init (__NR_SYSCALL_BASE+367)
 fanotify_mark (__NR_SYSCALL_BASE+368)
 prlimit64 (__NR_SYSCALL_BASE+369)
+sched_setattr (__NR_SYSCALL_BASE+380)
+sched_getattr (__NR_SYSCALL_BASE+381)
 renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
index 0e39902..31ceb8b 100644
--- a/testcases/kernel/include/i386.in
+++ b/testcases/kernel/include/i386.in
@@ -333,5 +333,7 @@ recvmmsg 337
 fanotify_init 338
 fanotify_mark 339
 prlimit64 340
+sched_setattr 351
+sched_getattr 352
 renameat2 354
 getrandom 355
diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
index 726b76f..b727ad9 100644
--- a/testcases/kernel/include/x86_64.in
+++ b/testcases/kernel/include/x86_64.in
@@ -300,5 +300,7 @@ recvmmsg 299
 fanotify_init 300
 fanotify_mark 301
 prlimit64 302
+sched_setattr 314
+sched_getattr 315
 renameat2 316
 getrandom 318
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 2553b2c..9f659c5 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -735,6 +735,7 @@
 /sched_get_priority_min/sched_get_priority_min01
 /sched_get_priority_min/sched_get_priority_min02
 /sched_getaffinity/sched_getaffinity01
+/sched_getattr/sched_getattr01
 /sched_getparam/sched_getparam01
 /sched_getparam/sched_getparam02
 /sched_getparam/sched_getparam03
diff --git a/testcases/kernel/syscalls/sched_getattr/Makefile b/testcases/kernel/syscalls/sched_getattr/Makefile
new file mode 100644
index 0000000..0ad382e
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2008
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -pthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
new file mode 100644
index 0000000..57b2314
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -0,0 +1,92 @@
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <linux/unistd.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <sys/syscall.h>
+#include <pthread.h>
+#include <sched.h>
+#include <errno.h>
+
+#include "test.h"
+#include "linux_syscall_numbers.h"
+#include "lapi/sched.h"
+
+char *TCID = "edf_test01";
+int TST_TOTAL = 1;
+
+#define SCHED_DEADLINE	6
+#define RUNTIME_VAL 10000000
+#define PERIOD_VAL 30000000
+#define DEADLINE_VAL 30000000
+
+void *run_deadline(void *data)
+{
+	struct sched_attr attr, attr_copy;
+	int ret;
+	unsigned int flags = 0;
+	unsigned int size;
+
+	attr.size = sizeof(attr);
+	attr.sched_flags = 0;
+	attr.sched_nice = 0;
+	attr.sched_priority = 0;
+
+	/* This creates a 10ms/30ms reservation */
+	attr.sched_policy = SCHED_DEADLINE;
+	attr.sched_runtime = 10 * 1000 * 1000;
+	attr.sched_period = 30 * 1000 * 1000;
+	attr.sched_deadline = 30 * 1000 * 1000;
+
+	ret = sched_setattr(0, &attr, flags);
+	if (ret < 0)
+		tst_brkm(TFAIL | TERRNO, NULL, "sched_setattr error\n");
+
+	size = sizeof(attr_copy);
+	ret = sched_getattr(0, &attr_copy, size, flags);
+	if (ret < 0)
+		tst_brkm(TFAIL | TERRNO, NULL, "sched_getattr error\n");
+
+	int fail = 0;
+
+	if (attr_copy.sched_runtime != RUNTIME_VAL) {
+		tst_resm(TINFO, "sched_runtime is incorrect (%"PRIu64"),"
+			" expected %u", attr.sched_runtime, RUNTIME_VAL);
+		fail++;
+	}
+	if (attr_copy.sched_period != PERIOD_VAL) {
+		tst_resm(TINFO, "sched_period is incorrect (%"PRIu64"),"
+			" expected %u", attr.sched_period, PERIOD_VAL);
+		fail++;
+	}
+	if (attr_copy.sched_deadline != DEADLINE_VAL) {
+		tst_resm(TINFO, "sched_deadline is incorrect (%"PRIu64"),"
+			" expected %u", attr.sched_deadline, DEADLINE_VAL);
+		fail++;
+	}
+
+	if (fail)
+		tst_resm(TFAIL, "attributes were read back incorrectly");
+	else
+		tst_resm(TPASS, "attributes were read back correctly");
+
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread;
+
+	if ((tst_kvercmp(3, 14, 0)) < 0)
+		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher\n");
+
+	pthread_create(&thread, NULL, run_deadline, NULL);
+
+	pthread_join(thread, NULL);
+
+	tst_exit();
+}
-- 
1.6.0.2 .


