From: Vishnu K <vishnu@zilogic.com>
Date: Fri, 20 Jul 2018 10:18:07 -0000
Subject: [LTP] [PATCH v2] Test for memfd_create() syscall with MFD_HUGETLB
	flag.
Message-ID: <20180720101807.4760-1-vishnu@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


memfd_create03.c: Tests the syscall for the flag MFD_HUGETLB.

memfd_create04.c: Tests the syscall for the flags MFD_HUGE_2MB,
MFD_HUGE_1GB,... used in conjunction with MFD_HUGETLB flag.

memfd_create_hugetlb.c: Contains helper functions for memfd_create03.c
and memfd_create04.c.

-- major changes from v1 to v2 --

Restore the original number of hugepages in cleanup().

Modify check_mfd_new() from memfd_create_common and replace
safe_huge_new() + safe_huge_x_new() from memfd_create_hugetlb
with it.

Modify get_from_file() from memfd_create_hugetlb to use
FILE_LINES_SCANF in code logic.

Move test dependent flags to include/lapi

Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
Signed-off-by: Vishnu K <vishnu@zilogic.com>
---
 include/lapi/memfd.h                          |  34 ++++
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/memfd_create/.gitignore   |   2 +
 .../kernel/syscalls/memfd_create/Makefile     |   4 +-
 .../syscalls/memfd_create/memfd_create03.c    | 165 +++++++++++++++++
 .../syscalls/memfd_create/memfd_create04.c    | 140 ++++++++++++++
 .../memfd_create/memfd_create_common.c        |  20 +-
 .../memfd_create/memfd_create_hugetlb.c       | 173 ++++++++++++++++++
 .../memfd_create/memfd_create_hugetlb.h       |  60 ++++++
 9 files changed, 594 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create03.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create04.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h

diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
index 18ed40fc6..1f92a18aa 100644
--- a/include/lapi/memfd.h
+++ b/include/lapi/memfd.h
@@ -24,4 +24,38 @@
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
+
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index a9afecf57..c310b0106 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1479,5 +1479,7 @@ futex_wait_bitset02 futex_wait_bitset02
 
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
diff --git a/testcases/kernel/syscalls/memfd_create/Makefile b/testcases/kernel/syscalls/memfd_create/Makefile
index f23b8732c..ec83a5c40 100644
--- a/testcases/kernel/syscalls/memfd_create/Makefile
+++ b/testcases/kernel/syscalls/memfd_create/Makefile
@@ -16,8 +16,8 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-FILTER_OUT_MAKE_TARGETS         := memfd_create_common
+FILTER_OUT_MAKE_TARGETS         := memfd_create_common memfd_create_hugetlb
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-$(MAKE_TARGETS): %: %.o memfd_create_common.o
+$(MAKE_TARGETS): %: %.o memfd_create_common.o memfd_create_hugetlb.o
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
new file mode 100644
index 000000000..26ad64ab3
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -0,0 +1,165 @@
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
+ * Test case 1: Write protect test
+ *		Hugepages are write protected. Any writes to
+ *		the file should return EINVAL error.
+ *
+ * Test case 2: Hugepage size test
+ *		Default hugepage sized pages are created with
+ *		MFD_HUGETLB flag. Any attempt to unmap memory-mapped
+ *		hugepages with an unmapping length less than
+ *		hugepage size should return EINVAL error.
+ *
+ * Test case 3: Number of hugepages test
+ *		Number of hugepages currently available to use should be
+ *		atmost total number of allowed hugepages. Memory-mapping
+ *		more than allowed hugepages should return ENOMEM error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_common.h"
+#include "memfd_create_hugetlb.h"
+
+#define MEMINFO_PATH "/proc/meminfo"
+
+static int hugepages_enabled;
+
+static void test_write_protect(int fd)
+{
+	if (CHECK_HUGE_NON_WRITEABLE(fd) == 0)
+		tst_res(TPASS, "write call failed as expected");
+	else
+		tst_res(TFAIL, "write call passed unexpectedly");
+}
+
+static void test_def_pagesize(int fd)
+{
+	int ret;
+	long hps;
+	void *mem;
+
+	hps = GET_HUGE_DEF_PAGESIZE();
+	mem = CHECK_HUGE_MMAPABLE(fd, hps);
+
+	ret = CHECK_MUNMAP_LT_PAGE(mem, hps);
+	if (ret == 0)
+		tst_res(TPASS, "File created in def pagesize %ldkB", hps/1024);
+	else
+		tst_res(TFAIL, "File is not in default pagesize");
+}
+
+static void test_max_hugepages(int fd)
+{
+	int res;
+	int new_fd;
+	int dummy_fd;
+	long hps;
+	long free_pages;
+	void *mem;
+
+	free_pages = GET_HUGE_FREE_PAGES();
+	hps = GET_HUGE_DEF_PAGESIZE();
+	mem = CHECK_HUGE_MMAPABLE(fd, free_pages * hps);
+
+	new_fd = CHECK_MFD_NEW("new_file", 0, MFD_HUGETLB);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create() failed");
+	res = CHECK_HUGE_NON_MMAPABLE(new_fd, hps);
+	dummy_fd = new_fd;
+	SAFE_CLOSE(new_fd);
+	tst_res(TINFO, "close(%d) succeeded", dummy_fd);
+
+	SAFE_MUNMAP(mem, free_pages * hps);
+
+	if (res == 0)
+		tst_res(TPASS, "Hugepages creation is limited as expected");
+	else
+		tst_res(TFAIL, "Hugepages creation limit failed");
+}
+
+static const struct tcase {
+	void (*func)(int fd);
+	const char *desc;
+} tcases[] = {
+	{&test_write_protect, "--TESTING WRITE CALL IN HUGEPAGES--"},
+	{&test_def_pagesize, "--TESTING PAGE SIZE OF CREATED FILE--"},
+	{&test_max_hugepages, "--TESTING THE NUMBER OF HUGEPAGES--"},
+};
+
+static void memfd_huge_controller(unsigned int n)
+{
+	int fd;
+	int dummy_fd;
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->desc);
+
+	fd = CHECK_MFD_NEW("test_file", 0, MFD_HUGETLB);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create() failed");
+
+	tc->func(fd);
+
+	dummy_fd = fd;
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "close(%d) succeeded", dummy_fd);
+}
+
+static void setup(void)
+{
+	int fd;
+
+	if (GET_HUGE_TOTAL_PAGES() > 0)
+		return;
+
+	fd = SAFE_OPEN("/proc/sys/vm/nr_hugepages", O_WRONLY);
+	SAFE_WRITE(1, fd, "4", 1);
+	hugepages_enabled = 1;
+	SAFE_CLOSE(fd);
+
+	if (GET_HUGE_TOTAL_PAGES() == 0)
+		tst_brk(TCONF, "Enable Hugepages manually");
+}
+
+static void cleanup(void)
+{
+	int fd;
+
+	if (hugepages_enabled == 0)
+		return;
+
+	fd = SAFE_OPEN("/proc/sys/vm/nr_hugepages", O_WRONLY);
+	SAFE_WRITE(1, fd, "0", 1);
+	SAFE_CLOSE(fd);
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
index 000000000..2593ad568
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -0,0 +1,140 @@
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
+ *		On success, size of hugepages are then validated with the fd
+ *		returned. On failure, syscall should return appropriate error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_common.h"
+#include "memfd_create_hugetlb.h"
+
+#include <errno.h>
+#include <sys/mman.h>
+#include <stdio.h>
+
+#define MEMINFO_PATH "/proc/meminfo"
+
+static int hugepages_enabled;
+
+static  struct test_flag {
+	int flag;
+	unsigned long long size;
+	char *h_size;
+	int exp_err;
+} test_flags[] =  {
+	{.flag = MFD_HUGE_64KB, .size = 64*1024ULL, .h_size = "64kB"},
+	{.flag = MFD_HUGE_512KB, .size = 512*1024ULL, .h_size = "512kB"},
+	{.flag = MFD_HUGE_2MB, .size = 2*1024*1024ULL, .h_size = "2MB"},
+	{.flag = MFD_HUGE_8MB, .size = 8*1024*1024ULL, .h_size = "8MB"},
+	{.flag = MFD_HUGE_16MB, .size = 16*1024*1024ULL, .h_size = "16MB"},
+	{.flag = MFD_HUGE_256MB, .size = 256*1024*1024ULL, .h_size = "256MB"},
+	{.flag = MFD_HUGE_1GB,	 .size = 1*1024*1024*1024ULL, .h_size = "1GB"},
+	{.flag = MFD_HUGE_2GB, .size = 2*1024*1024*1024ULL, .h_size = "2GB"},
+	{.flag = MFD_HUGE_16GB, .size = 16*1024*1024*1024ULL, .h_size = "16GB"},
+};
+
+static void check_hugepage_support(struct test_flag *test_flags)
+{
+	char pattern[50];
+
+	sprintf(pattern, "DirectMap%s", test_flags->h_size);
+	strcat(pattern, ":\t%ld kB");
+
+	if (FILE_LINES_SCANF(MEMINFO_PATH, pattern, NULL) == 1)
+		test_flags->exp_err = ENODEV;
+}
+
+static void memfd_huge_x_controller(unsigned int n)
+{
+	int fd;
+	int dummy_fd;
+	int ret;
+	struct test_flag tflag;
+
+	tflag = test_flags[n];
+	check_hugepage_support(&tflag);
+	tst_res(TINFO, "Attempt to create %s huge pages", tflag.h_size);
+
+	fd = CHECK_MFD_NEW("tfile", 0, MFD_HUGETLB | tflag.flag);
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
+	ret = CHECK_HUGE_NON_MMAPABLE(fd, tflag.size);
+	if (ret == 0)
+		tst_res(TWARN, "Contiguous memory unavailable to map");
+
+	dummy_fd = fd;
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "close(%d) succeeded", dummy_fd);
+
+	tst_res(TPASS, "Successfully created %s pages\n", tflag.h_size);
+}
+
+static void setup(void)
+{
+	int fd;
+
+	if (GET_HUGE_TOTAL_PAGES() > 0)
+		return;
+
+	fd = SAFE_OPEN("/proc/sys/vm/nr_hugepages", O_WRONLY);
+	SAFE_WRITE(1, fd, "4", 1);
+	hugepages_enabled = 1;
+	SAFE_CLOSE(fd);
+
+	if (GET_HUGE_TOTAL_PAGES() == 0)
+		tst_brk(TCONF, "Enable Hugepages manually");
+}
+
+static void cleanup(void)
+{
+	int fd;
+
+	if (hugepages_enabled == 0)
+		return;
+
+	fd = SAFE_OPEN("/proc/sys/vm/nr_hugepages", O_WRONLY);
+	SAFE_WRITE(1, fd, "0", 1);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_x_controller,
+	.tcnt = ARRAY_SIZE(test_flags),
+	.needs_root = 1,
+	.min_kver = "4.14",
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index f22e3d345..186eafa51 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -144,21 +144,33 @@ int mfd_flags_available(const char *filename, const int lineno,
 }
 
 int check_mfd_new(const char *filename, const int lineno,
-			const char *name, loff_t sz, int flags)
+		  const char *name, loff_t sz, int flags)
 {
 	int fd;
 
 	fd = sys_memfd_create(name, flags);
 	if (fd < 0) {
+		if ((flags & MFD_HUGETLB) == MFD_HUGETLB)
+			goto end;
+
 		tst_brk_(filename, lineno, TBROK | TERRNO,
-			"memfd_create(%s, %d) failed", name, flags);
+			 "memfd_create(%s, %d) failed", name, flags);
+	}
+
+	if ((flags & MFD_HUGETLB) == MFD_HUGETLB) {
+		tst_res_(filename, lineno, TINFO,
+			 "memfd_create(%s, %d) succeeded",
+			 name, flags);
+		goto end;
 	}
 
-	tst_res_(filename, lineno, TPASS, "memfd_create(%s, %d) succeeded",
-		name, flags);
+	tst_res_(filename, lineno, TPASS,
+		 "memfd_create(%s, %d) succeeded",
+		 name, flags);
 
 	check_ftruncate(filename, lineno, fd, sz);
 
+ end:
 	return fd;
 }
 
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
new file mode 100644
index 000000000..085565e9c
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
@@ -0,0 +1,173 @@
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
+#include "memfd_create_common.h"
+#include "memfd_create_hugetlb.h"
+#include "lapi/syscalls.h"
+
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define MEMINFO_PATH "/proc/meminfo"
+
+int check_huge_non_writeable(const char *filename, const int lineno, int fd)
+{
+	ssize_t ret;
+	char test_str[] = "data";
+
+	ret = write(fd, test_str, sizeof(test_str));
+
+	if (ret < 0) {
+		if (errno != EINVAL) {
+			tst_res_(filename, lineno, TINFO,
+				 "write(%d, \"%s\", %zu) didn't fail as expected",
+				 fd, test_str, strlen(test_str));
+
+			return -1;
+		}
+	} else {
+		tst_res_(filename, lineno, TINFO,
+			 "write(%d, \"%s\", %zu) succeeded unexpectedly",
+			 fd, test_str, strlen(test_str));
+
+		return -1;
+	}
+
+	tst_res_(filename, lineno, TINFO,
+		 "write(%d, \"%s\", %zu) failed as expected",
+		 fd, test_str, strlen(test_str));
+
+	return 0;
+}
+
+int check_munmap_lt_page(const char *filename, const int lineno,
+			 void *page_mem, unsigned long page_size)
+{
+	unsigned int i;
+	int ret;
+	int unmap_size = page_size / 4;
+
+	for (i = unmap_size; i < page_size; i += unmap_size) {
+		ret = munmap(page_mem, i);
+		if (ret == -1) {
+			tst_res_(filename, lineno, TINFO,
+				 "munmap(%p, %dkb) failed as expected",
+				 page_mem, i/1024);
+		} else {
+			tst_res_(filename, lineno, TINFO,
+				 "munmap(%p, %d) suceeded unexpectedly",
+				 page_mem, i);
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
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
+		 "mmap(%p, %lu, %d, %d, %d, %d) succeeded: %p",
+		 NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0, mem);
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
+
+static void get_from_file(const char *filename, const int lineno,
+			  char *pattern, char *err_msg, long *val)
+{
+	int ret;
+
+	ret = FILE_LINES_SCANF(MEMINFO_PATH, pattern, val);
+	if (ret == 1)
+		tst_brk_(filename, lineno, TBROK, err_msg, NULL);
+}
+
+long get_huge_def_pagesize(const char *filename, const int lineno)
+{
+	char *pattern = "Hugepagesize:\t%ld kB";
+	char *err_msg = "Unable to get hugepage size";
+	long hps;
+
+	get_from_file(filename, lineno, pattern, err_msg, &hps);
+
+	return hps << 10;
+}
+
+long get_huge_free_pages(const char *filename, const int lineno)
+{
+	char *pattern = "HugePages_Free:\t%ld";
+	char *err_msg = "Unable to get number of free hugepages";
+	long free_pages;
+
+	get_from_file(filename, lineno, pattern, err_msg, &free_pages);
+
+	return free_pages;
+}
+
+long get_huge_total_pages(const char *filename, const int lineno)
+{
+	char *pattern = "HugePages_Total:\t%ld";
+	char *err_msg = "Unable to get total number of hugepages";
+	long total_pages;
+
+	get_from_file(filename, lineno, pattern, err_msg, &total_pages);
+
+	return total_pages;
+}
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
new file mode 100644
index 000000000..a5f139075
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
@@ -0,0 +1,60 @@
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
+#define CHECK_HUGE_NON_WRITEABLE(fd)				\
+	check_huge_non_writeable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MUNMAP_LT_PAGE(mem, page_size)				\
+	check_munmap_lt_page(__FILE__, __LINE__, (mem), (page_size))
+
+#define CHECK_HUGE_MMAPABLE(fd, size)				\
+	check_huge_mmapable(__FILE__, __LINE__, (fd), (size))
+
+#define CHECK_HUGE_NON_MMAPABLE(fd, size)			\
+	check_huge_non_mmapable(__FILE__, __LINE__, (fd), (size))
+
+#define GET_HUGE_DEF_PAGESIZE()				\
+	get_huge_def_pagesize(__FILE__, __LINE__)
+
+#define GET_HUGE_TOTAL_PAGES()				\
+	get_huge_total_pages(__FILE__, __LINE__)
+
+#define GET_HUGE_FREE_PAGES()			\
+	get_huge_free_pages(__FILE__, __LINE__)
+
+
+int check_huge_non_writeable(const char *filename, const int lineno, int fd);
+
+int check_munmap_lt_page(const char *filename, const int lineno, void *page_mem,
+			unsigned long page_size);
+
+void *check_huge_mmapable(const char *filename, const int lineno, int fd,
+			  unsigned long size);
+
+int check_huge_non_mmapable(const char *filename, const int lineno, int fd,
+			    unsigned long size);
+
+long get_huge_def_pagesize(const char *filename, int lineno);
+
+long get_huge_total_pages(const char *filename, int lineno);
+
+long get_huge_free_pages(const char *filename, int lineno);
+
+#endif
-- 
2.17.1

