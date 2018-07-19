From: kewal <kewal@zilogic.com>
Date: Thu, 19 Jul 2018 14:27:22 -0000
Subject: [LTP] [PATCH v2] Test : madvise('MADV_WIPEONFORK')
Message-ID: <1532010442-4742-1-git-send-email-kewal@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


 madvise10.c :- Present the child process with zero-filled memory in
  this range after a fork(2).
  Test-Case 1 : madvise with 'MADV_WIPEONFORK'
  Test-Case 2 : madvise with 'MADV_WIPEONFORK' as size 'ZERO'

 madvise11.c:- The MADV_WIPEONFORK operation can be applied only to
  private anonymous pages.
  Test-Case 1 : mmap with 'MAP_SHARED | MAP_ANONYMOUS'
  Test-Case 2 : mmap with 'MAP_PRIVATE'

 madvise12.c:- Within the child created by fork(2), the MADV_WIPEONFORK
  setting remains in place on the specified address range.
  Test-Case 1: 'MADV_WIPEONFORK' on Grand child

 madvise13.c:- MADV_KEEPONFORK Undo the effect of an earlier MADV_WIPEONFORK
  Test-Case 1 : Undo 'MADV_WIPEONFORK' by 'MADV_KEEPONFORK'

* Update from v1 to v2:-

 Added EINVAL error check in madvise02.
 Tests having common code are combined together and put into one
  single file madvise10.c.
 Files were added to .gitignore which was left out in the previous
  patch file.
 Using -1 as file descriptor for MAP_PRIVATE | MAP_ANONYMOUS page.
 Whole mapped-memory area is compared instead of first byte.
 Printing test_errno with TFAIL.

Signed-off-by: Subash Ganesan <subash@zilogic.com>
Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise02.c |  12 ++
 testcases/kernel/syscalls/madvise/madvise10.c | 184 ++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a9afecf57..9b30635c2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -773,6 +773,7 @@ madvise06 madvise06
 madvise07 madvise07
 madvise08 madvise08
 madvise09 madvise09
+madvise10 madvise10
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 58bafb1b0..002d8e5d9 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -5,3 +5,4 @@
 /madvise07
 /madvise08
 /madvise09
+/madvise10
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 710e46e54..4c357c514 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -25,6 +25,8 @@
  *     locked or shared pages (with MADV_DONTNEED)
  *  4. MADV_MERGEABLE or MADV_UNMERGEABLE was specified in advice,
  *     but the kernel was not configured with CONFIG_KSM.
+ *  8|9. The MADV_FREE & MADV_WIPEONFORK operation can be applied
+ *  	only to private anonymous pages.
  *
  * (B) Test Case for ENOMEM
  *  5|6. addresses in the specified range are not currently mapped
@@ -51,6 +53,7 @@
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
+#define MAP_SIZE (4 * 1024)
 #define TEST_FILE "testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 #define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
@@ -59,6 +62,8 @@ static struct stat st;
 static long pagesize;
 static char *file1;
 static char *file2;
+static char *file3;
+static char *shared_anon;
 static char *ptr_addr;
 static char *tmp_addr;
 static char *nonalign;
@@ -81,6 +86,8 @@ static struct tcase {
 	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
 	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
 	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL, 0},
 };
 
 static void tcases_filter(void)
@@ -151,6 +158,9 @@ static void setup(void)
 	file1 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	file2 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	SAFE_MUNMAP(file2 + st.st_size - pagesize, pagesize);
+	file3 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	shared_anon = SAFE_MMAP(0, MAP_SIZE, PROT_READ, MAP_SHARED |
+			MAP_ANONYMOUS, -1, 0);
 
 	nonalign = file1 + 100;
 
@@ -192,6 +202,8 @@ static void cleanup(void)
 	free(ptr_addr);
 	SAFE_MUNMAP(file1, st.st_size);
 	SAFE_MUNMAP(file2, st.st_size - pagesize);
+	SAFE_MUNMAP(file3, st.st_size);
+	SAFE_MUNMAP(shared_anon, MAP_SIZE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
new file mode 100644
index 000000000..2c3e5902e
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise10.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
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
+ * DESCRIPTION
+ * Present the child process with zero-filled memory in this
+ * range after a fork(2).
+ * The MADV_WIPEONFORK operation can be applied only to
+ * private anonymous pages.
+ * Within the child created by fork(2), the MADV_WIPEONFORK
+ * setting remains in place on the specified map_address range.
+ * The MADV_KEEPONFORK operation undo the effect of MADV_WIPEONFORK.
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
+ *
+ * Test-Case 3 : "MADV_WIPEONFORK" on Grand child
+ * flow :	Map memory area as private anonymous.
+ *		Mark memory areas as wipe-on-fork.
+ *		On fork, child process memory should be zeroed.
+ *		In child, fork to create grand-child,
+ *		memory should be zeroed.
+ *
+ * Test-Case 4 : Undo "MADV_WIPEONFORK" by "MADV_KEEPONFORK"
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
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <error.h>
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
+#define MAP_SIZE (4 * 1024)
+
+static char pattern[MAP_SIZE];
+static char zero[MAP_SIZE];
+
+static const struct test_case {
+	int size;
+	int advise1;
+	int advise2;
+	char *exp;
+	int grand_child;
+} tcases[] = {
+	{MAP_SIZE, MADV_NORMAL,	MADV_WIPEONFORK, zero,    0},
+	{0,	   MADV_NORMAL, MADV_WIPEONFORK, pattern, 0},
+	{MAP_SIZE, MADV_NORMAL, MADV_WIPEONFORK, zero,    1},
+	{MAP_SIZE, MADV_WIPEONFORK, MADV_KEEPONFORK, pattern, 0},
+};
+
+static void cmp_area(char *addr, const struct test_case *tc)
+{
+	int i;
+
+	for (i = 0; i < tc->size; i++) {
+		if (addr[i] != tc->exp[i]) {
+			tst_res(TFAIL, "In PID : %d Failed match", getpid());
+			break;
+		}
+	}
+
+	tst_res(TPASS, "In PID : %d Matched expected pattern", getpid());
+}
+
+static int set_advice(char *addr, int size, int advise)
+{
+	TEST(madvise(addr, size, advise));
+
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "failed :madvise(%p, %d, 0x%x)",
+				addr, size, advise);
+
+		return 1;
+	}
+
+	tst_res(TINFO, "success :madvise(%p, %d, 0x%x)",
+			addr, size, advise);
+	return 0;
+}
+
+static char *mem_map(void)
+{
+	char *ptr;
+
+	ptr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS,
+			-1, 0);
+
+	memcpy(ptr, pattern, MAP_SIZE);
+
+	return ptr;
+}
+
+static void test_madvise(unsigned int test_nr)
+{
+	const struct test_case *tc = &tcases[test_nr];
+	char *addr;
+	pid_t pid;
+
+	addr = mem_map();
+
+	if (set_advice(addr, tc->size, tc->advise1))
+		goto un_map;
+
+	if (!set_advice(addr, tc->size, tc->advise2)) {
+		tst_res(TINFO, "In %s process",
+				tc->grand_child ? "grand_child" : "child");
+
+		pid = SAFE_FORK();
+
+		if (!pid) {
+			if (tc->grand_child) {
+				pid = SAFE_FORK();
+
+				if (!pid) {
+					cmp_area(addr, tc);
+					exit(0);
+				}
+			} else {
+				cmp_area(addr, tc);
+				exit(0);
+			}
+		}
+		tst_reap_children();
+	}
+
+un_map:
+	SAFE_MUNMAP(addr, MAP_SIZE);
+}
+
+static void setup(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < MAP_SIZE; i++)
+		pattern[i] = i % 0x02;
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = test_madvise,
+	.setup = setup,
+	.min_kver = "4.14",
+};
+
-- 
2.11.0
