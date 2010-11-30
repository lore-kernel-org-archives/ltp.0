Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PNNPV-0003TG-Ri
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 10:26:09 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNNPU-0003Mh-De
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 10:26:09 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAUAQ2Sh004426
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Nov 2010 05:26:02 -0500
Date: Tue, 30 Nov 2010 05:26:02 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <2137584473.757721291112762914.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1311381980.757701291112760305.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43126_1437958652.1291112762913"
Subject: [LTP] [PATCH v2] mbind_range() vma merge
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

------=_Part_43126_1437958652.1291112762913
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is a reproducer from mainline commit
9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:

"Strangely, current mbind() doesn't merge vma with neighbor vma although
it's possible.  Unfortunately, many vma can reduce performance..."

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: add mbind01 to the mm test list; avoid breakage on systems without
    proper numa libs; code cleanup; fix -lnuma.

 runtest/mm                           |    2 +
 testcases/kernel/mem/mbind/Makefile  |   25 ++++++
 testcases/kernel/mem/mbind/mbind01.c |  150 ++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/mbind/Makefile
 create mode 100644 testcases/kernel/mem/mbind/mbind01.c

diff --git a/runtest/mm b/runtest/mm
index cf16c0e..16e60d4 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -68,3 +68,5 @@ hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
 
 cpuset01 cpuset01 -I 3600
+
+mbind01 mbind01
diff --git a/testcases/kernel/mem/mbind/Makefile b/testcases/kernel/mem/mbind/Makefile
new file mode 100644
index 0000000..e202a6b
--- /dev/null
+++ b/testcases/kernel/mem/mbind/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= $(NUMA_LIBS)
\ No newline at end of file
diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
new file mode 100644
index 0000000..a218ad7
--- /dev/null
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -0,0 +1,150 @@
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
+char *TCID = "mbind01";
+int TST_TOTAL = 1;
+extern int Tst_count;
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
+		tst_brkm(TBROK, tst_exit,
+			"OPTION PARSING ERROR - %s", msg);
+	if (opt_node) {
+		node = atoi(optarg);
+		if (node < 1)
+			tst_brkm(TBROK, tst_exit,
+				"Number of NUMA nodes cannot be less "
+				"that 1.");
+		numa_bitmask_setbit(nmask, node);
+	} else
+		numa_bitmask_setbit(nmask, 0);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+			MAP_ANON|MAP_PRIVATE, 0, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+
+		tst_resm(TINFO, "pid = %d addr = %p", getpid(), addr);
+
+		/* make page populate */
+		memset(addr, 0, pagesize*3);
+
+		/* first mbind */
+		err = mbind(addr+pagesize, pagesize, MPOL_BIND,
+			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mbind1");
+
+		/* second mbind */
+		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mbind2 ");
+
+		/* /proc/%d/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+
+		sprintf(buf, "/proc/%d/maps", getpid());
+		sprintf(string, "%p", addr);
+
+		fp = fopen(buf, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, tst_exit, "fopen %s",
+				buf);
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
+
+		if (munmap(addr, pagesize*3) == -1)
+			tst_brkm(TWARN|TERRNO, tst_exit, "munmap");
+	}
+	return 0;
+}
+void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.1
------=_Part_43126_1437958652.1291112762913
Content-Type: text/x-patch; name=0005-mbind_range-vma-merge.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0005-mbind_range-vma-merge.patch

From: CAI Qian <caiqian@redhat.com>
Date: Tue, 30 Nov 2010 17:43:57 +0800
Subject: [PATCH v2] mbind_range() vma merge

This is a reproducer from mainline commit
9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:

"Strangely, current mbind() doesn't merge vma with neighbor vma although
it's possible.  Unfortunately, many vma can reduce performance..."

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: add mbind01 to the mm test list; avoid breakage on systems without
    proper numa libs; code cleanup; fix -lnuma.

 runtest/mm                           |    2 +
 testcases/kernel/mem/mbind/Makefile  |   25 ++++++
 testcases/kernel/mem/mbind/mbind01.c |  150 ++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/mbind/Makefile
 create mode 100644 testcases/kernel/mem/mbind/mbind01.c

diff --git a/runtest/mm b/runtest/mm
index cf16c0e..16e60d4 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -68,3 +68,5 @@ hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
 
 cpuset01 cpuset01 -I 3600
+
+mbind01 mbind01
diff --git a/testcases/kernel/mem/mbind/Makefile b/testcases/kernel/mem/mbind/Makefile
new file mode 100644
index 0000000..e202a6b
--- /dev/null
+++ b/testcases/kernel/mem/mbind/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= $(NUMA_LIBS)
\ No newline at end of file
diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
new file mode 100644
index 0000000..a218ad7
--- /dev/null
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -0,0 +1,150 @@
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
+char *TCID = "mbind01";
+int TST_TOTAL = 1;
+extern int Tst_count;
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
+		tst_brkm(TBROK, tst_exit,
+			"OPTION PARSING ERROR - %s", msg);
+	if (opt_node) {
+		node = atoi(optarg);
+		if (node < 1)
+			tst_brkm(TBROK, tst_exit,
+				"Number of NUMA nodes cannot be less "
+				"that 1.");
+		numa_bitmask_setbit(nmask, node);
+	} else
+		numa_bitmask_setbit(nmask, 0);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+			MAP_ANON|MAP_PRIVATE, 0, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+
+		tst_resm(TINFO, "pid = %d addr = %p", getpid(), addr);
+
+		/* make page populate */
+		memset(addr, 0, pagesize*3);
+
+		/* first mbind */
+		err = mbind(addr+pagesize, pagesize, MPOL_BIND,
+			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mbind1");
+
+		/* second mbind */
+		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err != 0)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mbind2 ");
+
+		/* /proc/%d/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+
+		sprintf(buf, "/proc/%d/maps", getpid());
+		sprintf(string, "%p", addr);
+
+		fp = fopen(buf, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, tst_exit, "fopen %s",
+				buf);
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
+
+		if (munmap(addr, pagesize*3) == -1)
+			tst_brkm(TWARN|TERRNO, tst_exit, "munmap");
+	}
+	return 0;
+}
+void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.1


------=_Part_43126_1437958652.1291112762913
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_43126_1437958652.1291112762913
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_43126_1437958652.1291112762913--

