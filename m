Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WstsR-0000sU-8v
	for ltp-list@lists.sourceforge.net; Fri, 06 Jun 2014 13:08:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WstsL-0003pN-2Q
	for ltp-list@lists.sourceforge.net; Fri, 06 Jun 2014 13:08:11 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s56D7vO2032531
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jun 2014 21:07:57 +0800
Message-ID: <1402060015.2086.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 6 Jun 2014 21:06:55 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] add new errno testes for timerfd_*
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

* Add EINVAL errno testes for timerfd_create(2)
  - The clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
    EINVAL would return.
  - flags is invalid, EINVAL would return.

* Add EBADF, EFAULT and EINVAL errno testes for timerfd_gettime(2)
  - fd is not a valid file descriptor, EBADF would return.
  - curr_value is not valid a pointer, EFAULT would return.
  - fd is not a valid timerfd file descriptor, EINVAL would return.

* Add EBADF, EFAULT and EINVAL errno testes for timerfd_settime(2)
  - fd is not a valid file descriptor, EBADF would return.
  - old_value is not valid a pointer, EFAULT would return.
  - fd is not a valid timerfd file descriptor, EINVAL would return.
  - flags is invalid, EINVAL would return.


Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/lapi/timerfd.h                             |  49 ++++++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/.gitignore               |   3 +
 .../kernel/syscalls/timerfd/timerfd_create01.c     | 106 ++++++++++++++++
 .../kernel/syscalls/timerfd/timerfd_gettime01.c    | 131 ++++++++++++++++++++
 .../kernel/syscalls/timerfd/timerfd_settime01.c    | 136 +++++++++++++++++++++
 6 files changed, 428 insertions(+)
 create mode 100644 include/lapi/timerfd.h
 create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_create01.c
 create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
 create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_settime01.c

diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
new file mode 100644
index 0000000..ba02003
--- /dev/null
+++ b/include/lapi/timerfd.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
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
+
+#ifndef TIMERFD_H
+#define TIMERFD_H
+
+#include <time.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_TIMERFD_CREATE)
+int timerfd_create(int clockid, int flags)
+{
+	return ltp_syscall(__NR_timerfd_create, clockid, flags);
+}
+#endif
+
+#if !defined(HAVE_TIMERFD_GETTIME)
+int timerfd_settime(int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value)
+{
+	return ltp_syscall(__NR_timerfd_settime, fd, flags, new_value,
+			   old_value);
+}
+#endif
+
+#if !defined(HAVE_TIMERFD_SETTIME)
+int timerfd_gettime(int fd, struct itimerspec *curr_value)
+{
+
+	return ltp_syscall(__NR_timerfd_gettime, fd, curr_value);
+}
+#endif
+
+#endif /* TIMERFD_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index 3db5f2a..abda223 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1252,6 +1252,9 @@ times03 times03
 timerfd01 timerfd01
 timerfd02 timerfd02
 timerfd03 timerfd03
+timerfd_create01 timerfd_create01
+timerfd_gettime01 timerfd_gettime01
+timerfd_settime01 timerfd_settime01
 
 timer_getoverrun01 timer_getoverrun01
 timer_gettime01 timer_gettime01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index e1ee18b..22aed94 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -964,6 +964,9 @@
 /timerfd/timerfd01
 /timerfd/timerfd02
 /timerfd/timerfd03
+/timerfd/timerfd_create01
+/timerfd/timerfd_gettime01
+/timerfd/timerfd_settime01
 /times/times01
 /times/times03
 /tkill/tkill01
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_create01.c b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
new file mode 100644
index 0000000..4793928
--- /dev/null
+++ b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ * DESCRIPTION
+ *  Verify that,
+ *   1. The clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
+ *	EINVAL would return.
+ *   2. flags is invalid, EINVAL would return.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "lapi/timerfd.h"
+
+char *TCID = "timerfd_create01";
+
+static struct test_case_t {
+	int clockid;
+	int flags;
+	int exp_errno;
+} test_cases[] = {
+	{-1, 0, EINVAL},
+	{0, -1, EINVAL},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static void setup(void);
+static void timerfd_create_verify(const struct test_case_t *);
+static void cleanup(void);
+static int exp_enos[] = { EINVAL, 0 };
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	const char *msg;
+	int i;
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
+			timerfd_create_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 25)) < 0)
+		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	TEST_EXP_ENOS(exp_enos);
+}
+
+static void timerfd_create_verify(const struct test_case_t *test)
+{
+	TEST(timerfd_create(test->clockid, test->flags));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "timerfd_create() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			 "timerfd_create() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "timerfd_create() failed unexpectedly; expected: "
+			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
new file mode 100644
index 0000000..2442b79
--- /dev/null
+++ b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ * DESCRIPTION
+ *  Verify that,
+ *   1. fd is not a valid file descriptor, EBADF would return.
+ *   2. curr_value is not valid a pointer, EFAULT would return.
+ *   3. fd is not a valid timerfd file descriptor, EINVAL would return.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "lapi/timerfd.h"
+
+char *TCID = "timerfd_gettime01";
+
+static int bad_clockfd = -1;
+static int clockfd;
+static int fd;
+
+static struct test_case_t {
+	int *fd;
+	struct itimerspec *curr_value;
+	int exp_errno;
+} test_cases[] = {
+	{&bad_clockfd, NULL, EBADF},
+	{&clockfd, (struct itimerspec *)-1, EFAULT},
+	{&fd, NULL, EINVAL},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static void setup(void);
+static void timerfd_gettime_verify(const struct test_case_t *);
+static void cleanup(void);
+static int exp_enos[] = { EBADF, EFAULT, EINVAL, 0 };
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	const char *msg;
+	int i;
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
+			timerfd_gettime_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 25)) < 0)
+		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	TEST_EXP_ENOS(exp_enos);
+
+	tst_tmpdir();
+
+	clockfd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME, 0);
+	if (clockfd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "timerfd_create() fail");
+
+	fd = SAFE_OPEN(cleanup, "test_timerfd", O_RDWR | O_CREAT, 0644);
+}
+
+static void timerfd_gettime_verify(const struct test_case_t *test)
+{
+	TEST(ltp_syscall(__NR_timerfd_gettime, *test->fd, test->curr_value));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "timerfd_gettime() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			 "timerfd_gettime() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "timerfd_gettime() failed unexpectedly; expected: "
+			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (clockfd > 0)
+		close(clockfd);
+
+	if (fd > 0)
+		close(fd);
+
+	tst_rmdir();
+}
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
new file mode 100644
index 0000000..6cb0cb7
--- /dev/null
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
@@ -0,0 +1,136 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ * DESCRIPTION
+ *  Verify that,
+ *   1. fd is not a valid file descriptor, EBADF would return.
+ *   2. old_value is not valid a pointer, EFAULT would return.
+ *   3. fd is not a valid timerfd file descriptor, EINVAL would return.
+ *   4. flags is invalid, EINVAL would return.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "lapi/timerfd.h"
+
+char *TCID = "timerfd_settime01";
+
+static int bad_clockfd = -1;
+static int clockfd;
+static int fd;
+
+static struct test_case_t {
+	int *fd;
+	int flags;
+	struct itimerspec *old_value;
+	int exp_errno;
+} test_cases[] = {
+	{&bad_clockfd, 0, NULL, EBADF},
+	{&clockfd, 0, (struct itimerspec *)-1, EFAULT},
+	{&fd, 0, NULL, EINVAL},
+	{&clockfd, -1, NULL, EINVAL},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static void setup(void);
+static void timerfd_settime_verify(const struct test_case_t *);
+static void cleanup(void);
+static int exp_enos[] = { EBADF, EFAULT, EINVAL, 0 };
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	const char *msg;
+	int i;
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
+			timerfd_settime_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 25)) < 0)
+		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	TEST_EXP_ENOS(exp_enos);
+
+	tst_tmpdir();
+
+	clockfd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME, 0);
+	if (clockfd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "timerfd_create() fail");
+
+	fd = SAFE_OPEN(cleanup, "test_timerfd", O_RDWR | O_CREAT, 0644);
+}
+
+static void timerfd_settime_verify(const struct test_case_t *test)
+{
+	struct itimerspec new_value;
+	TEST(timerfd_settime(*test->fd, test->flags, &new_value,
+			     test->old_value));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "timerfd_settime() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			 "timerfd_settime() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "timerfd_settime() failed unexpectedly; expected: "
+			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (clockfd > 0)
+		close(clockfd);
+
+	if (fd > 0)
+		close(fd);
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
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
