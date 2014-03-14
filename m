Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WOOjf-0001Rj-N3
	for ltp-list@lists.sourceforge.net; Fri, 14 Mar 2014 09:49:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WOOjd-0006Kz-R6
	for ltp-list@lists.sourceforge.net; Fri, 14 Mar 2014 09:49:03 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2E9ms2h008327
	for <ltp-list@lists.sourceforge.net>; Fri, 14 Mar 2014 17:48:54 +0800
Message-ID: <1394790533.2038.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 14 Mar 2014 17:48:53 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] pselect/pselect02.c: add new errno tests
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

Add EBADF and EINVAL errno tests for pselect(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pselect/pselect02.c | 127 ++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pselect/pselect02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f7127fe..6b28dec 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -585,6 +585,7 @@ pread03 pread03
 profil01 profil01
 
 pselect01 pselect01
+pselect02 pselect02
 
 ptrace01 ptrace01
 ptrace02 ptrace02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2f31e93..9867bdb 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -496,6 +496,7 @@ pread03 pread03
 profil01 profil01
 
 pselect01 pselect01
+pselect02 pselect02
 
 ptrace01 ptrace01
 ptrace02 ptrace02
diff --git a/runtest/syscalls b/runtest/syscalls
index 2a408c4..152c4c2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -769,6 +769,8 @@ prot_hsymlinks prot_hsymlinks
 
 pselect01 pselect01
 pselect01_64 pselect01_64
+pselect02 pselect02
+pselect02_64 pselect02_64
 
 ptrace01 ptrace01
 ptrace02 ptrace02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0138ba9..6c1b44a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -629,6 +629,8 @@
 /profil/profil01
 /pselect/pselect01
 /pselect/pselect01_64
+/pselect/pselect02
+/pselect/pselect02_64
 /ptrace/_syscalls.h
 /ptrace/ptrace01
 /ptrace/ptrace02
diff --git a/testcases/kernel/syscalls/pselect/pselect02.c b/testcases/kernel/syscalls/pselect/pselect02.c
new file mode 100644
index 0000000..4f3f776
--- /dev/null
+++ b/testcases/kernel/syscalls/pselect/pselect02.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. pselect() fails with -1 return value and sets errno to EBADF
+ *      if a file descriptor that was already closed.
+ *   2. pselect() fails with -1 return value and sets errno to EINVAL
+ *      if nfds was negative.
+ *   3. pselect() fails with -1 return value and sets errno to EINVAL
+ *      if the value contained within timeout was invalid.
+ */
+
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "pselect02";
+
+static fd_set read_fds;
+static struct timespec time_buf;
+
+static struct test_case_t {
+	int nfds;
+	fd_set *readfds;
+	struct timespec *timeout;
+	int exp_errno;
+} test_cases[] = {
+	{128, &read_fds, NULL, EBADF},
+	{-1, NULL, NULL, EINVAL},
+	{128, NULL, &time_buf, EINVAL},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBADF, EINVAL, 0 };
+
+static void setup(void);
+static void cleanup(void);
+static void pselect_verify(const struct test_case_t *);
+
+int main(int argc, char **argv)
+{
+	char *msg;
+	int lc, i;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			pselect_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	fd = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_CREAT, 0777);
+
+	FD_ZERO(&read_fds);
+	FD_SET(fd, &read_fds);
+
+	SAFE_CLOSE(cleanup, fd);
+
+	time_buf.tv_sec = -1;
+	time_buf.tv_nsec = 0;
+}
+
+static void pselect_verify(const struct test_case_t *test)
+{
+	TEST(pselect(test->nfds, test->readfds, NULL, NULL, test->timeout,
+	     NULL));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "pselect() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "pselect() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "pselect() failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
