Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8850C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 08:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 682D03CA55F
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 10:38:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0FEB3CA27C
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 10:38:25 +0200 (CEST)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 57438140097F
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 10:38:18 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3AMMet1qN9HUi8dVbvrR2VlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVW60D8khWZRmzQdD2+Hb/uCN2Tzfo91bIu2pBgOv5KAm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/gDWEmdBhjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPcdqOGefCfg2SCU5wicG5f2+N1qEFkeOYwD5v0xBWB?=
 =?us-ascii?q?I6OxeKSxlRhuDnf+8wamTUfR3i4IoPqHDJJ0YoHxk5SrEFvtgSoKrfklgzbe0x?=
 =?us-ascii?q?x9p3oYXQ6mYPJFfNFJSgN37S0UnEj8q5FgWxY9EXkXCTgA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyAGfhK2+p2F+nmswZoxEqQqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="123861577"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 27 Apr 2022 16:38:16 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id 494E54D1718C;
 Wed, 27 Apr 2022 16:38:15 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 27 Apr 2022 16:38:15 +0800
Received: from G08FNSTD200033.g08.fujitsu.local (10.167.225.189) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 27 Apr 2022 16:38:15 +0800
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Apr 2022 16:38:14 +0800
Message-ID: <20220427083814.1100-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 494E54D1718C.ADB33
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: chenhx.fnst@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/mount_setattr01: Add basic functional test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The mount_setattr() system call changes the mount properties of
a mount or an entire mount tree. Here we check whether the mount
attributes are set correctly.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v4:
  1) add AC_CHECK_TYPES for mount_attr
  2) fix cleanup issues
v3:
  1) fix doc issue
  2) fix bugs according to Petr's comments
v2:
  1) fix bugs according to Cyril's comments
  2) just set and test mount attributes, remove attr_clr section.

 configure.ac                                  |   7 +
 include/lapi/fsmount.h                        |  47 +++++++
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/mount_setattr/.gitignore  |   1 +
 .../kernel/syscalls/mount_setattr/Makefile    |   6 +
 .../syscalls/mount_setattr/mount_setattr01.c  | 132 ++++++++++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/mount_setattr/Makefile
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c

diff --git a/configure.ac b/configure.ac
index 81cba98c2..816ebf820 100644
--- a/configure.ac
+++ b/configure.ac
@@ -220,6 +220,13 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
                 struct __kernel_old_itimerspec, struct __kernel_itimerspec],,,[#include <sys/socket.h>])
 
 AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
+AC_CHECK_TYPES([struct mount_attr],,,[
+#ifdef HAVE_LINUX_MOUNT_H
+# include <linux/mount.h>
+#else
+# include <sys/mount.h>
+#endif
+])
 
 # Tools knobs
 
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 377af85ec..abf059486 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -16,6 +16,44 @@
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
+/*
+ * Mount attributes.
+ */
+#ifndef MOUNT_ATTR_RDONLY
+# define MOUNT_ATTR_RDONLY       0x00000001 /* Mount read-only */
+#endif
+#ifndef MOUNT_ATTR_NOSUID
+# define MOUNT_ATTR_NOSUID       0x00000002 /* Ignore suid and sgid bits */
+#endif
+#ifndef MOUNT_ATTR_NODEV
+# define MOUNT_ATTR_NODEV        0x00000004 /* Disallow access to device special files */
+#endif
+#ifndef MOUNT_ATTR_NOEXEC
+# define MOUNT_ATTR_NOEXEC       0x00000008 /* Disallow program execution */
+#endif
+#ifndef MOUNT_ATTR_NODIRATIME
+# define MOUNT_ATTR_NODIRATIME   0x00000080 /* Do not update directory access times */
+#endif
+#ifndef MOUNT_ATTR_NOSYMFOLLOW
+# define MOUNT_ATTR_NOSYMFOLLOW  0x00200000 /* Do not follow symlinks */
+#endif
+
+#ifndef ST_NOSYMFOLLOW
+# define ST_NOSYMFOLLOW 0x2000 /* do not follow symlinks */
+#endif
+
+#ifndef HAVE_STRUCT_MOUNT_ATTR
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	uint64_t attr_set;
+	uint64_t attr_clr;
+	uint64_t propagation;
+	uint64_t userns_fd;
+};
+#endif
+
 #ifndef HAVE_FSOPEN
 static inline int fsopen(const char *fsname, unsigned int flags)
 {
@@ -62,6 +100,15 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
 }
 #endif /* HAVE_OPEN_TREE */
 
+#ifndef HAVE_MOUNT_SETATTR
+static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
+				struct mount_attr *attr, size_t size)
+{
+	return tst_syscall(__NR_mount_setattr, dirfd, from_pathname, flags,
+			   attr, size);
+}
+#endif /* HAVE_MOUNT_SETATTR */
+
 /*
  * New headers added in kernel after 5.2 release, create them for old userspace.
 */
diff --git a/runtest/syscalls b/runtest/syscalls
index d43d6983b..307f9bed1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -803,6 +803,8 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
 
+mount_setattr01 mount_setattr01
+
 move_mount01 move_mount01
 move_mount02 move_mount02
 
diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
new file mode 100644
index 000000000..52a77b9ca
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
@@ -0,0 +1 @@
+/mount_setattr01
diff --git a/testcases/kernel/syscalls/mount_setattr/Makefile b/testcases/kernel/syscalls/mount_setattr/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
new file mode 100644
index 000000000..c9cfa502e
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Dai Shili <daisl.fnst@fujitsu.com>
+ * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic mount_setattr() test.
+ * Test whether the basic mount attributes are set correctly.
+ *
+ * Verify some MOUNT_SETATTR(2) attributes:
+ *
+ * - 1) MOUNT_ATTR_RDONLY - makes the mount read-only
+ * - 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
+ *     set-user-ID and set-group-ID mode bits and file capabilities
+ *     when executing programs.
+ * - 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
+ * - 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
+ * - 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
+ *    on this mount
+ * - 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
+ *    directories on this mount
+ *
+ * The functionality was added in v5.12.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/statvfs.h>
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT        "mntpoint"
+#define OT_MNTPOINT     "ot_mntpoint"
+#define TCASE_ENTRY(attrs, exp_attrs)   \
+	{                                \
+		.name = #attrs,                 \
+		.mount_attrs = attrs,           \
+		.expect_attrs = exp_attrs       \
+	}
+
+static int mount_flag, otfd = -1;
+
+static struct tcase {
+	char *name;
+	unsigned int mount_attrs;
+	unsigned int expect_attrs;
+} tcases[] = {
+	TCASE_ENTRY(MOUNT_ATTR_RDONLY, ST_RDONLY),
+	TCASE_ENTRY(MOUNT_ATTR_NOSUID, ST_NOSUID),
+	TCASE_ENTRY(MOUNT_ATTR_NODEV, ST_NODEV),
+	TCASE_ENTRY(MOUNT_ATTR_NOEXEC, ST_NOEXEC),
+	TCASE_ENTRY(MOUNT_ATTR_NOSYMFOLLOW, ST_NOSYMFOLLOW),
+	TCASE_ENTRY(MOUNT_ATTR_NODIRATIME, ST_NODIRATIME),
+};
+
+static void cleanup(void)
+{
+	if (otfd > -1)
+		SAFE_CLOSE(otfd);
+	if (mount_flag)
+		SAFE_UMOUNT(OT_MNTPOINT);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+	struct stat st = {0};
+
+	if (stat(OT_MNTPOINT, &st) == -1)
+		SAFE_MKDIR(OT_MNTPOINT, 0777);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct mount_attr attr = {
+		.attr_set = tc->mount_attrs,
+	};
+	struct statvfs buf;
+
+	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
+		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
+	if (!TST_PASS)
+		return;
+
+	otfd = (int)TST_RET;
+
+	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
+		"%s set", tc->name);
+	if (!TST_PASS)
+		goto out;
+
+	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+	if (!TST_PASS)
+		goto out;
+	mount_flag = 1;
+
+	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
+	if (!TST_PASS)
+		goto out;
+
+	if (buf.f_flag & tc->expect_attrs)
+		tst_res(TPASS, "%s is actually set as expected", tc->name);
+	else
+		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
+
+out:
+	if (otfd > -1)
+		SAFE_CLOSE(otfd);
+	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
+		mount_flag = 0;
+		SAFE_UMOUNT(OT_MNTPOINT);
+	}
+
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
+};
-- 
2.35.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
