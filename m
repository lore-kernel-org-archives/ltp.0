Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PKqyw-0003DG-Nk
	for ltp-list@lists.sourceforge.net; Tue, 23 Nov 2010 11:24:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PKqyv-0003yz-Ed
	for ltp-list@lists.sourceforge.net; Tue, 23 Nov 2010 11:24:18 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oANBOB4x018654
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Nov 2010 06:24:11 -0500
Date: Tue, 23 Nov 2010 06:24:11 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1163307688.229311290511451623.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <197804608.229291290511437013.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13864_1925758309.1290511451622"
Subject: [LTP] [PATCH] mbind_range() vma merge
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

------=_Part_13864_1925758309.1290511451622
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is a reproducer from mainline commit
9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:

"Strangely, current mbind() doesn't merge vma with neighbor vma although
it's possible.  Unfortunately, many vma can reduce performance..."

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
------=_Part_13864_1925758309.1290511451622
Content-Type: text/x-patch; name=0001-mbind_range-vma-merge.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-mbind_range-vma-merge.patch

 testcases/kernel/mem/mbind/Makefile  |   25 ++++++
 testcases/kernel/mem/mbind/mbind01.c |  158 ++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/mbind/Makefile
 create mode 100644 testcases/kernel/mem/mbind/mbind01.c

diff --git a/testcases/kernel/mem/mbind/Makefile b/testcases/kernel/mem/mbind/Makefile
new file mode 100644
index 0000000..11aa2f9
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
+LDLIBS 			+= -lnuma
\ No newline at end of file
diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
new file mode 100644
index 0000000..32a8b68
--- /dev/null
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -0,0 +1,158 @@
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
+#include <numaif.h>
+#include <numa.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "mbind01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+static unsigned long pagesize;
+static int opt_node;
+static char *opt_nodestr;
+
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
+	int node;
+	struct bitmask *nmask = numa_allocate_nodemask();
+	int err;
+	char buf[BUFSIZ];
+	char start[BUFSIZ];
+	char end[BUFSIZ];
+	char string[BUFSIZ];
+	char *p;
+
+	/* message returned from parse_opts */
+	char *msg;
+
+	/* loop counter */
+	int lc;
+
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+	if (opt_node) {
+		node = strtol(optarg, NULL, 0);
+		numa_bitmask_setbit(nmask, node);
+	} else
+		numa_bitmask_setbit(nmask, 0);
+
+	pagesize = getpagesize();
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+			MAP_ANON|MAP_PRIVATE, 0, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, NULL, "mmap"), exit(1);
+
+		tst_resm(TINFO, "pid = %d", getpid());
+		tst_resm(TINFO, "addr = %p", addr);
+
+		/* make page populate */
+		memset(addr, 0, pagesize*3);
+
+		/* first mbind */
+		err = mbind(addr+pagesize, pagesize, MPOL_BIND,
+			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
+		if (err)
+			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+
+		/* second mbind */
+		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err)
+			tst_brkm(TBROK|TERRNO, NULL, "mbind2 ");
+
+		/* /proc/%d/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+		sprintf(buf, "/proc/%d/maps", getpid());
+		sprintf(string, "%lx", (long)addr);
+
+		fp = fopen(buf, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, NULL, "fopen");
+
+		while (fgets(buf, BUFSIZ, fp) != NULL) {
+			/* Find out the 1st VMA. */
+			p = strtok(buf, "-");
+			if (p == NULL)
+				continue;
+			
+			strcpy(start, p);
+			if (strcmp(string, start) != 0)
+				continue;
+
+			/* Get the end range of the 2nd VMA. */
+			p = strtok(NULL, " ");
+			strcpy(end, p);
+
+			/* Find out the second VMA. */
+			if (fgets(buf, BUFSIZ, fp) == NULL)
+				tst_brkm(TBROK|TERRNO, NULL, "fgets");
+
+			p = strtok(buf, "-");
+			if (p == NULL || strcmp(p, end) != 0)
+				tst_resm(TPASS, "only 1 VMA.");
+			else
+				tst_resm(TFAIL, "more than 1 VMA.");
+		}
+		if (fclose(fp) == EOF)
+			tst_brkm(TWARN|TERRNO, NULL, "fclose");
+
+		if (munmap(addr, pagesize*3) == -1)
+			tst_brkm(TWARN|TERRNO, NULL, "munmap");
+	}
+	return 0;
+}
+
+void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}
-- 
1.7.1


------=_Part_13864_1925758309.1290511451622
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
------=_Part_13864_1925758309.1290511451622
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_13864_1925758309.1290511451622--

