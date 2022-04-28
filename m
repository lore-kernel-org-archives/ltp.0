Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64433C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 10:47:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EFEE3CA5F6
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 12:47:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC9593CA5F6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 12:46:54 +0200 (CEST)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 912861001421
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 12:46:47 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3ACfqbTag2nTek8/Wa+I4K33d2X161UBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVRnzMWCm2Ob/aJYGakfthwady09EIHuZWEmoA2TAI6+3w8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14N5NuJqwW?=
 =?us-ascii?q?UEnOLbQsOoAURhECDw4NqpDkFPCCSHl6pzClx2cKxMAxN0rVinaJ7Yw/vpvKWV?=
 =?us-ascii?q?P7uADbjQMaA2TweOqqJqwSvNxjMU4BNL2J45ZsWMI5SnHCuwrRbjYXr7Ho9RKt?=
 =?us-ascii?q?ArcLOgm8e32PpJfMGQwKk+bJUAnB7veM7pm9M/Au5U1W2QwRIqpmJcK?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Awl2GAqvpBsOzqSHJWN7TAobM7skDntV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHvJYVcqKRYdcL+7WJVoLUmxyXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLhuGO/9SKIUzDH4BmupuIC5IOauEYE2IK9vrS0U2pFco62tmb/OSNjefa?=
 =?us-ascii?q?9X1kSgZncMhbnn5EIzfeAktrXxNHGJZ8MJKd4/BMrz2mdW9SQd+8AhA+LpD+ju?=
 =?us-ascii?q?yOhJT7egQHGhJizAGPiAmj4Ln8HwPd/jp2aUIo/Ysf?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="123890820"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 28 Apr 2022 18:46:44 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id 8DE584D16FDF;
 Thu, 28 Apr 2022 18:46:42 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 28 Apr 2022 18:46:42 +0800
Received: from G08FNSTD200033.g08.fujitsu.local (10.167.225.189) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 28 Apr 2022 18:46:43 +0800
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 28 Apr 2022 18:46:42 +0800
Message-ID: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 8DE584D16FDF.AF634
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: chenhx.fnst@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional test
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
v5:
  1. remove numbers from doc
  2. modify cleanup labels
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
index 24d0f955d..3b26d19e6 100644
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
index 000000000..ef26bcbf2
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
+ * - MOUNT_ATTR_RDONLY - makes the mount read-only
+ * - MOUNT_ATTR_NOSUID - causes the mount not to honor the
+ *   set-user-ID and set-group-ID mode bits and file capabilities
+ *   when executing programs.
+ * - MOUNT_ATTR_NODEV - prevents access to devices on this mount
+ * - MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
+ * - MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
+ *   on this mount
+ * - MOUNT_ATTR_NODIRATIME - prevents updating access time for
+ *   directories on this mount
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
+		goto out1;
+
+	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+	if (!TST_PASS)
+		goto out1;
+	mount_flag = 1;
+	SAFE_CLOSE(otfd);
+
+	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
+	if (!TST_PASS)
+		goto out2;
+
+	if (buf.f_flag & tc->expect_attrs)
+		tst_res(TPASS, "%s is actually set as expected", tc->name);
+	else
+		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
+
+	goto out2;
+
+out1:
+	SAFE_CLOSE(otfd);
+out2:
+	mount_flag = 0;
+	SAFE_UMOUNT(OT_MNTPOINT);
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
