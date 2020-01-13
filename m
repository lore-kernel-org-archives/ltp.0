From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Jan 2020 15:24:24 +0100
Subject: [LTP] [PATCH v4] Use real FS block size in fallocate05
Message-ID: <20200113142424.25663-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fallocate() behavior depends on whether the file range is aligned to full
blocks. Make sure that the test always uses aligned file range so that
the test is consistent across platforms.

Also use the TEST() macro to prevent errno pollution and increase test device
size to avoid weird edge cases that don't happen in the real world.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Using fixed-size buffer in fallocate05 caused some failures in the past
due to allocation requests being misaligned with actual file system blocks.
Btrfs in particular will treat misaligned allocation as regular write()
and apply copy-on-write to partially allocated blocks even on the first real
write().

While that behavior is somewhat surprising, it does make sense. Fix the error
by using multiples of real block size in fallocate() and write().

I'll also write another fallocate() test later for checking FS behavior
on intentionally misaligned allocation. But this fix can be committed before
that.

Changes since v1:
- XFS keeps some free blocks even when write() failed with ENOSPC. Repeat
  fallocate() until it gets ENOSPC, too.
- Deallocate only part of the file.
- Add description of test scenario in the header comment.
- Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.

Changes since v2:
- Deallocate whole file on Btrfs, otherwise the PUNCH_HOLE check will fail.
  Btrfs deallocates only complete file extents by design.

Changes since v3:
- Code style fixes
- Reduce test device size to 512MB as that should be sufficient according to
  Btrfs devs.

 .../kernel/syscalls/fallocate/fallocate05.c   | 127 ++++++++++++++----
 1 file changed, 98 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 17034e5b1..d9beccc2c 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -1,93 +1,162 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
  */
 
 /*
  * Tests that writing to fallocated file works when filesystem is full.
+ * Test scenario:
+ * - fallocate() some empty blocks
+ * - fill the filesystem
+ * - write() into the preallocated space
+ * - try to fallocate() more blocks until we get ENOSPC
+ * - write() into the extra allocated space
+ * - deallocate part of the file
+ * - write() to the end of file to check that some blocks were freed
  */
 
 #define _GNU_SOURCE
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <errno.h>
+#include <string.h>
 #include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "mntpoint"
-#define FALLOCATE_SIZE (1024*1024)
+#define FALLOCATE_BLOCKS 16
+#define DEALLOCATE_BLOCKS 4
 #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
 
 static int fd;
+static char *buf;
+static blksize_t blocksize;
+static long bufsize;
 
-static void run(void)
+static void setup(void)
 {
-	char buf[FALLOCATE_SIZE];
-	ssize_t ret;
+	struct stat statbuf;
 
 	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
 
-	if (fallocate(fd, 0, 0, FALLOCATE_SIZE)) {
-		if (errno == EOPNOTSUPP) {
-			tst_res(TCONF | TERRNO, "fallocate() not supported");
+	/*
+	 * Use real FS block size, otherwise fallocate() call will test
+	 * different things on different platforms
+	 */
+	SAFE_FSTAT(fd, &statbuf);
+	blocksize = statbuf.st_blksize;
+	bufsize = FALLOCATE_BLOCKS * blocksize;
+	buf = malloc(bufsize);
+
+	if (!buf) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK, "Buffer allocation failed");
+	}
+}
+
+static void run(void)
+{
+	long extsize, tmp;
+
+	TEST(fallocate(fd, 0, 0, bufsize));
+
+	if (TST_RET) {
+		if (TST_ERR == ENOTSUP) {
 			SAFE_CLOSE(fd);
-			return;
+			tst_brk(TCONF | TTERRNO, "fallocate() not supported");
 		}
 
-		tst_brk(TBROK | TERRNO,
-			"fallocate(fd, 0, 0, %i)", FALLOCATE_SIZE);
+		tst_brk(TBROK | TTERRNO, "fallocate(fd, 0, 0, %ld)", bufsize);
 	}
 
 	tst_fill_fs(MNTPOINT, 1);
 
-	ret = write(fd, buf, sizeof(buf));
+	TEST(write(fd, buf, bufsize));
 
-	if (ret < 0)
-		tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
+	if (TST_RET < 0)
+		tst_res(TFAIL | TTERRNO, "write() failed unexpectedly");
+	else if (TST_RET != bufsize)
+		tst_res(TFAIL, "Short write(): %ld bytes (expected %zu)",
+			TST_RET, bufsize);
 	else
-		tst_res(TPASS, "write() wrote %zu bytes", ret);
+		tst_res(TPASS, "write() wrote %ld bytes", TST_RET);
+
+	/*
+	 * Some file systems may still have a few extra blocks that can be
+	 * allocated.
+	 */
+	for (TST_RET = 0, extsize = 0; !TST_RET; extsize += blocksize)
+		TEST(fallocate(fd, 0, bufsize + extsize, blocksize));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "Invalid fallocate() return value %ld", TST_RET);
+		return;
+	}
+
+	if (TST_ERR != ENOSPC) {
+		tst_res(TFAIL | TTERRNO, "fallocate() should fail with ENOSPC");
+		return;
+	}
 
-	ret = fallocate(fd, 0, FALLOCATE_SIZE, FALLOCATE_SIZE);
-	if (ret != -1)
-		tst_brk(TFAIL, "fallocate() succeeded unexpectedly");
+	/* The loop above always counts 1 more block than it should. */
+	extsize -= blocksize;
+	tst_res(TINFO, "fallocate()d %ld extra blocks on full FS",
+		extsize / blocksize);
 
-	if (errno != ENOSPC)
-		tst_brk(TFAIL | TERRNO, "fallocate() should fail with ENOSPC");
+	for (tmp = extsize; tmp > 0; tmp -= TST_RET) {
+		TEST(write(fd, buf, MIN(bufsize, tmp)));
 
-	tst_res(TPASS | TERRNO, "fallocate() on full FS");
+		if (TST_RET <= 0) {
+			tst_res(TFAIL | TTERRNO, "write() failed unexpectedly");
+			return;
+		}
+	}
 
-	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, FALLOCATE_SIZE);
-	if (ret == -1) {
-		if (errno == EOPNOTSUPP)
+	tst_res(TPASS, "fallocate() on full FS");
+
+	/* Btrfs deallocates only complete extents, not individual blocks */
+	if (!strcmp(tst_device->fs_type, "btrfs"))
+		tmp = bufsize + extsize;
+	else
+		tmp = DEALLOCATE_BLOCKS * blocksize;
+
+	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, tmp));
+
+	if (TST_RET == -1) {
+		if (TST_ERR == ENOTSUP)
 			tst_brk(TCONF, TESTED_FLAGS);
 
-		tst_brk(TBROK | TERRNO, TESTED_FLAGS);
+		tst_brk(TBROK | TTERRNO, TESTED_FLAGS);
 	}
 	tst_res(TPASS, TESTED_FLAGS);
 
-	ret = write(fd, buf, 10);
-	if (ret == -1)
-		tst_res(TFAIL | TERRNO, "write()");
+	TEST(write(fd, buf, 10));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "write()");
 	else
 		tst_res(TPASS, "write()");
 
-	SAFE_CLOSE(fd);
+	/* TODO: wipe the test device here to allow looping with -i/-I */
 }
 
 static void cleanup(void)
 {
 	if (fd > 0)
 		SAFE_CLOSE(fd);
+
+	free(buf);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.mount_device = 1,
+	.dev_min_size = 512,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
+	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
 };
-- 
2.24.1

