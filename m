Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565C1C001DB
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:09:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94313CE372
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:09:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1F1C3CE380
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:28 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5550D1400042
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:26 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="106476869"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="106476869"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:24 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B8222DB3C6
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:21 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 068A6CFAB6
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D470878F1;
 Sat,  5 Aug 2023 13:08:20 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:07:59 +0800
Message-Id: <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--12.538000-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb3IY6JevWs4vgPZZctd3P4B9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDWGH5wVAlhqE0Ng8GlLBbmo3oygjMeK7eSs47mbT7SATzWEMQjooUzShjD8kfQ8yyO3O
 Ha2yovZn93kA1ImA+YGbvBbE+V3KKu4AM1i3aFvYmZusHWPhfCheN9Hd3TB5G+32SXw3QiFwOvq
 z8x19fG2qJ0+VpCAVgyYyeAPTbBZYpcZda/ugaiN9JA2lmQRNUHhysWPN3OzibKItl61J/yZ+in
 TK0bC9eKrauXd3MZDVHCJ98AryPWLyZS7tdUToSAiaU3sLBMIVt4Q5aa8cKraqjsMGMRwgR
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
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
 include/lapi/faccessat2.h                     |  20 +++
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/faccessat2/.gitignore     |   1 +
 testcases/kernel/syscalls/faccessat2/Makefile |   9 ++
 .../kernel/syscalls/faccessat2/faccessat201.c | 115 ++++++++++++++++++
 19 files changed, 162 insertions(+)
 create mode 100644 include/lapi/faccessat2.h
 create mode 100644 testcases/kernel/syscalls/faccessat2/.gitignore
 create mode 100644 testcases/kernel/syscalls/faccessat2/Makefile
 create mode 100644 testcases/kernel/syscalls/faccessat2/faccessat201.c

diff --git a/include/lapi/faccessat2.h b/include/lapi/faccessat2.h
new file mode 100644
index 000000000..e8b27d6b1
--- /dev/null
+++ b/include/lapi/faccessat2.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LAPI_FACCESSAT2_H__
+#define LAPI_FACCESSAT2_H__
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
+#endif /* LAPI_FACCESSAT2_H__ */
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
index 1028e45fc..948c39030 100644
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
index 000000000..658d1dd81
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
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
+#include <stdio.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/faccessat2.h"
+
+#define TESTUSER	"nobody"
+#define TESTDIR		"faccessat2dir"
+#define TESTFILE	"faccessat2file"
+#define	RELPATH		"faccessat2dir/faccessat2file"
+#define TESTSYMLINK	"faccessat2symlink"
+
+static int dir_fd = -1, bad_fd = -1;
+static int atcwd_fd = AT_FDCWD;
+static char *filepaths[4];
+static char abs_path[128];
+static struct passwd *ltpuser;
+
+static struct tcase {
+	int *fd;
+	char **filename;
+	int flags;
+	int exp_errno;
+} tcases[] = {
+	{&dir_fd, &filepaths[0], 0, 0},
+	{&bad_fd, &filepaths[1], 0, 0},
+	{&atcwd_fd, &filepaths[2], 0, 0},
+	{&dir_fd, &filepaths[0], AT_EACCESS, 0},
+	{&bad_fd, &filepaths[1], AT_EACCESS, 0},
+	{&atcwd_fd, &filepaths[2], AT_EACCESS, 0},
+	{&dir_fd, &filepaths[0], AT_EACCESS, EACCES},
+	{&bad_fd, &filepaths[1], AT_EACCESS, EACCES},
+	{&atcwd_fd, &filepaths[2], AT_EACCESS, EACCES},
+	{&atcwd_fd, &filepaths[3], AT_SYMLINK_NOFOLLOW, 0},
+};
+
+static void verify_faccessat2(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (tc->exp_errno == EACCES) {
+		if (SAFE_FORK() == 0) {
+			SAFE_SETUID(ltpuser->pw_uid);
+			TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
+				    tc->exp_errno, "faccessat2(%d, %s, R_OK, %d) as %s",
+				    *tc->fd, *tc->filename, tc->flags, TESTUSER);
+		}
+
+		tst_reap_children();
+	} else {
+		TST_EXP_PASS(faccessat2(*tc->fd, *tc->filename, R_OK, tc->flags),
+			     "faccessat2(%d, %s, R_OK, %d) as root",
+			     *tc->fd, *tc->filename, tc->flags);
+	}
+}
+
+static void setup(void)
+{
+	char *tmpdir_path = tst_get_tmpdir();
+
+	sprintf(abs_path, "%s/%s", tmpdir_path, RELPATH);
+	free(tmpdir_path);
+
+	SAFE_MKDIR(TESTDIR, 0666);
+	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+	SAFE_TOUCH(abs_path, 0444, NULL);
+	SAFE_SYMLINK(abs_path, TESTSYMLINK);
+
+	filepaths[0] = TESTFILE;
+	filepaths[1] = abs_path;
+	filepaths[2] = RELPATH;
+	filepaths[3] = TESTSYMLINK;
+
+	ltpuser = SAFE_GETPWNAM(TESTUSER);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd > 0)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_faccessat2,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&filepaths[0], .size = sizeof(*filepaths[0])},
+		{&filepaths[1], .size = sizeof(*filepaths[1])},
+		{&filepaths[2], .size = sizeof(*filepaths[2])},
+		{&filepaths[3], .size = sizeof(*filepaths[3])},
+		{&ltpuser, .size = sizeof(ltpuser)},
+		{},
+	},
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
