Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF7C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 10:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2013CA6A6
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 12:29:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A87F3C02B1
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 12:29:32 +0200 (CEST)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id C02966002C9
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 12:29:29 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3AdFlR1qsqpyS3kEzakRUMwn5OGefnVHZcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mjFJDG+BOfjcNGf8KYxyO47n9U0BsZfRnNVqGgdrqX9gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1GtZG2S?=
 =?us-ascii?q?RdvMKvXhMwTThtZDzpje6ZB/dcrJFDm65fMlxGeKiKEL/JGSRte0Zcj0uJrGUl?=
 =?us-ascii?q?K9OcEM3YJbxael6S33NqTQel2m84iN+HwIZgS/HpypQw1p95OrYvrGv2MvIEHm?=
 =?us-ascii?q?mxrwJ0mIBoXXOJBARIHUfgKS0Qn1o8rNa8D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACSOcUayZWBG9ZWlXCFUQKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="123704011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 20 Apr 2022 18:29:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id 957714D17163;
 Wed, 20 Apr 2022 18:29:26 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 20 Apr 2022 18:29:26 +0800
Received: from G08FNSTD200033.g08.fujitsu.local (10.167.225.189) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 20 Apr 2022 18:29:26 +0800
From: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 20 Apr 2022 18:29:26 +0800
Message-ID: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 957714D17163.A99B8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: chenhx.fnst@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mount_setattr01: Add basic functional test
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

From: Chen Hanxiao <chenhx.fnst@fujitsu.com>

The mount_setattr() system call changes the mount properties of
a mount or an entire mount tree. Here we check whether the mount
attributes are set correctly.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
  1) fix bugs according to Cyril's comments
  2) just set and test mount attributes, remove attr_clr section.

 include/lapi/fsmount.h                        |  45 +++++++
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/mount_setattr/.gitignore  |   1 +
 .../kernel/syscalls/mount_setattr/Makefile    |   6 +
 .../syscalls/mount_setattr/mount_setattr01.c  | 118 ++++++++++++++++++
 5 files changed, 172 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/mount_setattr/Makefile
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index fa2530675..d44444309 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -15,6 +15,42 @@
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
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	uint64_t attr_set;
+	uint64_t attr_clr;
+	uint64_t propagation;
+	uint64_t userns_fd;
+};
+
 #ifndef HAVE_FSOPEN
 static inline int fsopen(const char *fsname, unsigned int flags)
 {
@@ -61,6 +97,15 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
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
index c30383ee5..1d93f419c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -801,6 +801,8 @@ mount04 mount04
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
index 000000000..d63db46fa
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -0,0 +1,118 @@
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
+ * 1) MOUNT_ATTR_RDONLY - makes the mount read-only
+ * 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
+ *    set-user-ID and set-group-ID mode bits and file capabilities
+ *    when executing programs.
+ * 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
+ * 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
+ * 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
+ *    on this mount
+ * 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
+ *    directories on this mount
+ * Minimum Linux version required is v5.12.
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
+static int dir_created;
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
+	if (dir_created)
+		SAFE_RMDIR(OT_MNTPOINT);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+	SAFE_MKDIR(OT_MNTPOINT, 0777);
+	dir_created = 1;
+}
+
+static void run(unsigned int n)
+{
+	int otfd;
+	struct tcase *tc = &tcases[n];
+	struct mount_attr attr = {
+		.attr_set = tc->mount_attrs,
+	};
+	struct statvfs buf;
+
+	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
+		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
+	otfd = (int)TST_RET;
+
+	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
+		"%s set", tc->name);
+
+	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
+		return;
+	}
+
+	SAFE_CLOSE(otfd);
+
+	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
+
+	if ((buf.f_flag & tc->expect_attrs) == 0)
+		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
+	else
+		tst_res(TPASS, "%s is actually set as expected", tc->name);
+
+	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT))
+		SAFE_UMOUNT(OT_MNTPOINT);
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
