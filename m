Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rrgat-0000GT-QS
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 02:03:43 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rrgas-0007EL-Vt
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 02:03:43 +0000
Received: by yhfq46 with SMTP id q46so1616825yhf.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 29 Jan 2012 18:03:37 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 30 Jan 2012 10:03:14 +0800
Message-Id: <1327888994-4884-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] mm/vma03: new testcase
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
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


vma03 - CVE-2011-2496 avoid wrapping vm_pgoff in mremap()

This is a reproducer for CVE-2011-2496.

The normal mmap paths all avoid creating a mapping where the pgoff
inside the mapping could wrap around due to overflow.  However, an
expanding mremap() can take such a non-wrapping mapping and make it
bigger and cause a wrapping condition. There is also another case
where we expand mappings hiding in plain sight: the automatic stack
expansion.

This program tries to remap a mapping with a new size that would
wrap pgoff. Notice that it only works on 32-bit arch for now.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/vma/vma03.c |  148 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vma/vma03.c


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-mm-vma03-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-vma03-new-testcase.patch"

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
new file mode 100644
index 0000000..4fb321c
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2012 Red Hat, Inc.
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
+ * This is a reproducer for CVE-2011-2496.
+ *
+ * The normal mmap paths all avoid creating a mapping where the pgoff
+ * inside the mapping could wrap around due to overflow.  However, an
+ * expanding mremap() can take such a non-wrapping mapping and make it
+ * bigger and cause a wrapping condition. There is also another case
+ * where we expand mappings hiding in plain sight: the automatic stack
+ * expansion.
+ *
+ * This program tries to remap a mapping with a new size that would
+ * wrap pgoff. Notice that it only works on 32-bit arch for now.
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "vma03";
+int TST_TOTAL = 1;
+
+#ifdef __NR_mmap2
+#define TESTFILE "testfile"
+
+static size_t pgsz;
+static int fd;
+
+static void *mmap2(void *addr, size_t length, int prot,
+		int flags, int fd, off_t pgoffset);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+	void *map, *remap;
+	off_t pgoff;
+
+#if __WORDSIZE != 32
+	tst_brkm(TCONF, NULL, "test is designed for 32-bit system only.");
+#endif
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	pgsz = sysconf(_SC_PAGE_SIZE);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		fd = open(TESTFILE, O_RDWR);
+		if (fd == -1)
+			tst_brkm(TBROK|TCONF, NULL, "open %s", TESTFILE);
+
+		pgoff = ULONG_MAX - 1;
+		map = mmap2(NULL, pgsz, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+				fd, pgoff);
+		if (map == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap2");
+
+		remap = mremap(map, pgsz, 2 * pgsz, 0);
+		if (remap == MAP_FAILED) {
+			if (errno == EINVAL)
+				tst_resm(TPASS,	"mremap failed as expected.");
+			else
+				tst_resm(TFAIL|TERRNO, "mremap");
+		} else {
+			tst_resm(TFAIL, "mremap succeeded unexpectedly.");
+		}
+
+		close(fd);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void *mmap2(void *addr, size_t length, int prot,
+		int flags, int fd, off_t pgoffset)
+{
+	return (void *)syscall(SYS_mmap2, addr, length, prot,
+			flags, fd, pgoffset);
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	fd = creat(TESTFILE, 0644);
+	if (fd == -1)
+		tst_brkm(TBROK|TCONF, NULL, "creat %s", TESTFILE);
+	close(fd);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+#else /* __NR_mmap2 */
+int main(int argc, char *argv[])
+{
+	tst_brkm(TCONF, NULL, "this test only runs on kernels that implements"
+			" mmap2 syscall");
+}
+#endif

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



