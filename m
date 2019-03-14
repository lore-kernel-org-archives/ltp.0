From: Christian Amann <camann@suse.com>
Date: Thu, 14 Mar 2019 09:57:17 +0100
Subject: [LTP] [PATCH v2] syscall: Add userfaultfd testcase
Message-ID: <20190314085717.10207-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This tests the userfaultfd syscall to handle pagefault events.
It does so by registering a userfaultfd object to the address of
a memory page. In a second thread it handles the event and writes
data in the monitored memory page to indicate success.

Signed-off-by: Christian Amann <camann@suse.com>
---
 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
 include/lapi/syscalls/powerpc.in                   |   1 +
 include/lapi/syscalls/powerpc64.in                 |   1 +
 include/lapi/syscalls/s390.in                      |   1 +
 include/lapi/syscalls/s390x.in                     |   1 +
 include/lapi/syscalls/sparc.in                     |   1 +
 include/lapi/syscalls/sparc64.in                   |   1 +
 include/lapi/syscalls/x86_64.in                    |   1 +
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/userfaultfd/.gitignore   |   1 +
 testcases/kernel/syscalls/userfaultfd/Makefile     |  23 ++++
 .../kernel/syscalls/userfaultfd/userfaultfd01.c    | 142 +++++++++++++++++++++
 15 files changed, 179 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/userfaultfd/Makefile
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 7ce148524..177dd0115 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -258,6 +258,7 @@ process_vm_writev 271
 kcmp 272
 getrandom 278
 memfd_create 279
+userfaultfd 282
 membarrier 283
 execveat 281
 mlock2 284
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 22c76d4f0..f4adedb2c 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -343,6 +343,7 @@ renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
 memfd_create (__NR_SYSCALL_BASE+385)
 execveat (__NR_SYSCALL_BASE+387)
+userfaultfd (__NR_SYSCALL_BASE+388)
 membarrier (__NR_SYSCALL_BASE+389)
 mlock2 (__NR_SYSCALL_BASE+390)
 copy_file_range (__NR_SYSCALL_BASE+391)
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 7e485aebf..af5254f77 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -341,6 +341,7 @@ renameat2 354
 getrandom 355
 memfd_create 356
 execveat 358
+userfaultfd 374
 membarrier 375
 mlock2 376
 copy_file_range 377
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 7c9a0ead6..c0aeed08b 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -298,6 +298,7 @@ process_vm_writev 1333
 renameat2 1338
 getrandom 1339
 memfd_create 1340
+userfaultfd 1343
 membarrier 1344
 execveat 1342
 mlock2 1346
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index fc1f89945..6b6be58a7 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -347,6 +347,7 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+userfaultfd 364
 membarrier 365
 execveat 362
 mlock2 378
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index fc1f89945..6b6be58a7 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -347,6 +347,7 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+userfaultfd 364
 membarrier 365
 execveat 362
 mlock2 378
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 6d0c895fa..2a2ffe223 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -331,6 +331,7 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+userfaultfd 355
 membarrier 356
 execveat 354
 mlock2 374
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 8105b5598..4c36ce17c 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -330,6 +330,7 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+userfaultfd 355
 membarrier 356
 execveat 354
 mlock2 374
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 20a21a9ce..20dc37b01 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -337,6 +337,7 @@ renameat2 345
 getrandom 347
 memfd_create 348
 membarrier 351
+userfaultfd 352
 execveat 350
 mlock2 356
 copy_file_range 357
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 36ab39420..c100b8e3e 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -313,6 +313,7 @@ renameat2 345
 getrandom 347
 memfd_create 348
 membarrier 351
+userfaultfd 352
 execveat 350
 mlock2 356
 copy_file_range 357
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 6aa9d12a8..87849e5c0 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -308,6 +308,7 @@ renameat2 316
 getrandom 318
 memfd_create 319
 execveat 322
+userfaultfd 323
 membarrier 324
 mlock2 325
 copy_file_range 326
diff --git a/runtest/syscalls b/runtest/syscalls
index d752dba33..ebb4d69a5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1464,6 +1464,8 @@ umount2_01 umount2_01
 umount2_02 umount2_02
 umount2_03 umount2_03
 
+userfaultfd01 userfaultfd01
+
 ustat01 ustat01
 ustat02 ustat02
 
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
new file mode 100644
index 000000000..d819a2a7c
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -0,0 +1 @@
+/userfaultfd01
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
new file mode 100644
index 000000000..55930ad92
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -0,0 +1,23 @@
+# Copyright (c) 2019 SUSE LLC
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+userfaultfd01: CFLAGS += -pthread
+
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
new file mode 100644
index 000000000..1601649fa
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-late
+/*
+ * Copyright (c) 2019 SUSE LLC
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test userfaultfd
+ *
+ * Force a pagefault event and handle it using userfaultfd
+ * from a different thread
+ *
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include <linux/userfaultfd.h>
+#include <pthread.h>
+#include <poll.h>
+
+static int page_size;
+static char *page;
+static void *copy_page;
+
+static int sys_userfaultfd(int flags)
+{
+	return tst_syscall(__NR_userfaultfd, flags);
+}
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	copy_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void *handle_thread(void *arg)
+{
+	static struct uffd_msg msg;
+	long uffd;
+	struct uffdio_copy uffdio_copy;
+	ssize_t nread;
+
+	uffd = (long) arg;
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO,
+				"Error on poll");
+
+	nread = read(uffd, &msg, sizeof(msg));
+	if (nread <= 0)
+		tst_brk(TBROK | TERRNO, "Error on read");
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO,
+				"Received unexpected UFFD_EVENT");
+
+	memset(copy_page, 'X', page_size);
+
+	uffdio_copy.src = (unsigned long) copy_page;
+
+	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_copy.len = page_size;
+	uffdio_copy.mode = 0;
+	uffdio_copy.copy = 0;
+	if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1)
+		tst_brk(TBROK | TERRNO,
+				"ioctl returned error for UFFDIO_COPY");
+	close(uffd);
+}
+
+static void run(void)
+{
+	long uffd;
+	pthread_t thr;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	int thread_ret;
+
+	set_pages();
+
+	uffd = sys_userfaultfd(O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1)
+		tst_brk(TBROK | TERRNO,
+			"Could not create userfault file descriptor");
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1)
+		tst_brk(TBROK | TERRNO, "ioctl returned error for UFFDIO_API");
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		tst_brk(TBROK | TERRNO,
+			"ioctl returned error for UFFDIO_REGISTER");
+
+	thread_ret = pthread_create(&thr, NULL,
+			handle_thread, (void *) uffd);
+	if (thread_ret != 0) {
+		errno = thread_ret;
+		tst_brk(TBROK | TERRNO, "Could not create pthread");
+	}
+
+	char c = page[0xf];
+
+	if (c == 'X')
+		tst_res(TPASS, "Pagefault handled!");
+	else
+		tst_res(TFAIL, "Pagefault not handled!");
+
+	pthread_join(thr, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.3",
+	.timeout = 20
+};
-- 
2.16.4

