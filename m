Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2CC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 07:20:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAAF33C0F3B
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:20:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AD2F3C04D2
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:20:41 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF306600438
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1646896839; i=@fujitsu.com;
 bh=Mvvwf3zWxAs5qYnVwMyWnyY65YU3Qi0alGPG1pR1otI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=pEsoZTyHedM2TjpixWZ9wElaOEQM2cEi4ouvrtcu7pL7hRXLux6hxndm78otMWcH+
 Ersi6vbLidArS3fZ8gJ+LOdZ4i8ssn1xxLtePLJ/mNO2WRqrGsnY1glf5icr5XJWpA
 Pb3GeZNrf/O3ZN4aBoSudSorztZEsxHVZLMhT9sQq7yoyZlLD5z/KV3tBgiIDcJyf/
 kkSEv6ZGFiRZx1MKJ55WcWDJvfsIxkHD7q161RJZdr3xthfeeC/+k8RM1Ve7Mm4cYi
 YfLCwCj/gUeoTkx6Wzuht48GRat1cG0SZnw2g7Phn37B8VPCmcp3dClHJMceFqZh+H
 STcwJGhvRsjDA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8MxSff4Ms0
 kg9vnuC1WfN/B6MDose/3OtYAxijWzLyk/IoE1ozedQ3sBYv0K26vvc7awLhRo4uRi0NI4Cyj
 xPHZJ9ghnJ1MEkufLmaGcPYzStzu3MbYxcjJwSagIXHtcTsziC0iICHR0fCWHcRmFlCT2H31G
 BuILSzgIrFtzR9WEJtFQFXi5oepQDYHB6+Am8SRhbogYQkBBYkpD9+DjeEVEJQ4OfMJC8QYCY
 mDL14wQ9QoSuzfu5ERwq6QmDFjGxuErSZx9dwm5gmM/LOQtM9C0r6AkWkVo3VSUWZ6RkluYma
 OrqGBga6hoamusbmuoZmRXmKVbqJeaqlueWpxiS6QW16sl1pcrFdcmZuck6KXl1qyiREYlinF
 qot2MO5f9VPvEKMkB5OSKK/QAY0kIb6k/JTKjMTijPii0pzU4kOMMhwcShK8/5ZoJgkJFqWmp
 1akZeYAYwQmLcHBoyTC+xgkzVtckJhbnJkOkTrFaMzxYOHevcwcfz/93cssxJKXn5cqJc77fi
 lQqQBIaUZpHtwgWOxeYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM+wZkCk9mXgncvldApzA
 BnWJnpAZySkkiQkqqgala2fvYpgbn2xH6Sk5pPmsm+bxVlP9cNSdLxzksZ+XrZy4LvwY1XbW/
 e/bcin3Xmpefr8ifuM9xwWPpF+4LbKdqrsz4uzT0N7P+NstuN8e1Mxn/CE7UWXa5OLTiZuzGB
 26JPOyGXuWmmd/lrlzWZeRYdfEjV2hlC/Pa57/7XP6y1HpOqtDT02rfy9jceXVlWGDUr4fc4j
 ZCjlPXdr+Kia/v03rGO/8gc8YisVUmE4/4X33vcmhj3dUjh95nMJ/4fsnQvEN83eMKoZLkFfe
 vNzc4/OHVXL7yB/9a8wM5+9u/nV16eKn2YuGFiwx8vvfo2m58vP3AFdX4MxMjVF8ZimTGx5uE
 Mk8/7BESfsrF9YsSS3FGoqEWc1FxIgCJ7RZ+WAMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1646896839!29055!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6058 invoked from network); 10 Mar 2022 07:20:39 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Mar 2022 07:20:39 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id C8221100457
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:20:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id BB40C100446
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:20:38 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Thu, 10 Mar 2022 07:20:26 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 10 Mar 2022 15:19:42 -0500
Message-ID: <1646943582-13826-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mount_setattr01: Add basic functional test
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
attributes are set and cleared correctly.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 include/lapi/fsmount.h                             |  29 ++++++
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/mount_setattr/.gitignore |   1 +
 testcases/kernel/syscalls/mount_setattr/Makefile   |   6 ++
 .../syscalls/mount_setattr/mount_setattr01.c       | 104 +++++++++++++++++++++
 5 files changed, 142 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/mount_setattr/Makefile
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index fa25306..99d0a0a 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -15,6 +15,26 @@
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY       0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID       0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV        0x00000004 /* Disallow access to device special files */
+#define MOUNT_ATTR_NOEXEC       0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR_NODIRATIME   0x00000080 /* Do not update directory access times */
+#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000 /* Do not follow symlinks */
+
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+
 #ifndef HAVE_FSOPEN
 static inline int fsopen(const char *fsname, unsigned int flags)
 {
@@ -61,6 +81,15 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
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
index 6186bfc..1a47a2e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -800,6 +800,8 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
 
+mount_setattr01 mount_setattr01
+
 move_mount01 move_mount01
 move_mount02 move_mount02
 
diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
new file mode 100644
index 0000000..52a77b9
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
@@ -0,0 +1 @@
+/mount_setattr01
diff --git a/testcases/kernel/syscalls/mount_setattr/Makefile b/testcases/kernel/syscalls/mount_setattr/Makefile
new file mode 100644
index 0000000..5ea7d67
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
index 0000000..b4b1d85
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Dai Shili <daisl.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic mount_setattr() test.
+ * Test whether the basic mount attributes are set and cleared correctly.
+ *
+ * Minimum Linux version required is v5.12.
+ */
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT        "mntpoint"
+#define OT_MNTPOINT     "ot_mntpoint"
+#define TCASE_ENTRY(_mount_attrs)	{.name = #_mount_attrs, .mount_attrs = _mount_attrs}
+
+static int dir_created;
+
+static struct tcase {
+	char *name;
+	unsigned int mount_attrs;
+} tcases[] = {
+	TCASE_ENTRY(MOUNT_ATTR_RDONLY),
+	TCASE_ENTRY(MOUNT_ATTR_NOSUID),
+	TCASE_ENTRY(MOUNT_ATTR_NODEV),
+	TCASE_ENTRY(MOUNT_ATTR_NOEXEC),
+	TCASE_ENTRY(MOUNT_ATTR_NOSYMFOLLOW),
+	TCASE_ENTRY(MOUNT_ATTR_NODIRATIME),
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
+
+	TEST(otfd = open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
+		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
+	if (otfd == -1) {
+		tst_res(TFAIL | TTERRNO, "open_tree() failed");
+		return;
+	}
+
+	TEST(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "mount_setattr() set attr %s failed.", tc->name);
+		return;
+	}
+
+	attr.attr_clr = tc->mount_attrs;
+
+	TEST(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "mount_setattr() clear attr %s failed.", tc->name);
+		return;
+	}
+
+	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
+		return;
+	}
+
+	SAFE_CLOSE(otfd);
+
+	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
+		SAFE_UMOUNT(OT_MNTPOINT);
+		tst_res(TPASS, "mount_setattr() set and clear attr %s passed.", tc->name);
+	}
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
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
