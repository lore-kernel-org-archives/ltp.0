Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC774C00140
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 02:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 502503C9223
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 04:24:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01F313C9223
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 04:24:00 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DF301A006BE
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 04:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1659493439; i=@fujitsu.com;
 bh=2yPhXpKSTfG8LDhfCpYAWFwmtbkETiC1vADyqZyErX0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=MyHFiTunCNqwrmH7U0eF0SvnqPjvh8M5/lxBsWhbu54htkcp9jFr7cypvwOxe9nAf
 vtF3ZqOxqqgEjDDh66XUnxjoBZHth3Sv+1N6KVBsOuTOJykpkB6kk2+be0T7JtArz8
 ZsjY62Fs9/3uteOmqWumSBpRMFtlXBM1jPU6vW/BzUS7BI+bTtLPryvQRVrOPXrq1o
 xUX5mZxalQsCsoBD6AoxkuddODAvieWw5dZKUj+Pyjc9rL/AfZN41IEthTp5TD7n4G
 vP6evkYp3DQY4Y70oXKmC7EPIh5tr+N0IV3Yjyyw22UU6CCVxHtuVsP9TQYcHxvw0q
 v08r3sABJrH5w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8ORqGt352W
 Swa9pvBavD39itFjxfQejxeG/x1ksfty6weLA4rFpVSebx77f61g91m+5yuJxZsER9gCWKNbM
 vKT8igTWjI13lzMWPNSv2Ld5GnMD40qNLkYuDiGBLYwSs+92sHQxcgI5y5kklr/NhkjsZpRYt
 e0hWIJNQFPiWecCZhBbREBCoqPhLTuIzSyQJfF62ivWLkYODmGBdIn+I7YgYRYBFYnG3idMID
 avgIfEraf9YOUSAgoSUx6+BxvDKeApMWd5FxPEXg+Jw3ues0PUC0qcnPmEBWK8hMTBFy+YIXo
 VJS51fGOEsCskXh++BBVXk7h6bhPzBEbBWUjaZyFpX8DItIrRMqkoMz2jJDcxM0fX0MBA19DQ
 VNdQ19RSL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMPhTihmtdzB29P3UO
 8QoycGkJMobVPUySYgvKT+lMiOxOCO+qDQntfgQowwHh5IE7+abQDnBotT01Iq0zBxgJMKkJT
 h4lER4590GSvMWFyTmFmemQ6ROMSpKifOygSQEQBIZpXlwbbDov8QoKyXMy8jAwCDEU5BalJt
 Zgir/ilGcg1FJmJcJZApPZl4J3PRXQIuZgBbrcL0AWVySiJCSamDS+v1tztnq0ChRP4MHsT+E
 5l0T1tdOcXl93Pnd7UqNSW82sshJLPpo7WO7Viv0pt+eLdMqQxI3On1YU9n8wGIR85e/IfMCS
 qIfX826EyfWFnP2jEj9g96D9ZfMnzkJer9jXXTZvlF76b8bN25wV96JX+FdYyWrsfZHWP3rS3
 n3Pksuz2mR4z3z5XZe/uYb3B7nztwM19cUYU80VTvpJGCuaHKshMs5ucvGs3RGgu4uP8u1f1c
 dNLwjyJGfIrTS59zLCU2n5Vr+fJh48H7Eq9pVqs/zzhmGNwa9/Xf0ivRd3qbdxyInOZT3Hz7Y
 uzrJXePo14sSr891pfYtk3v8IHnTxHQnHq88wcipv+5lpicpsRRnJBpqMRcVJwIAwzBzYHkDA
 AA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1659493437!110533!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18038 invoked from network); 3 Aug 2022 02:23:58 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Aug 2022 02:23:58 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C8E84100191;
 Wed,  3 Aug 2022 03:23:57 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BC0DB100043;
 Wed,  3 Aug 2022 03:23:57 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 03:23:55 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 3 Aug 2022 11:24:23 +0800
Message-ID: <1659497063-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/openat: Add new regression test when
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
Cc: brauner@kernel.org, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1-v2:
no change
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/openat/.gitignore |   1 +
 testcases/kernel/syscalls/openat/openat04.c | 194 ++++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/openat/openat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3847e8af2..448b5613c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -920,10 +920,10 @@ open12 open12
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
index 000000000..323d9a971
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat04.c
@@ -0,0 +1,194 @@
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
+ * filesystem without posix acl supported(by using noacl mount option). Test it
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
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
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
+			tst_brk(TBROK | TTERRNO, "open(%d, O_TMPFILE) failed", dirfd);
+	}
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
+}
+
+static void file_test(int dfd, const char *path, int flags)
+{
+	struct stat buf;
+
+	TST_EXP_PASS_SILENT(fstatat(dfd, path, &buf, flags));
+	if (!TST_PASS) {
+		tst_res(TFAIL, "fstat failed");
+		return;
+	}
+
+	if (buf.st_gid != free_gid) {
+		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
+			buf.st_gid, free_gid);
+	} else {
+		tst_res(TPASS, "%s: Owned by correct group", path);
+	}
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
+	int pid;
+	char path[PATH_MAX];
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		  /* Switch user */
+		SAFE_SETGID(ltpuser->pw_gid);
+		SAFE_SETREUID(-1, ltpuser->pw_uid);
+
+		umask(S_IXGRP);
+		tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
+		snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
+		SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
+		file_test(dir_fd, OPEN_FILE, 0);
+		SAFE_CLOSE(tmpfile_fd);
+		/* Cleanup between loops */
+		tst_purge_dir(WORKDIR);
+	}
+
+	tst_reap_children();
+}
+
+static void cleanup(void)
+{
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
+	.forks_child = 1,
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
+		{}
+	},
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
