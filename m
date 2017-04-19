From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2017 19:15:29 +0800
Subject: [LTP] [PATCH v2] syscalls: add new test for copy_file_range(2)
Message-ID: <20170419111529.15211-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v1 --> v2
        * Define a new struct to combine test parameters
        * Writing 1024 KB of random data into TESTFILE_1
        * Check if file contents match
        * Check if file offsets/off_in adjust

 runtest/syscalls                                   |   2 +
 testcases/kernel/include/aarch64.in                |   1 +
 testcases/kernel/include/arm.in                    |   1 +
 testcases/kernel/include/hppa.in                   |   1 +
 testcases/kernel/include/i386.in                   |   1 +
 testcases/kernel/include/ia64.in                   |   1 +
 testcases/kernel/include/powerpc.in                |   1 +
 testcases/kernel/include/powerpc64.in              |   1 +
 testcases/kernel/include/regen.sh                  |   2 +-
 testcases/kernel/include/s390.in                   |   1 +
 testcases/kernel/include/s390x.in                  |   1 +
 testcases/kernel/include/sh.in                     |   1 +
 testcases/kernel/include/sparc.in                  |   1 +
 testcases/kernel/include/sparc64.in                |   1 +
 testcases/kernel/include/x86_64.in                 |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/copy_file_range/Makefile |  19 +++
 .../syscalls/copy_file_range/copy_file_range01.c   | 162 +++++++++++++++++++++
 18 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/copy_file_range/Makefile
 create mode 100644 testcases/kernel/syscalls/copy_file_range/copy_file_range01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5909456..019ee32 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1458,3 +1458,5 @@ futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
+
+copy_file_range01 copy_file_range01
diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index b81c068..8b725e3 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -256,3 +256,4 @@ sendmmsg 269
 kcmp 272
 getrandom 278
 memfd_create 279
+copy_file_range 391
diff --git a/testcases/kernel/include/arm.in b/testcases/kernel/include/arm.in
index 0a5dde1..1a13661 100644
--- a/testcases/kernel/include/arm.in
+++ b/testcases/kernel/include/arm.in
@@ -339,3 +339,4 @@ sched_getattr (__NR_SYSCALL_BASE+381)
 renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
 memfd_create (__NR_SYSCALL_BASE+385)
+copy_file_range (__NR_SYSCALL_BASE+391)
diff --git a/testcases/kernel/include/hppa.in b/testcases/kernel/include/hppa.in
index 3946155..bb7a694 100644
--- a/testcases/kernel/include/hppa.in
+++ b/testcases/kernel/include/hppa.in
@@ -16,3 +16,4 @@ splice 291
 tee 293
 vmsplice 294
 memfd_create 340
+copy_file_range 346
diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
index 42c5e3f..9cbb139 100644
--- a/testcases/kernel/include/i386.in
+++ b/testcases/kernel/include/i386.in
@@ -339,3 +339,4 @@ sched_getattr 352
 renameat2 354
 getrandom 355
 memfd_create 356
+copy_file_range 377
diff --git a/testcases/kernel/include/ia64.in b/testcases/kernel/include/ia64.in
index dad25f4..1d5b21c 100644
--- a/testcases/kernel/include/ia64.in
+++ b/testcases/kernel/include/ia64.in
@@ -295,3 +295,4 @@ prlimit64 1325
 renameat2 1338
 getrandom 1339
 memfd_create 1340
+copy_file_range 1347
diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
index 10a6e5d..f87192e 100644
--- a/testcases/kernel/include/powerpc.in
+++ b/testcases/kernel/include/powerpc.in
@@ -346,3 +346,4 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+copy_file_range 379
diff --git a/testcases/kernel/include/powerpc64.in b/testcases/kernel/include/powerpc64.in
index 10a6e5d..f87192e 100644
--- a/testcases/kernel/include/powerpc64.in
+++ b/testcases/kernel/include/powerpc64.in
@@ -346,3 +346,4 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+copy_file_range 379
diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 3755bbf..929a3f8 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -60,7 +60,7 @@ cat << EOF > "${output_pid}"
 		tst_ret = syscall(NR, ##__VA_ARGS__); \\
 	} \\
 	if (tst_ret == -1 && errno == ENOSYS) { \\
-		tst_brk(TCONF, "syscall(%d) " #NR "not supported", NR); \\
+		tst_brk(TCONF, "syscall(%d) " #NR " not supported", NR); \\
 	} \\
 	tst_ret; \\
 })
diff --git a/testcases/kernel/include/s390.in b/testcases/kernel/include/s390.in
index 770db7f..2526f38 100644
--- a/testcases/kernel/include/s390.in
+++ b/testcases/kernel/include/s390.in
@@ -330,3 +330,4 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+copy_file_range 375
diff --git a/testcases/kernel/include/s390x.in b/testcases/kernel/include/s390x.in
index 770db7f..2526f38 100644
--- a/testcases/kernel/include/s390x.in
+++ b/testcases/kernel/include/s390x.in
@@ -330,3 +330,4 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+copy_file_range 375
diff --git a/testcases/kernel/include/sh.in b/testcases/kernel/include/sh.in
index 0345f8d..b41b578 100644
--- a/testcases/kernel/include/sh.in
+++ b/testcases/kernel/include/sh.in
@@ -363,3 +363,4 @@ fanotify_mark 368
 prlimit64 369
 kcmp 378
 memfd_create 385
+copy_file_range 391
diff --git a/testcases/kernel/include/sparc.in b/testcases/kernel/include/sparc.in
index b84c844..729768b 100644
--- a/testcases/kernel/include/sparc.in
+++ b/testcases/kernel/include/sparc.in
@@ -335,3 +335,4 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+copy_file_range 357
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index 7e0be30..9eb21ee 100644
--- a/testcases/kernel/include/sparc64.in
+++ b/testcases/kernel/include/sparc64.in
@@ -311,3 +311,4 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+copy_file_range 357
diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
index dec7742..29051d4 100644
--- a/testcases/kernel/include/x86_64.in
+++ b/testcases/kernel/include/x86_64.in
@@ -306,3 +306,4 @@ sched_getattr 315
 renameat2 316
 getrandom 318
 memfd_create 319
+copy_file_range 326
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5985cd..db6d7e9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1125,3 +1125,4 @@
 /perf_event_open/perf_event_open02
 /memfd_create/memfd_create01
 /memfd_create/memfd_create02
+/copy_file_range/copy_file_range01
diff --git a/testcases/kernel/syscalls/copy_file_range/Makefile b/testcases/kernel/syscalls/copy_file_range/Makefile
new file mode 100644
index 0000000..0143bde
--- /dev/null
+++ b/testcases/kernel/syscalls/copy_file_range/Makefile
@@ -0,0 +1,19 @@
+#
+#  Copyright (c) Linux Test Project, 2017
+#
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
new file mode 100644
index 0000000..6b8cd19
--- /dev/null
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (c) Linux Test Project, 2017
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "linux_syscall_numbers.h"
+
+#define TEST_FILE_1 "copy_file_range_ltp01.txt"
+#define TEST_FILE_2 "copy_file_range_ltp02.txt"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
+
+static size_t len1 = 1;
+static size_t len2;       /* stat.st_size */
+static size_t len3;       /* stat.st_size - 1 */
+static size_t page_size1; /* pagesize - 1 */
+static size_t page_size2; /* pagesize     */
+static size_t page_size3; /* pagesize + 1 */
+
+static struct tcase {
+	loff_t *off_in;
+	loff_t *off_out;
+	size_t *len;
+} tcases[] = {
+	{NULL, NULL, &len1}, /* NULL, NULL, 1 */
+	{NULL, NULL, &len2}, /* NULL, NULL, stat.st_size */
+	{(loff_t *)&len3,             (loff_t *)&len3,      &len1}, /* stat.st_size - 1, stat.st_size - 1, 1 */
+	{(loff_t *)&page_size1, (loff_t *)&page_size1, &page_size1}, /* pagesize - 1, pagesize - 1, pagesize - 1 */
+	{(loff_t *)&page_size2, (loff_t *)&page_size2, &page_size2}, /* pagesize, pagesize, pagesize */
+	{(loff_t *)&page_size3, (loff_t *)&page_size3, &page_size3}, /* pagesize + 1, pagesize + 1, pagesize + 1 */
+};
+
+static loff_t copy_file_range(int fd_in, loff_t *off_in,
+		int fd_out, loff_t *off_out,
+		size_t len, unsigned int flags)
+{
+	return tst_syscall(__NR_copy_file_range, fd_in, off_in, fd_out,
+			off_out, len, flags);
+}
+
+static void setup(void)
+{
+	int i, fd;
+	struct stat stat;
+
+	page_size2 = getpagesize();
+	page_size1 = page_size2 - 1;
+	page_size3 = page_size2 + 1;
+
+	fd = SAFE_OPEN(TEST_FILE_1, O_RDWR | O_CREAT, 0664);
+	/* Writing 1024 KB of random data into this file [32 * 32768 = 1048576] */
+	for (i = 0; i < 32768; i++)
+		SAFE_WRITE(1, fd, STR, strlen(STR));
+
+	SAFE_FSTAT(fd, &stat);
+	len2 = stat.st_size;
+	len3 = len2 - 1;
+
+	SAFE_CLOSE(fd);
+}
+
+static void copy_file_range_verify(unsigned int i)
+{
+	int fd_in, fd_out;
+	loff_t off_in_ori = 0;
+	loff_t off_out_ori = 0;
+
+	struct tcase *tc = &tcases[i];
+	loff_t len = *(tc->len);
+
+	if (tc->off_in) {
+		/*
+		 * off_in/off_out will be changed if it is not NULL,
+		 * here save the original value first
+		 */
+		off_in_ori = *(tc->off_in);
+		off_out_ori = *(tc->off_out);
+	}
+	loff_t len_ori = len;
+
+	fd_in = SAFE_OPEN(TEST_FILE_1, O_RDONLY);
+	fd_out = SAFE_OPEN(TEST_FILE_2, O_CREAT | O_WRONLY | O_TRUNC, 0644);
+
+	/*
+	 * copy_file_range() will return the number of bytes copied between files.
+	 * This could be less than the length originally requested.
+	 */
+	do {
+		TEST(copy_file_range(fd_in, tc->off_in, fd_out, tc->off_out, len, 0));
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO, "copy_file_range() failed");
+			SAFE_CLOSE(fd_in);
+			SAFE_CLOSE(fd_out);
+			return;
+		}
+
+		len -= TEST_RETURN;
+	} while (len > 0);
+
+	/* Compare these two file contents */
+	FILE *fp1, *fp2;
+	int ch1, ch2;
+	loff_t count = 0;
+
+	fp1 = SAFE_FOPEN(TEST_FILE_1, "r");
+	fseek(fp1, off_in_ori, SEEK_SET);
+	fp2 = SAFE_FOPEN(TEST_FILE_2, "r");
+	fseek(fp2, off_out_ori, SEEK_SET);
+
+	do {
+		ch1 = getc(fp1);
+		ch2 = getc(fp2);
+		count++;
+	} while ((count < len_ori) && (ch1 == ch2));
+
+	if (ch1 == ch2) {
+		/*
+		 * If off_in is NULL, the file offset is adjusted by the number of bytes copied.
+		 * If off_in is not NULL, the file offset of fd_in is not changed, but off_in is
+		 * adjusted appropriately.
+		 */
+		if (!tc->off_in) {
+			if (lseek(fd_in, 0, SEEK_CUR) == lseek(fd_out, 0, SEEK_CUR))
+				tst_res(TPASS, "copy_file_range() returned %ld", TEST_RETURN);
+			else
+				tst_res(TFAIL,"these two files offset are not same");
+		} else {
+			if (*(tc->off_in) == (off_in_ori + len_ori))
+				tst_res(TPASS, "copy_file_range() returned %ld", TEST_RETURN);
+			else
+				tst_res(TFAIL,"these two file off_in have no adjusted");
+		}
+	} else {
+		tst_res(TFAIL,"these two file contents are not match");
+	}
+
+	SAFE_FCLOSE(fp1);
+	SAFE_FCLOSE(fp2);
+	SAFE_CLOSE(fd_in);
+	SAFE_CLOSE(fd_out);
+}
+
+static struct tst_test test = {
+	.tid = "copy_file_range01",
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = copy_file_range_verify,
+};
-- 
2.9.3

