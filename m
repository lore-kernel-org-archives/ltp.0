Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WqHO9-00047b-5g
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 07:38:05 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WqHO4-00068o-TS
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 07:38:05 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4U7brKg030497
	for <ltp-list@lists.sourceforge.net>; Fri, 30 May 2014 15:37:53 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 30 May 2014 15:37:04 +0800
Message-ID: <1401435424-10803-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] tee/tee02.c: add EINVAL error value test
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
 configure.ac                          |   1 +
 m4/ltp-tee.m4                         |  25 ++++++
 runtest/syscalls                      |   1 +
 testcases/kernel/syscalls/.gitignore  |   1 +
 testcases/kernel/syscalls/tee/tee.h   |  33 ++++++++
 testcases/kernel/syscalls/tee/tee02.c | 145 ++++++++++++++++++++++++++++++++++
 6 files changed, 206 insertions(+)
 create mode 100644 m4/ltp-tee.m4
 create mode 100644 testcases/kernel/syscalls/tee/tee.h
 create mode 100644 testcases/kernel/syscalls/tee/tee02.c

diff --git a/configure.ac b/configure.ac
index 8698c47..3a7ec9c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,5 +182,6 @@ LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_TIRPC
+LTP_CHECK_TEE
 
 AC_OUTPUT
diff --git a/m4/ltp-tee.m4 b/m4/ltp-tee.m4
new file mode 100644
index 0000000..eb4a6b2
--- /dev/null
+++ b/m4/ltp-tee.m4
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
+dnl along with this program;  if not, write to the Free Software Foundation,
+dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_TEE
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_TEE],[
+AC_CHECK_FUNCS(tee,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 9207356..1eda929 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1152,6 +1152,7 @@ splice01 splice01
 splice02 seq 1 10000000 | splice02 splice02-temp
 
 tee01 tee01
+tee02 tee02
 
 ssetmask01 ssetmask01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 61c836c..6e1cb82 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -954,6 +954,7 @@
 /syslog/syslog12
 /syslog/syslogtst
 /tee/tee01
+/tee/tee02
 /time/time01
 /time/time02
 /timer_getoverrun/timer_getoverrun01
diff --git a/testcases/kernel/syscalls/tee/tee.h b/testcases/kernel/syscalls/tee/tee.h
new file mode 100644
index 0000000..0ba10a6
--- /dev/null
+++ b/testcases/kernel/syscalls/tee/tee.h
@@ -0,0 +1,33 @@
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef TEE_H
+#define TEE_H
+
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_TEE)
+ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
+{
+	return ltp_syscall(__NR_tee, fd_in, fd_out, len, flags);
+}
+#endif
+
+#endif /* TEE_H */
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
new file mode 100644
index 0000000..ba39662
--- /dev/null
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -0,0 +1,145 @@
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
+ *   1) tee() returns -1 and sets errno to EINVAL if fd_in does
+ *      not refer to a pipe.
+ *   2) tee() returns -1 and sets errno to EINVAL if fd_out does
+ *      not refer to a pipe.
+ *   3) tee() returns -1 and sets errno to EINVAL if fd_in and
+ *      fd_out refer to the same pipe.
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
+#include "tee.h"
+
+#define TEST_FILE "testfile"
+
+#define STR "abcdefghigklmnopqrstuvwxyz"
+#define TEE_TEST_LEN 10
+
+static int fd;
+static int pipes[2];
+
+static struct test_case_t {
+	int *fdin;
+	int *fdout;
+	int exp_errno;
+} test_cases[] = {
+	{ &fd, &pipes[1], EINVAL },
+	{ &pipes[0], &fd, EINVAL },
+	{ &pipes[0], &pipes[1], EINVAL },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void tee_verify(const struct test_case_t *);
+
+char *TCID = "tee02";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EINVAL, 0 };
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
+			tee_verify(&test_cases[i]);
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
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT);
+
+	SAFE_PIPE(cleanup, pipes);
+	SAFE_WRITE(cleanup, 1, pipes[1], STR, sizeof(STR) - 1);
+}
+
+static void tee_verify(const struct test_case_t *tc)
+{
+	TEST(tee(*(tc->fdin), *(tc->fdout), TEE_TEST_LEN, 0));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "tee() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "tee() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"tee() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
+	}
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (fd && close(fd) < 0)
+		tst_resm(TWARN | TERRNO, "close fd failed");
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
