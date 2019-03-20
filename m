From: Christian Amann <camann@suse.com>
Date: Wed, 20 Mar 2019 15:00:58 +0100
Subject: [LTP] [PATCH v1] syscalls/ioctl08: add file deduplication testcases
Message-ID: <20190320140058.13944-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds tests for the ioctl request FIDEDUPERANGE
on a btrfs device.

These tests set the contents of two files, and checks
if the following enteties are set correctly after
the ioctl call:

- errno (set by ioctl)
- number of deduplicated bytes
- status field of the file_dedupe_range_info struct

Signed-off-by: Christian Amann <camann@suse.com>
---
 configure.ac                               |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl08.c  | 133 +++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl08.c

diff --git a/configure.ac b/configure.ac
index e002c248e..3295ee909 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,6 +38,7 @@ AC_CHECK_HEADERS([ \
     linux/can.h \
     linux/dccp.h \
     linux/cryptouser.h \
+    linux/fs.h \
     linux/genetlink.h \
     linux/keyctl.h \
     linux/if_alg.h \
diff --git a/runtest/syscalls b/runtest/syscalls
index b0904086d..790cd56d0 100644
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
index 000000000..4e2507801
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -0,0 +1,133 @@
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
+#ifdef HAVE_LINUX_FS_H
+#include <linux/fs.h>
+
+#ifndef SUCCESS
+#define SUCCESS 0
+#endif
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
+	fd_dest = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0644);
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

