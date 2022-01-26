Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F462C3525A
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 03:01:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 993273C9696
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 04:01:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1798B3C0C9F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 04:01:28 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 374EC600F50
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 04:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1643166083; i=@fujitsu.com;
 bh=2Jv9CuXoJeCwMY/ntGJ9//u4qPcHZSgg5RIDBpdDhMU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=GbLRrNkJi9Yu+3fo9TLEHFNH7kG9YbI7/YchQBkr4Z/MukXiH0UWdEKvYMyq9OUXA
 IHv6I1ricuwPB7qLwhHczpEmXE6wsDr5PO9SAcTmqoeWeNr7Xj2vVevwPsbSt4Kk8a
 Zsqv6rc3DZ5MVXteUc8ZzQIyPM/MsRjYDHL5ZQCpEcXpkuAWxwn4dasqm0lsCB75n0
 9llvpJa9t0Lyp2dA0MZxPkrK08hILO9gaFPwMnvOjmtCkGsGB0gsKGsZMf8pwW0mC6
 omeXqZJ8aPN8Qk+5YRW0gBhmykXYdvS0SlnfmJ0nkiQ97apLWSRjZvvH24me7dFk/i
 rce9EiFncqHDw==
Received: from [100.115.65.91] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id D4/7D-30582-389B0F16;
 Wed, 26 Jan 2022 03:01:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsViZ8MxSbdp54d
 Eg+WNxhbTXxxls1jxfQejA5PHvt/rWD3OLDjCHsAUxZqZl5RfkcCacfHEX6aCw64Vp6Y1MzYw
 /rfqYuTiEBLYwijx9MdvVghnAZPEvN+LGLsYOYGc/YwStyengdhsAhoS1x63M4PYIgKiEp+nn
 wOzmQVsJPZdnQBmCwsYSTTvfcYGYrMIqEpcf3YMyObg4BVwk1h3LgEkLCGgIDHl4Xuwck4BFY
 mG9T+hVilLLH99ixXE5hUQlDg58wkLxHgJiYMvXjBD9CpK7N+7kRHCrpCYMWMbG4StJnH13Cb
 mCYyCs5C0z0LSvoCRaRWjXVJRZnpGSW5iZo6uoYGBrqGhqa6Zua6hmZleYpVuol5qqW5yal5J
 USJQWi+xvFgvtbhYr7gyNzknRS8vtWQTIzC8U4qdl+1gfNf3U+8QoyQHk5Io70udD4lCfEn5K
 ZUZicUZ8UWlOanFhxhlODiUJHh/bgfKCRalpqdWpGXmAGMNJi3BwaMkwvt4B1Cat7ggMbc4Mx
 0idYpRl6N50vLtzEIsefl5qVLivIobgIoEQIoySvPgRsDi/hKjrJQwLyMDA4MQT0FqUW5mCar
 8K0ZxDkYlYd4fIJfwZOaVwG16BXQEE9ARv8+/AzmiJBEhJdXAJDPH+PcJIV+BdLbNbfEynYon
 ypUWMHCsYpKPaVha9tssS1Npx31+FbufbF2Sq96ElHClSP5xiDq2quMybx3jxpPhi01SRarnB
 2q/P9n4MEJlyco3r/cYZwhXVc9n2fr1gIiErtJLkeOWD1dmz1XdZfo85rqxr5r2LftlspOlJd
 g8LE0m5K+425Ij3fNhX+zZ++/fBkY6fFzvOmHv/tLnO3SblV9v22/BzsY3QUk+msNy49n5jqn
 Fq3+W7LyVs59z6teUjRtYPXk3B52S7H2sKH/+oqLfjXVsLGkVHpNMdp/J7eAUaOA5OPNlvvDk
 Y1zxskrOl7nWf3DbZ8jH0/z7Qwxv9YV9U2bN2imVXvhKiaU4I9FQi7moOBEAtsJnC3YDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-23.tower-532.messagelabs.com!1643166082!61238!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6872 invoked from network); 26 Jan 2022 03:01:22 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-23.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 26 Jan 2022 03:01:22 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5E6A0100353;
 Wed, 26 Jan 2022 03:01:22 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 51B841000FE;
 Wed, 26 Jan 2022 03:01:22 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 26 Jan 2022 03:01:05 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <chrubis@suse.cz>
Date: Tue, 25 Jan 2022 22:00:57 -0500
Message-ID: <1643166057-25026-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ye6sWQ/kRf1V1FWy@yuki>
References: <Ye6sWQ/kRf1V1FWy@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/statx09: Add new test
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
 testcases/kernel/syscalls/statx/statx09.c  | 172 +++++++++++++++++++++++++++++
 8 files changed, 231 insertions(+)
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
index 0000000..0125fa8
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
+#include <linux/types.h>
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
+	__u32 version;
+	__u32 hash_algorithm;
+	__u32 block_size;
+	__u32 salt_size;
+	__u64 salt_ptr;
+	__u32 sig_size;
+	__u32 __reserved1;
+	__u64 sig_ptr;
+	__u64 __reserved2[11];
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
index 0000000..76716bf
--- /dev/null
+++ b/m4/ltp-fsverity.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2022 Fujitsu Ltd.
+dnl Author: Dai Shili <daisl.fnst@cfujitsu.com>
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
index 0000000..8fc3703
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -0,0 +1,172 @@
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
+ * fs-verity is currently supported by the ext4 and f2fs filesystems.
+ * The CONFIG_FS_VERITY kconfig option must be enabled to use fs-verity
+ * on either filesystem.
+ * ext4 supports fs-verity since Linux v5.4 and e2fsprogs v1.45.2.
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
+static int fd_flagged, fd_unflagged;
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
+		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ", buf.stx_attributes);
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
+	int attr, ret;
+	struct fsverity_enable_arg enable;
+
+	fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
+
+	ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
+	if (ret < 0) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
+
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd_flagged);
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
+	ret = ioctl(fd_flagged, FS_IOC_ENABLE_VERITY, &enable);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF,
+				"fs-verity is not supported on the file system or by the kernel");
+		}
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd_flagged);
+	}
+
+	ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
+	if ((ret == 0) && !(attr & FS_VERITY_FL))
+		tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd_flagged);
+
+	SAFE_CLOSE(fd_flagged);
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
+	fd_unflagged = SAFE_OPEN(TESTFILE_UNFLAGGED, O_RDWR | O_CREAT, 0664);
+	fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDWR | O_CREAT, 0664);
+	SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");
+	SAFE_CLOSE(fd_flagged);
+
+	flag_setup();
+}
+
+static void cleanup(void)
+{
+	if (fd_flagged > 0)
+		SAFE_CLOSE(fd_flagged);
+	if (fd_unflagged > 0)
+		SAFE_CLOSE(fd_unflagged);
+
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
