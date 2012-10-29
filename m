Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1TSlen-00070l-8I
	for ltp-list@lists.sourceforge.net; Mon, 29 Oct 2012 09:29:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TSlej-000132-3d
	for ltp-list@lists.sourceforge.net; Mon, 29 Oct 2012 09:29:17 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9T9T7Qs030121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Oct 2012 05:29:07 -0400
From: cxie@redhat.com
Date: Mon, 29 Oct 2012 17:29:00 +0800
Message-Id: <1351502940-20415-1-git-send-email-cxie@redhat.com>
Subject: [LTP] [PATCH] thp/thp03: new testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: Madper Xie <cxie@redhat.com>

Modified form a reproducer for
           https://patchwork.kernel.org/patch/1358441/
pmd_present would return the wrong value on PROT_NONE ranges or in case
of a non reproducible race with split_huge_page.

The system will crash when this test failed.

Signed-off-by: Madper Xie <cxie@redhat.com>
---
 testcases/kernel/mem/thp/thp03.c | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 testcases/kernel/mem/thp/thp03.c

diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
new file mode 100644
index 0000000..ee6fa1e
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2012  Red Hat, Inc.
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
+ *
+ * thp03 - Case for spliting unaligned memory.
+ *       - System will panic if failed.
+ *
+ * There was a bug in THP, will crash happened due to the following
+ * reason according to developers:
+ *
+ * most VM places are using pmd_none but a few are still using
+ * pmd_present. The meaning is about the same for the pmd. However
+ * pmd_present would return the wrong value on PROT_NONE ranges or in
+ * case of a non reproducible race with split_huge_page.
+ * When the code using pmd_present gets a false negative, the kernel will
+ * crash. It's just an annoying DoS with a BUG_ON triggering: no memory
+ * corruption and no data corruption (nor userland nor kernel).
+ */
+
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include "mem.h"
+#include "safe_macros.h"
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "thp03";
+
+static void thp_test(void);
+
+static long hugepage_size;
+static long unaligned_size;
+static long page_size;
+
+int main(int argc, char **argv)
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		thp_test();
+	}
+	tst_resm(TPASS, "system didn't crash, pass.");
+	cleanup();
+	tst_exit();
+}
+
+static void thp_test(void)
+{
+	void *p;
+
+	p = mmap(NULL, unaligned_size, PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (p == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+
+	memset(p, 0x00, unaligned_size);
+	if (mprotect(p, unaligned_size, PROT_NONE) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mprotect");
+	if (madvise(p + hugepage_size, page_size, MADV_MERGEABLE) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+
+	switch (fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		exit(0);
+	default:
+		if (waitpid(-1, NULL, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	}
+}
+
+void setup(void)
+{
+	hugepage_size = read_meminfo("Hugepagesize:") * KB;
+	unaligned_size = hugepage_size * 4 - 1;
+	page_size = SAFE_SYSCONF(NULL, _SC_PAGESIZE);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.8.0


------------------------------------------------------------------------------
The Windows 8 Center - In partnership with Sourceforge
Your idea - your app - 30 days.
Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
