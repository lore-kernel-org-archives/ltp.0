From: Vishnu K <vishnu@zilogic.com>
Date: Wed, 11 Jul 2018 13:50:32 -0000
Subject: [LTP] [PATCH v1] Test for memfd_create() syscall with MFD_HUGETLB
	flag.
Message-ID: <20180711135032.8669-1-vishnu@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


memfd_create03.c: Tests the syscall for the flag MFD_HUGETLB.

memfd_create04.c: Tests the syscall for the flags MFD_HUGE_2MB, MFD_HUGE_1GB,... used in conjunction with MFD_HUGETLB flag.

memfd_create_hugetlb.c: Contains helper functions for memfd_create03.c and memfd_create04.c.

Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
Signed-off-by: Vishnu K <vishnu@zilogic.com>
---
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/memfd_create/Makefile     |   4 +-
 .../syscalls/memfd_create/memfd_create03.c    | 151 +++++++++++
 .../syscalls/memfd_create/memfd_create04.c    | 139 ++++++++++
 .../memfd_create/memfd_create_hugetlb.c       | 244 ++++++++++++++++++
 .../memfd_create/memfd_create_hugetlb.h       |  86 ++++++
 6 files changed, 624 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create03.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create04.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h

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
index 000000000..8120ca6c8
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#include <stdio.h>
+
+#define MEMINFO_PATH "/proc/meminfo"
+#define HUGEPAGES_COUNT_STR "4"
+
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
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
+	unsigned int hps;
+	void *mem;
+
+	hps = GET_HUGE_DEF_PAGESIZE();
+	mem = CHECK_HUGE_MMAPABLE(fd, hps);
+	ret = CHECK_HUGE_PAGESIZE(mem, hps);
+	if (ret == 0)
+		tst_res(TPASS, "File created in def pagesize %dkB", hps/1024);
+	else
+		tst_res(TFAIL, "File is not in default pagesize");
+}
+
+static void test_max_hugepages(int fd)
+{
+	int res;
+	int new_fd;
+	unsigned int hps;
+	unsigned int free_pages;
+	void *mem;
+
+	free_pages = GET_HUGE_FREE_PAGES();
+	hps = GET_HUGE_DEF_PAGESIZE();
+	mem = CHECK_HUGE_MMAPABLE(fd, free_pages * hps);
+
+	new_fd = SAFE_HUGE_NEW("new_file", MFD_HUGETLB);
+	res = CHECK_HUGE_NON_MMAPABLE(new_fd, hps);
+	SAFE_HUGE_CLOSE(new_fd);
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
+	int flags;
+	void (*func)(int fd);
+	const char *desc;
+} tcases[] = {
+	{MFD_HUGETLB, &test_write_protect, "Testing write call in hugepages"},
+	{MFD_HUGETLB, &test_def_pagesize, "Testing page size of created file"},
+	{MFD_HUGETLB, &test_max_hugepages, "Testing the number of hugepages"},
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
+	fd = SAFE_HUGE_NEW("test_file", tc->flags);
+
+	tc->func(fd);
+
+	SAFE_HUGE_CLOSE(fd);
+	printf("\n");
+}
+
+static void setup(void)
+{
+	int fd;
+	int size;
+
+	if (GET_HUGE_TOTAL_PAGES() == 0) {
+		fd = open("/proc/sys/vm/nr_hugepages", O_WRONLY);
+		if (fd == -1)
+			tst_brk(TBROK | TERRNO, "Enable Hugepages manually");
+
+		size = strlen(HUGEPAGES_COUNT_STR);
+		if (write(fd, HUGEPAGES_COUNT_STR, size) == -1)
+			tst_brk(TBROK | TERRNO, "Enable Hugepages manually");
+	}
+
+	if (GET_HUGE_TOTAL_PAGES() == 0)
+		tst_brk(TBROK, "Enable Hugepages manually");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_controller,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.min_kver = "4.14",
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
new file mode 100644
index 000000000..8d893ff0f
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#define HUGEPAGES_COUNT_STR "4"
+
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
+
+#define MFD_HUGE_64KB (16 << 26)
+#define MFD_HUGE_512KB (19 << 26)
+#define MFD_HUGE_2MB (21 << 26)
+#define MFD_HUGE_8MB (23 << 26)
+#define MFD_HUGE_16MB (24 << 26)
+#define MFD_HUGE_256MB (28 << 26)
+#define MFD_HUGE_1GB (30 << 26)
+#define MFD_HUGE_2GB (31 << 26)
+#define MFD_HUGE_16GB (34 << 26)
+
+static  struct test_flag {
+	int flags;
+	unsigned long size;
+	char *h_size;
+	int exp_err;
+} test_flags[] =  {
+	{.flags = MFD_HUGE_64KB, .size = 64*1024, .h_size = "64kB"},
+	{.flags = MFD_HUGE_512KB, .size = 512*1024, .h_size = "512kB"},
+	{.flags = MFD_HUGE_2MB, .size = 2*1024*1024, .h_size = "2MB"},
+	{.flags = MFD_HUGE_8MB, .size = 8*1024*1024, .h_size = "8MB"},
+	{.flags = MFD_HUGE_16MB, .size = 16*1024*1024, .h_size = "16MB"},
+	{.flags = MFD_HUGE_256MB, .size = 256*1024*1024, .h_size = "256MB"},
+	{.flags = MFD_HUGE_1GB,	 .size = 1*1024*1024*1024L, .h_size = "1GB"},
+	{.flags = MFD_HUGE_2GB, .size = 2*1024*1024*1024L, .h_size = "2GB"},
+	{.flags = MFD_HUGE_16GB, .size = 16*1024*1024*1024L, .h_size = "16GB"},
+};
+
+static void check_hugepage_support(struct test_flag *test_flags)
+{
+	char pattern[50];
+
+	sprintf(pattern, "DirectMap%s", test_flags->h_size);
+	pattern[strlen(pattern) - 1] = 0;
+	strcat(pattern, ":\t%lu kB");
+
+	if (get_from_file(MEMINFO_PATH, pattern) == -1)
+		test_flags->exp_err = ENODEV;
+}
+
+static void memfd_huge_x_controller(unsigned int n)
+{
+	int fd;
+	int ret;
+	struct test_flag tflag;
+
+	tflag = test_flags[n];
+	check_hugepage_support(&tflag);
+	tst_res(TINFO, "Attempt to create %s huge pages", tflag.h_size);
+
+	fd = CHECK_HUGE_X_NEW("tfile", MFD_HUGETLB | tflag.flags);
+	if (fd < 0) {
+		tst_res(TINFO | TERRNO, "memfd_create() failed");
+		if (fd == -tflag.exp_err)
+			tst_res(TPASS, "Test failed as expected\n");
+		else
+			tst_brk(TFAIL, "memfd_create() failed unexpectedly");
+		return;
+	}
+
+	ret = CHECK_HUGE_NON_MMAPABLE(fd, tflag.size);
+	if (ret == 0)
+		tst_res(TWARN, "Page not created in expected %s\n",
+			tflag.h_size);
+
+	SAFE_HUGE_CLOSE(fd);
+	tst_res(TPASS, "Successfully created %s pages\n", tflag.h_size);
+}
+
+static void setup(void)
+{
+	int fd;
+	int size;
+
+	if (GET_HUGE_TOTAL_PAGES() == 0) {
+		fd = open("/proc/sys/vm/nr_hugepages", O_WRONLY);
+		if (fd == -1)
+			tst_brk(TBROK | TERRNO, "Enable Hugepages manually");
+
+		size = strlen(HUGEPAGES_COUNT_STR);
+		if (write(fd, HUGEPAGES_COUNT_STR, size) == -1)
+			tst_brk(TBROK | TERRNO, "Enable Hugepages manually");
+	}
+
+	if (GET_HUGE_TOTAL_PAGES() == 0)
+		tst_brk(TBROK, "Enable Hugepages manually");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = memfd_huge_x_controller,
+	.tcnt = ARRAY_SIZE(test_flags),
+	.needs_root = 1,
+	.min_kver = "4.14",
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
new file mode 100644
index 000000000..197f86f83
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+
+#include "lapi/syscalls.h"
+
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define MEMINFO_PATH "/proc/meminfo"
+
+#define MFD_HUGETLB 0x0004U
+#define BLOCK_SIZE (4 * 1024)
+
+
+int safe_huge_new(const char *filename, const int lineno,
+		   const char *name, int flags)
+{
+	int fd;
+
+	fd = tst_syscall(__NR_memfd_create, name, flags);
+	if (fd == -1)
+		tst_brk_(filename, lineno, TBROK | TERRNO,
+			 "memfd_create(%s, %d) failed",
+			 name, flags);
+
+	tst_res_(filename, lineno, TINFO,
+		 "memfd_create(%s, %d) succeeded: fd %d",
+		 name, flags, fd);
+
+	return fd;
+}
+
+int check_huge_x_new(const char *filename, const int lineno,
+		   const char *name, int flags)
+{
+	int fd;
+
+	fd = tst_syscall(__NR_memfd_create, name, flags);
+	if (fd == -1)
+		return -errno;
+
+	tst_res_(filename, lineno, TINFO,
+		 "memfd_create(%s, %d) succeeded: fd %d",
+		 name, flags, fd);
+
+	return fd;
+}
+
+void safe_huge_close(const char *filename, const int lineno,
+		      int fd)
+{
+	int dummy_fd;
+
+	dummy_fd = fd;
+	SAFE_CLOSE(fd);
+	tst_res_(filename, lineno, TINFO, "close(%d) succeeded", dummy_fd);
+}
+
+int check_huge_non_writeable(const char *filename, const int lineno,
+			     int fd)
+{
+	ssize_t ret;
+	char test_str[] = "data";
+
+	ret = write(fd, test_str, sizeof(test_str));
+
+	if (ret < 0) {
+		if (errno != EINVAL) {
+			tst_res_(filename, lineno, TINFO,
+				 "write(%d, \"%s\", %ld) didn't fail as expected",
+				 fd, test_str, strlen(test_str));
+			return -1;
+		}
+	} else {
+		tst_res_(filename, lineno, TINFO,
+			 "write(%d, \"%s\", %ld) succeeded unexpectedly",
+			 fd, test_str, strlen(test_str));
+		return -1;
+	}
+
+	tst_res_(filename, lineno, TINFO,
+		 "write(%d, \"%s\", %ld) failed as expected",
+		 fd, test_str, strlen(test_str));
+
+	return 0;
+}
+
+int check_huge_pagesize(const char *filename, const int lineno,
+			void *page_mem, unsigned long page_size)
+{
+	unsigned int i;
+	int ret;
+	int unmap_size = page_size / 4;
+
+	for (i = unmap_size; i <= page_size; i += unmap_size) {
+		ret = munmap(page_mem, i);
+		if (ret == -1) {
+			tst_res_(filename, lineno, TINFO,
+				 "munmap(%p, %dkb) failed",
+				 page_mem, i/1024);
+			if (i % page_size == 0)
+				return -1;
+		} else {
+			tst_res_(filename, lineno, TINFO,
+				 "munmap(%p, %d) suceeded",
+				 page_mem, i);
+			if (i % page_size != 0)
+				return -1;
+		}
+
+	}
+	return 0;
+}
+
+void *check_huge_mmapable(const char *filename, const int lineno,
+			  int fd, unsigned long size)
+{
+	void *mem;
+
+	mem = SAFE_MMAP(NULL, size, PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
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
+	mem = mmap(NULL, size, 0,
+		   MAP_PRIVATE, fd, 0);
+
+	if (mem == MAP_FAILED) {
+		if (errno == ENOMEM)
+			tst_res_(filename, lineno, TINFO,
+				 "mmap(%p, %lu, %d, %d, %d, %d) failed as expected",
+				 NULL, size, PROT_WRITE, MAP_PRIVATE, fd, 0);
+		else
+			tst_brk_(filename, lineno, TBROK | TTERRNO,
+				 "unable to mmap");
+		return 0;
+	}
+
+	tst_res_(filename, lineno, TINFO,
+		 "mmap(%p, %lu, %d, %d, %d, %d) succeeded unexpectedly",
+		 NULL, size, 0, MAP_PRIVATE, fd, 0);
+
+	SAFE_MUNMAP(mem, size);
+
+	return -1;
+}
+
+/*
+ * The function is based on the code available in linux
+ * kernel source repository file
+ * linux/tools/testing/selftests/memfd/common.c
+ */
+long get_from_file(const char *filepath, char *pattern)
+{
+	long val = -1;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen(filepath, "r");
+
+	if (!f)
+		return -1;
+
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, pattern, &val) == 1)
+			break;
+	}
+
+	free(line);
+	fclose(f);
+	return val;
+}
+
+unsigned long get_huge_def_pagesize(const char *filename, const int lineno)
+{
+	char *pattern = "Hugepagesize:\t%lu kB";
+	int hps;
+
+	hps = get_from_file(MEMINFO_PATH, pattern);
+	if (hps == -1)
+		tst_brk_(filename, lineno, TBROK,
+			 "unable to get hugepage size");
+	return hps << 10;
+}
+
+unsigned int get_huge_free_pages(const char *filename, const int lineno)
+{
+	char *pattern = "HugePages_Free:\t%d";
+	int free_pages;
+
+	free_pages = get_from_file(MEMINFO_PATH, pattern);
+	if (free_pages == -1)
+		tst_brk_(filename, lineno, TBROK,
+			 "unable to get free hugepages");
+	return free_pages;
+}
+
+unsigned int get_huge_total_pages(const char *filename, const int lineno)
+{
+	char *pattern = "HugePages_Total:\t%d";
+	int total_pages;
+
+	total_pages = get_from_file(MEMINFO_PATH, pattern);
+	if (total_pages == -1)
+		tst_brk_(filename, lineno, TBROK,
+			 "unable to get total hugepages");
+	return total_pages;
+}
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
new file mode 100644
index 000000000..2fab1bda7
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_hugetlb.h
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+
+#define SAFE_HUGE_NEW(name, flags)				\
+	safe_huge_new(__FILE__, __LINE__, name, (flags))
+
+#define CHECK_HUGE_X_NEW(name, flags)				\
+	check_huge_x_new(__FILE__, __LINE__, name, (flags))
+
+#define SAFE_HUGE_CLOSE(fd)				\
+	safe_huge_close(__FILE__, __LINE__, (fd))
+
+#define CHECK_HUGE_NON_WRITEABLE(fd)				\
+	check_huge_non_writeable(__FILE__, __LINE__, (fd))
+
+#define CHECK_HUGE_PAGESIZE(mem, page_size)				\
+	check_huge_pagesize(__FILE__, __LINE__, (mem), (page_size))
+
+#define CHECK_HUGE_MULTI_PAGES(fd, page_size)				\
+	check_huge_multi_pages(__FILE__, __LINE__, (fd), (page_size))
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
+int safe_huge_new(const char *filename, const int lineno, const char *name,
+		   int flags);
+
+int check_huge_x_new(const char *filename, const int lineno, const char *name,
+		   int flags);
+
+void safe_huge_close(const char *filename, const int lineno, int fd);
+
+int check_huge_non_writeable(const char *filename, const int lineno, int fd);
+
+int check_huge_pagesize(const char *filename, const int lineno, void *page_mem,
+			unsigned long page_size);
+
+int check_huge_multi_pages(const char *filename, const int lineno, int fd,
+			unsigned long page_size);
+
+void *check_huge_mmapable(const char *filename, const int lineno, int fd,
+			  unsigned long size);
+
+int check_huge_non_mmapable(const char *filename, const int lineno, int fd,
+			    unsigned long size);
+
+unsigned long get_huge_def_pagesize(const char *filename, int lineno);
+
+unsigned int get_huge_total_pages(const char *filename, int lineno);
+
+unsigned int get_huge_free_pages(const char *filename, int lineno);
+
+long get_from_file(const char *filepath, char *pattern);
+
+#endif
-- 
2.17.1

