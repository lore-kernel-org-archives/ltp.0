Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P5fVk-0002MB-66
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 14:07:24 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5fVi-0007Pf-LL
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 14:07:23 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9CE7GjN011875
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Oct 2010 10:07:16 -0400
Date: Tue, 12 Oct 2010 10:07:16 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <63954223.194911286892436382.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mmap/munmap /dev/zero
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

Add a new test to mmap/munmap /dev/zero.

Signed-off-by: CAI Qian <caiqian@redhat.com>

--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -0,0 +1,131 @@
+/*
+ * mmap/munmap /dev/zero
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
+void setup();
+/* cleanup function for the test */
+void cleanup();
+int mmapzero();
+
+
+int main(int ac, char **av)
+{
+	/* loop counter */
+	int lc;
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(ac, av, (option_t *) NULL, NULL);
+	if (msg != (char *)NULL) {
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
+		if(TEST_RETURN != 0)
+			tst_resm(TFAIL, "mmapzero() failed with %ld.",
+				TEST_RETURN);
+		else
+			tst_resm(TPASS, "mmapzero() completed successfully.");
+	 }
+
+	 cleanup();
+	 return 0;
+ }
+
+ int mmapzero()
+ {
+	 char *x;
+
+	 x = mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	 if (x == MAP_FAILED) {
+		 perror("error");
+		 return 1;
+	 }
+	 x[SIZE] = 0;
+	 if (!fork()) {
+		 munmap(x + SIZE+4096, SIZE-4096*2);
+		 _exit(0);
+	 }
+	 if (!fork()) {
+		 if (!fork()) {
+			 munmap(x + SIZE+4096, SIZE-4096*2);
+			 _exit(0);
+		 }
+		 munmap(x + SIZE+4096, SIZE-4096*2);
+		 _exit(0);
+	 }
+	 munmap(x, SIZE+SIZE-4096);
+	 while (waitpid(-1, NULL, WNOHANG) > 0);
+	 return 0;
+ }
+
+ void cleanup()
+ {
+	 /*
+	  * remove the tmp directory and exit
+	  */
+	 TEST_CLEANUP;
+	 tst_rmdir();
+	 tst_exit();
+
+ }
+
+
+void setup()
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
