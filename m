Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7497EC43334
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 09:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD583C9F67
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 11:27:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20FA03CA105
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:27:36 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B5D71000A35
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1658482054; i=@fujitsu.com;
 bh=WPtZOman6vM0QWnCFmT2VNMbDXkDKo7tJLdlm1b4kxU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=dSueckRnzfpspo6KMF+pHVG+SRqcEx5RDtwDgi00Wj8lCBxSagCSkI+Jy33wPHvBx
 F5FmRFOgfKwSlZK+T50OUqY8LAhtXkufhyXkHM/P4E92Xn27kAIcWORpa1wlQlb1yr
 RKvU/AgViGZqzbTAnbWog5EOKMA3sG+nP149zLow5LktPDSJ33R1aDDHbS/9CR33EN
 vd3/mgg4VMsvusUpMAj056HU4Qe10Gewl5PG/uU2KQnuLipCQLJILBljgeF38OYu6J
 Jyn0UwRBPcUUB2OlCdHD6icmYL/WlFkDGhO52hwyKCelJKCJkDWvKAEgxXCG4wY/Wn
 9lo2j85r8Fc+g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8OxWbc191a
 SwbdOPYvXhz8xWqz4voPR4setGywOzB6bVnWyeez7vY7V48yCI+wBzFGsmXlJ+RUJrBnPJtxj
 KrigX3Fvwl/mBsbZGl2MXBxCAhsYJR5/3cPYxcgJ5Cxmkmg6yQaR2MMosff+TFaQBJuApsSzz
 gXMILaIgIRER8NbdhCbWSBA4ubTRWBxYYF0iTkTloMNYhFQlVj1FsLmFfCQ6L3RygZiSwgoSE
 x5+B6snlPAU2L31I1ANgfQMg+JE6+LIMoFJU7OfMICMV5C4uCLF8wQrYoSlzq+MULYFRKvD1+
 CiqtJXD23iXkCo+AsJO2zkLQvYGRaxWiVVJSZnlGSm5iZo2toYKBraGiqCyRNTfQSq3QT9VJL
 dctTi0t0DfUSy4v1UouL9Yorc5NzUvTyUks2MQJDPaWYYdYOxll9P/UOMUpyMCmJ8vYJ30oS4
 kvKT6nMSCzOiC8qzUktPsQow8GhJMH7ORMoJ1iUmp5akZaZA4w7mLQEB4+SCK96DlCat7ggMb
 c4Mx0idYpRUUqc90w2UEIAJJFRmgfXBov1S4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeY1
 AxvNk5pXATX8FtJgJaLG5+Q2QxSWJCCmpBqaIJS3b1HgE/+hPuNY627tnj/bEKrZND6fdfsqX
 vVbg4ofi8J6q6HaeR1OrnjmYe56/UDW59Oqe1DyVHCP7hVOu84VoSd+z9N8fdej1u41ivLFH6
 uw/z70b9v/YjPztmnUdMXxc/Nt+FC25s5Gl6PaGqvksE16rPrm1eknN4vA1xj38107fDuipim
 fl2HnnlfHeSxHv/DdvfX1g16XerVcrOPcxrCkLiI96zJOSrT9nu7hn1fUJv0JXpnVU3nGu+5N
 9oD4j6qTreuc/TkEsUVNWFpx9mP9ispZAu3HG27M8J+d7TrNJnh+XHWFTNcEvbecCJX/1JDVt
 Zj9Ow9rDqU+Dtv4MKn/wKmYSR6ueXYESS3FGoqEWc1FxIgBrSY5bcAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-587.messagelabs.com!1658482053!67579!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5532 invoked from network); 22 Jul 2022 09:27:33 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-10.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Jul 2022 09:27:33 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 52E1A7C;
 Fri, 22 Jul 2022 10:27:33 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 4565973;
 Fri, 22 Jul 2022 10:27:33 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 22 Jul 2022 10:27:30 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 22 Jul 2022 18:27:20 +0800
Message-ID: <1658485640-2188-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] syscalls/openat: Add new regression test when
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
