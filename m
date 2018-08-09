From: Vishnu K <vishnu@zilogic.com>
Date: Thu, 09 Aug 2018 07:10:05 -0000
Subject: [LTP] [PATCH v5] Test for memfd_create() syscall with MFD_HUGETLB
	flag.
Message-ID: <20180809071005.12702-1-vishnu@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* memfd_create03: Tests the syscall for the flag MFD_HUGETLB.

* memfd_create04: Tests the syscall for the flags MFD_HUGE_2MB,
                  MFD_HUGE_1GB, ... used in conjunction with
                  MFD_HUGETLB flag.

-- major changes from v4 to v5 --

* memfd_create03:

** Add system huge page support check using sysfs.

Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
Signed-off-by: Vishnu K <vishnu@zilogic.com>
---
 include/lapi/memfd.h                          |  33 +++
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/memfd_create/.gitignore   |   2 +
 .../syscalls/memfd_create/memfd_create03.c    | 265 ++++++++++++++++++
 .../syscalls/memfd_create/memfd_create04.c    | 105 +++++++
 5 files changed, 407 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create03.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create04.c

diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
index 18ed40fc6..12a91f4a9 100644
--- a/include/lapi/memfd.h
+++ b/include/lapi/memfd.h
@@ -24,4 +24,37 @@
 # define MFD_ALLOW_SEALING       0x0002U
 #endif
 
+/* flags for memfd_create(3) and memfd_create(4) */
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
+
+#ifndef MFD_HUGE_64KB
+#define MFD_HUGE_64KB (16 << 26)
+#endif
+#ifndef MFD_HUGE_512KB
+#define MFD_HUGE_512KB (19 << 26)
+#endif
+#ifndef MFD_HUGE_2MB
+#define MFD_HUGE_2MB (21 << 26)
+#endif
+#ifndef MFD_HUGE_8MB
+#define MFD_HUGE_8MB (23 << 26)
+#endif
+#ifndef MFD_HUGE_16MB
+#define MFD_HUGE_16MB (24 << 26)
+#endif
+#ifndef MFD_HUGE_256MB
+#define MFD_HUGE_256MB (28 << 26)
+#endif
+#ifndef MFD_HUGE_1GB
+#define MFD_HUGE_1GB (30 << 26)
+#endif
+#ifndef MFD_HUGE_2GB
+#define MFD_HUGE_2GB (31 << 26)
+#endif
+#ifndef MFD_HUGE_16GB
+#define MFD_HUGE_16GB (34 << 26)
+#endif
+
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index b78f6bc02..9d0eac8f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1488,5 +1488,7 @@ futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
+memfd_create03 memfd_create03
+memfd_create04 memfd_create04
 
 copy_file_range01 copy_file_range01
diff --git a/testcases/kernel/syscalls/memfd_create/.gitignore b/testcases/kernel/syscalls/memfd_create/.gitignore
index 9b20604ab..71b898c34 100644
--- a/testcases/kernel/syscalls/memfd_create/.gitignore
+++ b/testcases/kernel/syscalls/memfd_create/.gitignore
@@ -1,2 +1,4 @@
 /memfd_create01
 /memfd_create02
+/memfd_create03
+/memfd_create04
\ No newline@end of file
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
new file mode 100644
index 000000000..d92033a24
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email: code@zilogic.com
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
+/*
+ * Test: Validating memfd_create() with MFD_HUGETLB flag.
+ *
+ * Test case 1: --WRITE CALL IN HUGEPAGES TEST--
+ *              Huge pages are write protected. Any writes to
+ *              the file should return EINVAL error.
+ *
+ * Test case 2: --PAGE SIZE OF CREATED FILE TEST--
+ *              Default huge page sized pages are created with
+ *              MFD_HUGETLB flag. Any attempt to unmap memory-mapped
+ *              huge pages with an unmapping length less than
+ *              huge page size should return EINVAL error.
+ *
+ * Test case 3: --HUGEPAGE ALLOCATION LIMIT TEST--
+ *              Number of huge pages currently available to use should be
+ *              atmost total number of allowed huge pages. Memory-mapping
+ *              more than allowed huge pages should return ENOMEM error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_common.h"
+
+#include <stdio.h>
+#include <errno.h>
+
+#define TOTAL_HP_PATH "/proc/sys/vm/nr_hugepages"
+#define MEMINFO_PATH "/proc/meminfo"
+#define FREE_HP "HugePages_Free:\t%ld"
+#define DEFAULT_HPS "Hugepagesize:\t%ld kB"
+
+static int hugepages_allocated;
+static long og_total_pages;
+
+static void *check_huge_mmapable(int fd, unsigned long size)
+{
+	void *mem;
+
+	mem = SAFE_MMAP(NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	memset((char *)mem, 0, 1);
+
+	tst_res(TINFO,
+		"mmap(%p, %lu, %d, %d, %d, %d) succeeded",
+		NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	return mem;
+}
+
+static void test_write_protect(int fd)
+{
+	ssize_t ret;
+	char test_str[] = "LTP";
+
+	ret = write(fd, test_str, strlen(test_str));
+	if (ret < 0) {
+		if (errno != EINVAL) {
+			tst_res(TFAIL | TERRNO,
+				"write(%d, \"%s\", %zu) didn't fail as expected\n",
+				fd, test_str, strlen(test_str));
+			return;
+		}
+	} else {
+		tst_res(TFAIL,
+			"write(%d, \"%s\", %zu) succeeded unexpectedly\n",
+			fd, test_str, strlen(test_str));
+		return;
+	}
+
+	tst_res(TPASS,
+		"write(%d, \"%s\", %zu) failed as expected\n",
+		fd, test_str, strlen(test_str));
+}
+
+static void test_def_pagesize(int fd)
+{
+	unsigned int i;
+	int unmap_size;
+	int ret;
+	long hps;
+	void *mem;
+
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, DEFAULT_HPS, &hps);
+	hps = hps << 10;
+	unmap_size = hps / 4;
+	mem = check_huge_mmapable(fd, hps);
+
+	for (i = unmap_size; i < hps; i += unmap_size) {
+		ret = munmap(mem, i);
+		if (ret == -1) {
+			if (errno == EINVAL) {
+				tst_res(TINFO,
+					"munmap(%p, %dkB) failed as expected",
+					mem, i/1024);
+			} else {
+				tst_res(TFAIL | TERRNO,
+					"munmap(%p, %dkB) failed unexpectedly",
+					mem, i/1024);
+				return;
+			}
+		} else {
+			tst_res(TFAIL,
+				"munmap(%p, %dkB) suceeded unexpectedly\n",
+				mem, i);
+			return;
+		}
+	}
+
+	SAFE_MUNMAP(mem, hps);
+
+	tst_res(TPASS,
+		"munmap() fails for page sizes less than %ldkB\n", hps/1024);
+}
+
+static void test_max_hugepages(int fd)
+{
+	int new_fd;
+	long hps;
+	long free_pages;
+	void *mem;
+	void *new_mem;
+
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, DEFAULT_HPS, &hps);
+	hps = hps << 10;
+	mem = check_huge_mmapable(fd, free_pages * hps);
+
+	new_fd = sys_memfd_create("new_file", MFD_HUGETLB);
+	if (new_fd < 0)
+		tst_brk(TFAIL | TERRNO, "memfd_create() failed");
+	tst_res(TINFO, "memfd_create() succeeded");
+
+	new_mem = mmap(NULL, hps, 0, MAP_PRIVATE, new_fd, 0);
+	if (new_mem == MAP_FAILED) {
+		if (errno == ENOMEM)
+			tst_res(TPASS,
+				"mmap(%p, %lu, %d, %d, %d, %d) failed as expected",
+				NULL, hps, 0, MAP_PRIVATE, new_fd, 0);
+		else
+			tst_res(TFAIL | TERRNO,
+				"mmap(%p, %lu, %d, %d, %d, %d) failed unexpectedly",
+				NULL, hps, 0, MAP_PRIVATE, new_fd, 0);
+	} else {
+		tst_res(TFAIL,
+			"mmap(%p, %lu, %d, %d, %d, %d) succeeded",
+			NULL, hps, 0, MAP_PRIVATE, new_fd, 0);
+		SAFE_MUNMAP(new_mem, hps);
+	}
+
+	SAFE_CLOSE(new_fd);
+
+	SAFE_MUNMAP(mem, free_pages * hps);
+}
+
+static const struct tcase {
+	void (*func)(int fd);
+	const char *desc;
+} tcases[] = {
+	{&test_write_protect,   "--TESTING WRITE CALL IN HUGEPAGES--"},
+	{&test_def_pagesize,  "--TESTING PAGE SIZE OF CREATED FILE--"},
+	{&test_max_hugepages, "--TESTING HUGEPAGE ALLOCATION LIMIT--"},
+};
+
+static void memfd_huge_controller(unsigned int n)
+{
+	int fd;
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->desc);
+
+	fd = sys_memfd_create("test_file", MFD_HUGETLB);
+	if (fd < 0)
+		tst_brk(TFAIL | TERRNO, "memfd_create() failed");
+	tst_res(TINFO, "memfd_create() succeeded");
+
+	tc->func(fd);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	char buf[8];
+	int fd;
+	long free_pages;
+	long total_pages;
+
+	if (access(MEMINFO_PATH, F_OK) ||
+	    access("/sys/kernel/mm/hugepages", F_OK) ||
+	    access(TOTAL_HP_PATH, F_OK))
+		tst_brk(TCONF, "Huge page is not supported");
+
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
+	if (free_pages > 0)
+		return;
+
+	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &og_total_pages);
+	sprintf(buf, "%ld", og_total_pages + 1);
+
+	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+
+	if (write(fd, buf, strlen(buf)) == -1)
+		tst_brk(TCONF | TERRNO,
+			"write() fail: Hugepage allocation failed");
+
+	SAFE_CLOSE(fd);
+
+	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &total_pages);
+	if (total_pages != (og_total_pages + 1))
+		tst_brk(TCONF, "Hugepage allocation failed");
+
+	hugepages_allocated = 1;
+}
+
+static void cleanup(void)
+{
+	char buf[8];
+	int fd;
+	long total_pages;
+
+	if (hugepages_allocated == 0)
+		return;
+
+	sprintf(buf, "%ld", og_total_pages);
+
+	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+
+	if (write(fd, buf, strlen(buf)) == -1)
+		tst_brk(TCONF | TERRNO, "Clean-up failed: write() failed");
+
+	SAFE_CLOSE(fd);
+
+	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &total_pages);
+	if (og_total_pages != total_pages)
+		tst_brk(TCONF, "Clean-up failed");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_controller,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.min_kver = "4.14",
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
new file mode 100644
index 000000000..cbbdc5ff7
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email: code@zilogic.com
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
+/*
+ * Test: Validating memfd_create() with MFD_HUGETLB and MFD_HUGE_x flags.
+ *
+ * Test cases: Attempt to create files in the hugetlbfs filesystem using
+ *             different huge page sizes.
+ *
+ * Test logic: memfd_create() should return non-negative value (fd)
+ *             if the system supports that particular huge page size.
+ *             On success, fd is returned.
+ *             On failure, -1 is returned with ENODEV error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_common.h"
+
+#include <errno.h>
+#include <stdio.h>
+
+#define PATH_HUGEPAGES "/sys/kernel/mm/hugepages"
+
+static  struct test_flag {
+	int flag;
+	char *h_size;
+	int exp_err;
+} test_flags[] =  {
+	{.flag = MFD_HUGE_64KB,         .h_size = "64kB"},
+	{.flag = MFD_HUGE_512KB,       .h_size = "512kB"},
+	{.flag = MFD_HUGE_2MB,        .h_size = "2048kB"},
+	{.flag = MFD_HUGE_8MB,        .h_size = "8192kB"},
+	{.flag = MFD_HUGE_16MB,      .h_size = "16384kB"},
+	{.flag = MFD_HUGE_256MB,    .h_size = "262144kB"},
+	{.flag = MFD_HUGE_1GB,     .h_size = "1048576kB"},
+	{.flag = MFD_HUGE_2GB,     .h_size = "2097152kB"},
+	{.flag = MFD_HUGE_16GB,   .h_size = "16777216kB"},
+};
+
+static void check_hugepage_support(struct test_flag *test_flags)
+{
+	char pattern[64];
+
+	sprintf(pattern, PATH_HUGEPAGES);
+	strcat(pattern, "/hugepages-");
+	strcat(pattern, test_flags->h_size);
+
+	if (access(pattern, F_OK))
+		test_flags->exp_err = ENODEV;
+}
+
+static void memfd_huge_x_controller(unsigned int n)
+{
+	int fd;
+	struct test_flag tflag;
+
+	tflag = test_flags[n];
+	check_hugepage_support(&tflag);
+	tst_res(TINFO,
+		"Attempt to create file using %s huge page size",
+		tflag.h_size);
+
+	fd = sys_memfd_create("tfile", MFD_HUGETLB | tflag.flag);
+	if (fd < 0) {
+		if (errno == tflag.exp_err)
+			tst_res(TPASS, "Test failed as expected\n");
+		else
+			tst_brk(TFAIL | TERRNO,
+				"memfd_create() failed unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS,
+		"memfd_create succeeded for %s page size\n",
+		tflag.h_size);
+}
+
+static void setup(void)
+{
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brk(TCONF, "Huge page is not supported");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_x_controller,
+	.tcnt = ARRAY_SIZE(test_flags),
+	.min_kver = "4.14",
+};
-- 
2.17.1

