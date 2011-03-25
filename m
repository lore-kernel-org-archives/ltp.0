Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q37Ui-0000YR-UZ
	for ltp-list@lists.sourceforge.net; Fri, 25 Mar 2011 13:56:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q37Uh-0000bH-LI
	for ltp-list@lists.sourceforge.net; Fri, 25 Mar 2011 13:56:04 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2PDtvuJ017585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Mar 2011 09:55:57 -0400
From: czhang@redhat.com
Date: Fri, 25 Mar 2011 21:55:51 +0800
Message-Id: <1301061351-20787-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH] mem test items cleanup
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
To: ltp-list@lists.sourceforge.net
Cc: Caspar Zhang <czhang@redhat.com>

From: Caspar Zhang <czhang@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


I found several problems of the tests in mem/ dir: mlock test should be
in syscalls/ dir; hugemmap05 test should be executed with other hugetlb
tests together.

So I made some changes to do the cleanup.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/hugetlb                           |    4 +
 runtest/mm                                |    9 +--
 runtest/syscalls                          |    5 +-
 testcases/kernel/mem/mlock/Makefile       |   23 ------
 testcases/kernel/mem/mlock/mlock01.c      |  105 ----------------------------
 testcases/kernel/syscalls/mlock/mlock04.c |  108 +++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 138 deletions(-)
 delete mode 100644 testcases/kernel/mem/mlock/Makefile
 delete mode 100644 testcases/kernel/mem/mlock/mlock01.c
 create mode 100644 testcases/kernel/syscalls/mlock/mlock04.c


--------------1.7.4.1
Content-Type: text/x-patch; name="0001-mem-test-items-cleanup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mem-test-items-cleanup.patch"

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 1347f32..af45868 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -2,6 +2,10 @@ hugemmap01 hugemmap01 -H/tmp
 hugemmap02 hugemmap02 -H/tmp -c10
 hugemmap03 hugemmap03 -H/tmp -I2 -c10
 hugemmap04 hugemmap04 -H/tmp
+hugemmap05 hugemmap05
+hugemmap05_1 hugemmap05 -m
+hugemmap05_2 hugemmap05 -s
+hugemmap05_3 hugemmap05 -s -m
 
 hugeshmat01 hugeshmat01 -i 5
 hugeshmat02 hugeshmat02 -i 5
diff --git a/runtest/mm b/runtest/mm
index 0633e14..f2d50d6 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -59,6 +59,7 @@ mmap10_1 mmap10 -a
 mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -i 60
+mmap10_5 mmap10 -a -s -c 200
 
 ksm01 ksm01
 ksm01_1 ksm01 -u 128
@@ -69,16 +70,8 @@ ksm03_1 ksm03 -u 128
 ksm04 ksm04
 ksm04_1 ksm04 -u 128
 
-hugemmap05 hugemmap05
-hugemmap05_1 hugemmap05 -m
-hugemmap05_2 hugemmap05 -s
-hugemmap05_3 hugemmap05 -s -m
-
 cpuset01 cpuset01 -I 3600
 
-mlock01 mlock01
-mlock03 mlock03 -i 20
-
 mbind01 mbind01
 
 oom01 oom01
diff --git a/runtest/syscalls b/runtest/syscalls
index 3bd9c50..4294d07 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -541,6 +541,8 @@ mknodat01 cd $LTPROOT/testcases/bin && chown root mknodat01 && chmod 04755 mknod
 
 mlock01 mlock01
 mlock02 mlock02
+mlock03 mlock03 -i 20
+mlock04 mlock04
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
@@ -552,6 +554,7 @@ mmap06 mmap06
 mmap07 mmap07
 mmap08 mmap08
 mmap09 mmap09
+mmap11 mmap11 -i 30000
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
@@ -1290,5 +1293,3 @@ writev03 writev03
 writev04 writev04
 writev05 writev05
 writev06 writev06
-
-mmap11 mmap11 -i 30000
diff --git a/testcases/kernel/mem/mlock/Makefile b/testcases/kernel/mem/mlock/Makefile
deleted file mode 100644
index dbfbc1b..0000000
--- a/testcases/kernel/mem/mlock/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-#  Copyright (C) 2010  Red Hat, Inc.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or (at
-#  your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-#  02110-1301, USA.
-#
-
-top_srcdir              ?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/mlock/mlock01.c b/testcases/kernel/mem/mlock/mlock01.c
deleted file mode 100644
index 33b9194..0000000
--- a/testcases/kernel/mem/mlock/mlock01.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * This is a reproducer copied from one of LKML patch submission,
- * which subject is
- *
- * [PATCH] mlock: revert the optimization for dirtying pages and triggering writeback.
- *
- * "In 5ecfda0, we do some optimization in mlock, but it causes
- * a very basic test case(attached below) of mlock to fail. So
- * this patch revert it with some tiny modification so that it
- * apply successfully with the lastest 38-rc2 kernel."
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#include "test.h"
-#include "usctest.h"
-#include "config.h"
-
-char *TCID = "mlock01";
-int TST_TOTAL = 1;
-
-#include <sys/mman.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/types.h>
-
-int fd, file_len = 40960;
-char *testfile = "test_mmap";
-
-static void cleanup(void)
-{
-	TEST_CLEANUP;
-	
-	close(fd);
-
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	tst_tmpdir();
-
-	fd = open(testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open");
-
-	if (ftruncate(fd, file_len) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "ftruncate");
-
-	TEST_PAUSE;
-}
-
-int main(void)
-{
-	char *buf;
-	int lc;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		buf = mmap(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
-
-		if (buf == MAP_FAILED)
-			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
-
-		if (mlock(buf, file_len) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "mlock");
-
-		tst_resm(TINFO, "locked %d bytes from %p", file_len, buf);
-
-		if (munlock(buf, file_len) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "munlock");
-
-		if (munmap(buf, file_len) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
-	}
-
-	tst_resm(TPASS, "mlock01 pass");
-
-	cleanup();
-
-	tst_exit();
-}
diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
new file mode 100644
index 0000000..7ee0e8d
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -0,0 +1,108 @@
+/*
+ * This is a reproducer copied from one of LKML patch submission,
+ * which subject is
+ *
+ * [PATCH] mlock: revert the optimization for dirtying pages and triggering writeback.
+ *
+ * "In 5ecfda0, we do some optimization in mlock, but it causes
+ * a very basic test case(attached below) of mlock to fail. So
+ * this patch revert it with some tiny modification so that it
+ * apply successfully with the lastest 38-rc2 kernel."
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
+char *TCID = "mlock04";
+int TST_TOTAL = 1;
+
+#include <sys/mman.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+int fd, file_len = 40960;
+char *testfile = "test_mlock";
+
+static void setup(void);
+static void cleanup(void);
+
+int main(void)
+{
+	char *buf;
+	int lc;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		buf = mmap(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
+
+		if (buf == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+
+		if (mlock(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "mlock");
+
+		tst_resm(TINFO, "locked %d bytes from %p", file_len, buf);
+
+		if (munlock(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munlock");
+
+		if (munmap(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+	}
+
+	tst_resm(TPASS, "test succeeded.");
+
+	cleanup();
+
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_tmpdir();
+
+	fd = open(testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	if (ftruncate(fd, file_len) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "ftruncate");
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	close(fd);
+
+	tst_rmdir();
+}

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



