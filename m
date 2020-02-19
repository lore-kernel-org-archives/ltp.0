From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Feb 2020 14:58:02 +0530
Subject: [LTP] [PATCH V2 06/10] syscalls/fsmount: Improve fsmount01 test
In-Reply-To: <cover.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <9706f359006ea409d2f85c111d3e001ca6f6d128.1582104018.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch updates the fsmount01.c file to make it look similar to all
other fsmount related syscall tests and here is the list of all changes:

- Test all fsmount flags and mount attributes
- Remove extra PASS messages as all we want to test here is fsmount()
  and not other syscalls.
- On the same lines, print TFAIL for fsmount() syscall and TBROK for
  other calls.
- close sfd on failures
- Make the file look similar to other fsmount related tests
- General cleanup

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/fsmount/fsmount01.c | 92 ++++++++++++-------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index c3cf8106f63b..b746a14ba472 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -3,67 +3,95 @@
  * Copyright (C) 2020 Red Hat, Inc.  All rights reserved.
  * Author: Zorro Lang <zlang@redhat.com>
  *
- * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(), move_mount())
- * to mount a filesystem without any specified mount options.
+ * Description:
+ * Basic fsmount() test.
  */
 
-#include <sys/mount.h>
-
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT "newmount_point"
-static int sfd, mfd, is_mounted;
+#define MNTPOINT	"mntpoint"
+
+static struct tcase {
+	char *name;
+	unsigned int flags;
+	unsigned int mount_attrs;
+} tcases[] = {
+	{"Flag 0, attr RDONLY", 0, MOUNT_ATTR_RDONLY},
+	{"Flag 0, attr NOSUID", 0, MOUNT_ATTR_NOSUID},
+	{"Flag 0, attr NODEV", 0, MOUNT_ATTR_NODEV},
+	{"Flag 0, attr NOEXEC", 0, MOUNT_ATTR_NOEXEC},
+	{"Flag 0, attr RELATIME", 0, MOUNT_ATTR_RELATIME},
+	{"Flag 0, attr NOATIME", 0, MOUNT_ATTR_NOATIME},
+	{"Flag 0, attr STRICTATIME", 0, MOUNT_ATTR_STRICTATIME},
+	{"Flag 0, attr NODIRATIME", 0, MOUNT_ATTR_NODIRATIME},
+	{"Flag CLOEXEC, attr RDONLY", FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY},
+	{"Flag CLOEXEC, attr NOSUID", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID},
+	{"Flag CLOEXEC, attr NODEV", FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV},
+	{"Flag CLOEXEC, attr NOEXEC", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC},
+	{"Flag CLOEXEC, attr RELATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME},
+	{"Flag CLOEXEC, attr NOATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOATIME},
+	{"Flag CLOEXEC, attr STRICTATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_STRICTATIME},
+	{"Flag CLOEXEC, attr NODIRATIME", FSMOUNT_CLOEXEC, MOUNT_ATTR_NODIRATIME},
+};
 
-static void cleanup(void)
+static void setup(void)
 {
-	if (is_mounted)
-		SAFE_UMOUNT(MNTPOINT);
+	fsopen_supported_by_kernel();
 }
 
-static void test_fsmount(void)
+static void run(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+	int sfd, mfd;
+
 	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "fsopen() on %s failed", tst_device->fs_type);
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "fsopen() on %s failed",
+			tst_device->fs_type);
+	}
 	sfd = TST_RET;
-	tst_res(TPASS, "fsopen() on %s", tst_device->fs_type);
 
 	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
-	if (TST_RET < 0)
+	if (TST_RET < 0) {
+		SAFE_CLOSE(sfd);
 		tst_brk(TBROK | TTERRNO,
 			"fsconfig() failed to set source to %s", tst_device->dev);
-	tst_res(TPASS, "fsconfig() set source to %s", tst_device->dev);
-
+	}
 
 	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
-	if (TST_RET < 0)
+	if (TST_RET < 0) {
+		SAFE_CLOSE(sfd);
 		tst_brk(TBROK | TTERRNO, "fsconfig() created superblock");
-	tst_res(TPASS, "fsconfig() created superblock");
+	}
 
-	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "fsmount() failed to create a mount object");
-	mfd = TST_RET;
-	tst_res(TPASS, "fsmount() created a mount object");
+	TEST(fsmount(sfd, tc->flags, tc->mount_attrs));
 	SAFE_CLOSE(sfd);
 
+	if (TST_RET < 0) {
+		tst_brk(TFAIL | TTERRNO,
+			"fsmount() failed to create a mount object");
+	}
+	mfd = TST_RET;
+
 	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "move_mount() failed to attach to the mount point");
-	is_mounted = 1;
-	tst_res(TPASS, "move_mount() attached to the mount point");
 	SAFE_CLOSE(mfd);
 
-	if (!tst_ismount(MNTPOINT)) {
-		SAFE_UMOUNT(MNTPOINT);
-		is_mounted = 0;
+	if (TST_RET < 0) {
+		tst_brk(TBROK | TTERRNO,
+			"move_mount() failed to attach to the mount point");
 	}
+
+	if (!tst_ismount(MNTPOINT))
+		tst_res(TPASS, "%s: fsmount() passed", tc->name);
+
+	SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
-	.test_all = test_fsmount,
-	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
 	.needs_root = 1,
 	.mntpoint = MNTPOINT,
 	.format_device = 1,
-- 
2.21.0.rc0.269.g1a574e7a288b

