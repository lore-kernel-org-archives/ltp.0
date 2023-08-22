Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91ACEE4996
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 10:42:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23C003CC7A1
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 12:42:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0C783CC6D2
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 12:42:16 +0200 (CEST)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84AD5200B98
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 12:42:14 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="117086216"
X-IronPort-AV: E=Sophos;i="6.01,192,1684767600"; d="scan'208";a="117086216"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 19:42:12 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1526CE428A
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 19:42:10 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 541ECD21AF
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 19:42:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7017E87899;
 Tue, 22 Aug 2023 19:42:08 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 22 Aug 2023 18:41:39 +0800
Message-Id: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27828.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27828.006
X-TMASE-Result: 10--11.132000-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb3IY6JevWs4vgPZZctd3P4B9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmJU1CACweeL4NbNQByfRPHgSs47mbT7SATzWEMQjooUzShjD8kfQ8yyuJE
 UmdYPGSUgRqs658XN41OWqZ+cVy7s8PB/0vDHqZc2aDVyTGx/pwGZ/+APXW9kr2Pto2emO2UG6E
 w0t87pQEEtPSJifonDyYyeAPTbBZYpcZda/ugaiN9JA2lmQRNUHhysWPN3OzibKItl61J/yZ+in
 TK0bC9eKrauXd3MZDXaU0BzsrbL7cGuZvewCr0K/HLlZA8T7EofsctTTvxpC2lj74733u09
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/faccessat201: Add new testcase
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check the basic functionality of faccessat2().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 +
 include/lapi/faccessat.h                      | 21 +++++
 include/lapi/syscalls/aarch64.in              |  1 +
 include/lapi/syscalls/arc.in                  |  1 +
 include/lapi/syscalls/arm.in                  |  1 +
 include/lapi/syscalls/hppa.in                 |  1 +
 include/lapi/syscalls/i386.in                 |  1 +
 include/lapi/syscalls/ia64.in                 |  1 +
 include/lapi/syscalls/powerpc.in              |  1 +
 include/lapi/syscalls/powerpc64.in            |  1 +
 include/lapi/syscalls/s390.in                 |  1 +
 include/lapi/syscalls/s390x.in                |  1 +
 include/lapi/syscalls/sh.in                   |  1 +
 include/lapi/syscalls/sparc.in                |  1 +
 include/lapi/syscalls/sparc64.in              |  1 +
 include/lapi/syscalls/x86_64.in               |  1 +
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/faccessat2/.gitignore     |  1 +
 testcases/kernel/syscalls/faccessat2/Makefile |  9 ++
 .../kernel/syscalls/faccessat2/faccessat201.c | 89 +++++++++++++++++++
 20 files changed, 138 insertions(+)
 create mode 100644 include/lapi/faccessat.h
 create mode 100644 testcases/kernel/syscalls/faccessat2/.gitignore
 create mode 100644 testcases/kernel/syscalls/faccessat2/Makefile
 create mode 100644 testcases/kernel/syscalls/faccessat2/faccessat201.c

diff --git a/configure.ac b/configure.ac
index e4aa2cadf..662c4c058 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,6 +92,7 @@ AC_CHECK_FUNCS_ONCE([ \
     epoll_pwait \
     epoll_pwait2 \
     execveat \
+    faccessat2 \
     fallocate \
     fchownat \
     fsconfig \
diff --git a/include/lapi/faccessat.h b/include/lapi/faccessat.h
new file mode 100644
index 000000000..5b42014d2
--- /dev/null
+++ b/include/lapi/faccessat.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef FACCESSAT2_H
+#define FACCESSAT2_H
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_FACCESSAT2
+int faccessat2(int dirfd, const char *pathname, int mode, int flags)
+{
+	return tst_syscall(__NR_faccessat2, dirfd, pathname, mode, flags);
+}
+#endif
+
+#endif /* FACCESSAT2_H */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index de4ed5fb1..2cb6c2d87 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -293,6 +293,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 9f11381db..3e2ee9061 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -313,6 +313,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 4b0f63a28..7bdbca533 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -391,6 +391,7 @@ clone3 (__NR_SYSCALL_BASE+435)
 close_range (__NR_SYSCALL_BASE+436)
 openat2 (__NR_SYSCALL_BASE+437)
 pidfd_getfd (__NR_SYSCALL_BASE+438)
+faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index b6d32d386..8ebdafafb 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -40,6 +40,7 @@ fsmount 432
 fspick 433
 pidfd_open 434
 close_range 436
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index d0e6e9a4b..1472631c4 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -427,6 +427,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 123200624..0ea6e9722 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -340,6 +340,7 @@ pidfd_open 1458
 close_range 1460
 openat2 1461
 pidfd_getfd 1462
+faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
 futex_waitv 1473
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index d5de621e1..545d9d3d6 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -420,6 +420,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index d5de621e1..545d9d3d6 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -420,6 +420,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 6505f3822..7213ac5f8 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -407,6 +407,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index bc5d2b34c..879012e2b 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -355,6 +355,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 316ffe5f1..7d5192a27 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -401,6 +401,7 @@ pidfd_open 434
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index e0c60a360..91d2fb1c2 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -406,6 +406,7 @@ pidfd_open 434
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 0acde6856..1f2fc59b7 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -371,6 +371,7 @@ pidfd_open 434
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 1863e1df7..dc61aa56e 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -348,6 +348,7 @@ clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
+faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
diff --git a/runtest/syscalls b/runtest/syscalls
index 119710d63..02768c236 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -216,6 +216,9 @@ exit_group01 exit_group01
 #faccessat test cases
 faccessat01 faccessat01
 
+#faccessat2 test cases
+faccessat201 faccessat201
+
 #fallocate test cases
 fallocate01 fallocate01
 fallocate02 fallocate02
diff --git a/testcases/kernel/syscalls/faccessat2/.gitignore b/testcases/kernel/syscalls/faccessat2/.gitignore
new file mode 100644
index 000000000..53f700bac
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/.gitignore
@@ -0,0 +1 @@
+/faccessat201
diff --git a/testcases/kernel/syscalls/faccessat2/Makefile b/testcases/kernel/syscalls/faccessat2/Makefile
new file mode 100644
index 000000000..aaac6b703
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+# Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
new file mode 100644
index 000000000..88ee21522
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of faccessat2().
+ *
+ * Minimum Linux version required is v5.8.
+ */
+
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/faccessat.h"
+
+#define TESTDIR         "faccessat2dir"
+#define TESTFILE        "faccessat2file"
+#define RELPATH         "faccessat2dir/faccessat2file"
+#define TESTSYMLINK     "faccessat2symlink"
+
+static int dir_fd, bad_fd = -1;
+static int atcwd_fd = AT_FDCWD;
+static char *testfile;
+static char *abs_path;
+static char *rel_path;
+static char *sym_path;
+
+static struct tcase {
+	int *fd;
+	char **filename;
+	int flags;
+} tcases[] = {
+	{&dir_fd, &testfile, 0},
+	{&bad_fd, &abs_path, 0},
+	{&atcwd_fd, &rel_path, 0},
+	{&dir_fd, &testfile, AT_EACCESS},
+	{&bad_fd, &abs_path, AT_EACCESS},
+	{&atcwd_fd, &rel_path, AT_EACCESS},
+	{&atcwd_fd, &sym_path, AT_SYMLINK_NOFOLLOW},
+};
+
+static void verify_faccessat2(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_PASS(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
+		     "faccessat2(%d, %s, R_OK, %d)",
+		     *tc->fd, *tc->filename, tc->flags);
+}
+
+static void setup(void)
+{
+	char *tmpdir_path = tst_get_tmpdir();
+
+	abs_path = tst_aprintf("%s/%s", tmpdir_path, RELPATH);
+	free(tmpdir_path);
+
+	SAFE_MKDIR(TESTDIR, 0666);
+	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+	SAFE_TOUCH(abs_path, 0444, NULL);
+	SAFE_SYMLINK(abs_path, TESTSYMLINK);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_faccessat2,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&testfile, .str = TESTFILE},
+		{&abs_path, .size = sizeof(char)},
+		{&rel_path, .str = RELPATH},
+		{&sym_path, .str = TESTSYMLINK},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
