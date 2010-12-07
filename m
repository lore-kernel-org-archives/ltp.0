Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PPs6S-0005yb-5m
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:36:48 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PPs6Q-0006WO-TN
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:36:48 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB77afft031201
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 02:36:41 -0500
Date: Tue, 7 Dec 2010 02:36:41 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1887538489.253411291707401443.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1023907111.253391291707398584.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17391_142707163.1291707401442"
Subject: [LTP] [PATCH v2] munmap() don't check sysctl_max_mapcount
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_17391_142707163.1291707401442
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From http://lkml.org/lkml/2009/10/2/85:

On ia64, the following test program exit abnormally, because glibc
thread library called abort().

 ========================================================
 (gdb) bt
 #0  0xa000000000010620 in __kernel_syscall_via_break ()
 #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
 #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
 #3  0x200000000027c3e0 in __deallocate_stack () from
     /lib/libpthread.so.0
 #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
 #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
 ========================================================
The fact is, glibc call munmap() when thread exitng time for freeing
stack, and it assume munlock() never fail. However, munmap() often make
vma splitting and it with many mapcount make -ENOMEM.

Oh well, stack unfreeing is not reasonable option. Also munlock() via
free() shouldn't failed.

Thus, munmap() shoudn't check max-mapcount.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup
 
 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/mmap/Makefile |    2 +
 testcases/kernel/syscalls/mmap/mmap11.c |  144 +++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..1589b5f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1287,3 +1287,4 @@ writev04 writev04
 writev05 writev05
 writev06 writev06
 
+mmap11 mmap11 -i 30000
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mmap/Makefile b/testcases/kernel/syscalls/mmap/Makefile
index bd617d8..68771cd 100644
--- a/testcases/kernel/syscalls/mmap/Makefile
+++ b/testcases/kernel/syscalls/mmap/Makefile
@@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= -lpthread
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
new file mode 100644
index 0000000..0cd32d4
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -0,0 +1,144 @@
+/*
+ * munmap() don't check sysctl_max_mapcount
+ *
+ * From http://lkml.org/lkml/2009/10/2/85:
+ *
+ * On ia64, the following test program exit abnormally, because glibc
+ * thread library called abort().
+ *
+ *  ========================================================
+ *  (gdb) bt
+ *  #0  0xa000000000010620 in __kernel_syscall_via_break ()
+ *  #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
+ *  #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
+ *  #3  0x200000000027c3e0 in __deallocate_stack () from
+ *      /lib/libpthread.so.0
+ *  #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
+ *  #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
+ *  ========================================================
+ * The fact is, glibc call munmap() when thread exitng time for freeing
+ * stack, and it assume munlock() never fail. However, munmap() often
+ * make vma splitting and it with many mapcount make -ENOMEM.
+ *
+ * Oh well, stack unfreeing is not reasonable option. Also munlock() via
+ * free() shouldn't failed.
+ *
+ * Thus, munmap() shoudn't check max-mapcount.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program
+ * with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+#include<stdio.h>
+#include<stdlib.h>
+#include<string.h>
+#include<pthread.h>
+#include<errno.h>
+#include<unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "mmap11";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define MAL_SIZE (100*1024)
+
+static void *wait_thread(void *args);
+static void *wait_thread2(void *args);
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void check(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	check();
+	cleanup();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void check(void)
+{
+	int lc;
+	pthread_t *thread, th;
+	int ret, count = 0;
+	pthread_attr_t attr;
+
+	ret = pthread_attr_init(&attr);
+	if (ret)
+		tst_brkm(TBROK|TERRNO, cleanup, "pthread_attr_init");
+	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+	if (ret)
+		tst_brkm(TBROK|TERRNO, cleanup, "pthread_attr_setdetachstate");
+	thread = malloc(STD_LOOP_COUNT * sizeof(pthread_t));
+	if (thread == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		ret = pthread_create(&th, &attr, wait_thread, NULL);
+		if (ret) {
+			tst_resm(TINFO, "[%d] ", count);
+			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
+		}
+		count++;
+		ret = pthread_create(&thread[lc], &attr, wait_thread2, NULL);
+		if (ret) {
+			tst_resm(TINFO, "[%d] ", count);
+			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
+		}
+		count++;
+	}
+	tst_resm(TPASS, "test completed.");
+	free(thread);
+}
+
+void *wait_thread(void *args)
+{
+	void *addr;
+
+	addr = malloc(MAL_SIZE);
+	if (addr)
+		memset(addr, 1, MAL_SIZE);
+	sleep(1);
+	return NULL;
+}
+
+void *wait_thread2(void *args)
+{
+	return NULL;
+}
-- 
1.7.3.2
------=_Part_17391_142707163.1291707401442
Content-Type: text/x-patch; name=munmap-dont-check-sysctl-max-mapcount.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=munmap-dont-check-sysctl-max-mapcount.patch

From http://lkml.org/lkml/2009/10/2/85:

On ia64, the following test program exit abnormally, because glibc
thread library called abort().

 ========================================================
 (gdb) bt
 #0  0xa000000000010620 in __kernel_syscall_via_break ()
 #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
 #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
 #3  0x200000000027c3e0 in __deallocate_stack () from
     /lib/libpthread.so.0
 #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
 #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
 ========================================================
The fact is, glibc call munmap() when thread exitng time for freeing
stack, and it assume munlock() never fail. However, munmap() often make
vma splitting and it with many mapcount make -ENOMEM.

Oh well, stack unfreeing is not reasonable option. Also munlock() via
free() shouldn't failed.

Thus, munmap() shoudn't check max-mapcount.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup
 
 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/mmap/Makefile |    2 +
 testcases/kernel/syscalls/mmap/mmap11.c |  144 +++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..1589b5f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1287,3 +1287,4 @@ writev04 writev04
 writev05 writev05
 writev06 writev06
 
+mmap11 mmap11 -i 30000
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mmap/Makefile b/testcases/kernel/syscalls/mmap/Makefile
index bd617d8..68771cd 100644
--- a/testcases/kernel/syscalls/mmap/Makefile
+++ b/testcases/kernel/syscalls/mmap/Makefile
@@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= -lpthread
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
new file mode 100644
index 0000000..0cd32d4
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -0,0 +1,144 @@
+/*
+ * munmap() don't check sysctl_max_mapcount
+ *
+ * From http://lkml.org/lkml/2009/10/2/85:
+ *
+ * On ia64, the following test program exit abnormally, because glibc
+ * thread library called abort().
+ *
+ *  ========================================================
+ *  (gdb) bt
+ *  #0  0xa000000000010620 in __kernel_syscall_via_break ()
+ *  #1  0x20000000003208e0 in raise () from /lib/libc.so.6.1
+ *  #2  0x2000000000324090 in abort () from /lib/libc.so.6.1
+ *  #3  0x200000000027c3e0 in __deallocate_stack () from
+ *      /lib/libpthread.so.0
+ *  #4  0x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
+ *  #5  0x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
+ *  ========================================================
+ * The fact is, glibc call munmap() when thread exitng time for freeing
+ * stack, and it assume munlock() never fail. However, munmap() often
+ * make vma splitting and it with many mapcount make -ENOMEM.
+ *
+ * Oh well, stack unfreeing is not reasonable option. Also munlock() via
+ * free() shouldn't failed.
+ *
+ * Thus, munmap() shoudn't check max-mapcount.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program
+ * with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+#include<stdio.h>
+#include<stdlib.h>
+#include<string.h>
+#include<pthread.h>
+#include<errno.h>
+#include<unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "mmap11";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define MAL_SIZE (100*1024)
+
+static void *wait_thread(void *args);
+static void *wait_thread2(void *args);
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void check(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	check();
+	cleanup();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void check(void)
+{
+	int lc;
+	pthread_t *thread, th;
+	int ret, count = 0;
+	pthread_attr_t attr;
+
+	ret = pthread_attr_init(&attr);
+	if (ret)
+		tst_brkm(TBROK|TERRNO, cleanup, "pthread_attr_init");
+	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+	if (ret)
+		tst_brkm(TBROK|TERRNO, cleanup, "pthread_attr_setdetachstate");
+	thread = malloc(STD_LOOP_COUNT * sizeof(pthread_t));
+	if (thread == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		ret = pthread_create(&th, &attr, wait_thread, NULL);
+		if (ret) {
+			tst_resm(TINFO, "[%d] ", count);
+			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
+		}
+		count++;
+		ret = pthread_create(&thread[lc], &attr, wait_thread2, NULL);
+		if (ret) {
+			tst_resm(TINFO, "[%d] ", count);
+			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
+		}
+		count++;
+	}
+	tst_resm(TPASS, "test completed.");
+	free(thread);
+}
+
+void *wait_thread(void *args)
+{
+	void *addr;
+
+	addr = malloc(MAL_SIZE);
+	if (addr)
+		memset(addr, 1, MAL_SIZE);
+	sleep(1);
+	return NULL;
+}
+
+void *wait_thread2(void *args)
+{
+	return NULL;
+}
-- 
1.7.3.2


------=_Part_17391_142707163.1291707401442
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
------=_Part_17391_142707163.1291707401442
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_17391_142707163.1291707401442--

