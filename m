From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Mar 2020 12:41:58 +0530
Subject: [LTP] [PATCH 1/2] syscalls/fspick: Set .mount_device to get rid of
 mounting related code
Message-ID: <aa66c041b2eca3f874056de72ca3dcdf8825a6b5.1584947466.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't necessarily need to work with the fsmount() related syscalls to
initially mount the device, we can set .mount_device instead and get rid
of a lot of code.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/fspick/fspick.h   | 60 ---------------------
 testcases/kernel/syscalls/fspick/fspick01.c |  7 ++-
 testcases/kernel/syscalls/fspick/fspick02.c |  8 +--
 3 files changed, 7 insertions(+), 68 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fspick/fspick.h

diff --git a/testcases/kernel/syscalls/fspick/fspick.h b/testcases/kernel/syscalls/fspick/fspick.h
deleted file mode 100644
index 4be296ee79da..000000000000
--- a/testcases/kernel/syscalls/fspick/fspick.h
+++ /dev/null
@@ -1,60 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
- */
-
-#ifndef FSPICK_H__
-#define FSPICK_H__
-
-#define MNTPOINT	"mntpoint"
-
-static int ismounted;
-
-static void cleanup(void)
-{
-	if (ismounted)
-		SAFE_UMOUNT(MNTPOINT);
-}
-
-static void setup(void)
-{
-	int fd, fsmfd;
-
-	fsopen_supported_by_kernel();
-
-	TEST(fd = fsopen(tst_device->fs_type, 0));
-	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "fsopen() failed");
-
-	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
-	}
-
-	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
-	}
-
-	TEST(fsmfd = fsmount(fd, 0, 0));
-	SAFE_CLOSE(fd);
-
-	if (fsmfd == -1)
-		tst_brk(TBROK | TERRNO, "fsmount() failed");
-
-	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
-			MOVE_MOUNT_F_EMPTY_PATH));
-	SAFE_CLOSE(fsmfd);
-
-	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "move_mount() failed");
-
-	if (!tst_is_mounted_at_tmpdir(MNTPOINT))
-		tst_brk(TBROK | TERRNO, "device not mounted");
-
-	ismounted = 1;
-}
-
-#endif /* FSPICK_H__ */
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index c84723805cb9..2f372f7f126c 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,8 +6,8 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
-#include "fspick.h"
 
+#define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
 
 static struct tcase {
@@ -58,10 +58,9 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
-	.setup = setup,
-	.cleanup = cleanup,
+	.setup = fsopen_supported_by_kernel,
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.dev_fs_flags = TST_FS_SKIP_FUSE,
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
index dc8f153ccc48..b9d020226856 100644
--- a/testcases/kernel/syscalls/fspick/fspick02.c
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -6,7 +6,8 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
-#include "fspick.h"
+
+#define MNTPOINT		"mntpoint"
 
 static struct tcase {
 	char *name;
@@ -44,10 +45,9 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
-	.setup = setup,
-	.cleanup = cleanup,
+	.setup = fsopen_supported_by_kernel,
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.dev_fs_flags = TST_FS_SKIP_FUSE,
-- 
2.21.0.rc0.269.g1a574e7a288b

