From: kewal <kewal@zilogic.com>
Date: Wed, 11 Jul 2018 15:59:52 -0000
Subject: [LTP] [PATCH v1] Test madvise with advise value 'MADV_WIPEONFORK'
Message-ID: <1531324792-16559-1-git-send-email-kewal@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* madvise10.c :- Present the child process with zero-filled memory in
  this range after a fork(2).

  Test-Case 1 : madvise with 'MADV_WIPEONFORK'
  Test-Case 2 : madvise with 'MADV_WIPEONFORK' as size 'ZERO'

* madvise11.c:- The MADV_WIPEONFORK operation can be applied only to
  private anonymous pages.

  Test-Case 1 : mmap with 'MAP_SHARED | MAP_ANONYMOUS'
  Test-Case 2 : mmap with 'MAP_PRIVATE'

* madvise12.c:- Within the child created by fork(2), the MADV_WIPEONFORK
  setting remains in place on the specified address range.

  Test-Case 1: 'MADV_WIPEONFORK' on Grand child

* madvise13.c:- MADV_KEEPONFORK Undo the effect of an earlier MADV_WIPEONFORK

  Test-Case 1 : Undo 'MADV_WIPEONFORK' by 'MADV_KEEPONFORK'

Signed-off-by: Subash Ganesan <subash@zilogic.com>
Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
---
 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/madvise/madvise10.c | 179 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise11.c | 132 +++++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise12.c | 171 ++++++++++++++++++++++++
 testcases/kernel/syscalls/madvise/madvise13.c | 162 +++++++++++++++++++++++
 5 files changed, 648 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise10.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a9afecf57..a95c47c3a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -773,6 +773,10 @@ madvise06 madvise06
 madvise07 madvise07
 madvise08 madvise08
 madvise09 madvise09
+madvise10 madvise10
+madvise11 madvise11
+madvise12 madvise12
+madvise13 madvise13
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
new file mode 100644
index 000000000..1cf3097b0
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise10.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
+ *  Email : code@zilogic.com
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
+ * test cases for madvise(2) system call, advise value as "MADV_WIPEONFORK".
+ *
+ * DESCRIPTION :
+ * Present the child process with zero-filled memory in this
+ * range after a fork(2).
+ * The MADV_WIPEONFORK operation can be applied only to
+ * private anonymous pages.
+ *
+ * Test-Case 1 : madvise with "MADV_WIPEONFORK"
+ * flow :	Map memory area as private anonymous page.
+ *		Mark memory area as wipe-on-fork.
+ *		On fork, child process memory should be zeroed.
+ *
+ * Test-Case 2 : madvise with "MADV_WIPEONFORK" as size "ZERO"
+ * flow :	Map memory area as private anonymous page.
+ *		Mark memory area as wipe-on-fork, with length zero.
+ *		On fork, child process memory should be accessible.
+ **/
+
+#include <stdio.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <error.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "lapi/mmap.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define TEST_FILE "test_file.txt"
+#define MAP_SIZE (4 * 1024)
+
+static int test_file_fd;
+
+static const struct test_case {
+	int size;
+	int advise;
+	char *advise_name;
+	int expect;
+} tcases[] = {
+	{.size = MAP_SIZE,
+	 .advise = MADV_WIPEONFORK,
+	 .advise_name = "MADV_WIPEONFORK",
+	 .expect = 0},
+
+	{.size = 0,
+	.advise = MADV_WIPEONFORK,
+	.advise_name = "MADV_WIPEONFORK",
+	.expect = 1}
+};
+
+static void assert_equal(int status, const struct test_case *tc)
+{
+	if (status == tc->expect)
+		tst_res(TPASS, "In child data %d : madvise(%s)",
+				tc->expect, tc->advise_name);
+	else
+		tst_res(TFAIL, "In child data %d : madvise(%s)",
+				tc->expect, tc->advise_name);
+}
+
+static void safe_wait_status(int *status)
+{
+	SAFE_WAIT(status);
+
+	if (!WIFEXITED(*status)) {
+		if (WTERMSIG(*status) == SIGSEGV)
+			tst_res(TFAIL, "Invalid access : SIGSEGV");
+		else
+			tst_res(TFAIL, "Abnormal termination");
+	} else {
+		*status = WEXITSTATUS(*status);
+	}
+}
+
+static void spawn_child(char *map_addr)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+
+	if (!pid)
+		exit(*map_addr);
+}
+
+static int set_advice(char *map_addr, const struct test_case *tc)
+{
+	TEST(madvise(map_addr, tc->size, tc->advise));
+
+	if (TEST_RETURN == -1) {
+		tst_res(TINFO, "failed  :madvise(%p, %d, %s)",
+				map_addr, tc->size, tc->advise_name);
+		return 1;
+	}
+
+	tst_res(TINFO, "success :madvise(%p, %d, %s)",
+			map_addr, tc->size, tc->advise_name);
+
+	return 0;
+}
+
+static void mem_map(char **map_addr)
+{
+	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
+			     PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANON,
+			     test_file_fd, 0);
+
+	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
+		MAP_SIZE, "MAP_PRIVATE | MAP_ANON", test_file_fd);
+}
+
+static void test_madvise(unsigned int test_nr)
+{
+	const struct test_case *tc = &tcases[test_nr];
+	char *map_addr;
+	int status;
+
+	mem_map(&map_addr);
+	memset(map_addr, 1, MAP_SIZE);
+
+	if (set_advice(map_addr, tc)) {
+		tst_res(TFAIL, "madvise failed");
+	} else {
+		spawn_child(map_addr);
+		safe_wait_status(&status);
+		assert_equal(status, tc);
+	}
+
+	SAFE_MUNMAP(map_addr, MAP_SIZE);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(test_file_fd);
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static void setup(void)
+{
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.test = test_madvise,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.14",
+};
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
new file mode 100644
index 000000000..aee277dbd
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
+ *  Email : code@zilogic.com
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
+ * test cases for madvise(2) system call, advise value as "MADV_WIPEONFORK".
+ *
+ * DESCRIPTION :
+ * Present the child process with zero-filled memory in this
+ * range after a fork(2).
+ * The MADV_WIPEONFORK operation can be applied only to
+ * private anonymous pages.
+ *
+ * Test-Case 1 : mmap with "MAP_SHARED | MAP_ANONYMOUS"
+ * flow :	Map memory area as shared anonymous page.
+ *		Mark memory area as wipe-on-fork, should fail.
+ *
+ * Test-Case 2 : mmap with "MAP_PRIVATE"
+ * flow :	Map memory area as private file-backed.
+ *		Mark memory area as wipe-on-fork, should fail.
+ **/
+
+#include <stdio.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <error.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "lapi/mmap.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define TEST_FILE "test_file.txt"
+#define MAP_SIZE (4 * 1024)
+#define ADVISE "MADV_WIPEONFORK"
+
+static int test_file_fd;
+
+static const struct test_case {
+	int flag;
+	char *flag_name;
+} tcases[] = {
+	{.flag = MAP_SHARED | MAP_ANON,
+	.flag_name = "MAP_SHARED | MAP_ANON"},
+
+	{.flag = MAP_PRIVATE,
+	.flag_name = "MAP_PRIVATE"}
+};
+
+static int set_advice(char *map_addr)
+{
+	TEST(madvise(map_addr, MAP_SIZE, MADV_WIPEONFORK));
+
+	if (TEST_RETURN == -1) {
+		tst_res(TINFO, "failed :madvise(%p, MAP_SIZE, %s)",
+				map_addr, ADVISE);
+		return 1;
+	}
+
+	tst_res(TINFO, "success :madvise(%p, MAP_SIZE, %s)",
+			map_addr, ADVISE);
+
+	return 0;
+}
+
+static void mem_map(char **map_addr, const struct test_case *tc)
+{
+	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			tc->flag,
+			test_file_fd, 0);
+
+	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
+			MAP_SIZE, tc->flag_name, test_file_fd);
+}
+
+static void test_madvise(unsigned int test_nr)
+{
+	const struct test_case *tc = &tcases[test_nr];
+	char *map_addr;
+
+	mem_map(&map_addr, tc);
+
+	if (set_advice(map_addr))
+		tst_res(TPASS, "madvise failed");
+	else
+		tst_res(TFAIL, "madvise success");
+
+	SAFE_MUNMAP(map_addr, MAP_SIZE);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(test_file_fd);
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static void setup(void)
+{
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.test = test_madvise,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.14",
+};
+
diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
new file mode 100644
index 000000000..7e6283d13
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise12.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2007
+ *  Email : code@zilogic.com
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
+ * test cases for madvise(2) system call, advise value as "MADV_WIPEONFORK".
+ *
+ * DESCRIPTION :
+ * Present the child process with zero-filled memory in this
+ * range after a fork(2).
+ * The MADV_WIPEONFORK operation can be applied only to
+ * private anonymous pages.
+ * Within the child created by fork(2), the MADV_WIPEONFORK
+ * setting remains in place on the specified map_address range.
+ *
+ * Test-Case 1 : "MADV_WIPEONFORK" on Grand child
+ * flow :	Map memory area as private anonymous.
+ *		Mark memory areas as wipe-on-fork.
+ *		On fork, child process memory should be zeroed.
+ *		In child, fork to create grand-child,
+ *		memory should be zeroed.
+ **/
+
+#include <stdio.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <error.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "lapi/mmap.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define TEST_FILE "test_file.txt"
+#define MAP_SIZE (4 * 1024)
+#define EXP_VAL 0
+
+static int test_file_fd;
+
+static void assert_equal(int status)
+{
+	if (status == EXP_VAL)
+		tst_res(TPASS, "In child data %d : madvise(%s)",
+				EXP_VAL, "MADV_WIPEONFORK");
+	else
+		tst_res(TFAIL, "In child data %d : madvise(%s)",
+				EXP_VAL, "MADV_WIPEONFORK");
+}
+
+static void safe_wait_status(int *status)
+{
+	SAFE_WAIT(status);
+
+	if (!WIFEXITED(*status)) {
+		if (WTERMSIG(*status) == SIGSEGV)
+			tst_res(TFAIL, "Invalid access : SIGSEGV");
+		else
+			tst_res(TFAIL, "Abnormal termination");
+	}
+}
+
+static void spawn_grand_child(char *map_addr)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+
+	if (!pid)
+		exit(*map_addr);
+}
+
+static void spawn_child(char *map_addr)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		spawn_grand_child(map_addr);
+		safe_wait_status(&status);
+		exit(status);
+	}
+}
+
+static int set_advice(char *map_addr)
+{
+	TEST(madvise(map_addr, MAP_SIZE, MADV_WIPEONFORK));
+
+	if (TEST_RETURN == -1) {
+		tst_res(TINFO, "failed  :madvise(%p, %d, %s)",
+				map_addr, MAP_SIZE, "MADV_WIPEONFORK");
+		return 1;
+	}
+
+	tst_res(TINFO, "success :madvise(%p, %d, %s)",
+			map_addr, MAP_SIZE, "MADV_WIPEONFORK");
+
+	return 0;
+}
+
+static void mem_map(char **map_addr)
+{
+	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
+			     PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANON,
+			     test_file_fd, 0);
+
+	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
+		MAP_SIZE, "MAP_PRIVATE | MAP_ANON", test_file_fd);
+}
+
+static void test_madvise(void)
+{
+	int status;
+	char *map_addr;
+
+	mem_map(&map_addr);
+	memset(map_addr, 1, MAP_SIZE);
+
+	if (set_advice(map_addr)) {
+		tst_res(TFAIL, "madvise failed");
+	} else {
+		spawn_child(map_addr);
+		safe_wait_status(&status);
+		assert_equal(status);
+	}
+
+	SAFE_MUNMAP(map_addr, MAP_SIZE);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(test_file_fd);
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static void setup(void)
+{
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.test_all = test_madvise,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.14",
+};
diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
new file mode 100644
index 000000000..cc4433380
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise13.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
+ * Email : code@zilogic.com
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
+ * test cases for madvise(2) system call, advise value as "MADV_WIPEONFORK".
+ *
+ * DESCRIPTION :
+ * Present the child process with zero-filled memory in this
+ * range after a fork(2).
+ * The MADV_KEEPONFORK operation undo the effect of MADV_WIPEONFORK.
+ *
+ * Test-Case 1 : Undo "MADV_WIPEONFORK" by "MADV_KEEPONFORK"
+ * flow :	Map memory area as private anonymous page.
+ *		Mark memory area as wipe-on-fork.
+ *		Mark memory area as keep-on-fork.
+ *		On fork, child process memory should be retained.
+ **/
+
+#include <stdio.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <error.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "lapi/mmap.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define EXP_VAL 1
+#define TEST_FILE "test_file.txt"
+#define MAP_SIZE (4 * 1024)
+
+static char *map_addr;
+static int test_file_fd;
+
+static void assert_equal(int status)
+{
+	if (status == EXP_VAL)
+		tst_res(TPASS, "In child data %d : madvise(%s)",
+				EXP_VAL, "MADV_KEEPONFORK");
+	else
+		tst_res(TFAIL, "In child data %d : madvise(%s)",
+				EXP_VAL, "MADV_KEEPONFORK");
+}
+
+static void safe_wait_status(int *status)
+{
+	SAFE_WAIT(status);
+
+	if (!WIFEXITED(*status)) {
+		if (WTERMSIG(*status) == SIGSEGV)
+			tst_res(TFAIL, "Invalid access : SIGSEGV");
+		else
+			tst_res(TFAIL, "Abnormal termination");
+	} else {
+		*status = WEXITSTATUS(*status);
+	}
+}
+
+static void spawn_child(char *map_addr)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+
+	if (!pid)
+		exit(*map_addr);
+}
+
+static int set_advice(int size, int advise, char *adv_name)
+{
+	TEST(madvise(map_addr, size, advise));
+
+	if (TEST_RETURN == -1) {
+		tst_res(TINFO, "failed  :madvise(%p, %d, %s)",
+			map_addr, size, adv_name);
+		return 1;
+	}
+
+	tst_res(TINFO, "success :madvise(%p, %d, %s)",
+			map_addr, size, adv_name);
+
+	return 0;
+}
+
+static void test_madvise(void)
+{
+	int status;
+
+	if (set_advice(MAP_SIZE, MADV_WIPEONFORK,
+				"MADV_WIPEONFORK")) {
+		tst_res(TFAIL, "madvise failed");
+		return;
+	}
+
+	if (set_advice(MAP_SIZE, MADV_KEEPONFORK,
+				"MADV_KEEPONFORK")) {
+		tst_res(TFAIL, "madvise failed");
+		return;
+	}
+
+	spawn_child(map_addr);
+	safe_wait_status(&status);
+	assert_equal(status);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(map_addr, MAP_SIZE);
+	SAFE_CLOSE(test_file_fd);
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static void mem_map(char **map_addr)
+{
+	*map_addr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANON,
+			test_file_fd, 0);
+
+	tst_res(TINFO, "mmap(NULL, %d, PROT_READ | PROT_WRITE, %s, %d, 0)",
+		MAP_SIZE, "MAP_PRIVATE | MAP_ANON", test_file_fd);
+}
+
+static void setup(void)
+{
+	mem_map(&map_addr);
+	memset(map_addr, 1, MAP_SIZE);
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.test_all = test_madvise,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.14",
+};
-- 
2.11.0
