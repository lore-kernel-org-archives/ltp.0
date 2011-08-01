Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QnhHY-00056Q-Bl
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:27:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QnhHX-0001Ml-8d
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:27:00 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p711QrWX000697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Jul 2011 21:26:53 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon,  1 Aug 2011 09:26:09 +0800
Message-Id: <34cb58b0bcceeff022417656c27e8f69ac92ef16.1312148778.git.czhang@redhat.com>
In-Reply-To: <9456f48c7d2f166712811753aaaa117410a85b51.1312148778.git.czhang@redhat.com>
References: <4387b2003cde3c5841dd4bcd9d58560aa891501d.1312147752.git.czhang@redhat.com>
	<1312161969-9519-1-git-send-email-czhang@redhat.com>
	<9456f48c7d2f166712811753aaaa117410a85b51.1312148778.git.czhang@redhat.com>
In-Reply-To: <9456f48c7d2f166712811753aaaa117410a85b51.1312148778.git.czhang@redhat.com>
References: <9456f48c7d2f166712811753aaaa117410a85b51.1312148778.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH] mm/mbind01: move to mm/vma02
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
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


why move testcase location:

mm/mbind01 has the same testcase name with syscalls/mbind01, which will
obviously make mm/mbind01 cover syscalls/mbind01 binary when `make
install'. Thus, we must change the testcase name. Since this testcase is
used to test vma merging issue during mbind, I propose to add it to
mm/vma test set.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                           |    3 +-
 testcases/kernel/mem/mbind/Makefile  |   26 -----
 testcases/kernel/mem/mbind/mbind01.c |  170 ----------------------------------
 testcases/kernel/mem/vma/Makefile    |    2 +
 testcases/kernel/mem/vma/vma02.c     |  170 ++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 198 deletions(-)
 delete mode 100644 testcases/kernel/mem/mbind/Makefile
 delete mode 100644 testcases/kernel/mem/mbind/mbind01.c
 create mode 100644 testcases/kernel/mem/vma/vma02.c


--------------1.7.6
Content-Type: text/x-patch; name="0002-mm-mbind01-move-to-mm-vma02.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-mbind01-move-to-mm-vma02.patch"

diff --git a/runtest/mm b/runtest/mm
index 5b08d15..b81ba8c 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,8 +72,6 @@ ksm04_1 ksm04 -u 128
 
 cpuset01 cpuset01 -I 3600
 
-mbind01 mbind01
-
 oom01 oom01
 oom02 oom02
 oom03 oom03
@@ -82,3 +80,4 @@ oom04 oom04
 thp01 thp01 -I 120
 
 vma01 vma01
+vma02 vma02
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
index 35f26ca..0000000
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ /dev/null
@@ -1,170 +0,0 @@
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
-#include <errno.h>
-
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
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
-	void *addr, *start, *end, *lastend;
-	int node, err, lc;
-	char buf[BUFSIZ];
-	struct bitmask *nmask = numa_allocate_nodemask();
-	char *msg;
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
-		addr = mmap(NULL, pagesize*3, PROT_WRITE,
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
-		if (err != 0) {
-			if (errno != ENOSYS)
-				tst_brkm(TBROK|TERRNO, NULL, "mbind1");
-			else
-				tst_brkm(TCONF, NULL,
-					"mbind syscall not implemented on this system.");
-		}
-
-		/* second mbind */
-		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
-		if (err != 0)
-			tst_brkm(TBROK|TERRNO, NULL, "mbind2");
-
-		/* /proc/self/maps in the form of
-		   "00400000-00406000 r-xp 00000000". */
-		fp = fopen("/proc/self/maps", "r");
-		if (fp == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "fopen");
-
-		while (fgets(buf, BUFSIZ, fp) != NULL) {
-			if (sscanf(buf, "%p-%p ", &start, &end) != 2)
-				continue;
-
-			if (start == addr) {
-				tst_resm(TINFO, "start = %p, end = %p",
-					start, end);
-				if (end == addr + pagesize*3) {
-					tst_resm(TPASS, "only 1 VMA.");
-					break;
-				}
-
-				lastend = end;
-				while (fgets(buf, BUFSIZ, fp) != NULL) {
-					/* No more VMAs, break */
-					if (sscanf(buf, "%p-%p ", &start,
-						&end) != 2)
-						break;
-					tst_resm(TINFO, "start = %p, end = %p",
-						start, end);
-
-					/* more VMAs found */
-					if (start == lastend)
-						lastend = end;
-					if (end == addr + pagesize*3) {
-						tst_resm(TFAIL,
-							">1 unmerged VMAs.");
-						break;
-					}
-				}
-				if (end != addr + pagesize*3)
-					tst_resm(TFAIL, "no matched VMAs.");
-				break;
-			}
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
-#else /* libnuma v1 */
-int main(void) {
-	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
-}
-#endif
-#else /* no NUMA */
-int main(void) {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
-#endif
diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
index 6b347c4..3899fcb 100644
--- a/testcases/kernel/mem/vma/Makefile
+++ b/testcases/kernel/mem/vma/Makefile
@@ -21,4 +21,6 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS 			+= $(NUMA_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
new file mode 100644
index 0000000..a1c8f24
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -0,0 +1,170 @@
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
+char *TCID = "vma02";
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
+#include <errno.h>
+
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
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
+	void *addr, *start, *end, *lastend;
+	int node, err, lc;
+	char buf[BUFSIZ];
+	struct bitmask *nmask = numa_allocate_nodemask();
+	char *msg;
+
+	pagesize = getpagesize();
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
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
+		addr = mmap(NULL, pagesize*3, PROT_WRITE,
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
+		if (err != 0) {
+			if (errno != ENOSYS)
+				tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+			else
+				tst_brkm(TCONF, NULL,
+					"mbind syscall not implemented on this system.");
+		}
+
+		/* second mbind */
+		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, NULL, "mbind2");
+
+		/* /proc/self/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+		fp = fopen("/proc/self/maps", "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, NULL, "fopen");
+
+		while (fgets(buf, BUFSIZ, fp) != NULL) {
+			if (sscanf(buf, "%p-%p ", &start, &end) != 2)
+				continue;
+
+			if (start == addr) {
+				tst_resm(TINFO, "start = %p, end = %p",
+					start, end);
+				if (end == addr + pagesize*3) {
+					tst_resm(TPASS, "only 1 VMA.");
+					break;
+				}
+
+				lastend = end;
+				while (fgets(buf, BUFSIZ, fp) != NULL) {
+					/* No more VMAs, break */
+					if (sscanf(buf, "%p-%p ", &start,
+						&end) != 2)
+						break;
+					tst_resm(TINFO, "start = %p, end = %p",
+						start, end);
+
+					/* more VMAs found */
+					if (start == lastend)
+						lastend = end;
+					if (end == addr + pagesize*3) {
+						tst_resm(TFAIL,
+							">1 unmerged VMAs.");
+						break;
+					}
+				}
+				if (end != addr + pagesize*3)
+					tst_resm(TFAIL, "no matched VMAs.");
+				break;
+			}
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
+#else /* libnuma v1 */
+int main(void) {
+	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
+}
+#endif
+#else /* no NUMA */
+int main(void) {
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



