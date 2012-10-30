Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1TT1Ey-0007iu-Sh
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 02:07:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TT1Ex-0008MO-TH
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 02:07:40 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9U27XKw028386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Oct 2012 22:07:33 -0400
From: cxie@redhat.com
Date: Tue, 30 Oct 2012 10:07:26 +0800
Message-Id: <1351562846-3321-1-git-send-email-cxie@redhat.com>
Subject: [LTP] [PATCH v2] thp/thp03: new testcase
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
Commit: 59af0d4348eb07087097e310f60422b994dd3a2c
pmd_present would return the wrong value on PROT_NONE ranges or in case
of a non reproducible race with split_huge_page.

The system will crash when this test failed.

Signed-off-by: Madper Xie <cxie@redhat.com>
---
 runtest/mm                       |   1 +
 testcases/kernel/mem/thp/thp03.c | 121 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 testcases/kernel/mem/thp/thp03.c

diff --git a/runtest/mm b/runtest/mm
index 2dd66f0..0f59ef7 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -82,6 +82,7 @@ swapping01 swapping01 -i 5
 
 thp01 thp01 -I 120
 thp02 thp02
+thp03 thp03
 
 vma01 vma01
 vma02 vma02
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
new file mode 100644
index 0000000..93a0689
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -0,0 +1,121 @@
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
+ * Modified form a reproducer for
+ *          https://patchwork.kernel.org/patch/1358441/
+ * Commit: 59af0d4348eb07087097e310f60422b994dd3a2c
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
+int TST_TOTAL = 1;
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
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
