From: Christian Amann <camann@suse.com>
Date: Fri, 22 Mar 2019 14:32:28 +0100
Subject: [LTP] [PATCH v2] syscalls/ioctl08: add file deduplication testcases
Message-ID: <20190322133228.18901-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds tests for the ioctl request FIDEDUPERANGE
on a btrfs device.

These tests set the contents of two files, and checks
if the following entities are set correctly after
the ioctl call:

- errno (set by ioctl)
- number of deduplicated bytes
- status field of the file_dedupe_range_info struct

Signed-off-by: Christian Amann <camann@suse.com>
---
 configure.ac                               |   1 +
 m4/ltp-ioctl.m4                            |  22 +++++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl08.c  | 131 +++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+)
 create mode 100644 m4/ltp-ioctl.m4
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl08.c

diff --git a/configure.ac b/configure.ac
index f05db9d2e..6a16138bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -236,6 +236,7 @@ LTP_CHECK_PERF_EVENT
 LTP_CHECK_SYNCFS
 LTP_CHECK_SYNC_FILE_RANGE
 LTP_CHECK_FTS_H
+LTP_CHECK_FIDEDUPE
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/m4/ltp-ioctl.m4 b/m4/ltp-ioctl.m4
new file mode 100644
index 000000000..c7e3814c5
--- /dev/null
+++ b/m4/ltp-ioctl.m4
@@ -0,0 +1,22 @@
+dnl
+dnl Copyright (c) 2019 SUSE LLC
+dnl Author: Christian Amann <camann@suse.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+AC_DEFUN([LTP_CHECK_FIDEDUPE],[
+AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index a13d51918..0f9f985b2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -499,6 +499,7 @@ ioctl05      ioctl05
 ioctl06      ioctl06
 
 ioctl07      ioctl07
+ioctl08      ioctl08
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 79516a17c..4d480a0ed 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -5,3 +5,4 @@
 /ioctl05
 /ioctl06
 /ioctl07
+/ioctl08
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
new file mode 100644
index 000000000..302482dd6
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ *
+ */
+
+/*
+ * Tests the ioctl functionality to deduplicate fileranges using
+ * btrfs filesystem.
+ *
+ * 1)	Sets the same contents for two files and deduplicates it.
+ *	Deduplicates 3 bytes and set the status to
+ *	FILE_DEDUPE_RANGE_SAME.
+ * 2)	Sets different content for two files and tries to
+ *	deduplicate it. 0 bytes get deduplicated and status is
+ *	set to FILE_DEDUPE_RANGE_DIFFERS.
+ * 3)	Sets same content for two files but sets the length to
+ *	deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+#include <sys/ioctl.h>
+#include <errno.h>
+
+#ifdef HAVE_STRUCT_FILE_DEDUPE_RANGE
+#include <linux/fs.h>
+
+#define SUCCESS 0
+
+#define MNTPOINT "mnt_point"
+#define FILE_SRC_PATH	MNTPOINT"/file_src"
+#define FILE_DEST_PATH	MNTPOINT"/file_dest"
+
+static int fd_src;
+static int fd_dest;
+static struct file_dedupe_range *fdr;
+
+static struct tcase {
+	uint64_t	src_length;
+	char		*src_fcontents;
+	char		*dest_fcontents;
+	int		exp_err;
+	uint64_t	bytes_deduped;
+	int		status;
+} tcases[] = {
+	{3, "AAA", "AAA", SUCCESS, 3, FILE_DEDUPE_RANGE_SAME},
+	{3, "AAA", "AAB", SUCCESS, 0, FILE_DEDUPE_RANGE_DIFFERS},
+	{-1, "AAA", "AAA", EINVAL, 0, 0},
+};
+
+static void verify_ioctl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	fd_src  = SAFE_OPEN(FILE_SRC_PATH,  O_RDWR | O_CREAT, 0664);
+	fd_dest = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
+
+	SAFE_WRITE(1, fd_src,  tc->src_fcontents,  strlen(tc->src_fcontents));
+	SAFE_WRITE(1, fd_dest, tc->dest_fcontents, strlen(tc->dest_fcontents));
+
+	memset(fdr, 0, sizeof(struct file_dedupe_range) +
+			sizeof(struct file_dedupe_range_info));
+
+	fdr->src_length = tc->src_length;
+	fdr->dest_count = 1;
+	fdr->info[0].dest_fd = fd_dest;
+
+	TEST(ioctl(fd_src, FIDEDUPERANGE, fdr));
+
+	if (tc->exp_err != TST_ERR) {
+		tst_res(TFAIL,
+			"ioctl(FIDEDUPERANGE) ended with %s, expected %s",
+			tst_strerrno(TST_ERR), tst_strerrno(tc->exp_err));
+		return;
+	}
+
+	if (fdr->info[0].bytes_deduped != tc->bytes_deduped) {
+		tst_res(TFAIL,
+			"ioctl(FIDEDUPERANGE) deduplicated %lld bytes, expected %ld. Status: %d",
+			fdr->info[0].bytes_deduped, tc->bytes_deduped,
+			fdr->info[0].status);
+		return;
+	}
+
+	if (fdr->info[0].status != tc->status) {
+		tst_res(TFAIL,
+			"ioctl(FIDEDUPERANGE) status set to %d, expected %d",
+			fdr->info[0].status, tc->status);
+		return;
+	}
+
+	tst_res(TPASS, "ioctl(FIDEDUPERANGE) ended with %s as expected",
+			tst_strerrno(tc->exp_err));
+
+	SAFE_CLOSE(fd_dest);
+	SAFE_CLOSE(fd_src);
+}
+
+static void cleanup(void)
+{
+	if (fd_dest > 0)
+		SAFE_CLOSE(fd_dest);
+	if (fd_src > 0)
+		SAFE_CLOSE(fd_src);
+	if (fdr)
+		free(fdr);
+}
+
+static void setup(void)
+{
+	fdr = SAFE_MALLOC(sizeof(struct file_dedupe_range) +
+			sizeof(struct file_dedupe_range_info));
+}
+
+static struct tst_test test = {
+	.test = verify_ioctl,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "btrfs",
+};
+#else
+	TST_TEST_TCONF(
+		"This system does not provide support for ioctl(FIDEDUPERANGE)");
+#endif
-- 
2.16.4

