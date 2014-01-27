Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1W7nPU-0007Zn-J2
	for ltp-list@lists.sourceforge.net; Mon, 27 Jan 2014 14:43:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W7nPN-0007Be-Iv
	for ltp-list@lists.sourceforge.net; Mon, 27 Jan 2014 14:43:36 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0REhM57023319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Jan 2014 09:43:22 -0500
From: Madper Xie <cxie@redhat.com>
Date: Mon, 27 Jan 2014 22:43:17 +0800
Message-ID: <87vbx532pm.fsf@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] syscalls/fork: add new case fork14
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
To: LTP <ltp-list@lists.sourceforge.net>


This testcase is a reproducer for https://lkml.org/lkml/2012/4/24/328.
Modified from Siddhesh Poyarekar's testcase posted on above link.
Since vma length in dup_mmap is calculated and stored in a unsigned
int, which is insufficient and hence overflows for very large maps
(beyond 16TB). Once overflow occurred, the fork after mmaped memory >
16TB will succeed incorrectly.

    This case will run following loop:
             + mmap one (more) GB memory
             + fork and check return value.
    When mmaped more than 16 * 1024 GB, it will check if fork still fail.
    Expected result: Fork failed even if mmaped memory > 16 * 1024 GB

The issue has been fixed by:
  commit 7edc8b0ac16cbaed7cb4ea4c6b95ce98d2997e84
  Author: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
    mm/fork: fix overflow in vma length when copying mmap on clone

Signed-off-by: Madper Xie <cxie@redhat.com>
---
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/fork/fork14.c | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fork/fork14.c

diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..4cf90e8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -277,6 +277,7 @@ fork09 fork09
 fork10 fork10
 fork11 fork11
 fork13 fork13 -i 1000000
+fork14 fork14
 
 fpathconf01 fpathconf01
 
diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
new file mode 100644
index 0000000..65d124b
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -0,0 +1,118 @@
+/*********************************************************************
+ * Copyright (C) 2014  Red Hat, Inc.
+ *
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
+ * This test is a reporducer for this patch:
+ *              https://lkml.org/lkml/2012/4/24/328
+ * Since vma length in dup_mmap is calculated and stored in a unsigned
+ * int, it will overflow when length of mmaped memory > 16 TB. When
+ * overflow occur, fork will  incorrectly succeed. The patch above
+ * fixed it.
+ ********************************************************************/
+
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork14";
+int TST_TOTAL = 1;
+
+#define GB		(1024 * 1024 * 1024L)
+
+/* set mmap threshold to 16TB */
+#define LARGE		(16 * 1024)
+#define EXTENT		(16 * 1024 + 10)
+
+static void setup(void);
+static void cleanup(void);
+static int  fork_test(void);
+
+int main(int ac, char **av)
+{
+	int lc, ret;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+/*
+ * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
+ * Since a 32bit program can't mmap so many memory.
+ */
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
+#endif
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		ret = fork_test();
+		if (ret == 0)
+			tst_resm(TPASS, "fork failed as expected.");
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
+
+static int fork_test(void)
+{
+	int i, ret = 0;
+	void *addr;
+
+	for (i = 0; i < EXTENT; i++) {
+		addr = mmap(NULL, (size_t) 1 * GB, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+		switch (fork()) {
+		case -1:
+			break;
+		case 0:
+			exit(0);
+		default:
+			if (waitpid(-1, NULL, 0) == -1)
+				tst_brkm(TBROK|TERRNO,
+					cleanup, "waitpid");
+
+			if (i >= LARGE) {
+				tst_brkm(TFAIL, NULL,
+					"Fork succeeds incorrectly");
+				ret++;
+			}
+		}
+	}
+	return ret;
+}
-- 
1.8.5.3


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
