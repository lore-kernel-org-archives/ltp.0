From: Jakub Racek <jracek@redhat.com>
Date: Wed, 15 Mar 2017 17:35:39 +0100
Subject: [LTP] [PATCH v4 5/6] syscalls: added memfd_create dir and
	memfd_create/memfd_create01.c
In-Reply-To: <1489595740-26159-1-git-send-email-jracek@redhat.com>
References: <1489595740-26159-1-git-send-email-jracek@redhat.com>
Message-ID: <1489595740-26159-6-git-send-email-jracek@redhat.com>
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
 .../kernel/syscalls/memfd_create/memfd_create01.c  | 284 +++++++++++++
 .../syscalls/memfd_create/memfd_create_common.h    | 457 +++++++++++++++++++++
 5 files changed, 763 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/Makefile
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create01.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 89abac5..d2e0a73 100644
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
index 0000000..8e560ac
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -0,0 +1,284 @@
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
+/*
+ *  Based on Linux/tools/testing/selftests/memfd/memfd_test.c
+ *  by David Herrmann <dh.herrmann@gmail.com>
+ *
+ *  24/02/2017   Port to LTP    <jracek@redhat.com>
+ */
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
+
+	/* add them again */
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_WRITE);
+
+	/* add more seals and seal against sealing */
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_GROW | F_SEAL_SEAL);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW |
+			F_SEAL_WRITE | F_SEAL_SEAL);
+
+	/* verify that sealing no longer works */
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
+	CHECK_MFD_FAIL_ADD_SEALS(fd, 0);
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
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SEAL);
+	CHECK_MFD_FAIL_ADD_SEALS(fd,
+			F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SEAL);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
+
+	CHECK_MFD_READABLE(fd);
+	CHECK_MFD_NON_WRITEABLE(fd);
+	CHECK_MFD_SHRINKABLE(fd);
+	CHECK_MFD_GROWABLE(fd);
+	CHECK_NON_GROWABLE_BY_WRITE(fd);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK);
+
+	CHECK_MFD_READABLE(fd);
+	CHECK_MFD_WRITEABLE(fd);
+	CHECK_MFD_NON_SHRINKABLE(fd);
+	CHECK_MFD_GROWABLE(fd);
+	CHECK_GROWABLE_BY_WRITE(fd);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_GROW);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_GROW);
+
+	CHECK_MFD_READABLE(fd);
+	CHECK_MFD_WRITEABLE(fd);
+	CHECK_MFD_SHRINKABLE(fd);
+	CHECK_MFD_NON_GROWABLE(fd);
+	CHECK_NON_GROWABLE_BY_WRITE(fd);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK | F_SEAL_GROW);
+
+	CHECK_MFD_READABLE(fd);
+	CHECK_MFD_WRITEABLE(fd);
+	CHECK_MFD_NON_SHRINKABLE(fd);
+	CHECK_MFD_NON_GROWABLE(fd);
+	CHECK_NON_GROWABLE_BY_WRITE(fd);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+
+	fd2 = SAFE_DUP(fd);
+	CHECK_MFD_HAS_SEALS(fd2, 0);
+
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE);
+
+	CHECK_MFD_ADD_SEALS(fd2, F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
+
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SEAL);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_SEAL);
+
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
+	CHECK_MFD_FAIL_ADD_SEALS(fd2, F_SEAL_GROW);
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_SEAL);
+	CHECK_MFD_FAIL_ADD_SEALS(fd2, F_SEAL_SEAL);
+
+	SAFE_CLOSE(fd2);
+
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_GROW);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+
+	/* shared/writable ref prevents sealing WRITE, but allows others */
+	p = SAFE_MMAP(NULL, MFD_DEF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
+			fd, 0);
+
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SHRINK);
+	SAFE_MUNMAP(p, MFD_DEF_SIZE);
+
+	/* readable ref allows sealing */
+	p = SAFE_MMAP(NULL, MFD_DEF_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
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
+	CHECK_MFD_HAS_SEALS(fd, 0);
+
+	fd2 = CHECK_MFD_OPEN(fd, O_RDWR, 0);
+	CHECK_MFD_ADD_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE);
+
+	CHECK_MFD_ADD_SEALS(fd2, F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
+
+	SAFE_CLOSE(fd);
+	fd = CHECK_MFD_OPEN(fd2, O_RDONLY, 0);
+
+	CHECK_MFD_FAIL_ADD_SEALS(fd, F_SEAL_SEAL);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_WRITE | F_SEAL_SHRINK);
+	CHECK_MFD_HAS_SEALS(fd2, F_SEAL_WRITE | F_SEAL_SHRINK);
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
+	int fd;
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	fd = CHECK_MFD_NEW(TCID, MFD_DEF_SIZE, tc->flags);
+
+	tc->func(fd);
+
+	SAFE_CLOSE(fd);
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
index 0000000..71f4123
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
@@ -0,0 +1,457 @@
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
+static int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return tst_syscall(__NR_memfd_create, name, flags);
+}
+
+static void check_ftruncate(const char *filename, const int lineno,
+		int fd, off_t length)
+{
+	safe_ftruncate(filename, lineno, fd, length);
+
+	tst_res_(filename, lineno, TPASS,
+			"ftruncate(%d, %ld) succeeded", fd, length);
+}
+
+static void check_ftruncate_fail(const char *filename, const int lineno,
+		int fd, off_t length)
+{
+	if (ftruncate(fd, length) >= 0)
+		tst_brk_(filename, lineno, TFAIL,
+				"ftruncate(%d, %ld) succeeded unexpectedly",
+				fd, length);
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+			"ftruncate(%d, %ld) failed as expected", fd, length);
+}
+
+#define CHECK_MFD_NEW(name, sz, flags) \
+	check_mfd_new(__FILE__, __LINE__, name, (sz), (flags))
+
+static int check_mfd_new(const char *filename, const int lineno,
+		const char *name, loff_t sz, int flags)
+{
+	int fd;
+
+	fd = sys_memfd_create(name, flags);
+	if (fd < 0)
+		tst_brk_(filename, lineno, TBROK | TERRNO,
+				"memfd_create(%s, %d) failed", name, flags);
+	tst_res_(filename, lineno, TPASS, "memfd_create(%s, %d) succeeded",
+			name, flags);
+
+	check_ftruncate(filename, lineno, fd, sz);
+
+	return fd;
+}
+
+static int check_fallocate(const char *filename, const int lineno,
+		int fd, int mode, off_t offset, off_t len)
+{
+	int r;
+
+	r = fallocate(fd, mode, offset, len);
+	if (r < 0)
+		tst_brk_(filename, lineno, TFAIL | TERRNO,
+				"fallocate(%d, %d, %ld, %ld) failed",
+				fd, mode, offset, len);
+
+	tst_res_(filename, lineno, TPASS,
+			"fallocate(%d, %d, %ld, %ld) succeeded",
+			fd, mode, offset, len);
+
+	return r;
+}
+
+static int check_fallocate_fail(const char *filename, const int lineno,
+		int fd, int mode, off_t offset, off_t len)
+{
+	int r;
+
+	r = fallocate(fd, mode, offset, len);
+	if (r >= 0)
+		tst_brk_(filename, lineno, TFAIL,
+			"fallocate(%d, %d, %ld, %ld) succeeded unexpectedly",
+			fd, mode, offset, len);
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+			"fallocate(%d, %d, %ld, %ld) failed as expected",
+			fd, mode, offset, len);
+
+	return r;
+}
+
+#define ASSERT_HAVE_MEMFD_CREATE() \
+	assert_have_memfd_create(__FILE__, __LINE__)
+
+void assert_have_memfd_create(const char *filename, const int lineno)
+{
+	int flags;
+
+	TEST(sys_memfd_create("dummy_call", 0));
+	if (TEST_RETURN < 0) {
+		flags = ((TERRNO == -ENOSYS ||
+			TERRNO == -EINVAL) ? TCONF : TBROK) | TERRNO;
+		tst_brk_(filename, lineno, flags, "memfd_create() failed");
+	}
+
+	SAFE_CLOSE(TEST_RETURN);
+}
+
+
+#define CHECK_MFD_FAIL_NEW(name, flags) \
+	do { \
+		int fd; \
+		fd = sys_memfd_create((name), (flags)); \
+		if (fd >= 0) { \
+			safe_close(__FILE__, __LINE__, NULL, fd); \
+			tst_brk(TFAIL, \
+				"memfd_create(%s, %d) succeeded unexpectedly",\
+				(name), (flags)); \
+		} \
+		tst_res_(__FILE__, __LINE__, TPASS | TERRNO, \
+			"memfd_create(%s, %d) failed as expected", \
+			(name), (flags)) \
+	} while (0)
+
+#define CHECK_MMAP_FAIL(addr, length, prot, flags, fd, offset) \
+	check_mmap_fail(__FILE__, __LINE__, (addr), (length), (prot), \
+			(flags), (fd), (offset))
+
+void check_mmap_fail(const char *file, const int lineno, void *addr,
+		size_t length, int prot, int flags, int fd, off_t offset)
+{
+	if (mmap(addr, length, prot, flags, fd, offset) != MAP_FAILED) {
+		tst_brk_(file, lineno, TFAIL,
+			"mmap(%p, %zu, %i, %i, %i, %zi) succeeded unexpectedly",
+			addr, length, prot, flags, fd, offset);
+	}
+
+	tst_res_(file, lineno, TPASS | TERRNO,
+			"mmap(%p, %zu, %i, %i, %i, %zi) failed as expected",
+			addr, length, prot, flags, fd, offset);
+}
+
+#define CHECK_MMAP(addr, length, prot, flags, fd, offset) \
+	check_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
+			(flags), (fd), (offset))
+
+void *check_mmap(const char *file, const int lineno, void *addr,
+		size_t length, int prot, int flags, int fd, off_t offset)
+{
+	void *p;
+
+	p = safe_mmap(file, lineno, addr, length, prot, flags, fd, offset);
+
+	tst_res_(file, lineno, TPASS,
+			"mmap(%p, %zu, %i, %i, %i, %zi) succeeded",
+			addr, length, prot, flags, fd, offset);
+
+	return p;
+}
+
+#define CHECK_MUNMAP(p, length) \
+	check_munmap(__FILE__, __LINE__, (p), (length))
+
+void check_munmap(const char *file, const int lineno, void *p, size_t length)
+{
+	safe_munmap(file, lineno, NULL, p, length);
+	tst_res_(file, lineno, TPASS, "munmap(%p, %ld) succeeded",
+			p, length);
+}
+
+void check_mprotect(const char *file, const int lineno, void *addr,
+		size_t length, int prot)
+{
+	if (mprotect(addr, length, prot) < 0)
+		tst_brk_(file, lineno, TFAIL | TERRNO,
+			"mprotect(%p, %ld, %d) failed", addr, length, prot);
+
+	tst_res_(file, lineno, TPASS,
+			"mprotect(%p, %ld, %d) succeeded", addr, length, prot);
+}
+
+#define CHECK_MFD_GET_SEALS(fd) \
+	({int r = SAFE_FCNTL((fd), F_GET_SEALS); \
+	 tst_res(TPASS, "fcntl(%d, F_GET_SEALS) succeeded", (fd)); r; })
+
+#define CHECK_MFD_HAS_SEALS(fd, seals) \
+	do { \
+		if (CHECK_MFD_GET_SEALS((fd)) != (seals)) \
+		tst_brk(TFAIL, "fd %d doesn't have expected seals", (fd)); \
+		tst_res(TPASS, "fd %d has expected seals", (fd)); \
+	} while (0)
+
+#define CHECK_MFD_ADD_SEALS(fd, seals) \
+	({int r = SAFE_FCNTL((fd), F_ADD_SEALS, (seals)); \
+	 tst_res(TPASS, "fcntl(%d, F_ADD_SEALS, %d) succeeded", \
+		 (fd), (seals)); r; })
+
+#define CHECK_MFD_FAIL_ADD_SEALS(fd, seals) \
+	do { \
+		if (fcntl((fd), F_ADD_SEALS, (seals)) >= 0) \
+		tst_brk(TFAIL, \
+			"fcntl(%d, F_ADD_SEALS) succeeded unexpectedly", \
+			(fd)); \
+		tst_res(TPASS | TERRNO, \
+			"fcntl(%d, F_ADD_SEALS, %d) failed as expected", \
+				(fd), (seals)); \
+	} while (0)
+
+#define CHECK_MFD_SIZE(fd, size) \
+	check_mfd_size(__FILE__, __LINE__, (fd), (size))
+
+static void check_mfd_size(const char *filename, const int lineno,
+		int fd, size_t size)
+{
+	struct stat st;
+
+	safe_fstat(filename, lineno, fd, &st);
+
+	if (st.st_size != (long)size)
+		tst_brk_(filename, lineno, TFAIL,
+				"fstat(%d, &st): unexpected file size", fd);
+
+	tst_res_(filename, lineno, TPASS,
+			"fstat(%d, &st): file size is correct", fd);
+}
+
+#define CHECK_MFD_OPEN(fd, flags, mode) \
+	check_mfd_open(__FILE__, __LINE__, (fd), (flags), (mode))
+
+static int check_mfd_open(const char *filename, const int lineno, int fd,
+		int flags, mode_t mode)
+{
+	int r;
+	char buf[512];
+
+	sprintf(buf, "/proc/self/fd/%d", fd);
+
+	r = safe_open(filename, lineno, NULL, buf, flags, mode);
+	tst_res_(filename, lineno, TPASS, "open(%s, %d, %d) succeeded",
+			buf, flags, mode);
+
+	return r;
+}
+
+#define CHECK_MFD_FAIL_OPEN(fd, flags, mode) \
+	do { \
+		char buf[512]; \
+		sprintf(buf, "/proc/self/fd/%d", (fd)); \
+		if (open(buf, (flags), (mode)) >= 0) \
+		tst_brk(TFAIL, "open(%s, %d, %d) succeeded unexpectedly",\
+				buf, (flags), (mode)); \
+		tst_res(TPASS | TERRNO, "open(%s, %d, %d) failed as expected",\
+				buf, (flags), (mode));\
+	} while (0)
+
+#define CHECK_MFD_READABLE(fd) \
+	check_mfd_readable(__FILE__, __LINE__, (fd))
+
+static void check_mfd_readable(const char *filename, const int lineno, int fd)
+{
+	char buf[16];
+	void *p;
+
+	safe_read(filename, lineno, NULL, 1, fd, buf, sizeof(buf));
+	tst_res_(filename, lineno, TPASS, "read(%d, %s, %ld) succeeded",
+			fd, buf, sizeof(buf));
+
+	/* verify PROT_READ *is* allowed */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_READ, MAP_PRIVATE, fd, 0);
+
+	check_munmap(filename, lineno, p, MFD_DEF_SIZE);
+
+	/* verify MAP_PRIVATE is *always* allowed (even writable) */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	check_munmap(filename, lineno, p, MFD_DEF_SIZE);
+}
+
+#define CHECK_MFD_WRITEABLE(fd) \
+	check_mfd_writeable(__FILE__, __LINE__, (fd))
+
+static void check_mfd_writeable(const char *filename,
+		const int lineno, int fd)
+{
+	void *p;
+
+	/* verify write() succeeds */
+	safe_write(filename, lineno, NULL, 1, fd, "\0\0\0\0", 4);
+	tst_res_(filename, lineno, TPASS, "write(%d, %p, %d) succeeded",
+			fd, "\0\0\0\0", 4);
+
+	/* verify PROT_READ | PROT_WRITE is allowed */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	*(char *)p = 0;
+	check_munmap(filename, lineno, p, MFD_DEF_SIZE);
+
+	/* verify PROT_WRITE is allowed */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_WRITE, MAP_SHARED, fd, 0);
+
+	*(char *)p = 0;
+	check_munmap(filename, lineno, p, MFD_DEF_SIZE);
+
+	/* verify PROT_READ with MAP_SHARED is allowed and a following
+	 * mprotect(PROT_WRITE) allows writing
+	 */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_READ, MAP_SHARED, fd, 0);
+
+	check_mprotect(filename, lineno, p, MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE);
+
+	*(char *)p = 0;
+	check_munmap(filename, lineno, p, MFD_DEF_SIZE);
+
+	/* verify PUNCH_HOLE works */
+	check_fallocate(filename, lineno, fd,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, MFD_DEF_SIZE);
+}
+
+#define CHECK_MFD_NON_WRITEABLE(fd) \
+	check_mfd_non_writeable(__FILE__, __LINE__, (fd))
+
+static void check_mfd_non_writeable(const char *filename,
+		const int lineno, int fd)
+{
+	ssize_t l;
+	void *p;
+
+	/* verify write() fails */
+	l = write(fd, "data", 4);
+	if (l != -EPERM)
+		tst_brk(TFAIL | TERRNO, "write() didn't fail as expected");
+
+	/* verify PROT_READ | PROT_WRITE is not allowed */
+	check_mmap_fail(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	/* verify PROT_WRITE is not allowed */
+	check_mmap_fail(filename, lineno, NULL, MFD_DEF_SIZE,
+			PROT_WRITE, MAP_SHARED, fd, 0);
+
+	/* Verify PROT_READ with MAP_SHARED with a following mprotect is not
+	 * allowed. Note that for r/w the kernel already prevents the mmap.
+	 */
+	p = mmap(NULL, MFD_DEF_SIZE, PROT_READ, MAP_SHARED, fd, 0);
+	if (p != MAP_FAILED) {
+		if (mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE) >= 0)
+			tst_brk(TFAIL | TERRNO,
+				"mmap()+mprotect() succeeded unexpectedly");
+	}
+
+	/* verify PUNCH_HOLE fails */
+	check_fallocate_fail(filename, lineno, fd,
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, MFD_DEF_SIZE);
+}
+
+#define CHECK_MFD_SHRINKABLE(fd) \
+	check_mfd_shrinkable(__FILE__, __LINE__, (fd))
+
+static void check_mfd_shrinkable(const char *filename,
+				const int lineno, int fd)
+{
+	int fd2;
+
+	check_ftruncate(filename, lineno, fd, MFD_DEF_SIZE / 2);
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE / 2);
+
+	fd2 = check_mfd_open(filename, lineno, fd,
+			O_RDWR | O_CREAT | O_TRUNC, 0600);
+	safe_close(filename, lineno, NULL, fd2);
+
+	check_mfd_size(filename, lineno, fd, 0);
+}
+
+#define CHECK_MFD_NON_SHRINKABLE(fd) \
+	do { \
+		check_ftruncate_fail(__FILE__, __LINE__, (fd), \
+				MFD_DEF_SIZE / 2); \
+		CHECK_MFD_FAIL_OPEN((fd), (O_RDWR | O_CREAT | O_TRUNC), 0600);\
+	} while (0)
+
+#define CHECK_MFD_GROWABLE(fd) \
+	check_mfd_growable(__FILE__, __LINE__, (fd))
+
+static void check_mfd_growable(const char *filename, const int lineno, int fd)
+{
+	check_ftruncate(filename, lineno, fd, MFD_DEF_SIZE * 2);
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 2);
+
+	check_fallocate(filename, lineno, fd, 0, 0, MFD_DEF_SIZE * 4);
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 4);
+}
+
+#define CHECK_MFD_NON_GROWABLE(fd) \
+	do { \
+		check_ftruncate_fail(__FILE__, __LINE__, fd, \
+				MFD_DEF_SIZE * 2); \
+		check_fallocate_fail(__FILE__, __LINE__, fd, \
+				0, 0, MFD_DEF_SIZE * 4); \
+	} while (0)
+
+#define CHECK_GROWABLE_BY_WRITE(fd) \
+	do {\
+		char buf[MFD_DEF_SIZE * 8]; \
+		if (pwrite((fd), buf, sizeof(buf), 0) != sizeof(buf)) \
+		tst_brk(TFAIL | TERRNO, "pwrite(%d, %s, %ld, %d) failed", \
+				(fd), buf, sizeof(buf), 0); \
+		tst_res(TPASS, "pwrite(%d, %s, %ld, %d) succeeded", \
+				(fd), buf, sizeof(buf), 0); \
+		check_mfd_size(__FILE__, __LINE__, (fd), MFD_DEF_SIZE * 8); \
+	} while (0)
+
+#define CHECK_NON_GROWABLE_BY_WRITE(fd) \
+	do { \
+		char buf[MFD_DEF_SIZE * 8]; \
+		if (pwrite((fd), buf, sizeof(buf), 0) == sizeof(buf)) \
+		tst_brk(TFAIL, \
+			"pwrite(%d, %s, %ld, %d) didn't fail as expected", \
+			(fd), buf, sizeof(buf), 0); \
+	} while (0)
+
+#endif
-- 
1.8.3.1

