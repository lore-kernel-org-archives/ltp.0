Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFEDECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 07:12:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D6133CABF2
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:12:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02D683CAC07
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:53 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A1831A014AA
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1663139512; i=@fujitsu.com;
 bh=SrJERncJAMYv8zzrUURP3/0hPe36ZpeW44W13OPKI0s=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=bYmC/Fh3JtU2AmBSXYzsxdt3zhUdEwmKvilIzAnGoHMm5n45i2dyJMvoXJcyxO4WO
 ARtKiBGzmCtX2N2Y6fa9CxUpkpc7MrvjKPJeexVSowWdlcaTwcYoHCfPzFuUY9K4cm
 hP5ZHvV07k3aYeNJUvj2FEzqLES9/OYswixms2MFf7816EOzUaYuqvFq1KxoJdvrcT
 AKz9mwPjz8oCMvjIGNpFdTtB2bmB3ZLr9Bucc1H0+QGBE5N2ZBpDfwwET66oLdpDdw
 mMX4Gk6ue+GjRMx1zMDqmwszCoFC89K3h0+iah1VfPB6IO+Q20aRnVy/lQl4vndg0J
 CKV1iI9ISLIJg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsViZ8OxWXd7nWK
 ywd7TmhavD39itJj+4iibxYrvOxgdmD02repk89j3ex2rx5kFR9gDmKNYM/OS8isSWDPutTWx
 FqzQrTi1t42lgXG/WhcjF4eQwEZGiecrnzF2MXICOUuYJD4tCYFI7GGUuLhzCxNIgk1AU+JZ5
 wJmEFtEQEKio+EtO4jNLBAoceZYByuILSyQLnHu/hewehYBVYmZnzrBangFPCTuLWlmA7ElBB
 Qkpjx8DzaHU8BT4tDXacwQiz0kXp1+xwZRLyhxcuYTFoj5EhIHX7xghuhVlLjU8Y0Rwq6QaJx
 +iAnCVpO4em4T8wRGwVlI2mchaV/AyLSK0SapKDM9oyQ3MTNH19DAQNfQ0FTX0kLXyNhYL7FK
 N1EvtVQ3L7+oJEPXUC+xvFgvtbhYr7gyNzknRS8vtWQTIzDgU4qTXu5gPL/vl94hRkkOJiVR3
 g9fFZKF+JLyUyozEosz4otKc1KLDzHKcHAoSfDuqFVMFhIsSk1PrUjLzAFGH0xagoNHSYR3Uj
 5Qmre4IDG3ODMdInWKUVFKnPdxNVBCACSRUZoH1waL+EuMslLCvIwMDAxCPAWpRbmZJajyrxj
 FORiVhHmngGznycwrgZv+CmgxE9BiI2t5kMUliQgpqQamRcFLGBom/ZFWZuMR9luy8m1Xa3Bm
 yBmVez+EPz/9OVtY4cYe7SNmwodeBF7I5faWYjTiae2Trru+Vcz2yoZlqQEPr5yZNW9phqPDq
 hC+PEW3om/XjpouPFM240fZ13VR5ZOEmK09HzcE/TZ8dZfp2KdSmdX7+mTdNHbdX9DLHpJ5Ls
 rSuXulz+p/3t/W7dPgUznvcs56147SJfGv3/A1OZbyKCq5hV/ftW7GgvdbhM4Eawf/5r/pu2L
 i3Yi3u0t8tCaIz5NafOvkr6nvczY6SRe0LXdNkLNX++p1l4VL9/vfvQeuWM3U+/wiveLAKr8p
 +QYnRC8wfV/dXZBbv+StnvVHvhr9R9H3ivMfPxBoVWIpzkg01GIuKk4EAILsX09zAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-732.messagelabs.com!1663139511!373926!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17578 invoked from network); 14 Sep 2022 07:11:51 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-6.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Sep 2022 07:11:51 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 13BFB156;
 Wed, 14 Sep 2022 08:11:51 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 0642E142;
 Wed, 14 Sep 2022 08:11:51 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 14 Sep 2022 08:11:48 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Sep 2022 16:12:22 +0800
Message-ID: <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test when
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
Cc: brauner@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/openat/.gitignore |   1 +
 testcases/kernel/syscalls/openat/openat04.c | 181 ++++++++++++++++++++
 3 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/openat/openat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9d58e0aa1..cd38a4ddf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -919,10 +919,10 @@ open12 open12
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
index 000000000..1fbe51c60
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat04.c
@@ -0,0 +1,181 @@
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
+		{}
+	},
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
