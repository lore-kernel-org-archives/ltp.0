Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PPrwG-0007CQ-RZ
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:26:16 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PPrwF-0000W3-5r
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:26:16 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB77Q9VP029177
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 02:26:09 -0500
Date: Tue, 7 Dec 2010 02:26:09 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1207663306.252961291706769042.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <492692237.252661291706460818.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v11] mmap/munmap /dev/zero
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
To: ltp-list <ltp-list@lists.sourceforge.net>

The basic purpose of this is a to test if it is possible to map and
unmap /dev/zero, and to read and write the mapping. Being inspired by
two bugs in the past, the design of the test was added some variations
based on the reproducers for them. It also accept an option to
mmap/munmap anonymous pages.

One is to trigger panic with transparent hugepage feature that
split_huge_page is very strict in checking the rmap walk was
perfect. Keep it strict because if page_mapcount isn't stable and just
right, the __split_huge_page_refcount that follows the rmap walk could
lead to erratic page_count()s for the subpages. The bug in fork lead
to the rmap walk finding the parent huge-pmd twice instead of just
one, because the anon_vma_chain objects of the child vma still point
to the vma->vm_mm of the parent. That trips on the split_huge_page
mapcount vs page_mapcount check leading to a BUG_ON.

The other bug is mmap() of /dev/zero results in calling map_zero()
which on RHEL5 maps the ZERO_PAGE in every PTE within that virtual
address range. Since the application which maps a region from 5M to
16M in size is also multi-threaded the subsequent munmap() of
/dev/zero results is TLB shootdowns to all other CPUs. When this
happens thousands or millions of times the application performance is
terrible. The mapping ZERO_PAGE in every pte within that virtual
address range was an optimization to make the subsequent pagefault
times faster on RHEL5 that has been removed/changed upstream.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v11: more code cleanup
v10: code cleanup
v9:  add the tests to runtest/mm.
v8:  add an option to utilize KSM; no need to open /dev/zero for
     anonymous page testing.
v7:  another "(void)" fix
v6:  really use git format; check return from children; cleanup.
v5:  add an option to test anonymous pages; move open() into setup().
v4:  comment fix; code cleanup.
v3:  really mmap /dev/zero; replace _exit() with exit(); fix patch
     format.
v2:  incorporate comments from Mike and Garrett.
---
 runtest/mm                              |    5 +
 testcases/kernel/syscalls/mmap/mmap10.c |  179 +++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap10.c

diff --git a/runtest/mm b/runtest/mm
index 2f3f407..36550d2 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -54,3 +54,8 @@ mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
+mmap10 mmap10
+mmap10_1 mmap10 -a
+mmap10_2 mmap10 -s
+mmap10_3 mmap10 -a -s
+mmap10_4 mmap10 -a -s -c 60
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
new file mode 100644
index 0000000..fe9d622
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -0,0 +1,179 @@
+/*
+ * mmap/munmap /dev/zero: a common way of malloc()/free() anonymous
+ * memory on Solaris.
+ *
+ * The basic purpose of this is a to test if it is possible to map and
+ * unmap /dev/zero, and to read and write the mapping. Being inspired
+ * by two bugs in the past, the design of the test was added some
+ * variations based on the reproducers for them. It also accept an
+ * option to mmap/munmap anonymous pages.
+ *
+ * One is to trigger panic with transparent hugepage feature that
+ * split_huge_page is very strict in checking the rmap walk was
+ * perfect. Keep it strict because if page_mapcount isn't stable and
+ * just right, the __split_huge_page_refcount that follows the rmap
+ * walk could lead to erratic page_count()s for the subpages. The bug
+ * in fork lead to the rmap walk finding the parent huge-pmd twice
+ * instead of just one, because the anon_vma_chain objects of the
+ * child vma still point to the vma->vm_mm of the parent. That trips
+ * on the split_huge_page mapcount vs page_mapcount check leading to a
+ * BUG_ON.
+ *
+ * The other bug is mmap() of /dev/zero results in calling map_zero()
+ * which on RHEL5 maps the ZERO_PAGE in every PTE within that virtual
+ * address range. Since the application which maps a region from 5M to
+ * 16M in size is also multi-threaded the subsequent munmap() of
+ * /dev/zero results is TLB shootdowns to all other CPUs. When this
+ * happens thousands or millions of times the application performance
+ * is terrible. The mapping ZERO_PAGE in every pte within that virtual
+ * address range was an optimization to make the subsequent pagefault
+ * times faster on RHEL5 that has been removed/changed upstream.
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
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include "test.h"
+#include "usctest.h"
+
+#define SIZE (5*1024*1024)
+
+char *TCID = "mmap10";
+int TST_TOTAL = 1;
+extern int Tst_count;
+static int fd, opt_anon, opt_ksm;
+
+void setup(void);
+void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+void mmapzero(void);
+void help(void);
+
+static option_t options[] = {
+	{ "a", &opt_anon,   NULL},
+	{ "s", &opt_ksm,    NULL},
+	{ NULL, NULL,       NULL}
+};
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "start tests.");
+		mmapzero();
+	}
+	cleanup();
+}
+
+void mmapzero(void)
+{
+	char *x;
+	int n;
+
+	if (opt_anon) {
+		tst_resm(TINFO, "use anonymous pages.");
+		x = mmap(NULL, SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	} else {
+		tst_resm(TINFO, "use /dev/zero.");
+		if ((fd = open("/dev/zero", O_RDWR, 0666)) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		x = mmap(NULL, SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
+	}
+	if (x == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	if (opt_ksm) {
+		tst_resm(TINFO, "add to KSM regions.");
+		if (madvise(x, SIZE+SIZE-4096, MADV_MERGEABLE) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+	}
+	x[SIZE] = 0;
+
+	switch(n = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+		exit(0);
+	default:
+		break;
+	}
+	switch(n = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+		exit(0);
+	default:
+		switch (n = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+			exit(0);
+		default:
+			break;
+		}
+		break;
+	}
+	if (munmap(x, SIZE+SIZE-4096) == -1)
+		tst_resm(TFAIL|TERRNO, "munmap");
+	while (waitpid(-1, &n, WUNTRACED | WCONTINUED) > 0)
+		if (WEXITSTATUS(n) != 0)
+			tst_resm(TFAIL, "child exit status is %d",
+				WEXITSTATUS(n));
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void help(void)
+{
+	printf("  -a      Test anonymous pages\n");
+	printf("  -s      Add to KSM regions\n");
+}
-- 
1.7.3.2

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
