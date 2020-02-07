From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Feb 2020 15:41:05 +0100
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount API
 v5.2
In-Reply-To: <20200207144105.19947-1-pvorel@suse.cz>
References: <20200207144105.19947-1-pvorel@suse.cz>
Message-ID: <20200207144105.19947-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Zorro Lang <zlang@redhat.com>

Add basic tests tests for new mount API from kernel v5.2.
Testing mount and umount filesystems with fsopen(), fsconfig(),
fsmount() and move_mount().

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
[ pvorel: cleanup autotools and other fixes ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                  |  4 +
 include/lapi/newmount.h                       | 95 +++++++++++++++++++
 include/lapi/syscalls/powerpc64.in            |  4 +
 runtest/syscalls                              |  2 +
 testcases/kernel/syscalls/fsmount/.gitignore  |  1 +
 testcases/kernel/syscalls/fsmount/Makefile    |  8 ++
 testcases/kernel/syscalls/fsmount/fsmount01.c | 94 ++++++++++++++++++
 7 files changed, 208 insertions(+)
 create mode 100644 include/lapi/newmount.h
 create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c

diff --git a/configure.ac b/configure.ac
index df4e8c832..05b7d0a72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,9 @@ AC_CHECK_FUNCS([ \
     execveat \
     fallocate \
     fchownat \
+    fsconfig \
+    fsmount \
+    fsopen \
     fstatat \
     getdents \
     getdents64 \
@@ -88,6 +91,7 @@ AC_CHECK_FUNCS([ \
     mkdirat \
     mknodat \
     modify_ldt \
+    move_mount \
     name_to_handle_at \
     openat \
     pidfd_open \
diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
new file mode 100644
index 000000000..d4efdb300
--- /dev/null
+++ b/include/lapi/newmount.h
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
+ */
+
+#ifndef NEWMOUNT_H__
+#define NEWMOUNT_H__
+
+#include <stdint.h>
+#include <unistd.h>
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_FSOPEN
+static inline int fsopen(const char *fs_name, unsigned int flags)
+{
+	return tst_syscall(__NR_fsopen, fs_name, flags);
+}
+
+/*
+ * fsopen() flags.
+ */
+#define FSOPEN_CLOEXEC		0x00000001
+#endif	/* HAVE_FSOPEN */
+
+#ifndef HAVE_FSCONFIG
+static inline int fsconfig(int fsfd, unsigned int cmd,
+                           const char *key, const void *val, int aux)
+{
+	return tst_syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+	FSCONFIG_SET_FLAG	= 0,    /* Set parameter, supplying no value */
+	FSCONFIG_SET_STRING	= 1,    /* Set parameter, supplying a string value */
+	FSCONFIG_SET_BINARY	= 2,    /* Set parameter, supplying a binary blob value */
+	FSCONFIG_SET_PATH	= 3,    /* Set parameter, supplying an object by path */
+	FSCONFIG_SET_PATH_EMPTY	= 4,    /* Set parameter, supplying an object by (empty) path */
+	FSCONFIG_SET_FD		= 5,    /* Set parameter, supplying an object by fd */
+	FSCONFIG_CMD_CREATE	= 6,    /* Invoke superblock creation */
+	FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
+};
+#endif	/* HAVE_FSCONFIG */
+
+#ifndef HAVE_FSMOUNT
+static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
+{
+	return tst_syscall(__NR_fsmount, fsfd, flags, ms_flags);
+}
+
+/*
+ * fsmount() flags.
+ */
+#define FSMOUNT_CLOEXEC		0x00000001
+
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
+#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
+#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
+#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
+#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
+#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+#endif	/* HAVE_FSMOUNT */
+
+#ifndef HAVE_MOVE_MOUNT
+static inline int move_mount(int from_dfd, const char *from_pathname,
+                             int to_dfd, const char *to_pathname,
+                             unsigned int flags)
+{
+	return tst_syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+	                   to_pathname, flags);
+}
+
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
+#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
+#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
+#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
+#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
+#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
+#define MOVE_MOUNT__MASK		0x00000077
+#endif	/* HAVE_MOVE_MOUNT */
+
+#endif /* NEWMOUNT_H__ */
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
index 000000000..99e7a1720
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -0,0 +1,94 @@
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
+#include "lapi/newmount.h"
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
+static void test_newmount(void)
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
+		tst_res(TPASS, "new mount API from v5.2 works");
+		SAFE_UMOUNT(MNTPOINT);
+		is_mounted = 0;
+	} else
+		tst_res(TFAIL, "new mount API from v5.2 works");
+}
+
+static struct tst_test test = {
+	.test_all = test_newmount,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
-- 
2.24.1

