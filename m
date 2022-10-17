Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB09C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 07:49:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87DF03CAFD1
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 09:49:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16B583CAFEA
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:49:27 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5341C1A006F2
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1665992965; i=@fujitsu.com;
 bh=S1ahXPbpWmy79DE27Q/k+sgLBna1/XPLIAroyCRnSSY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=g+ZrhRMxWQJNZGKchLo1JUcc3TrbuUs1XgXXNf9TymFCkqh0wjT3qVaSaFvwkbsmI
 L/GIb+eJiqwGbCjkFaFgNNH/8rD4TRonADfNMo0lMt76F5LZIGb/+LiLG0oGS6PKLc
 yrfyWAXkyuN/DG00JoT9bftp2JT47zLeGBrU9Sik6ZHCaKFic2LWoBgyq21+cqguL5
 0LS9MzRTsp9uozwc46PslC4myLS2QQD6xliBZzrLwhvjKSl1ImUVGFjvHxjG6tswEr
 l6fGDbpywN8CMm7b89mcW7D1QN5+JdDp+1RWCsq8KgZgRsnBA8zYwmmhHZIA4fdA3D
 d7merUpMPhlHA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8ORpMvC6Zt
 s0HvH0OL14U+MFtNfHGWzWPF9B6MDs8emVZ1sHvt+r2P1OLPgCHsAcxRrZl5SfkUCa8bVGZ1M
 BZ91K7Ze/sDcwPhfrYuRi0NIYCOjxIUNd1khnCVMEoe3rmGDcPYwSvR3zmHsYuTkYBPQlHjWu
 YAZxBYREJX4PP0cmM0sECIx4dEeJhBbWCBd4u21h2wgNouAqsSRX8dZQGxeAQ+Jmxv+gs2REF
 CQmPLwPVAvBwengKfE0oOZIGEhoJKrlw4xQpQLSpyc+YQFYryExMEXL5ghWhUlLnV8gxpTITF
 rVhsThK0mcfXcJuYJjIKzkLTPQtK+gJFpFaNZcWpRWWqRrqVeUlFmekZJbmJmjl5ilW6iXmqp
 bl5+UUmGrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgkKcUp+fuYLy07I/eIUZJDiYlUd5Zf32Sh
 fiS8lMqMxKLM+KLSnNSiw8xynBwKEnwHgLJCRalpqdWpGXmACMOJi3BwaMkwuvI6pssxFtckJ
 hbnJkOkTrFqCglzuvCAZQQAElklObBtcGi/BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5
 RkCk8mXklcNNfAS1mAlqcsd8LZHFJIkJKqoGpisPHKcXIdWZZ9KmD/XIiJqW+qVuv9Pc9i6vR
 2Ll1p/i0RXNv8W9zmfN63cT+I8YZadM0muZw7r/A7h7L+dLB8N2ZB/6rmsIbWdpLN98SL12/z
 +Xdk5SY9mNdGZGfNs34W3z0yJ8Vuf/CM7ZMer859QDjwl1JiZendX/VfCiRZ793unXcsqsX1O
 1yHq3p7nl+K2F3IU/0ssLzRnIVejdv7FjH4cD6yt9Fa+atuL2Hw67fMttZeKPtf4LuGRWV+79
 fsXdfPT1lnsQVzYbVyY3iR5raODfe332Yf/Pp71d3yprn//R0PDB32fdLvCyBW5IOv+x4a2Wz
 xvXqx9fZX47/Ocklto3h0u1HJ3repu7sfaTEUpyRaKjFXFScCABwgqfObQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-728.messagelabs.com!1665992964!156268!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25880 invoked from network); 17 Oct 2022 07:49:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-16.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Oct 2022 07:49:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 32E8E1B2;
 Mon, 17 Oct 2022 08:49:24 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 213311B1;
 Mon, 17 Oct 2022 08:49:24 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 17 Oct 2022 08:49:21 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <chrubis@suse.cz>
Date: Mon, 17 Oct 2022 16:49:59 +0800
Message-ID: <1665996599-6420-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665996599-6420-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1665996599-6420-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
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
Cc: brauner@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v4->v5: add 426b4ca2d6a5 to the test tag
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/openat/.gitignore |   1 +
 testcases/kernel/syscalls/openat/openat04.c | 182 ++++++++++++++++++++
 3 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/openat/openat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c81764df4..776a121f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -918,10 +918,10 @@ open12 open12
 open13 open13
 open14 open14
 
-#openat test cases
 openat01 openat01
 openat02 openat02
 openat03 openat03
+openat04 openat04
 
 openat201 openat201
 openat202 openat202
diff --git a/testcases/kernel/syscalls/openat/.gitignore b/testcases/kernel/syscalls/openat/.gitignore
index 2928dae22..2d15872ab 100644
--- a/testcases/kernel/syscalls/openat/.gitignore
+++ b/testcases/kernel/syscalls/openat/.gitignore
@@ -2,3 +2,4 @@
 /openat02
 /openat02_child
 /openat03
+/openat04
diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
new file mode 100644
index 000000000..f99911d25
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat04.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check setgid strip logic whether works correctly when creating tmpfile under
+ * filesystem without POSIX ACL supported(by using noacl mount option). Test it
+ * with umask S_IXGRP and also check file mode whether has filtered S_IXGRP.
+ *
+ * Fixed in:
+ *
+ *  commit ac6800e279a22b28f4fc21439843025a0d5bf03e
+ *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ *  Date:   Thu July 14 14:11:26 2022 +0800
+ *
+ *  fs: Add missing umask strip in vfs_tmpfile
+ *
+ * The most code is pasted form creat09.c.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "tst_safe_file_at.h"
+
+#define MODE_RWX        0777
+#define MODE_SGID       (S_ISGID|0777)
+#define MNTPOINT	"mntpoint"
+#define WORKDIR		MNTPOINT "/testdir"
+#define OPEN_FILE	"open.tmp"
+
+static gid_t free_gid;
+static int tmpfile_fd = -1, dir_fd = -1, mount_flag;
+static struct passwd *ltpuser;
+
+static void do_mount(const char *source, const char *target,
+	const char *filesystemtype, unsigned long mountflags,
+	const void *data)
+{
+	TEST(mount(source, target, filesystemtype, mountflags, data));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL)
+		tst_brk(TCONF, "Kernel does not support noacl feature");
+
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
+
+	if (TST_RET)
+		tst_brk(TBROK, "Invalid mount return value %ld", TST_RET);
+
+	mount_flag = 1;
+}
+
+static void open_tmpfile_supported(int dirfd)
+{
+	TEST(openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID));
+
+	if (TST_RET == -1) {
+		if (errno == ENOTSUP)
+			tst_brk(TCONF, "fs doesn't support O_TMPFILE");
+		else
+			tst_brk(TBROK | TTERRNO, "openat(%d, O_TMPFILE) failed", dirfd);
+	}
+
+	if (TST_RET < 0)
+		tst_brk(TBROK, "Invalid openat return value %ld", TST_RET);
+
+	SAFE_CLOSE(TST_RET);
+}
+
+static void setup(void)
+{
+	struct stat buf;
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noacl");
+
+	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
+		(int)ltpuser->pw_gid);
+	free_gid = tst_get_free_gid(ltpuser->pw_gid);
+
+	/* Create directories and set permissions */
+	SAFE_MKDIR(WORKDIR, MODE_RWX);
+	dir_fd = SAFE_OPEN(WORKDIR, O_RDONLY, O_DIRECTORY);
+	open_tmpfile_supported(dir_fd);
+
+	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
+	SAFE_CHMOD(WORKDIR, MODE_SGID);
+	SAFE_STAT(WORKDIR, &buf);
+
+	if (!(buf.st_mode & S_ISGID))
+		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
+
+	if (buf.st_gid != free_gid) {
+		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
+			buf.st_gid, free_gid);
+	}
+
+	/* Switch user */
+	SAFE_SETGID(ltpuser->pw_gid);
+	SAFE_SETREUID(-1, ltpuser->pw_uid);
+}
+
+static void file_test(int dfd, const char *path, int flags)
+{
+	struct stat buf;
+
+	SAFE_FSTATAT(dfd, path, &buf, flags);
+
+	TST_EXP_EQ_LI(buf.st_gid, free_gid);
+
+	if (buf.st_mode & S_ISGID)
+		tst_res(TFAIL, "%s: Setgid bit is set", path);
+	else
+		tst_res(TPASS, "%s: Setgid bit not set", path);
+
+	if (buf.st_mode & S_IXGRP)
+		tst_res(TFAIL, "%s: S_IXGRP bit is set", path);
+	else
+		tst_res(TPASS, "%s: S_IXGRP bit is not set", path);
+}
+
+static void run(void)
+{
+	char path[PATH_MAX];
+
+	umask(S_IXGRP);
+	tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
+	snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
+	SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
+	file_test(dir_fd, OPEN_FILE, 0);
+	SAFE_CLOSE(tmpfile_fd);
+	/* Cleanup between loops */
+	tst_purge_dir(WORKDIR);
+}
+
+static void cleanup(void)
+{
+	SAFE_SETREUID(-1, 0);
+
+	if (tmpfile_fd >= 0)
+		SAFE_CLOSE(tmpfile_fd);
+	if (dir_fd >= 0)
+		SAFE_CLOSE(dir_fd);
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char*[]) {
+		"exfat",
+		"ntfs",
+		"vfat",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ac6800e279a2"},
+		{"linux-git", "426b4ca2d6a5"},
+		{}
+	},
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
