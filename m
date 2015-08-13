Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZPgy9-00087D-7v
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 01:06:09 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZPgy3-0006N3-KQ
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 01:06:09 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 13 Aug 2015 01:05:26 +0000
Message-ID: <1439427926-7958-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] edf-scheduler/edf_test01: Add new testcase to test
	edf-sched
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
To: ltp-list@lists.sourceforge.net

Add testcase 'edf_test01' to test edf-sched

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 runtest/sched                                     |    2 +
 testcases/kernel/sched/edf-scheduler/.gitignore   |    1 +
 testcases/kernel/sched/edf-scheduler/Makefile     |   25 ++++
 testcases/kernel/sched/edf-scheduler/edf_test01.c |  129 +++++++++++++++++++++
 4 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/sched/edf-scheduler/.gitignore
 create mode 100644 testcases/kernel/sched/edf-scheduler/Makefile
 create mode 100644 testcases/kernel/sched/edf-scheduler/edf_test01.c

diff --git a/runtest/sched b/runtest/sched
index 16877a3..39b4c5a 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -9,6 +9,8 @@ trace_sched01		trace_sched -c 1
 hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000
 
+edf_test01 edf_test01
+
 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
 sched_stress sched_stress.sh
diff --git a/testcases/kernel/sched/edf-scheduler/.gitignore b/testcases/kernel/sched/edf-scheduler/.gitignore
new file mode 100644
index 0000000..20d383b
--- /dev/null
+++ b/testcases/kernel/sched/edf-scheduler/.gitignore
@@ -0,0 +1 @@
+/edf_test01
diff --git a/testcases/kernel/sched/edf-scheduler/Makefile b/testcases/kernel/sched/edf-scheduler/Makefile
new file mode 100644
index 0000000..4ab9a6c
--- /dev/null
+++ b/testcases/kernel/sched/edf-scheduler/Makefile
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
+LDLIBS			+= -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/edf-scheduler/edf_test01.c b/testcases/kernel/sched/edf-scheduler/edf_test01.c
new file mode 100644
index 0000000..6c136c8
--- /dev/null
+++ b/testcases/kernel/sched/edf-scheduler/edf_test01.c
@@ -0,0 +1,129 @@
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
+
+char *TCID = "edf_test01";
+int TST_TOTAL = 1;
+
+#define gettid() syscall(__NR_gettid)
+
+#define SCHED_DEADLINE	6
+
+/* XXX use the proper syscall numbers */
+#ifdef __x86_64__
+#define __NR_sched_setattr		314
+#define __NR_sched_getattr		315
+#endif
+
+#ifdef __i386__
+#define __NR_sched_setattr		351
+#define __NR_sched_getattr		352
+#endif
+
+#ifdef __arm__
+#define __NR_sched_setattr		380
+#define __NR_sched_getattr		381
+#endif
+
+struct sched_attr {
+	__u32 size;
+
+	__u32 sched_policy;
+	__u64 sched_flags;
+
+	/* SCHED_NORMAL, SCHED_BATCH */
+	__s32 sched_nice;
+
+	/* SCHED_FIFO, SCHED_RR */
+	__u32 sched_priority;
+
+	/* SCHED_DEADLINE (nsec) */
+	__u64 sched_runtime;
+	__u64 sched_deadline;
+	__u64 sched_period;
+};
+
+int sched_setattr(pid_t pid,
+       	  const struct sched_attr *attr,
+       	  unsigned int flags)
+{
+	return syscall(__NR_sched_setattr, pid, attr, flags);
+}
+
+int sched_getattr(pid_t pid,
+       	  struct sched_attr *attr,
+       	  unsigned int size,
+       	  unsigned int flags)
+{
+	return syscall(__NR_sched_getattr, pid, attr, size, flags);
+}
+
+void *run_deadline(void* data)
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
+	if ( ret < 0) {
+		printf("errno = %d, ret = %d\n", errno, ret);
+		tst_brkm(TFAIL, NULL, "sched_setattr error\n");
+	}
+
+	size = sizeof(attr_copy);
+	ret = sched_getattr(0, &attr_copy, size, flags);
+	if ( ret < 0) {
+                printf("errno = %d, ret = %d\n", errno, ret);
+        	tst_brkm(TFAIL, NULL, "sched_getattr error\n");
+	}
+
+	if ( (10000000 != attr_copy.sched_runtime) || 
+		(30000000 != attr_copy.sched_period) || 
+		(30000000 != attr_copy.sched_deadline) ) {
+		tst_brkm(TFAIL, NULL, "edf_test01 failed\n");
+	}
+
+	return NULL;
+}
+
+int main (int argc, char **argv)
+{
+	pthread_t thread;
+
+	if ((tst_kvercmp(3, 14, 0)) < 0) {
+		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher\n");
+	}
+
+	pthread_create(&thread, NULL, run_deadline, NULL);
+
+	sleep(1);
+
+	pthread_join(thread, NULL);
+
+	tst_resm(TPASS, "edf_test01 succeed");
+	tst_exit();
+}
-- 
1.6.0.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
