Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WqHpY-0000uP-PO
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 08:06:24 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WqHpU-00071s-Qv
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 08:06:24 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4U86Dxs032709
	for <ltp-list@lists.sourceforge.net>; Fri, 30 May 2014 16:06:13 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 30 May 2014 16:05:25 +0800
Message-ID: <1401437125-17840-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1401098198-1109-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1401098198-1109-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] splice/splice03.c: add EBADF,
	EINVAL and ESPIPE error value tests
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 configure.ac                                |   1 +
 m4/ltp-splice.m4                            |  25 ++++
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/splice/splice.h   |  36 ++++++
 testcases/kernel/syscalls/splice/splice01.c |  11 +-
 testcases/kernel/syscalls/splice/splice02.c |  11 +-
 testcases/kernel/syscalls/splice/splice03.c | 180 ++++++++++++++++++++++++++++
 8 files changed, 249 insertions(+), 17 deletions(-)
 create mode 100644 m4/ltp-splice.m4
 create mode 100644 testcases/kernel/syscalls/splice/splice.h
 create mode 100644 testcases/kernel/syscalls/splice/splice03.c

diff --git a/configure.ac b/configure.ac
index 8698c47..96611cf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,5 +182,6 @@ LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_TIRPC
+LTP_CHECK_SPLICE
 
 AC_OUTPUT
diff --git a/m4/ltp-splice.m4 b/m4/ltp-splice.m4
new file mode 100644
index 0000000..0ddaae0
--- /dev/null
+++ b/m4/ltp-splice.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_SPLICE
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_SPLICE],[
+AC_CHECK_FUNCS(splice,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 9207356..9602770 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1150,6 +1150,7 @@ sockioctl01 sockioctl01
 #splice test
 splice01 splice01
 splice02 seq 1 10000000 | splice02 splice02-temp
+splice03 splice03
 
 tee01 tee01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 61c836c..ba52ff1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -900,6 +900,7 @@
 /sockioctl/sockioctl01
 /splice/splice01
 /splice/splice02
+/splice/splice03
 /ssetmask/ssetmask01
 /stat/stat01
 /stat/stat01_64
diff --git a/testcases/kernel/syscalls/splice/splice.h b/testcases/kernel/syscalls/splice/splice.h
new file mode 100644
index 0000000..4e243fd
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
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
+
+#ifndef SPLICE_H
+#define SPLICE_H
+
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_SPLICE)
+ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
+	loff_t *off_out, size_t len, unsigned int flags)
+{
+	return ltp_syscall(__NR_splice, fd_in, off_in,
+		fd_out, off_out, len, flags);
+}
+#endif
+
+#endif /* SPLICE_H */
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index 5e8b841..6ca3e71 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -42,6 +42,8 @@
  *
  */
 
+#define _GNU_SOURCE
+
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
@@ -52,6 +54,7 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 #include "tst_fs_type.h"
+#include "splice.h"
 
 #define SPLICE_TEST_BLOCK_SIZE 1024
 
@@ -64,14 +67,6 @@ int TST_TOTAL = 1;
 char testfile1[256];
 char testfile2[256];
 
-static inline long splice(int fd_in, loff_t * off_in,
-			  int fd_out, loff_t * off_out,
-			  size_t len, unsigned int flags)
-{
-	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
-		len, flags);
-}
-
 int main(int ac, char **av)
 {
 	int lc;
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index 3e69070..57e0141 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -40,19 +40,12 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
+#include "splice.h"
 
 char *TCID = "splice02";
 int testno;
 int TST_TOTAL = 1;
 
-static inline long ltp_splice(int fd_in, loff_t * off_in,
-			      int fd_out, loff_t * off_out,
-			      size_t len, unsigned int flags)
-{
-	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
-		len, flags);
-}
-
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -135,7 +128,7 @@ int main(int ac, char **av)
 	}
 
 	do {
-		TEST(ltp_splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
+		TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
 		if (TEST_RETURN < 0) {
 			tst_resm(TFAIL, "splice failed - errno = %d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
new file mode 100644
index 0000000..40c017f
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1) splice() returns -1 and sets errno to EBADF if the file
+ *      descriptor fd_in is not valid.
+ *   2) splice() returns -1 and sets errno to EBADF if the file
+ *      descriptor fd_out is not valid..
+ *   3) splice() returns -1 and sets errno to EBADF if the file
+ *      descriptor fd_in does not have proper read-write mode.
+ *   4) splice() returns -1 and sets errno to EINVAL if target
+ *      file is opened in append mode.
+ *   5) splice() returns -1 and sets errno to EINVAL if neither
+ *      of the descriptors refer to a pipe.
+ *   6) splice() returns -1 and sets errno to ESPIPE if off_in is
+ *      not NULL when the file descriptor fd_in refers to a pipe.
+ *   7) splice() returns -1 and sets errno to ESPIPE if off_out is
+ *      not NULL when the file descriptor fd_out refers to a pipe.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "splice.h"
+
+#define TEST_FILE "testfile"
+#define TEST_FILE2 "testfile2"
+#define TEST_FILE3 "testfile3"
+
+#define STR "abcdefghigklmnopqrstuvwxyz"
+#define SPLICE_TEST_LEN 10
+
+static int badfd = -1;
+static int rdfd;
+static int wrfd;
+static int appendfd;
+static int pipes[2];
+static loff_t offset;
+
+static struct test_case_t {
+	int *fdin;
+	loff_t *offin;
+	int *fdout;
+	loff_t *offout;
+	int exp_errno;
+} test_cases[] = {
+	{ &badfd, NULL, &pipes[1], NULL, EBADF },
+	{ &pipes[0], NULL, &badfd, NULL, EBADF },
+	{ &wrfd, NULL, &pipes[1], NULL, EBADF },
+	{ &pipes[0], NULL, &appendfd, NULL, EINVAL },
+	{ &rdfd, NULL, &wrfd, NULL, EINVAL },
+	{ &pipes[0], &offset, &wrfd, NULL, ESPIPE },
+	{ &rdfd, NULL, &pipes[1], &offset, ESPIPE },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void splice_verify(const struct test_case_t *);
+
+char *TCID = "splice03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBADF, EINVAL, ESPIPE, 0 };
+
+int main(int ac, char **av)
+{
+	int i, lc;
+	const char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			splice_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 17)) < 0) {
+		tst_brkm(TCONF, cleanup, "This test can only run on kernels "
+			"that are 2.6.17 or higher");
+	}
+
+	TEST_PAUSE;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	SAFE_FILE_PRINTF(cleanup, TEST_FILE, STR);
+	rdfd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+
+	wrfd = SAFE_OPEN(cleanup, TEST_FILE2,
+		O_WRONLY | O_CREAT, 0644);
+
+	appendfd = SAFE_OPEN(cleanup, TEST_FILE3,
+		O_RDWR | O_CREAT | O_APPEND, 0644);
+
+	SAFE_PIPE(cleanup, pipes);
+
+	SAFE_WRITE(cleanup, 1, pipes[1], STR, sizeof(STR) - 1);
+}
+
+static void splice_verify(const struct test_case_t *tc)
+{
+	TEST(splice(*(tc->fdin), tc->offin, *(tc->fdout),
+		tc->offout, SPLICE_TEST_LEN, 0));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "splice() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "splice() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"splice() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
+	}
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (rdfd && close(rdfd) < 0)
+		tst_resm(TWARN | TERRNO, "close rdfd failed");
+
+	if (wrfd && close(wrfd) < 0)
+		tst_resm(TWARN | TERRNO, "close wrfd failed");
+
+	if (appendfd && close(appendfd) < 0)
+		tst_resm(TWARN | TERRNO, "close appendfd failed");
+
+	if (pipes[0] && close(pipes[0]) < 0)
+		tst_resm(TWARN | TERRNO, "close pipes[0] failed");
+
+	if (pipes[1] && close(pipes[1]) < 0)
+		tst_resm(TWARN | TERRNO, "close pipes[1] failed");
+
+	tst_rmdir();
+}
-- 
1.9.0


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
