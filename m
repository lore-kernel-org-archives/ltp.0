From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:06 +0530
Subject: [LTP] [PATCH V6 06/10] syscalls/fsmount: Improve fsmount01 test
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <34617a5bd9778cd1350f620629315c3c759e4e07.1584014172.git.viresh.kumar@linaro.org>
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

Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/fsmount/fsmount01.c | 99 ++++++++++++-------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 43337e22e224..34d9365d4680 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -3,67 +3,94 @@
  * Copyright (C) 2020 Red Hat, Inc.  All rights reserved.
  * Author: Zorro Lang <zlang@redhat.com>
  *
- * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(), move_mount())
- * to mount a filesystem without any specified mount options.
+ * Basic fsmount() test.
  */
 
-#include <sys/mount.h>
-
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT "newmount_point"
-static int sfd, mfd, is_mounted;
+#define MNTPOINT	"mntpoint"
 
-static void cleanup(void)
-{
-	if (is_mounted)
-		SAFE_UMOUNT(MNTPOINT);
-}
+#define TCASE_ENTRY(_flags, _attrs)	{.name = "Flag " #_flags ", Attr " #_attrs, .flags = _flags, .attrs = _attrs}
 
-static void test_fsmount(void)
+static struct tcase {
+	char *name;
+	unsigned int flags;
+	unsigned int attrs;
+} tcases[] = {
+	TCASE_ENTRY(0, MOUNT_ATTR_RDONLY),
+	TCASE_ENTRY(0, MOUNT_ATTR_NOSUID),
+	TCASE_ENTRY(0, MOUNT_ATTR_NODEV),
+	TCASE_ENTRY(0, MOUNT_ATTR_NOEXEC),
+	TCASE_ENTRY(0, MOUNT_ATTR_RELATIME),
+	TCASE_ENTRY(0, MOUNT_ATTR_NOATIME),
+	TCASE_ENTRY(0, MOUNT_ATTR_STRICTATIME),
+	TCASE_ENTRY(0, MOUNT_ATTR_NODIRATIME),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NOATIME),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_STRICTATIME),
+	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NODIRATIME),
+};
+
+static void run(unsigned int n)
 {
-	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "fsopen() on %s failed", tst_device->fs_type);
-	sfd = TST_RET;
-	tst_res(TPASS, "fsopen() on %s", tst_device->fs_type);
+	struct tcase *tc = &tcases[n];
+	int sfd, mfd;
+
+	TEST(sfd = fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
+	if (sfd == -1) {
+		tst_res(TFAIL | TTERRNO, "fsopen() on %s failed",
+			tst_device->fs_type);
+		return;
+	}
 
 	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO,
+	if (TST_RET == -1) {
+		SAFE_CLOSE(sfd);
+		tst_res(TFAIL | TTERRNO,
 			"fsconfig() failed to set source to %s", tst_device->dev);
-	tst_res(TPASS, "fsconfig() set source to %s", tst_device->dev);
-
+		return;
+	}
 
 	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "fsconfig() created superblock");
-	tst_res(TPASS, "fsconfig() created superblock");
+	if (TST_RET == -1) {
+		SAFE_CLOSE(sfd);
+		tst_res(TFAIL | TTERRNO, "fsconfig() created superblock");
+		return;
+	}
 
-	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "fsmount() failed to create a mount object");
-	mfd = TST_RET;
-	tst_res(TPASS, "fsmount() created a mount object");
+	TEST(mfd = fsmount(sfd, tc->flags, tc->attrs));
 	SAFE_CLOSE(sfd);
 
+	if (mfd == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"fsmount() failed to create a mount object");
+		return;
+	}
+
 	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "move_mount() failed to attach to the mount point");
-	is_mounted = 1;
-	tst_res(TPASS, "move_mount() attached to the mount point");
 	SAFE_CLOSE(mfd);
 
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"move_mount() failed to attach to the mount point");
+		return;
+	}
+
 	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
 		SAFE_UMOUNT(MNTPOINT);
-		is_mounted = 0;
+		tst_res(TPASS, "%s: fsmount() passed", tc->name);
 	}
 }
 
 static struct tst_test test = {
-	.test_all = test_fsmount,
-	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = fsopen_supported_by_kernel,
 	.needs_root = 1,
 	.mntpoint = MNTPOINT,
 	.format_device = 1,
-- 
2.21.0.rc0.269.g1a574e7a288b

