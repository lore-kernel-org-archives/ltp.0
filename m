Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q7mkx-0008MU-VL
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 10:48:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q7mkv-0005m7-GR
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 10:48:07 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p37Alxsg032496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Apr 2011 06:47:59 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu,  7 Apr 2011 18:47:55 +0800
Message-Id: <1302173275-19016-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] mem: mbind01: not work in 32bit system
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when execute mem/mbind01 testcase under 32bit systems, it returns ENOSYS
error. This patch checks wordsize before executing the actual case. And
this testcase appears to be better in syscalls/mbind dir, I moved it
there.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                                |    2 -
 runtest/syscalls                          |   11 +-
 testcases/kernel/mem/mbind/Makefile       |   26 -----
 testcases/kernel/mem/mbind/mbind01.c      |  141 ----------------------------
 testcases/kernel/syscalls/mbind/mbind02.c |  146 +++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 174 deletions(-)
 delete mode 100644 testcases/kernel/mem/mbind/Makefile
 delete mode 100644 testcases/kernel/mem/mbind/mbind01.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind02.c


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mem-mbind01-not-work-in-32bit-system.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mem-mbind01-not-work-in-32bit-system.patch"

diff --git a/runtest/mm b/runtest/mm
index f2d50d6..6382c82 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,8 +72,6 @@ ksm04_1 ksm04 -u 128
 
 cpuset01 cpuset01 -I 3600
 
-mbind01 mbind01
-
 oom01 oom01
 oom02 oom02
 oom03 oom03
diff --git a/runtest/syscalls b/runtest/syscalls
index 4294d07..265f67a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -505,6 +505,7 @@ lstat03_64 lstat03_64
 mallopt01 mallopt01
 
 mbind01 mbind01
+mbind02 mbind02
 
 memset01 memset01
 memcmp01 memcmp01
@@ -573,7 +574,7 @@ mount1234 test_mount
 
 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
-move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 04755 move_pages03 && move_pages.sh 03 
+move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 04755 move_pages03 && move_pages.sh 03
 move_pages04 move_pages.sh 04
 move_pages05 move_pages.sh 05
 move_pages06 move_pages.sh 06
@@ -675,7 +676,7 @@ open10 open10
 openat01 openat01
 
 mincore01 mincore01
-mincore02 mincore02 
+mincore02 mincore02
 
 madvise01 madvise01
 madvise02 madvise02
@@ -689,8 +690,8 @@ pause01 pause01
 pause02 pause02
 pause03 pause03
 
-#  The personality() system call is poorly documented 
-#  and difficult to figure out how to use by looking 
+#  The personality() system call is poorly documented
+#  and difficult to figure out how to use by looking
 #  at the different architecture specific kernel files.
 #personality01 personality01
 #personality02 personality02
@@ -1200,7 +1201,7 @@ truncate04_64 truncate04_64
 # This syscall is obsolete.  The latest glibc does not even
 # include the ulimit.h file anymore.  The test will fail
 # because the error handling has been simplified.
-# 
+#
 ulimit01 ulimit01
 
 umask01 umask01
diff --git a/testcases/kernel/mem/mbind/Makefile b/testcases/kernel/mem/mbind/Makefile
deleted file mode 100644
index 27208d1..0000000
--- a/testcases/kernel/mem/mbind/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-#  Copyright (C) 2010  Red Hat, Inc.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or (at
-#  your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-#  02110-1301, USA.
-#
-
-top_srcdir              ?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS 			+= $(NUMA_LIBS)
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
deleted file mode 100644
index 80a56c4..0000000
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * This is a reproducer from mainline commit
- * 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:
- *
- * "Strangely, current mbind() doesn't merge vma with neighbor vma
- * although it's possible.  Unfortunately, many vma can reduce
- * performance..."
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#include "test.h"
-#include "usctest.h"
-#include "config.h"
-
-char *TCID = "mbind01";
-int TST_TOTAL = 1;
-
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-#include <numaif.h>
-#include <numa.h>
-#include <sys/mman.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-
-static unsigned long pagesize;
-static int opt_node;
-static char *opt_nodestr;
-static option_t options[] = {
-	{ "n:", &opt_node,	&opt_nodestr},
-	{ NULL, NULL,		NULL}
-};
-
-static void usage(void);
-
-int main(int argc, char** argv)
-{
-	FILE *fp;
-	void* addr;
-	int node, err, lc;
-	struct bitmask *nmask = numa_allocate_nodemask();
-	char buf[BUFSIZ], start[BUFSIZ], end[BUFSIZ], string[BUFSIZ];
-	char *p, *msg;
-
-	pagesize = getpagesize();
-	msg = parse_opts(argc, argv, options, usage);
-	if (msg != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	if (opt_node) {
-		node = atoi(optarg);
-		if (node < 1)
-			tst_brkm(TBROK, NULL,
-				"Number of NUMA nodes cannot be less that 1.");
-		numa_bitmask_setbit(nmask, node);
-	} else
-		numa_bitmask_setbit(nmask, 0);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
-		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
-			MAP_ANON|MAP_PRIVATE, 0, 0);
-		if (addr == MAP_FAILED)
-			tst_brkm(TBROK|TERRNO, NULL, "mmap");
-
-		tst_resm(TINFO, "pid = %d addr = %p", getpid(), addr);
-		/* make page populate */
-		memset(addr, 0, pagesize*3);
-
-		/* first mbind */
-		err = mbind(addr+pagesize, pagesize, MPOL_BIND, nmask->maskp,
-			nmask->size, MPOL_MF_MOVE_ALL);
-		if (err != 0)
-			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
-
-		/* second mbind */
-		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
-		if (err != 0)
-			tst_brkm(TBROK|TERRNO, NULL, "mbind2");
-
-		/* /proc/self/maps in the form of
-		   "00400000-00406000 r-xp 00000000". */
-		sprintf(string, "%p", addr);
-		fp = fopen("/proc/self/maps", "r");
-		if (fp == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "fopen");
-
-		while (fgets(buf, BUFSIZ, fp) != NULL) {
-			/* Find out the 1st VMAs. */
-			if (sscanf(buf, "%s-%s ", start, end) != 2)
-				continue;
-			/* Remove leading 0x. */
-			if (strcmp(string + 2, start) != 0)
-				continue;
-			/* Find out the second VMA. */
-			if (fgets(buf, BUFSIZ, fp) == NULL)
-				tst_brkm(TBROK|TERRNO, NULL, "fgets");
-			p = strtok(buf, "-");
-			if (p == NULL || strcmp(p, end) != 0)
-				tst_resm(TPASS, "only 1 VMA.");
-			else
-				tst_resm(TFAIL, "more than 1 VMA.");
-		}
-		fclose(fp);
-		if (munmap(addr, pagesize*3) == -1)
-			tst_brkm(TWARN|TERRNO, NULL, "munmap");
-	}
-	tst_exit();
-}
-
-void usage(void)
-{
-	printf("  -n      Number of NUMA nodes\n");
-}
-
-#else /* no NUMA */
-int main(void) {
-	tst_resm(TCONF, "no NUMA development packages installed.");
-	tst_exit();
-}
-#endif
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
new file mode 100644
index 0000000..a2993a8
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -0,0 +1,146 @@
+/*
+ * This is a reproducer from mainline commit
+ * 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:
+ *
+ * "Strangely, current mbind() doesn't merge vma with neighbor vma
+ * although it's possible.  Unfortunately, many vma can reduce
+ * performance..."
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "mbind02";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <numaif.h>
+#include <numa.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+
+static unsigned long pagesize;
+static int opt_node;
+static char *opt_nodestr;
+static option_t options[] = {
+	{ "n:", &opt_node,	&opt_nodestr},
+	{ NULL, NULL,		NULL}
+};
+
+static void usage(void);
+
+int main(int argc, char** argv)
+{
+	FILE *fp;
+	void* addr;
+	int node, err, lc;
+	struct bitmask *nmask = numa_allocate_nodemask();
+	char buf[BUFSIZ], start[BUFSIZ], end[BUFSIZ], string[BUFSIZ];
+	char *p, *msg;
+
+	pagesize = getpagesize();
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+#endif
+
+	if (opt_node) {
+		node = atoi(optarg);
+		if (node < 1)
+			tst_brkm(TBROK, NULL,
+				"Number of NUMA nodes cannot be less that 1.");
+		numa_bitmask_setbit(nmask, node);
+	} else
+		numa_bitmask_setbit(nmask, 0);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+			MAP_ANON|MAP_PRIVATE, 0, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, NULL, "mmap");
+
+		tst_resm(TINFO, "pid = %d addr = %p", getpid(), addr);
+		/* make page populate */
+		memset(addr, 0, pagesize*3);
+
+		/* first mbind */
+		err = mbind(addr+pagesize, pagesize, MPOL_BIND, nmask->maskp,
+			nmask->size, MPOL_MF_MOVE_ALL);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+
+		/* second mbind */
+		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, NULL, "mbind2");
+
+		/* /proc/self/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+		sprintf(string, "%p", addr);
+		fp = fopen("/proc/self/maps", "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, NULL, "fopen");
+
+		while (fgets(buf, BUFSIZ, fp) != NULL) {
+			/* Find out the 1st VMAs. */
+			if (sscanf(buf, "%s-%s ", start, end) != 2)
+				continue;
+			/* Remove leading 0x. */
+			if (strcmp(string + 2, start) != 0)
+				continue;
+			/* Find out the second VMA. */
+			if (fgets(buf, BUFSIZ, fp) == NULL)
+				tst_brkm(TBROK|TERRNO, NULL, "fgets");
+			p = strtok(buf, "-");
+			if (p == NULL || strcmp(p, end) != 0)
+				tst_resm(TPASS, "only 1 VMA.");
+			else
+				tst_resm(TFAIL, "more than 1 VMA.");
+		}
+		fclose(fp);
+		if (munmap(addr, pagesize*3) == -1)
+			tst_brkm(TWARN|TERRNO, NULL, "munmap");
+	}
+	tst_exit();
+}
+
+void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}
+
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



