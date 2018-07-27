From: Vishnu K <vishnu@zilogic.com>
Date: Fri, 27 Jul 2018 13:53:20 -0000
Subject: [LTP] [PATCH v3] Test for memfd_create() syscall with MFD_HUGETLB
	flag.
Message-ID: <20180727135320.6590-1-vishnu@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* memfd_create03: Tests the syscall for the flag MFD_HUGETLB.

* memfd_create04: Tests the syscall for the flags MFD_HUGE_2MB,
    MFD_HUGE_1GB,... used in conjunction with
  MFD_HUGETLB flag.

* memfd_create_hugetlb: Contains helper functions for memfd_create03.c
  and memfd_create04.c.

-- major changes from v2 to v3 --

* memfd_create03:

** Move the code logic from CHECK_HUGE_NON_WRITEABLE() to
   test_write_protect() avoiding indirection.

** Move the code logic from CHECK_MUNMAP_LT_PAGE() to
   test_def_pagesize() avoiding indirection.

** Remove get_from_file() and it's dependencies from
   memfd_create_hugetlb, and use SAFE_FILE_LINES_SCANF()
   in the main test code.

** Change set-up logic such that it check for free hugepages
   and allocate them if needed.

* memfd_create04:

** Remove the memory-mapping of file.

** Change set-up logic to check for hugepage support only
   and remove clean-up.

Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
Signed-off-by: Vishnu K <vishnu@zilogic.com>
---
 include/lapi/memfd.h                          |  33 +++
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/memfd_create/.gitignore   |   2 +
 .../syscalls/memfd_create/memfd_create03.c    | 230 ++++++++++++++++++
 .../syscalls/memfd_create/memfd_create04.c    | 100 ++++++++
 .../memfd_create/memfd_create_hugetlb.c       |  69 ++++++
 .../memfd_create/memfd_create_hugetlb.h       |  35 +++
 7 files changed, 471 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create03.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create04.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h

diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
index 18ed40fc6..72e50d2d0 100644
--- a/include/lapi/memfd.h
+++ b/include/lapi/memfd.h
@@ -24,4 +24,37 @@
 # define MFD_ALLOW_SEALING       0x0002U
 #endif
 
+/* flags for memfd_create(3) and memfd_create(4)  */
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
index dc72484cb..24661e2b1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1481,5 +1481,7 @@ futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
+memfd_create03 memfd_create03
+memfd_create04 memfd_create04
 
 copy_file_range01 copy_file_range01
diff --git a/testcases/kernel/syscalls/memfd_create/.gitignore b/testcases/kernel/syscalls/memfd_create/.gitignore
index 9b20604ab..b79adfa65 100644
--- a/testcases/kernel/syscalls/memfd_create/.gitignore
+++ b/testcases/kernel/syscalls/memfd_create/.gitignore
@@ -1,2 +1,4 @@
 /memfd_create01
 /memfd_create02
+/memfd_create03
+/memfd_create04
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
new file mode 100644
index 000000000..4227d15b4
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -0,0 +1,230 @@
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
+ *		Hugepages are write protected. Any writes to
+ *		the file should return EINVAL error.
+ *
+ * Test case 2: --PAGE SIZE OF CREATED FILE TEST--
+ *		Default hugepage sized pages are created with
+ *		MFD_HUGETLB flag. Any attempt to unmap memory-mapped
+ *		hugepages with an unmapping length less than
+ *		hugepage size should return EINVAL error.
+ *
+ * Test case 3: --HUGEPAGE ALLOCATION LIMIT TEST--
+ *		Number of hugepages currently available to use should be
+ *		atmost total number of allowed hugepages. Memory-mapping
+ *		more than allowed hugepages should return ENOMEM error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_hugetlb.h"
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
+static int hugepages_enabled;
+static long og_total_pages;
+
+static void test_write_protect(int fd)
+{
+	ssize_t ret;
+	char test_str[] = "LTP";
+
+	ret = write(fd, test_str, sizeof(test_str));
+	if (ret < 0) {
+		if (errno != EINVAL) {
+			tst_res(TFAIL,
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
+	mem = CHECK_HUGE_MMAPABLE(fd, hps);
+
+	for (i = unmap_size; i < hps; i += unmap_size) {
+		ret = munmap(mem, i);
+		if (ret == -1) {
+			tst_res(TINFO,
+				"munmap(%p, %dkb) failed as expected",
+				mem, i/1024);
+		} else {
+			tst_res(TFAIL,
+				"munmap(%p, %d) suceeded unexpectedly\n",
+				mem, i);
+			return;
+		}
+	}
+
+	SAFE_MUNMAP(mem, hps);
+
+	tst_res(TPASS, "File created in default pagesize %ldkB\n", hps/1024);
+}
+
+static void test_max_hugepages(int fd)
+{
+	int res;
+	int new_fd;
+	long hps;
+	long free_pages;
+	void *mem;
+
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, DEFAULT_HPS, &hps);
+	hps = hps << 10;
+	mem = CHECK_HUGE_MMAPABLE(fd, free_pages * hps);
+
+	new_fd = sys_memfd_create("new_file", MFD_HUGETLB);
+	if (new_fd < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create() failed");
+	tst_res(TINFO, "memfd_create() succeeded");
+
+	res = CHECK_HUGE_NON_MMAPABLE(new_fd, hps);
+	if (res == 0)
+		tst_res(TPASS, "Hugepages creation is limited as expected\n");
+	else
+		tst_res(TFAIL, "Hugepages exceeded the allocation limit\n");
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
+		tst_brk(TBROK | TERRNO, "memfd_create() failed");
+
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
+	if (access("/sys/kernel/mm/hugepages", F_OK))
+		tst_brk(TCONF, "Huge page is not supported");
+
+	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
+	if (free_pages > 0)
+		return;
+
+	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &og_total_pages);
+	sprintf(buf, "%ld", og_total_pages + 4);
+
+	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+
+	if (write(fd, buf, strlen(buf)) == -1)
+		tst_brk(TCONF, "write() fail: Enable Hugepages manually");
+
+	hugepages_enabled = 1;
+
+	SAFE_CLOSE(fd);
+
+	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &total_pages);
+	if (total_pages != (og_total_pages + 4))
+		tst_brk(TCONF, "Enable Hugepages manually");
+}
+
+static void cleanup(void)
+{
+	char buf[8];
+	int fd;
+	long total_pages;
+
+	if (hugepages_enabled == 0)
+		return;
+
+	sprintf(buf, "%ld", og_total_pages);
+
+	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+
+	if (write(fd, buf, strlen(buf)) == -1)
+		tst_brk(TCONF, "Clean-up failed: write() failed");
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
index 000000000..f10f3d2bc
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -0,0 +1,100 @@
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
+ * Test cases: Attempt to create hugepages of different sizes.
+ *
+ * Test logic:	memfd_create() should return non-negative value (fd)
+ *		if the system supports that particular hugepage size.
+ *		On success, fd is returned.
+ *              On failure, -1 is returned with ENODEV error.
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
+static  struct test_flag {
+	int flag;
+	char *h_size;
+	int exp_err;
+} test_flags[] =  {
+	{.flag = MFD_HUGE_64KB,   .h_size = "64kB"},
+	{.flag = MFD_HUGE_512KB, .h_size = "512kB"},
+	{.flag = MFD_HUGE_2MB,     .h_size = "2MB"},
+	{.flag = MFD_HUGE_8MB,     .h_size = "8MB"},
+	{.flag = MFD_HUGE_16MB,   .h_size = "16MB"},
+	{.flag = MFD_HUGE_256MB, .h_size = "256MB"},
+	{.flag = MFD_HUGE_1GB,     .h_size = "1GB"},
+	{.flag = MFD_HUGE_2GB,     .h_size = "2GB"},
+	{.flag = MFD_HUGE_16GB,   .h_size = "16GB"},
+};
+
+static void check_hugepage_support(struct test_flag *test_flags)
+{
+	char pattern[50];
+
+	sprintf(pattern, "DirectMap%s", test_flags->h_size);
+	strcat(pattern, ":\t%ld kB");
+
+	if (FILE_LINES_SCANF("/proc/meminfo", pattern, NULL) == 1)
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
+	tst_res(TINFO, "Attempt to create %s huge pages", tflag.h_size);
+
+	fd = sys_memfd_create("tfile", MFD_HUGETLB | tflag.flag);
+	if (fd < 0) {
+		tst_res(TINFO | TERRNO, "memfd_create() failed");
+
+		if (errno == tflag.exp_err)
+			tst_res(TPASS, "Test failed as expected\n");
+		else
+			tst_brk(TFAIL, "memfd_create() failed unexpectedly");
+
+		return;
+	}
+
+	tst_res(TPASS, "memfd_create succeeded for %s page size\n",
+		tflag.h_size);
+}
+
+static void setup(void)
+{
+	if (access("/sys/kernel/mm/hugepages", F_OK))
+		tst_brk(TCONF, "Huge page is not supported");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_x_controller,
+	.tcnt = ARRAY_SIZE(test_flags),
+	.min_kver = "4.14",
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
new file mode 100644
index 000000000..3ce7ad9e4
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
@@ -0,0 +1,69 @@
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
+#define _GNU_SOURCE
+
+#include "memfd_create_hugetlb.h"
+#include "lapi/syscalls.h"
+
+#include <sys/mman.h>
+#include <string.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+void *check_huge_mmapable(const char *filename, const int lineno,
+			  int fd, unsigned long size)
+{
+	void *mem;
+
+	mem = SAFE_MMAP(NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	memset((char *)mem, 0, 1);
+	tst_res_(filename, lineno, TINFO,
+		 "mmap(%p, %lu, %d, %d, %d, %d) succeeded",
+		 NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	return mem;
+}
+
+int check_huge_non_mmapable(const char *filename, const int lineno,
+			    int fd, unsigned long size)
+{
+	void *mem;
+
+	mem = mmap(NULL, size, 0, MAP_PRIVATE, fd, 0);
+
+	if (mem == MAP_FAILED) {
+		if (errno == ENOMEM)
+			tst_res_(filename, lineno, TINFO,
+				 "mmap(%p, %lu, %d, %d, %d, %d) failed",
+				 NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+		else
+			tst_brk_(filename, lineno, TBROK | TTERRNO,
+				 "unable to mmap");
+		return 0;
+	}
+
+	tst_res_(filename, lineno, TINFO,
+		 "mmap(%p, %lu, %d, %d, %d, %d) succeeded",
+		 NULL, size, 0, MAP_PRIVATE, fd, 0);
+
+	SAFE_MUNMAP(mem, size);
+
+	return -1;
+}
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
new file mode 100644
index 000000000..92eac31d6
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
@@ -0,0 +1,35 @@
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
+#ifndef _MEMFD_CREATE_HUGETLB_H_
+#define _MEMFD_CREATE_HUGETLB_H_
+
+#define CHECK_HUGE_MMAPABLE(fd, size)				\
+	check_huge_mmapable(__FILE__, __LINE__, (fd), (size))
+
+#define CHECK_HUGE_NON_MMAPABLE(fd, size)			\
+	check_huge_non_mmapable(__FILE__, __LINE__, (fd), (size))
+
+
+void *check_huge_mmapable(const char *filename, const int lineno, int fd,
+			  unsigned long size);
+
+int check_huge_non_mmapable(const char *filename, const int lineno, int fd,
+			    unsigned long size);
+
+
+#endif
-- 
2.17.1

