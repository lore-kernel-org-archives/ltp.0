From: Jakub Racek <jracek@redhat.com>
Date: Thu, 23 Mar 2017 19:15:56 +0100
Subject: [LTP] [PATCH v5 5/6] syscalls: added memfd_create dir and
	memfd_create/memfd_create01.c
In-Reply-To: <1490292957-26941-1-git-send-email-jracek@redhat.com>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
Message-ID: <1490292957-26941-6-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/memfd_create/Makefile    |  23 ++
 .../kernel/syscalls/memfd_create/memfd_create01.c  | 270 +++++++++++++
 .../syscalls/memfd_create/memfd_create_common.c    | 446 +++++++++++++++++++++
 .../syscalls/memfd_create/memfd_create_common.h    | 152 +++++++
 6 files changed, 894 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/Makefile
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create01.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 84930ca..2da5b48 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1450,3 +1450,5 @@ futex_wake03 futex_wake03
 futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
 futex_wait_bitset02 futex_wait_bitset02
+
+memfd_create01 memfd_create01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 5838c1c..905badc 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1118,3 +1118,4 @@
 /fanotify/fanotify06
 /perf_event_open/perf_event_open01
 /perf_event_open/perf_event_open02
+/memfd_create/memfd_create01
diff --git a/testcases/kernel/syscalls/memfd_create/Makefile b/testcases/kernel/syscalls/memfd_create/Makefile
new file mode 100644
index 0000000..f23b873
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/Makefile
@@ -0,0 +1,23 @@
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
+FILTER_OUT_MAKE_TARGETS         := memfd_create_common
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o memfd_create_common.o
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
new file mode 100644
index 0000000..c181fe6
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -0,0 +1,270 @@
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
+		F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRITE);
+	CHECK_MFD_HAS_SEALS(fd, F_SEAL_SEAL);
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
+	CHECK_MFD_GROWABLE_BY_WRITE(fd);
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
+		fd, 0);
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
+}
+
+
+static const struct tcase {
+	int flags;
+	void (*func)(int fd);
+	const char *desc;
+} tcases[] = {
+	{MFD_ALLOW_SEALING, &test_basic, "Basic tests + set/get seals"},
+	{0,                 &test_no_sealing_without_flag, "Disabled sealing"},
+
+	{MFD_ALLOW_SEALING, &test_seal_write, "Write seal"},
+	{MFD_ALLOW_SEALING, &test_seal_shrink, "Shrink seal"},
+	{MFD_ALLOW_SEALING, &test_seal_grow, "Grow seal"},
+	{MFD_ALLOW_SEALING, &test_seal_resize, "Resize seal"},
+
+	{MFD_ALLOW_SEALING, &test_share_dup, "Seals shared for dup"},
+	{MFD_ALLOW_SEALING, &test_share_mmap, "Seals shared for mmap"},
+	{MFD_ALLOW_SEALING, &test_share_open, "Seals shared for open"},
+};
+
+static void verify_memfd_create(unsigned int n)
+{
+	int fd;
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->desc);
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
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
new file mode 100644
index 0000000..0c7143b
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -0,0 +1,446 @@
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
+ #define _GNU_SOURCE
+
+ #include <sys/types.h>
+ #include <sys/syscall.h>
+ #include <sys/uio.h>
+ #include <lapi/fallocate.h>
+ #include <lapi/fcntl.h>
+ #include <lapi/memfd.h>
+ #include <errno.h>
+ #include <string.h>
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
+
+ #define TST_NO_DEFAULT_MAIN
+ #include <tst_test.h>
+
+#include "linux_syscall_numbers.h"
+
+#include "memfd_create_common.h"
+
+int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return tst_syscall(__NR_memfd_create, name, flags);
+}
+
+int check_fallocate(const char *filename, const int lineno, int fd,
+			int mode, off_t offset, off_t len)
+{
+	int r;
+
+	r = fallocate(fd, mode, offset, len);
+	if (r < 0) {
+		tst_brk_(filename, lineno, TFAIL | TERRNO,
+			"fallocate(%d, %d, %ld, %ld) failed", fd, mode,
+			offset, len);
+	}
+
+	tst_res_(filename, lineno, TPASS,
+		"fallocate(%d, %d, %ld, %ld) succeeded", fd, mode,
+		offset, len);
+
+	return r;
+}
+
+int check_fallocate_fail(const char *filename, const int lineno, int fd,
+				int mode, off_t offset, off_t len)
+{
+	int r;
+
+	r = fallocate(fd, mode, offset, len);
+	if (r >= 0) {
+		tst_res_(filename, lineno, TFAIL,
+			"fallocate(%d, %d, %ld, %ld) succeeded unexpectedly",
+			fd, mode, offset, len);
+
+		return r;
+	}
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+		"fallocate(%d, %d, %ld, %ld) failed as expected", fd,
+		mode, offset, len);
+
+	return r;
+}
+
+void check_ftruncate(const char *filename, const int lineno, int fd,
+			off_t length)
+{
+	safe_ftruncate(filename, lineno, fd, length);
+
+	tst_res_(filename, lineno, TPASS, "ftruncate(%d, %ld) succeeded", fd,
+		length);
+}
+
+void check_ftruncate_fail(const char *filename, const int lineno,
+				int fd, off_t length)
+{
+	if (ftruncate(fd, length) >= 0) {
+		tst_res_(filename, lineno, TFAIL,
+			"ftruncate(%d, %ld) succeeded unexpectedly",
+			fd, length);
+
+		return;
+	}
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+		"ftruncate(%d, %ld) failed as expected", fd, length);
+}
+
+void assert_have_memfd_create(const char *filename, const int lineno)
+{
+	TEST(sys_memfd_create("dummy_call", 0));
+	if (TEST_RETURN < 0) {
+		if (TEST_ERRNO == EINVAL) {
+			tst_brk_(filename, lineno, TCONF | TTERRNO,
+				"memfd_create() not implemented");
+		}
+
+		tst_brk_(filename, lineno, TBROK | TTERRNO,
+			"memfd_create() failed");
+	}
+
+	SAFE_CLOSE(TEST_RETURN);
+}
+
+int check_mfd_new(const char *filename, const int lineno,
+			const char *name, loff_t sz, int flags)
+{
+	int fd;
+
+	fd = sys_memfd_create(name, flags);
+	if (fd < 0) {
+		tst_brk_(filename, lineno, TBROK | TERRNO,
+			"memfd_create(%s, %d) failed", name, flags);
+	}
+
+	tst_res_(filename, lineno, TPASS, "memfd_create(%s, %d) succeeded",
+		name, flags);
+
+	check_ftruncate(filename, lineno, fd, sz);
+
+	return fd;
+}
+
+void check_mfd_fail_new(const char *filename, const int lineno,
+			const char *name, int flags)
+{
+	int fd;
+
+	fd = sys_memfd_create(name, flags);
+	if (fd >= 0) {
+		safe_close(filename, lineno, NULL, fd);
+		tst_brk(TFAIL, "memfd_create(%s, %d) succeeded unexpectedly",
+			name, flags);
+	}
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+		"memfd_create(%s, %d) failed as expected", name, flags);
+}
+
+void *check_mmap(const char *file, const int lineno, void *addr, size_t length,
+		int prot, int flags, int fd, off_t offset)
+{
+	void *p;
+
+	p = safe_mmap(file, lineno, addr, length, prot, flags, fd, offset);
+
+	tst_res_(file, lineno, TPASS,
+		"mmap(%p, %zu, %i, %i, %i, %zi) succeeded", addr,
+		length, prot, flags, fd, offset);
+
+	return p;
+}
+
+void check_mmap_fail(const char *file, const int lineno, void *addr,
+		size_t length, int prot, int flags, int fd, off_t offset)
+{
+	if (mmap(addr, length, prot, flags, fd, offset) != MAP_FAILED) {
+		tst_res_(file, lineno, TFAIL,
+			"mmap(%p, %zu, %i, %i, %i, %zi) succeeded unexpectedly",
+			addr, length, prot, flags, fd, offset);
+
+		return;
+	}
+
+	tst_res_(file, lineno, TPASS | TERRNO,
+		"mmap(%p, %zu, %i, %i, %i, %zi) failed as expected",
+		addr, length, prot, flags, fd, offset);
+}
+
+void check_munmap(const char *file, const int lineno, void *p, size_t length)
+{
+	safe_munmap(file, lineno, NULL, p, length);
+
+	tst_res_(file, lineno, TPASS, "munmap(%p, %ld) succeeded", p, length);
+}
+
+void check_mprotect(const char *file, const int lineno, void *addr,
+		size_t length, int prot)
+{
+	if (mprotect(addr, length, prot) < 0) {
+		tst_brk_(file, lineno, TFAIL | TERRNO,
+			"mprotect(%p, %ld, %d) failed", addr, length, prot);
+	}
+
+	tst_res_(file, lineno, TPASS, "mprotect(%p, %ld, %d) succeeded", addr,
+		length, prot);
+}
+
+void check_mfd_fail_add_seals(const char *filename, const int lineno,
+				int fd, int seals)
+{
+	if (fcntl(fd, F_ADD_SEALS, seals) >= 0) {
+		tst_brk_(filename, lineno, TFAIL,
+			"fcntl(%d, F_ADD_SEALS) succeeded unexpectedly", fd);
+	}
+
+	tst_res_(filename, lineno, TPASS | TERRNO,
+		"fcntl(%d, F_ADD_SEALS, %d) failed as expected", (fd),
+		(seals));
+}
+
+void check_mfd_size(const char *filename, const int lineno, int fd,
+			size_t size)
+{
+	struct stat st;
+
+	safe_fstat(filename, lineno, fd, &st);
+
+	if (st.st_size != (long)size) {
+		tst_brk_(filename, lineno, TFAIL,
+			"fstat(%d, &st): unexpected file size", fd);
+	}
+
+	tst_res_(filename, lineno, TPASS,
+		"fstat(%d, &st): file size is correct", fd);
+}
+
+int check_mfd_open(const char *filename, const int lineno, int fd,
+			int flags, mode_t mode)
+{
+	int r;
+	char buf[512];
+
+	sprintf(buf, "/proc/self/fd/%d", fd);
+
+	r = safe_open(filename, lineno, NULL, buf, flags, mode);
+
+	tst_res_(filename, lineno, TPASS, "open(%s, %d, %d) succeeded", buf,
+		flags, mode);
+
+	return r;
+}
+
+void check_mfd_fail_open(const char *filename, const int lineno, int fd,
+				int flags, mode_t mode)
+{
+	char buf[512];
+
+	sprintf(buf, "/proc/self/fd/%d", fd);
+
+	fd = open(buf, flags, mode);
+	if (fd > 0) {
+		safe_close(filename, lineno, NULL, fd);
+		tst_res_(filename, lineno, TFAIL,
+			"open(%s, %d, %d) succeeded unexpectedly", buf,
+			flags, mode);
+	} else {
+		tst_res_(filename, lineno, TPASS | TERRNO,
+			"open(%s, %d, %d) failed as expected", buf,
+			flags, mode);
+	}
+}
+
+void check_mfd_readable(const char *filename, const int lineno, int fd)
+{
+	char buf[16];
+	void *p;
+
+	safe_read(filename, lineno, NULL, 1, fd, buf, sizeof(buf));
+	tst_res_(filename, lineno, TPASS, "read(%d, %s, %ld) succeeded", fd,
+		buf, sizeof(buf));
+
+	/* verify PROT_READ *is* allowed */
+	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE, PROT_READ,
+			MAP_PRIVATE, fd, 0);
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
+void check_mfd_writeable(const char *filename, const int lineno, int fd)
+{
+	void *p;
+
+	/* verify write() succeeds */
+	safe_write(filename, lineno, NULL, 1, fd, "\0\0\0\0", 4);
+	tst_res_(filename, lineno, TPASS, "write(%d, %p, %d) succeeded", fd,
+		"\0\0\0\0", 4);
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
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			MFD_DEF_SIZE);
+}
+
+void check_mfd_non_writeable(const char *filename, const int lineno,
+				int fd)
+{
+	void *p;
+
+	/* verify write() fails */
+	TEST(write(fd, "data", 4));
+	if (TEST_RETURN < 0) {
+		if (TEST_ERRNO != EPERM) {
+			tst_brk_(filename, lineno, TFAIL | TTERRNO,
+				"write() didn't fail as expected");
+		}
+	} else {
+		tst_brk_(filename, lineno, TFAIL,
+			"write() succeeded unexpectedly");
+	}
+	tst_res_(filename, lineno, TPASS | TTERRNO, "write failed as expected");
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
+		if (mprotect(p, MFD_DEF_SIZE, PROT_READ | PROT_WRITE) >= 0) {
+			tst_brk_(filename, lineno, TFAIL | TERRNO,
+				"mmap()+mprotect() succeeded unexpectedly");
+		}
+	}
+
+	/* verify PUNCH_HOLE fails */
+	check_fallocate_fail(filename, lineno, fd,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			MFD_DEF_SIZE);
+}
+
+void check_mfd_shrinkable(const char *filename, const int lineno, int fd)
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
+void check_mfd_non_shrinkable(const char *filename, const int lineno, int fd)
+{
+	check_ftruncate_fail(filename, lineno, fd,  MFD_DEF_SIZE / 2);
+	check_mfd_fail_open(filename, lineno, fd,
+			O_RDWR | O_CREAT | O_TRUNC, 0600);
+}
+
+void check_mfd_growable(const char *filename, const int lineno, int fd)
+{
+	check_ftruncate(filename, lineno, fd, MFD_DEF_SIZE * 2);
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 2);
+
+	check_fallocate(filename, lineno, fd, 0, 0, MFD_DEF_SIZE * 4);
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 4);
+}
+
+void check_mfd_non_growable(const char *filename, const int lineno, int fd)
+{
+	check_ftruncate_fail(filename, lineno, fd, MFD_DEF_SIZE * 2);
+	check_fallocate_fail(filename, lineno, fd, 0, 0, MFD_DEF_SIZE * 4);
+}
+
+void check_mfd_growable_by_write(const char *filename, const int lineno, int fd)
+{
+	char buf[MFD_DEF_SIZE * 8];
+
+	if (pwrite(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
+		tst_res_(filename, lineno, TFAIL | TERRNO,
+			"pwrite(%d, %s, %ld, %d) failed",
+			fd, buf, sizeof(buf), 0);
+
+		return;
+	}
+
+	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %ld, %d) succeeded",
+		fd, buf, sizeof(buf), 0);
+
+	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 8);
+}
+
+void check_mfd_non_growable_by_write(const char *filename, const int lineno,
+					int fd)
+{
+	char buf[MFD_DEF_SIZE * 8];
+
+	if (pwrite(fd, buf, sizeof(buf), 0) == sizeof(buf)) {
+		tst_res_(filename, lineno, TFAIL,
+			"pwrite(%d, %s, %ld, %d) didn't fail as expected",
+			fd, buf, sizeof(buf), 0);
+
+		return;
+	}
+
+	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %ld, %d) succeeded",
+		fd, buf, sizeof(buf), 0);
+}
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
new file mode 100644
index 0000000..2705375
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
@@ -0,0 +1,152 @@
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
+#include <lapi/fcntl.h>
+#include <lapi/memfd.h>
+
+#define MFD_DEF_SIZE 8192
+
+#define ASSERT_HAVE_MEMFD_CREATE() \
+	assert_have_memfd_create(__FILE__, __LINE__)
+
+#define CHECK_MFD_NEW(name, sz, flags) \
+	check_mfd_new(__FILE__, __LINE__, (name), (sz), (flags))
+
+#define CHECK_MFD_FAIL_NEW(name, flags) \
+	check_mfd_fail_new(__FILE__, __LINE__, (name), (flags))
+
+#define CHECK_MMAP(addr, length, prot, flags, fd, offset) \
+	check_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
+			(flags), (fd), (offset))
+
+#define CHECK_MMAP_FAIL(addr, length, prot, flags, fd, offset) \
+	check_mmap_fail(__FILE__, __LINE__, (addr), (length), (prot), \
+			(flags), (fd), (offset))
+
+#define CHECK_MUNMAP(p, length) \
+	check_munmap(__FILE__, __LINE__, (p), (length))
+
+#define CHECK_MFD_HAS_SEALS(fd, seals) \
+	do { \
+		if (SAFE_FCNTL((fd), F_GET_SEALS) != (seals)) { \
+			tst_brk(TFAIL, "fd %d doesn't have expected seals", \
+				(fd)); \
+		} \
+		tst_res(TPASS, "fd %d has expected seals", (fd)); \
+	} while (0)
+
+#define CHECK_MFD_ADD_SEALS(fd, seals) \
+	({int r = SAFE_FCNTL((fd), F_ADD_SEALS, (seals)); \
+	tst_res(TPASS, "fcntl(%d, F_ADD_SEALS, %d) succeeded", \
+		(fd), (seals)); r; })
+
+#define CHECK_MFD_FAIL_ADD_SEALS(fd, seals) \
+	check_mfd_fail_add_seals(__FILE__, __LINE__, (fd), (seals))
+
+#define CHECK_MFD_SIZE(fd, size) \
+	check_mfd_size(__FILE__, __LINE__, (fd), (size))
+
+#define CHECK_MFD_OPEN(fd, flags, mode) \
+	check_mfd_open(__FILE__, __LINE__, (fd), (flags), (mode))
+
+#define CHECK_MFD_FAIL_OPEN(fd, flags, mode) \
+	check_mfd_fail_open(__FILE__, __LINE__, (fd), (flags), (mode))
+
+#define CHECK_MFD_READABLE(fd) \
+	check_mfd_readable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_WRITEABLE(fd) \
+	check_mfd_writeable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_NON_WRITEABLE(fd) \
+	check_mfd_non_writeable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_SHRINKABLE(fd) \
+	check_mfd_shrinkable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_NON_SHRINKABLE(fd) \
+	check_mfd_non_shrinkable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_GROWABLE(fd) \
+	check_mfd_growable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_NON_GROWABLE(fd) \
+	check_mfd_non_growable(__FILE__, __LINE__, (fd))
+
+#define CHECK_MFD_GROWABLE_BY_WRITE(fd) \
+	check_mfd_growable_by_write(__FILE__, __LINE__, (fd))
+
+#define CHECK_NON_GROWABLE_BY_WRITE(fd) \
+	check_mfd_non_growable_by_write(__FILE__, __LINE__, (fd))
+
+void assert_have_memfd_create(const char *filename, const int lineno);
+int sys_memfd_create(const char *name, unsigned int flags);
+
+int check_fallocate(const char *filename, const int lineno, int fd,
+			int mode, off_t offset, off_t len);
+int check_fallocate_fail(const char *filename, const int lineno, int fd,
+			int mode, off_t offset, off_t len);
+void check_ftruncate(const char *filename, const int lineno, int fd,
+			off_t length);
+void check_ftruncate_fail(const char *filename, const int lineno, int fd,
+			off_t length);
+
+int check_mfd_new(const char *filename, const int lineno,
+			const char *name, loff_t sz, int flags);
+void check_mfd_fail_new(const char *filename, const int lineno,
+			const char *name, int flags);
+
+void *check_mmap(const char *file, const int lineno, void *addr, size_t length,
+		int prot, int flags, int fd, off_t offset);
+void check_mmap_fail(const char *file, const int lineno, void *addr,
+		size_t length, int prot, int flags, int fd, off_t offset);
+
+void check_munmap(const char *file, const int lineno, void *p, size_t length);
+
+void check_mprotect(const char *file, const int lineno, void *addr,
+		size_t length, int prot);
+
+void check_mfd_fail_add_seals(const char *filename, const int lineno, int fd,
+			int seals);
+
+void check_mfd_size(const char *filename, const int lineno, int fd,
+		size_t size);
+
+int check_mfd_open(const char *filename, const int lineno, int fd,
+			int flags, mode_t mode);
+void check_mfd_fail_open(const char *filename, const int lineno, int fd,
+			int flags, mode_t mode);
+
+void check_mfd_readable(const char *filename, const int lineno, int fd);
+
+void check_mfd_writeable(const char *filename, const int lineno, int fd);
+void check_mfd_non_writeable(const char *filename, const int lineno, int fd);
+
+void check_mfd_shrinkable(const char *filename, const int lineno, int fd);
+void check_mfd_non_shrinkable(const char *filename, const int lineno, int fd);
+
+void check_mfd_growable(const char *filename, const int lineno, int fd);
+void check_mfd_non_growable(const char *filename, const int lineno, int fd);
+
+void check_mfd_growable_by_write(const char *filename, const int lineno,
+				int fd);
+void check_mfd_non_growable_by_write(const char *filename, const int lineno,
+				int fd);
+
+#endif
-- 
1.8.3.1

