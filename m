From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 09:46:22 +0100
Subject: [LTP] [PATCH v7 4/4] syscalls/fsmount01: Add test for fsmount
 series API
In-Reply-To: <20200217084622.11199-1-pvorel@suse.cz>
References: <20200217084622.11199-1-pvorel@suse.cz>
Message-ID: <20200217084622.11199-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Zorro Lang <zlang@redhat.com>

Add basic tests tests for new mount API from kernel v5.2.
Testing mount and umount filesystems with fsopen(), fsconfig(),
fsmount() and move_mount().

NOTE: most of the syscalls numbers were added in previous commits
(c2f27f6e9b, 01e4dc2222, 87a2612857).

Signed-off-by: Zorro Lang <zlang@redhat.com>
Acked-by: Li Wang <liwang@redhat.com>
[ pvorel: rebased, cleanup autotools and other small fixes ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/syscalls/powerpc64.in            |  4 +
 runtest/syscalls                              |  2 +
 testcases/kernel/syscalls/fsmount/.gitignore  |  1 +
 testcases/kernel/syscalls/fsmount/Makefile    |  8 ++
 testcases/kernel/syscalls/fsmount/fsmount01.c | 95 +++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c

diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 2c1f105c1..beb0e6812 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -371,3 +371,7 @@ pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
diff --git a/runtest/syscalls b/runtest/syscalls
index 0743cf4e3..72e729c1c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -341,6 +341,8 @@ fpathconf01 fpathconf01
 fremovexattr01 fremovexattr01
 fremovexattr02 fremovexattr02
 
+fsmount01 fsmount01
+
 fstat02 fstat02
 fstat02_64 fstat02_64
 fstat03 fstat03
diff --git a/testcases/kernel/syscalls/fsmount/.gitignore b/testcases/kernel/syscalls/fsmount/.gitignore
new file mode 100644
index 000000000..e2f01ea17
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/.gitignore
@@ -0,0 +1 @@
+/fsmount01
diff --git a/testcases/kernel/syscalls/fsmount/Makefile b/testcases/kernel/syscalls/fsmount/Makefile
new file mode 100644
index 000000000..cc80d2efd
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
new file mode 100644
index 000000000..464458080
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
+ *
+ * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(), move_mount())
+ * to mount a filesystem without any specified mount options.
+ */
+
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
+
+#define LINELENGTH 256
+#define MNTPOINT "newmount_point"
+static int sfd, mfd, is_mounted;
+
+static int ismount(char *mntpoint)
+{
+	int ret = 0;
+	FILE *file;
+	char line[LINELENGTH];
+
+	file = SAFE_FOPEN("/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, mntpoint) != NULL) {
+			ret = 1;
+			break;
+		}
+	}
+	SAFE_FCLOSE(file);
+	return ret;
+}
+
+static void cleanup(void)
+{
+	if (is_mounted)
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static void test_fsmount(void)
+{
+	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "fsopen %s", tst_device->fs_type);
+	sfd = TST_RET;
+	tst_res(TPASS, "fsopen %s", tst_device->fs_type);
+
+	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO,
+		        "fsconfig set source to %s", tst_device->dev);
+	tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
+
+
+	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "fsconfig create superblock");
+	tst_res(TPASS, "fsconfig create superblock");
+
+	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "fsmount");
+	mfd = TST_RET;
+	tst_res(TPASS, "fsmount");
+	SAFE_CLOSE(sfd);
+
+	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "move_mount attach to mount point");
+	is_mounted = 1;
+	tst_res(TPASS, "move_mount attach to mount point");
+	SAFE_CLOSE(mfd);
+
+	if (ismount(MNTPOINT)) {
+		tst_res(TPASS, "new mount API works");
+		SAFE_UMOUNT(MNTPOINT);
+		is_mounted = 0;
+	} else
+		tst_res(TFAIL, "new mount API works");
+}
+
+static struct tst_test test = {
+	.test_all = test_fsmount,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
-- 
2.25.0

