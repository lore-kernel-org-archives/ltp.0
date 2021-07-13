From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 13 Jul 2021 15:32:36 +0200
Subject: [LTP] [PATCH] squashfs: Add regression test for sanity check bug
Message-ID: <20210713133236.1584958-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Adds a regression test for the fixes
c1b2028315 ("squashfs: fix inode lookup sanity checks ?")
and
8b44ca2b62 ("squashfs: fix xattr id and id lookup sanity checks")

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 runtest/fs                                    |  2 +
 testcases/kernel/fs/squashfs/.gitignore       |  1 +
 testcases/kernel/fs/squashfs/Makefile         | 11 +++
 .../kernel/fs/squashfs/squashfs-createfiles.c | 84 +++++++++++++++++++
 .../kernel/fs/squashfs/squashfs_regression.sh | 65 ++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 testcases/kernel/fs/squashfs/.gitignore
 create mode 100644 testcases/kernel/fs/squashfs/Makefile
 create mode 100644 testcases/kernel/fs/squashfs/squashfs-createfiles.c
 create mode 100755 testcases/kernel/fs/squashfs/squashfs_regression.sh

diff --git a/runtest/fs b/runtest/fs
index 17b1415eb..a01eaf41d 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -85,3 +85,5 @@ fs_fill fs_fill
 
 binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
+
+squashfs_regression_sh squashfs_regression.sh
diff --git a/testcases/kernel/fs/squashfs/.gitignore b/testcases/kernel/fs/squashfs/.gitignore
new file mode 100644
index 000000000..ca1306b99
--- /dev/null
+++ b/testcases/kernel/fs/squashfs/.gitignore
@@ -0,0 +1 @@
+squashfs-createfiles
diff --git a/testcases/kernel/fs/squashfs/Makefile b/testcases/kernel/fs/squashfs/Makefile
new file mode 100644
index 000000000..f4e854fa2
--- /dev/null
+++ b/testcases/kernel/fs/squashfs/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS := squashfs_regression.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/squashfs/squashfs-createfiles.c b/testcases/kernel/fs/squashfs/squashfs-createfiles.c
new file mode 100644
index 000000000..e7808041f
--- /dev/null
+++ b/testcases/kernel/fs/squashfs/squashfs-createfiles.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+ *
+ * Simple c program for fast batch creation of dummy files,
+ * it can also set unique uid/gid combinations and xattr for
+ * all files creates. The same as shell code is extremely slower.
+ */
+
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/xattr.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+void print_usage(const char *name)
+{
+    printf("Usage: %s [OPTION]\n\n", name);
+    printf("Creates n files in the current directory names 0,1,...\n\n");
+    printf(" -n n    the number of files to create (default: 2048)\n");
+    printf(" -c      set uid and groupid of file i to i:i\n");
+    printf(" -x      set xattr security.x of file i to i\n");
+    printf(" -h      this message\n");
+}
+
+int main(int argc, char** argv)
+{
+    int i;
+    int option;
+    int nfiles = 2048;
+    int set_owner = 0;
+    int set_xattr = 0;
+
+	while ((option = getopt(argc, argv, "n:cxh")) != -1) {
+		switch (option) {
+		case 'n':
+			if (tst_parse_int(optarg, &nfiles, 0, INT_MAX)) {
+                printf("Value for -n is invalid\n");
+                print_usage(argv[0]);
+                return EXIT_FAILURE;
+            }
+			break;
+        case 'c':
+            set_owner = 1;
+            break;
+        case 'x':
+            set_xattr = 1;
+            break;
+		case 'h':
+			print_usage(argv[0]);
+			return EXIT_SUCCESS;
+		default:
+			print_usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+    for (i = 0; i < nfiles; ++i)
+    {
+        int fd;
+        char name[20];
+        sprintf(name, "%d", i);
+        fd = SAFE_OPEN(name, O_CREAT | O_EXCL, 0666);
+        if (set_owner)
+            SAFE_FCHOWN(fd, i, i);
+
+        /* This must be either security, user or trusted namespace.
+         * Nothing else can be stores in squashfs.
+         * Since the files are most likely created on a tmpfs,
+         * user is also not possible, because it is not allowed on tmpfs. */
+        if (set_xattr)
+            SAFE_FSETXATTR(fd, "security.x", &i, sizeof(i), XATTR_CREATE);
+        close(fd);
+    }
+
+    return 0;
+}
diff --git a/testcases/kernel/fs/squashfs/squashfs_regression.sh b/testcases/kernel/fs/squashfs/squashfs_regression.sh
new file mode 100755
index 000000000..8d3b8812c
--- /dev/null
+++ b/testcases/kernel/fs/squashfs/squashfs_regression.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# This is a regression test for squashfs.
+# See test comment for details.
+
+TST_TESTFUNC=test
+TST_CLEANUP=cleanup
+TST_NEEDS_CMDS=mksquashfs
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
+
+. tst_test.sh
+
+cleanup()
+{
+    umount mnt >/dev/null 2>&1
+}
+
+
+# For inodes: 1023 (+1) entries
+# For ids: 2048
+# Fox xattr: 512
+
+test1()
+{
+    # Kernel commits
+    #  - f37aa4c7366e23f91b81d00bafd6a7ab54e4a381
+    #  - eabac19e40c095543def79cb6ffeb3a8588aaff4
+    #  - 506220d2ba21791314af569211ffd8870b8208fa
+    # added some sanity checks, that verified the size of
+    # inode lookup, id (uid/gid) and xattr blocks in the squashfs,
+    # but roke mounting filesystems with completely filled blocks.
+    # A block has a max size of 8192.
+    # An inode lookup entry has an uncompressed size of 8 bytes,
+    # an id block 4 bytes and an xattr block 16 bytes.
+    #
+    # To fill up at least one block for each of the three tables,
+    # 2048 files with unique uid/gid and xattr are created.
+    #
+    # The bugs are fixed in kernel commits
+    #  - c1b2028315c6b15e8d6725e0d5884b15887d3daa
+    #  - 8b44ca2b634527151af07447a8090a5f3a043321
+
+    tst_res TINFO "Test squashfs sanity check regressions"
+
+    mkdir data
+    cd data
+    ROD squashfs-createfiles -cxn 2048
+    cd ..
+
+    # Create squashfs without any comporession.
+    # This allows reasoning about block sizes
+    mksquashfs data image.raw -noI -noD -noX -noF >/dev/null 2>&1
+    squashfs-info image.raw
+
+    mkdir mnt
+    EXPECT_PASS_BRK mount -o loop image.raw mnt
+    umount mnt
+
+    tst_res TPASS "Test passed"
+}
+
+tst_run
-- 
2.25.1

