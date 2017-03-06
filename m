From: Jakub Racek <jracek@redhat.com>
Date: Mon,  6 Mar 2017 18:45:39 +0100
Subject: [LTP] [PATCH v2 5/6] syscalls: added memfd_create dir and
	memfd_create/memfd_create01.c
In-Reply-To: <1488822340-29259-1-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
Message-ID: <1488822340-29259-6-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/memfd_create/Makefile    |  19 +
 .../kernel/syscalls/memfd_create/memfd_create01.c  | 303 ++++++++++++
 .../syscalls/memfd_create/memfd_create_common.h    | 525 +++++++++++++++++++++
 5 files changed, 850 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/Makefile
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create01.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 931a354..fd305ce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1448,3 +1448,5 @@ futex_wake03 futex_wake03
 futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
 futex_wait_bitset02 futex_wait_bitset02
+
+memfd_create01 memfd_create01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9a4727c..915b1b9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1116,3 +1116,4 @@
 /fanotify/fanotify06
 /perf_event_open/perf_event_open01
 /perf_event_open/perf_event_open02
+/memfd_create/memfd_create01
diff --git a/testcases/kernel/syscalls/memfd_create/Makefile b/testcases/kernel/syscalls/memfd_create/Makefile
new file mode 100644
index 0000000..9dbc4b9
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/Makefile
@@ -0,0 +1,19 @@
+#
+#  Copyright (C) 2017  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU General Public License as
+#  published by the Free Software Foundation; either version 2 of
+#  the License, or (at your option) any later version.
+#
+#  This program is distributed in the hope that it would be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
new file mode 100644
index 0000000..a950ce5
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -0,0 +1,303 @@
+/*
+ * Copyright (C) 2017  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+ /*
+  *  Based on Linux/tools/testing/selftests/memfd/memfd_test.c
+  *  by David Herrmann <dh.herrmann@gmail.com>
+  *
+  *  24/02/2017   Port to LTP    <jracek@redhat.com>
+  */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "memfd_create_common.h"
+
+/*
+ * Do few basic sealing tests to see whether setting/retrieving seals works.
+ */
+static void test_basic(int fd)
+{
+	/* add basic seals */
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_WRITE));
+
+	/* add them again */
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_WRITE));
+
+	/* add more seals and seal against sealing */
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_GROW | F_SEAL_SEAL));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_GROW |
+			F_SEAL_WRITE |
+			F_SEAL_SEAL));
+
+	/* verify that sealing no longer works */
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
+	CHECK_RESULT(mfd_fail_add_seals(fd, 0));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Verify that no sealing is possible when memfd is created without
+ * MFD_ALLOW_SEALING flag.
+ */
+static void test_no_sealing_without_flag(int fd)
+{
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SEAL));
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SHRINK |
+			F_SEAL_GROW |
+			F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SEAL));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test SEAL_WRITE
+ * Test whether SEAL_WRITE actually prevents modifications.
+ */
+static void test_seal_write(int fd)
+{
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
+
+	CHECK_RESULT(mfd_assert_read(fd));
+	CHECK_RESULT(mfd_fail_write(fd));
+	CHECK_RESULT(mfd_assert_shrink(fd));
+	CHECK_RESULT(mfd_assert_grow(fd));
+	CHECK_RESULT(mfd_fail_grow_write(fd));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test SEAL_SHRINK
+ * Test whether SEAL_SHRINK actually prevents shrinking
+ */
+static void test_seal_shrink(int fd)
+{
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK));
+
+	CHECK_RESULT(mfd_assert_read(fd));
+	CHECK_RESULT(mfd_assert_write(fd));
+	CHECK_RESULT(mfd_fail_shrink(fd));
+	CHECK_RESULT(mfd_assert_grow(fd));
+	CHECK_RESULT(mfd_assert_grow_write(fd));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test SEAL_GROW
+ * Test whether SEAL_GROW actually prevents growing
+ */
+static void test_seal_grow(int fd)
+{
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_GROW));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_GROW));
+
+	CHECK_RESULT(mfd_assert_read(fd));
+	CHECK_RESULT(mfd_assert_write(fd));
+	CHECK_RESULT(mfd_assert_shrink(fd));
+	CHECK_RESULT(mfd_fail_grow(fd));
+	CHECK_RESULT(mfd_fail_grow_write(fd));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test SEAL_SHRINK | SEAL_GROW
+ * Test whether SEAL_SHRINK | SEAL_GROW actually prevents resizing
+ */
+static void test_seal_resize(int fd)
+{
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK | F_SEAL_GROW));
+
+	CHECK_RESULT(mfd_assert_read(fd));
+	CHECK_RESULT(mfd_assert_write(fd));
+	CHECK_RESULT(mfd_fail_shrink(fd));
+	CHECK_RESULT(mfd_fail_grow(fd));
+	CHECK_RESULT(mfd_fail_grow_write(fd));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test sharing via dup()
+ * Test that seals are shared between dupped FDs and they're all equal.
+ */
+static void test_share_dup(int fd)
+{
+	int fd2;
+
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+
+	fd2 = SAFE_DUP(fd);
+	CHECK_RESULT(mfd_assert_has_seals(fd2, 0));
+
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE));
+
+	CHECK_RESULT(mfd_assert_add_seals(fd2, F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
+
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SEAL));
+	CHECK_RESULT(mfd_assert_has_seals(fd,
+		F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL));
+	CHECK_RESULT(mfd_assert_has_seals(fd2,
+		F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL));
+
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
+	CHECK_RESULT(mfd_fail_add_seals(fd2, F_SEAL_GROW));
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SEAL));
+	CHECK_RESULT(mfd_fail_add_seals(fd2, F_SEAL_SEAL));
+
+	SAFE_CLOSE(fd2);
+
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_GROW));
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test sealing with active mmap()s
+ * Modifying seals is only allowed if no other mmap() refs exist.
+ */
+static void test_share_mmap(int fd)
+{
+	void *p;
+
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+
+	/* shared/writable ref prevents sealing WRITE, but allows others */
+	p = SAFE_MMAP(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED,
+			fd,
+			0);
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_SHRINK));
+	SAFE_MUNMAP(p, MFD_DEF_SIZE);
+
+	/* readable ref allows sealing */
+	p = SAFE_MMAP(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ,
+			MAP_PRIVATE,
+			fd,
+			0);
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
+	SAFE_MUNMAP(p, MFD_DEF_SIZE);
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+/*
+ * Test sealing with open(/proc/self/fd/%d)
+ * Via /proc we can get access to a separate file-context for the same memfd.
+ * This is *not* like dup(), but like a real separate open(). Make sure the
+ * semantics are as expected and we correctly check for RDONLY / WRONLY / RDWR.
+ */
+static void test_share_open(int fd)
+{
+	int fd2;
+
+	CHECK_RESULT(mfd_assert_has_seals(fd, 0));
+
+	fd2 = CHECK_RESULT(mfd_assert_open(fd, O_RDWR, 0));
+	CHECK_RESULT(mfd_assert_add_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE));
+	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE));
+
+	CHECK_RESULT(mfd_assert_add_seals(fd2, F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
+
+	SAFE_CLOSE(fd);
+	fd = CHECK_RESULT(mfd_assert_open(fd2, O_RDONLY, 0));
+
+	CHECK_RESULT(mfd_fail_add_seals(fd, F_SEAL_SEAL));
+	CHECK_RESULT(mfd_assert_has_seals(fd, F_SEAL_WRITE | F_SEAL_SHRINK));
+	CHECK_RESULT(mfd_assert_has_seals(fd2, F_SEAL_WRITE | F_SEAL_SHRINK));
+
+	SAFE_CLOSE(fd2);
+
+	tst_res(TPASS, "%s", __func__);
+}
+
+static const struct tcase {
+	int flags;
+	void (*func)(int fd);
+} tcases[] = {
+	{MFD_ALLOW_SEALING, &test_basic},
+	{0,                 &test_no_sealing_without_flag},
+
+	{MFD_ALLOW_SEALING, &test_seal_write},
+	{MFD_ALLOW_SEALING, &test_seal_shrink},
+	{MFD_ALLOW_SEALING, &test_seal_grow},
+	{MFD_ALLOW_SEALING, &test_seal_resize},
+
+	{MFD_ALLOW_SEALING, &test_share_dup},
+	{MFD_ALLOW_SEALING, &test_share_mmap},
+	{MFD_ALLOW_SEALING, &test_share_open},
+};
+
+static void verify_memfd_create(unsigned int n)
+{
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	TEST(mfd_assert_new(TCID, MFD_DEF_SIZE, tc->flags));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create() failed unexpectedly");
+
+	tc->func(TEST_RETURN);
+
+	if (TEST_RETURN > 0)
+		SAFE_CLOSE(TEST_RETURN);
+}
+
+static void setup(void)
+{
+	ASSERT_HAVE_MEMFD_CREATE();
+}
+
+static struct tst_test test = {
+	.tid = "memfd_create01",
+	.test = verify_memfd_create,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
new file mode 100644
index 0000000..f07cc8c
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
@@ -0,0 +1,525 @@
+/*
+ * Copyright (C) 2017  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef MEMFD_TEST_COMMON
+#define MEMFD_TEST_COMMON
+
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <lapi/fallocate.h>
+#include <lapi/fcntl.h>
+#include <lapi/memfd.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include <tst_test.h>
+
+#include "linux_syscall_numbers.h"
+
+#define MFD_DEF_SIZE 8192
+#define STACK_SIZE 65536
+
+enum assert_retval {
+	ALL_OK,
+	MEMFD_FAIL,
+	MEMFD_MISMATCH,
+	FTRUNCATE_FAIL,
+	FCNTL_FAIL,
+	GET_SEALS_MISMATCH,
+	ADD_SEALS_FAIL,
+	ADD_SEALS_MISMATCH,
+	FSTAT_FAIL,
+	FILE_SIZE_MISMATCH,
+	OPEN_MISMATCH,
+	OPEN_FAIL,
+	MPROTECT_FAIL,
+	FALLOCATE_PUNCH_FAIL,
+	WRITE_FAIL,
+	WRITE_MISMATCH,
+	MUNMAP_FAIL,
+	MMAP_FAIL,
+	MMAP_MISMATCH,
+	MMAP_MPROT_MISMATCH,
+	FALLOCATE_PUNCH_MISMATCH,
+	FTRUNCATE_SHRINK_MISMATCH,
+	FALLOCATE_ALLOC_FAIL,
+	FTRUNCATE_GROW_MISMATCH,
+	FALLOCATE_ALLOC_MISMATCH,
+	PWRITE_FAIL,
+	PWRITE_MISMATCH,
+	READ_FAIL,
+	READ_MISMATCH,
+	CLOSE_FAIL,
+};
+
+const char *err_msg[] = {
+	"all OK",
+	"memfd_create() failed",
+	"memfd_create() succeeded, but failure expected",
+	"ftruncate() failed",
+	"fcntl() failed",
+	"GET_SEALS() returned unexpected value",
+	"ADD_SEALS() failed",
+	"ADD_SEALS() didn't fail as expected",
+	"fstat() failed",
+	"wrong file size",
+	"open() didn't fail as expected",
+	"open() failed",
+	"mprotect() failed",
+	"fallocate(PUNCH_HOLE) failed",
+	"write() failed",
+	"write() didn't fail as expected",
+	"munmap() failed",
+	"mmap() failed",
+	"mmap() didn't fail as expected",
+	"mmap()+mprotect() didn't fail as expected",
+	"fallocate(PUNCH_HOLE) didn't fail as expected",
+	"ftruncate(SHRINK) didn't fail as expected",
+	"fallocate(ALLOC) failed",
+	"ftruncate(GROW) didn't fail as expected",
+	"fallocate(ALLOC) didn't fail as expected",
+	"pwrite() failed",
+	"pwrite() didn't fail as expected",
+	"read() failed",
+	"read() didn't fail as expected",
+	"close() failed",
+};
+
+#define STRINGIFY(A) #A
+
+#define CHECK_RESULT(func2call) ({ \
+	int result; \
+	result = func2call; \
+	if (result < ALL_OK) \
+		tst_brk(TFAIL, "%s: %s", STRINGIFY(func2call), \
+			err_msg[-result]); \
+	else \
+		tst_res(TPASS, "%s", STRINGIFY(func2call)); \
+	result; \
+})
+
+#define ASSERT_HAVE_MEMFD_CREATE() do { \
+	int r; \
+	r = mfd_assert_new("dummy_call", 0, 0); \
+	if (r < 0) \
+		tst_brk(TCONF, "memfd_create does not exist on your system."); \
+		SAFE_CLOSE(r); \
+	} while (0)
+
+static int sys_memfd_create(const char *name,
+		unsigned int flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
+static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
+{
+	int fd, r;
+
+	fd = sys_memfd_create(name, flags);
+	if (fd < 0)
+		return -MEMFD_FAIL;
+
+	r = ftruncate(fd, sz);
+	if (r < 0)
+		return -FTRUNCATE_FAIL;
+
+	return fd;
+}
+
+static int mfd_fail_new(const char *name, unsigned int flags)
+{
+	int fd;
+
+	fd = sys_memfd_create(name, flags);
+	if (fd >= 0) {
+		close(fd);
+		return -MEMFD_MISMATCH;
+	}
+
+	return fd;
+}
+
+static int mfd_assert_get_seals(int fd)
+{
+	int r;
+
+	r = fcntl(fd, F_GET_SEALS);
+	if (r < 0)
+		return -FCNTL_FAIL;
+
+	return r;
+}
+
+static int mfd_assert_has_seals(int fd, int seals)
+{
+	int s;
+
+	s = mfd_assert_get_seals(fd);
+	if (s < 0)
+		return s;
+
+	if (s != seals)
+		return -GET_SEALS_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_add_seals(int fd, int seals)
+{
+	int r;
+
+	r = mfd_assert_get_seals(fd);
+	if (r < 0)
+		return r;
+
+	r = fcntl(fd, F_ADD_SEALS, seals);
+	if (r < 0)
+		return -ADD_SEALS_FAIL;
+
+	return ALL_OK;
+}
+
+static int mfd_fail_add_seals(int fd, int seals)
+{
+	int r;
+	int s;
+
+	r = fcntl(fd, F_GET_SEALS);
+	if (r < 0)
+		s = 0;
+	else
+		s = r;
+
+	r = fcntl(fd, F_ADD_SEALS, seals);
+	if (r >= 0)
+		return -ADD_SEALS_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_size(int fd, size_t size)
+{
+	struct stat st;
+	int r;
+
+	r = fstat(fd, &st);
+	if (r < 0)
+		return -FSTAT_FAIL;
+	else if (st.st_size != (long)size)
+		return -FILE_SIZE_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_open(int fd, int flags, mode_t mode)
+{
+	char buf[512];
+	int r;
+
+	sprintf(buf, "/proc/self/fd/%d", fd);
+
+	r = open(buf, flags, mode);
+	if (r < 0)
+		return -OPEN_FAIL;
+
+	return r;
+}
+
+static int mfd_fail_open(int fd, int flags, mode_t mode)
+{
+	char buf[512];
+	int r;
+
+	sprintf(buf, "/proc/self/fd/%d", fd);
+
+	r = open(buf, flags, mode);
+	if (r >= 0)
+		return -OPEN_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_read(int fd)
+{
+	char buf[16];
+	void *p;
+	ssize_t l;
+
+	l = read(fd, buf, sizeof(buf));
+	if (l != sizeof(buf))
+		return -READ_FAIL;
+
+	/* verify PROT_READ *is* allowed */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ,
+			MAP_PRIVATE,
+			fd,
+			0);
+	if (p == MAP_FAILED)
+		return -MMAP_FAIL;
+
+	if (munmap(p, MFD_DEF_SIZE) < 0)
+		return -MUNMAP_FAIL;
+
+	/* verify MAP_PRIVATE is *always* allowed (even writable) */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE,
+			fd,
+			0);
+	if (p == MAP_FAILED)
+		return -MMAP_FAIL;
+
+	if (munmap(p, MFD_DEF_SIZE) < 0)
+		return -MUNMAP_FAIL;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_write(int fd)
+{
+	void *p;
+	int r;
+
+	/* verify write() succeeds */
+	if (write(fd, "\0\0\0\0", 4) != 4)
+		return -WRITE_FAIL;
+
+	/* verify PROT_READ | PROT_WRITE is allowed */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p == MAP_FAILED)
+		return -MMAP_FAIL;
+
+	*(char *)p = 0;
+	if (munmap(p, MFD_DEF_SIZE) < 0)
+		return -MUNMAP_FAIL;
+
+	/* verify PROT_WRITE is allowed */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_WRITE,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p == MAP_FAILED)
+		return -MMAP_FAIL;
+
+	*(char *)p = 0;
+	if (munmap(p, MFD_DEF_SIZE) < 0)
+		return -MUNMAP_FAIL;
+
+	/* verify PROT_READ with MAP_SHARED is allowed and a following
+	 * mprotect(PROT_WRITE) allows writing
+	 */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p == MAP_FAILED)
+		return -MMAP_FAIL;
+
+	r = mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE);
+	if (r < 0)
+		return -MPROTECT_FAIL;
+
+	*(char *)p = 0;
+	if (munmap(p, MFD_DEF_SIZE) < 0)
+		return -MUNMAP_FAIL;
+
+	/* verify PUNCH_HOLE works */
+	r = fallocate(fd,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0,
+			MFD_DEF_SIZE);
+	if (r < 0)
+		return -FALLOCATE_PUNCH_FAIL;
+
+	return ALL_OK;
+}
+
+static int mfd_fail_write(int fd)
+{
+	ssize_t l;
+	void *p;
+	int r;
+
+	/* verify write() fails */
+	l = write(fd, "data", 4);
+	if (l != -EPERM)
+		return -WRITE_MISMATCH;
+
+	/* verify PROT_READ | PROT_WRITE is not allowed */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p != MAP_FAILED)
+		return -MMAP_MISMATCH;
+
+	/* verify PROT_WRITE is not allowed */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_WRITE,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p != MAP_FAILED)
+		return -MMAP_MISMATCH;
+
+	/* Verify PROT_READ with MAP_SHARED with a following mprotect is not
+	 * allowed. Note that for r/w the kernel already prevents the mmap.
+	 */
+	p = mmap(NULL,
+			MFD_DEF_SIZE,
+			PROT_READ,
+			MAP_SHARED,
+			fd,
+			0);
+	if (p != MAP_FAILED) {
+		r = mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE);
+		if (r >= 0)
+			return -MMAP_MPROT_MISMATCH;
+	}
+
+	/* verify PUNCH_HOLE fails */
+	r = fallocate(fd,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0,
+			MFD_DEF_SIZE);
+	if (r >= 0)
+		return -FALLOCATE_PUNCH_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_shrink(int fd)
+{
+	int fd2, r;
+
+	r = ftruncate(fd, MFD_DEF_SIZE / 2);
+	if (r < 0)
+		return -FTRUNCATE_FAIL;
+
+	r = mfd_assert_size(fd, MFD_DEF_SIZE / 2);
+	if (r < 0)
+		return r;
+
+	fd2 = mfd_assert_open(fd,
+			O_RDWR | O_CREAT | O_TRUNC,
+			0600);
+	if (fd2 < 0)
+		return fd2;
+
+	if (close(fd2) < 0)
+		return -CLOSE_FAIL;
+
+	return mfd_assert_size(fd, 0);
+}
+
+static int mfd_fail_shrink(int fd)
+{
+	int r;
+
+	r = ftruncate(fd, MFD_DEF_SIZE / 2);
+	if (r >= 0)
+		return -FTRUNCATE_SHRINK_MISMATCH;
+
+	return mfd_fail_open(fd,
+			O_RDWR | O_CREAT | O_TRUNC,
+			0600);
+}
+
+static int mfd_assert_grow(int fd)
+{
+	int r;
+
+	r = ftruncate(fd, MFD_DEF_SIZE * 2);
+	if (r < 0)
+		return -FTRUNCATE_FAIL;
+
+	r = mfd_assert_size(fd, MFD_DEF_SIZE * 2);
+	if (r < 0)
+		return r;
+
+	r = fallocate(fd,
+			0,
+			0,
+			MFD_DEF_SIZE * 4);
+	if (r < 0)
+		return -FALLOCATE_ALLOC_FAIL;
+
+	return mfd_assert_size(fd, MFD_DEF_SIZE * 4);
+}
+
+static int mfd_fail_grow(int fd)
+{
+	int r;
+
+	r = ftruncate(fd, MFD_DEF_SIZE * 2);
+	if (r >= 0)
+		return -FTRUNCATE_GROW_MISMATCH;
+
+	r = fallocate(fd,
+			0,
+			0,
+			MFD_DEF_SIZE * 4);
+	if (r >= 0)
+		return -FALLOCATE_ALLOC_MISMATCH;
+
+	return ALL_OK;
+}
+
+static int mfd_assert_grow_write(int fd)
+{
+	static char buf[MFD_DEF_SIZE * 8];
+	ssize_t l;
+
+	l = pwrite(fd, buf, sizeof(buf), 0);
+	if (l != sizeof(buf))
+		return -PWRITE_FAIL;
+
+	return mfd_assert_size(fd, MFD_DEF_SIZE * 8);
+}
+
+static int mfd_fail_grow_write(int fd)
+{
+	static char buf[MFD_DEF_SIZE * 8];
+	ssize_t l;
+
+	l = pwrite(fd, buf, sizeof(buf), 0);
+	if (l == sizeof(buf))
+		return -PWRITE_MISMATCH;
+
+	return ALL_OK;
+}
+
+#endif
-- 
1.8.3.1

