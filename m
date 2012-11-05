Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TVKhc-0001kK-DE
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 11:18:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TVKhW-0004v3-OR
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 11:18:48 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA5BIaVS017303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Nov 2012 06:18:36 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id qA5BIZVs005397
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Nov 2012 06:18:36 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  5 Nov 2012 12:18:33 +0100
Message-Id: <fef9ce5fc2abe348ad30da745eabbf9c92c4d01e.1352114181.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] mremap: add new test mremap05
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

New mremap syscall testcase targeting flag MREMAP_FIXED.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                            |    1 +
 testcases/kernel/syscalls/.gitignore        |    1 +
 testcases/kernel/syscalls/mremap/mremap05.c |  248 +++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 78f3bd3..e2f6b84 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -606,6 +606,7 @@ mremap01 mremap01
 mremap02 mremap02
 mremap03 mremap03
 mremap04 mremap04
+mremap05 mremap05
 
 msgctl01 msgctl01
 msgctl02 msgctl02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index a146eee..16a45be 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -543,6 +543,7 @@
 /mremap/mremap02
 /mremap/mremap03
 /mremap/mremap04
+/mremap/mremap05
 /msync/msync01
 /msync/msync02
 /msync/msync03
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
new file mode 100644
index 0000000..793c404
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -0,0 +1,248 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
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
+ */
+/*
+ * Test Name: mremap05
+ *
+ * Test Description:
+ *  Verify that MREMAP_FIXED fails without MREMAP_MAYMOVE.
+ *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if target address
+ *    is not page aligned.
+ *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if old range
+ *    overlaps with new range.
+ *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE can move mapping to new address.
+ *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE unmaps previous mapping
+ *    at the address range specified by new_address and new_size.
+ */
+
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <errno.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "mremap05";
+
+struct test_case_t {
+	char *old_address;
+	char *new_address;
+	size_t old_size;        /* in pages */
+	size_t new_size;        /* in pages */
+	int flags;
+	const char *msg;
+	void *exp_ret;
+	int exp_errno;
+	char *ret;
+	void (*setup)(struct test_case_t *);
+	void (*cleanup)(struct test_case_t *);
+};
+
+static void setup(void);
+static void cleanup(void);
+static void setup0(struct test_case_t *);
+static void setup1(struct test_case_t *);
+static void setup2(struct test_case_t *);
+static void setup3(struct test_case_t *);
+static void setup4(struct test_case_t *);
+static void cleanup0(struct test_case_t *);
+static void cleanup1(struct test_case_t *);
+
+struct test_case_t tdat[] = {
+	{
+		.old_size = 1,
+		.new_size = 1,
+		.flags = MREMAP_FIXED,
+		.msg = "MREMAP_FIXED requires MREMAP_MAYMOVE",
+		.exp_ret = MAP_FAILED,
+		.exp_errno = EINVAL,
+		.setup = setup0,
+		.cleanup = cleanup0
+	},
+	{
+		.old_size = 1,
+		.new_size = 1,
+		.flags = MREMAP_FIXED|MREMAP_MAYMOVE,
+		.msg = "new_addr has to be page aligned",
+		.exp_ret = MAP_FAILED,
+		.exp_errno = EINVAL,
+		.setup = setup1,
+		.cleanup = cleanup0
+	},
+	{
+		.old_size = 2,
+		.new_size = 1,
+		.flags = MREMAP_FIXED|MREMAP_MAYMOVE,
+		.msg = "old/new area must not overlap",
+		.exp_ret = MAP_FAILED,
+		.exp_errno = EINVAL,
+		.setup = setup2,
+		.cleanup = cleanup0
+	},
+	{
+		.old_size = 1,
+		.new_size = 1,
+		.flags = MREMAP_FIXED|MREMAP_MAYMOVE,
+		.msg = "mremap #1",
+		.setup = setup3,
+		.cleanup = cleanup0
+	},
+	{
+		.old_size = 1,
+		.new_size = 1,
+		.flags = MREMAP_FIXED|MREMAP_MAYMOVE,
+		.msg = "mremap #2",
+		.setup = setup4,
+		.cleanup = cleanup1
+	},
+};
+
+static int pagesize;
+static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+
+static void free_test_area(void *p, int size)
+{
+	if (munmap(p, size) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "free_test_area munmap");
+}
+
+static void *get_test_area(int size, int free_area)
+{
+	void *p;
+	p = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
+		0, 0);
+	if (p == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_test_area mmap");
+	if (free_area)
+		free_test_area(p, size);
+	return p;
+}
+
+static void test_mremap(struct test_case_t *t)
+{
+	t->ret = mremap(t->old_address, t->old_size, t->new_size, t->flags,
+		t->new_address);
+
+	if (t->ret == t->exp_ret) {
+		if (t->ret != MAP_FAILED) {
+			tst_resm(TPASS, "%s", t->msg);
+			if (*(t->ret) == 0x1)
+				tst_resm(TPASS, "%s value OK", t->msg);
+			else
+				tst_resm(TPASS, "%s value failed", t->msg);
+		} else {
+			if (errno == t->exp_errno)
+				tst_resm(TPASS, "%s", t->msg);
+			else
+				tst_resm(TFAIL|TERRNO, "%s", t->msg);
+		}
+	} else {
+		tst_resm(TFAIL, "%s ret: %p, expected: %p", t->msg,
+				t->ret, t->exp_ret);
+	}
+}
+
+static void setup0(struct test_case_t *t)
+{
+	t->old_address = get_test_area(t->old_size*pagesize, 0);
+	t->new_address = get_test_area(t->new_size*pagesize, 1);
+}
+
+static void setup1(struct test_case_t *t)
+{
+	t->old_address = get_test_area(t->old_size*pagesize, 0);
+	t->new_address = get_test_area((t->new_size + 1)*pagesize, 1) + 1;
+}
+
+static void setup2(struct test_case_t *t)
+{
+	t->old_address = get_test_area(t->old_size*pagesize, 0);
+	t->new_address = t->old_address;
+}
+
+static void setup3(struct test_case_t *t)
+{
+	t->old_address = get_test_area(t->old_size*pagesize, 0);
+	t->new_address = get_test_area(t->new_size*pagesize, 1);
+	t->exp_ret = t->new_address;
+	*(t->old_address) = 0x1;
+}
+
+static void setup4(struct test_case_t *t)
+{
+	t->old_address = get_test_area(t->old_size*pagesize, 0);
+	t->new_address = get_test_area(t->new_size*pagesize, 0);
+	t->exp_ret = t->new_address;
+	*(t->old_address) = 0x1;
+	*(t->new_address) = 0x2;
+}
+
+static void cleanup0(struct test_case_t *t)
+{
+	if (t->ret == MAP_FAILED)
+		free_test_area(t->old_address, t->old_size*pagesize);
+	else
+		free_test_area(t->ret, t->new_size*pagesize);
+}
+
+static void cleanup1(struct test_case_t *t)
+{
+	if (t->ret == MAP_FAILED) {
+		free_test_area(t->old_address, t->old_size*pagesize);
+		free_test_area(t->new_address, t->new_size*pagesize);
+	} else {
+		free_test_area(t->ret, t->new_size*pagesize);
+	}
+}
+
+int main(int ac, char **av)
+{
+	char *msg;
+	int lc, testno;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		for (testno = 0; testno < TST_TOTAL; testno++) {
+			tdat[testno].setup(&tdat[testno]);
+			test_mremap(&tdat[testno]);
+			tdat[testno].cleanup(&tdat[testno]);
+		}
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	pagesize = getpagesize();
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.7.1


------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
