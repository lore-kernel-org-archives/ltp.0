Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A6C433EF
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 03:03:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39F0B3C973B
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 04:03:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 972F63C03AE
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 04:03:06 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42B5F600687
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 04:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1643338981; i=@fujitsu.com;
 bh=F4pdRTH2DM864vCtwjtqTMAuPAj28PSd6ruAGu1X46c=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=EzUxPicohYwmvd0t39dAE213QAH+LcdlEZJNPnLTgNu22m5CcdWIXpYiVb7ieRRvc
 N4htnmWyjiPl1yJZM/nvWxtMT943CEhzKE4V075nyyHdsAqpqFi2k170otzPQF+sMR
 CpmPxnah4agPAup8VjfIftylisyiv877ck/B2dqj2g+hm+hUCzuqZl4GiQKweXTFp7
 0aV2MJq3qTXfi3VWMNqDZ7AOCW8KHViV3y2v6HxdZinbmL5kOeIfoJd2XZGlP0lciL
 VlOq6bDiS7M10ahjAJ8MWsNEK3Vsclgp4OEeYAwqGqhkicWBaAkIMPZk4K1KqFxD/C
 UE1U3Iw26ZvYA==
Received: from [100.115.34.7] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 23/2E-29321-4EC53F16;
 Fri, 28 Jan 2022 03:03:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8ORqPsk5nO
 iwdtPKhbTXxxls1jxfQejA5PHvt/rWD3OLDjCHsAUxZqZl5RfkcCacWDWVZaCrY4Vc86tZGxg
 3GnexcjFISSwhVGi83QfC4SzgEniyfFzzBDOfkaJe9N+sXUxcnKwCWhIXHvczgxiiwiISnyef
 g7MZhawkdh3dQKYLSxgJLFxw212EJtFQFXi8c7tTCA2r4CrxNPTFxhBbAkBBYkpD98D1XNwcA
 qoSPz74QYSFhJQltg4+w0bRLmgxMmZT1ggxktIHHzxghmiVVFi/96NUGMqJGbM2MYGYatJXD2
 3iXkCo+AsJO2zkLQvYGRaxWidVJSZnlGSm5iZo2toYKBraGiqa2yqa2hhopdYpZuol1qqW55a
 XKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERjaKcXKO3Ywtq36qXeIUZKDSUmUt5zvc6IQX1J+S
 mVGYnFGfFFpTmrxIUYZDg4lCV5TP6CcYFFqempFWmYOMM5g0hIcPEoivEbAWBPiLS5IzC3OTI
 dInWLU5WietHw7sxBLXn5eqpQ4ry5IkQBIUUZpHtwIWMxfYpSVEuZlZGBgEOIpSC3KzSxBlX/
 FKM7BqCTM+y8aaApPZl4J3KZXQEcwAR2x7cgnkCNKEhFSUg1MAjX7VVYZtCztOBGq99M0zclB
 PayjxfD1g8PhZ5/t/Ra9b8OJ0NL81s3Mnx0efvfOc1S9G5nw7066efFejcdOkSU2364vNttb+
 k55/6aulxw64cW5ibqXlwsHWxm85JuQ/Nvt15zHXf3L26deNvedUlkfFne4ivXVgZstFzcpLD
 1zRPgK69Q92usX3mPbX9d8RV3n1iRmtQVRrzcx+UQfeXDPv+hN4CPxvtfJp629ORticlIv/1Z
 +u011wvLz0blPlSb+ZRGMWj7JxUg5mO3n1x17xcLmr6i6+4bl6Cz92FSXg3El+VtSum+1RqU+
 XyF0/ND9b4vfvZrJMGWKu+E8xt0HLIQ/N27a8y5TyVbwqBJLcUaioRZzUXEiAIMqvWl0AwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-571.messagelabs.com!1643338980!29458!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2974 invoked from network); 28 Jan 2022 03:03:00 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Jan 2022 03:03:00 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3EC9C100189;
 Fri, 28 Jan 2022 03:03:00 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3254510004D;
 Fri, 28 Jan 2022 03:03:00 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 28 Jan 2022 03:02:38 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <chrubis@suse.cz>
Date: Thu, 27 Jan 2022 22:02:27 -0500
Message-ID: <1643338947-1436-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YfKkxx1y4Ctgn0IX@yuki>
References: <YfKkxx1y4Ctgn0IX@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/statx09: Add new test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test is basically the same as statx04 but here we check for the
STATX_ATTR_VERITY flag which is currently only implemented on ext4.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 configure.ac                               |   1 +
 include/lapi/fs.h                          |   4 +
 include/lapi/fsverity.h                    |  38 +++++++
 include/lapi/stat.h                        |   4 +
 m4/ltp-fsverity.m4                         |  10 ++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx09.c  | 161 +++++++++++++++++++++++++++++
 8 files changed, 220 insertions(+)
 create mode 100644 include/lapi/fsverity.h
 create mode 100644 m4/ltp-fsverity.m4
 create mode 100644 testcases/kernel/syscalls/statx/statx09.c

diff --git a/configure.ac b/configure.ac
index 3c56d19..aeb486f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -367,6 +367,7 @@ LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_FCNTL
+LTP_CHECK_FSVERITY
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index aafeab4..27b3a18 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -41,6 +41,10 @@
 #define FS_NODUMP_FL	   0x00000040 /* do not dump file */
 #endif
 
+#ifndef FS_VERITY_FL
+#define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
+#endif
+
 /*
  * Helper function to get MAX_LFS_FILESIZE.
  * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
diff --git a/include/lapi/fsverity.h b/include/lapi/fsverity.h
new file mode 100644
index 0000000..66bea15
--- /dev/null
+++ b/include/lapi/fsverity.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Dai Shili <daisl.fnst@cn.fujitsu.com>
+ */
+#ifndef LAPI_FSVERITY_H__
+#define LAPI_FSVERITY_H__
+
+#include "config.h"
+#include <stdint.h>
+
+#ifdef HAVE_LINUX_FSVERITY_H
+#include <linux/fsverity.h>
+#endif
+
+#ifndef FS_VERITY_HASH_ALG_SHA256
+# define FS_VERITY_HASH_ALG_SHA256       1
+#endif
+
+#ifndef HAVE_STRUCT_FSVERITY_ENABLE_ARG
+struct fsverity_enable_arg {
+	uint32_t version;
+	uint32_t hash_algorithm;
+	uint32_t block_size;
+	uint32_t salt_size;
+	uint64_t salt_ptr;
+	uint32_t sig_size;
+	uint32_t __reserved1;
+	uint64_t sig_ptr;
+	uint64_t __reserved2[11];
+};
+#endif
+
+#ifndef FS_IOC_ENABLE_VERITY
+# define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
+#endif
+
+#endif
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index d596058..ce1f2b6 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -223,6 +223,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_AUTOMOUNT	0x00001000
 #endif
 
+#ifndef STATX_ATTR_VERITY
+# define STATX_ATTR_VERITY	0x00100000
+#endif
+
 #ifndef AT_SYMLINK_NOFOLLOW
 # define AT_SYMLINK_NOFOLLOW	0x100
 #endif
diff --git a/m4/ltp-fsverity.m4 b/m4/ltp-fsverity.m4
new file mode 100644
index 0000000..7104886
--- /dev/null
+++ b/m4/ltp-fsverity.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2022 Fujitsu Ltd.
+dnl Author: Dai Shili <daisl.fnst@fujitsu.com>
+
+AC_DEFUN([LTP_CHECK_FSVERITY],[
+	AC_CHECK_HEADERS([linux/fsverity.h], [have_fsverity=yes], [AC_MSG_WARN(missing linux/fsverity.h header)])
+	if test "x$have_fsverity" = "xyes"; then
+		AC_CHECK_TYPES(struct fsverity_enable_arg,,,[#include <linux/fsverity.h>])
+	fi
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 3b2deb6..7ba0331 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1744,6 +1744,7 @@ statx05 statx05
 statx06 statx06
 statx07 statx07
 statx08 statx08
+statx09 statx09
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 4db060d..1cea43c 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -6,3 +6,4 @@
 /statx06
 /statx07
 /statx08
+/statx09
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
new file mode 100644
index 0000000..230176b
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Dai Shili <daisl.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This code tests if the attributes field of statx received expected value.
+ * File set with following flags by using SAFE_IOCTL:
+ *
+ * - STATX_ATTR_VERITY: statx() system call sets STATX_ATTR_VERITY if the file
+ * has fs-verity enabled. This can perform better than FS_IOC_GETFLAGS and
+ * FS_IOC_MEASURE_VERITY because it doesn't require opening the file,
+ * and opening verity files can be expensive.
+ *
+ * Minimum Linux version required is v5.5.
+ */
+
+#define _GNU_SOURCE
+#include <sys/mount.h>
+#include <stdlib.h>
+#include <linux/ioctl.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include "lapi/fsverity.h"
+#include "lapi/stat.h"
+#include <inttypes.h>
+
+#define MNTPOINT "mnt_point"
+#define TESTFILE_FLAGGED MNTPOINT"/test_file3"
+#define TESTFILE_UNFLAGGED MNTPOINT"/test_file4"
+
+static int mount_flag;
+
+static const uint32_t hash_algorithms[] = {
+	FS_VERITY_HASH_ALG_SHA256,
+};
+
+static void test_flagged(void)
+{
+	struct statx buf;
+
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_FLAGGED, 0, 0, &buf),
+		"statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_FLAGGED);
+
+	if (buf.stx_attributes & STATX_ATTR_VERITY)
+		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ",
+			(uint64_t)buf.stx_attributes);
+	else
+		tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
+}
+
+static void test_unflagged(void)
+{
+	struct statx buf;
+
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_UNFLAGGED, 0, 0, &buf),
+		"statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_UNFLAGGED);
+
+	if ((buf.stx_attributes & STATX_ATTR_VERITY) == 0)
+		tst_res(TPASS, "STATX_ATTR_VERITY flag is not set");
+	else
+		tst_res(TFAIL, "STATX_ATTR_VERITY flag is set");
+}
+
+static struct test_cases {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_flagged},
+	{&test_unflagged},
+};
+
+static void run(unsigned int i)
+{
+	tcases[i].tfunc();
+}
+
+static void flag_setup(void)
+{
+	int fd, attr, ret;
+	struct fsverity_enable_arg enable;
+
+	fd = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
+
+	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+	if (ret < 0) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
+
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
+	}
+
+	memset(&enable, 0, sizeof(enable));
+	enable.version = 1;
+	enable.hash_algorithm = hash_algorithms[0];
+	enable.block_size = 4096;
+	enable.salt_size = 0;
+	enable.salt_ptr = (intptr_t)NULL;
+	enable.sig_size = 0;
+	enable.sig_ptr = (intptr_t)NULL;
+
+	ret = ioctl(fd, FS_IOC_ENABLE_VERITY, &enable);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF,
+				"fs-verity is not supported on the file system or by the kernel");
+		}
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd);
+	}
+
+	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+	if ((ret == 0) && !(attr & FS_VERITY_FL))
+		tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
+	if (TST_RET) {
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF, "fs-verity not supported on loopdev");
+
+		tst_brk(TBROK | TERRNO, "mount() failed with %ld", TST_RET);
+	}
+	mount_flag = 1;
+
+	SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");
+	SAFE_FILE_PRINTF(TESTFILE_UNFLAGGED, "a");
+
+	flag_setup();
+}
+
+static void cleanup(void)
+{
+	if (mount_flag)
+		tst_umount(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_fs_opts = (const char *const []){"-O verity", NULL},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_FS_VERITY",
+		NULL
+	},
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 >= 1.45.2",
+		NULL
+	}
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
