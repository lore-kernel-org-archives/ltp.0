Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P5qfr-00059b-2t
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:02:35 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5qfq-0007ub-1b
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:02:35 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9D22SvR015027
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Oct 2010 22:02:28 -0400
Date: Tue, 12 Oct 2010 22:02:28 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <92362031.267291286935348328.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <50821116.267171286935261958.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] mmap/munmap /dev/zero
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

v2: incorporate comments from Mike and Garrett.

Add a new test to mmap/munmap /dev/zero. A common way of malloc()/free() anonymous memory on Solaris. Anyway, mmap() of /dev/zero results in calling map_zero() which on RHEL5 maps the ZERO_PAGE in every pte within that virtual address range. Since a application is also multi-threaded the subsequent munmap() of /dev/zero results is TLB shootdowns to all other CPUs.  When this happens thousands or millions of times the application performance is terrible. The mapping ZERO_PAGE in every pte within that virtual address range was an optimization to make the subsequent pagefault times faster on RHEL5 that has been removed/changed upstream.

Signed-off-by: CAI Qian <caiqian@redhat.com>

 testcases/kernel/syscalls/mmap/mmap10.c |  153 +++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)

--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -0,0 +1,153 @@
+/*
+ * mmap/munmap /dev/zero: a common way of malloc()/free() anonymous
+ * memory on Solaris. Anyway, mmap() of /dev/zero results in calling
+ * map_zero() which on RHEL5 maps the ZERO_PAGE in every pte within
+ * that virtual address range. Since a application is also
+ * multi-threaded the subsequent munmap() of /dev/zero results is TLB
+ * shootdowns to all other CPUs. When this happens thousands or
+ * millions of times the application performance is terrible. The
+ * mapping ZERO_PAGE in every pte within that virtual address range
+ * was an optimization to make the subsequent pagefault times faster
+ * on RHEL5 that has been removed/changed upstream.
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
+
+#include "test.h"
+#include "usctest.h"
+#include <errno.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <stdio.h>
+
+#define SIZE (5*1024*1024)
+
+char *TCID = "mmap10";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+/* main setup function of test */
+void setup(void);
+/* cleanup function for the test */
+void cleanup(void);
+int mmapzero(void);
+
+int main(int argc, char *argv[])
+{
+	/* loop counter */
+	int lc;
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, (option_t *) NULL, NULL);
+	if (msg != NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+
+	/* Perform global setup for test */
+	setup();
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		TEST(mmapzero());
+
+		if (TEST_RETURN != 0)
+			tst_resm(TFAIL, "mmapzero() failed with %ld.",
+				TEST_RETURN);
+		else
+			tst_resm(TPASS, "mmapzero() completed successfully.");
+	}
+
+	cleanup();
+	return 0;
+}
+
+int mmapzero(void)
+{
+	char *x;
+	int n;
+
+	x = mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (x == MAP_FAILED) {
+		tst_resm(TFAIL, "mmap: %s", strerror(errno));
+		return 1;
+	}
+	x[SIZE] = 0;
+	n = fork();
+	if (n == -1)
+		tst_brkm(TBROK, cleanup, "fork: %s", strerror(errno));
+	else if (n == 0) {
+		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+			tst_resm(TFAIL, "munmap: %s", strerror(errno));
+		_exit(0);
+	}
+	n = fork();
+	if (n == -1)
+		tst_brkm(TBROK, cleanup, "fork: %s", strerror(errno));
+	else if (n == 0) {
+		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+			tst_resm(TFAIL, "munmap: %s", strerror(errno));
+		_exit(0);
+	} else {
+		n = fork();
+		if (n == -1)
+			tst_brkm(TBROK, cleanup, "fork: %s", strerror(errno));
+		else if (n == 0) {
+			if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
+				tst_resm(TFAIL, "munmap: %s", strerror(errno));
+			_exit(0);
+		}
+	}
+	if (munmap(x, SIZE+SIZE-4096) == -1)
+		tst_resm(TFAIL, "munmap: %s", strerror(errno));
+	while (waitpid(-1, NULL, WNOHANG) > 0);
+	return 0;
+}
+
+void cleanup(void)
+{
+	/*
+	 * remove the tmp directory and exit
+	 */
+	TEST_CLEANUP;
+	tst_rmdir();
+	tst_exit();
+}
+
+
+void setup(void)
+{
+	/*
+	 * setup a default signal hander and a
+	 * temporary working directory.
+	 */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	tst_tmpdir();
+}

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
