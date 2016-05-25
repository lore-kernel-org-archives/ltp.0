From: Li Wang <liwang@redhat.com>
Date: Wed, 25 May 2016 14:29:39 +0800
Subject: [LTP] [PATCH V3 3/3] syscalls/madvise02: reconstruct and convert to
	new API
In-Reply-To: <1464157779-6883-2-git-send-email-liwang@redhat.com>
References: <1464157779-6883-1-git-send-email-liwang@redhat.com>
 <1464157779-6883-2-git-send-email-liwang@redhat.com>
Message-ID: <1464157779-6883-3-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* take use of some SAFE Marcos
* move the intialization operations to setup()
* create new struct array madvise_opt[]
* add enable as a global variable

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 365 +++++++++-----------------
 1 file changed, 127 insertions(+), 238 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index b9eb77d..2c7ecce 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -1,20 +1,16 @@
 /*
  *  Copyright (c) International Business Machines  Corp., 2004
- *  Copyright (c) Linux Test Project, 2013-2014
+ *  Copyright (c) Linux Test Project, 2013-2016
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU Library General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software Foundation,
- *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -48,263 +44,156 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
+
+#include "tst_kvercmp.h"
+#include "tst_test.h"
+#include "lapi/mmap.h"
 
 #define TEST_FILE "testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
-
 #define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
 
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(int expected_errno);
-
-static void test_addr_einval(void);
-static void test_advice_einval(void);
-#if !defined(UCLINUX)
-static void test_lock_einval(void);
-#endif /* if !defined(UCLINUX) */
-#if defined(MADV_MERGEABLE)
-static void test_mergeable_einval(void);
-#endif
-#if defined(MADV_UNMERGEABLE)
-static void test_unmergeable_einval(void);
-#endif
-static void test_enomem(void);
-static void test_ebadf(void);
-
-static void (*test_func[])(void) = {
-	test_addr_einval,
-	test_advice_einval,
-#if !defined(UCLINUX)
-	test_lock_einval,
-#endif /* if !defined(UCLINUX) */
-#if defined(MADV_MERGEABLE)
-	test_mergeable_einval,
-#endif
-#if defined(MADV_UNMERGEABLE)
-	test_unmergeable_einval,
-#endif
-	test_enomem,
-	test_ebadf,
-};
-
-char *TCID = "madvise02";
-int TST_TOTAL = ARRAY_SIZE(test_func);
-
-static int fd;
 static struct stat st;
 static int pagesize;
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*test_func[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
+static int enable;
+static char *file;
+static char *tmp_file;
+static char *ptr_addr;
+static char *tmp_addr;
+
+static struct tcase {
+	int advice;
+	char *name;
+	char **addr;
+	int exp_errno;
+} tcases[] = {
+	{MADV_NORMAL,      "MADV_NORMAL",      &file, EINVAL},
+	{1212,             "MADV_NORMAL",      &file, EINVAL},
+	{MADV_DONTNEED,    "MADV_DONTNEED",    &file, EINVAL},
+	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file, EINVAL},
+	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file, EINVAL},
+	{MADV_WILLNEED,    "MADV_WILLNEED,",   &file,  EBADF},
+	{MADV_NORMAL,      "MADV_NORMAL",      &file, ENOMEM}
+};
 
 static void setup(void)
 {
-	int i;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	int i, fd;
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0664);
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 
 	pagesize = getpagesize();
 
 	/* Writing 16 pages of random data into this file */
 	for (i = 0; i < (pagesize / 2); i++)
-		SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+		SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
 
-	SAFE_FSTAT(cleanup, fd, &st);
-}
+	SAFE_FSTAT(fd, &st);
 
-static void cleanup(void)
-{
-	if (fd && close(fd) < 0)
-		tst_resm(TWARN | TERRNO, "close failed");
+	file = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 
-	tst_rmdir();
-}
+	tmp_file = file;
 
-static void check_and_print(int expected_errno)
-{
-	if (TEST_RETURN == -1) {
-		if (TEST_ERRNO == expected_errno)
-			tst_resm(TPASS | TTERRNO, "failed as expected");
-		else
-			tst_resm(TFAIL | TTERRNO,
-				 "failed unexpectedly; expected - %d : %s",
-				 expected_errno, strerror(expected_errno));
-	} else {
-		tst_resm(TFAIL, "madvise succeeded unexpectedly");
-	}
+	SAFE_CLOSE(fd);
 }
 
-static void test_addr_einval(void)
+static void tcases_filter(unsigned int i)
 {
-	char *file;
-
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
-
-	TEST(madvise(file + 100, st.st_size, MADV_NORMAL));
-	check_and_print(EINVAL);
-
-	SAFE_MUNMAP(cleanup, file, st.st_size);
-}
-
-static void test_advice_einval(void)
-{
-	char *file;
-
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
-
-	TEST(madvise(file, st.st_size, 1212));
-	check_and_print(EINVAL);
-
-	SAFE_MUNMAP(cleanup, file, st.st_size);
-}
-
-#if !defined(UCLINUX)
-static void test_lock_einval(void)
-{
-	char *file;
-
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
-
-	if (mlock(file, st.st_size) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mlock failed");
-
-	TEST(madvise(file, st.st_size, MADV_DONTNEED));
-	check_and_print(EINVAL);
-
-	SAFE_MUNMAP(cleanup, file, st.st_size);
-}
-#endif /* if !defined(UCLINUX) */
-
-#if defined(MADV_MERGEABLE)
-static void test_mergeable_einval(void)
-{
-	char *file;
-
-	if (access(KSM_SYS_DIR, F_OK) >= 0) {
-		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
-				 "skip EINVAL test for MADV_MERGEABLE.");
-		return;
+	enable = 1;
+	file = tmp_file;
+
+	switch (i) {
+	case 0:
+		/* Test for addr EINVAL */
+		file = tmp_file + 100;
+		break;
+
+	case 1:
+		/* Test for advice EINVAL */
+		break;
+
+	case 2:
+		enable = 0;
+		/* Test for lock EINVAL */
+		#if !defined(UCLINUX)
+		if (mlock(file, st.st_size) < 0)
+			tst_brk(TBROK | TERRNO, "mlock failed");
+		enable = 1;
+		#endif /* if !defined(UCLINUX) */
+		break;
+
+	case 3:
+	case 4:
+		/* Test for MADV_MERGEABLE EINVAL */
+		if ((tst_kvercmp(2, 6, 32)) < 0)
+			enable = 0;
+
+		if (access(KSM_SYS_DIR, F_OK) == 0)
+			/* kernel configured with CONFIG_KSM,
+			 * skip EINVAL test for MADV_MERGEABLE. */
+			enable = 0;
+		break;
+
+	case 5:
+		/* Test for MADV_WILLNEED EBADF */
+		ptr_addr = SAFE_MALLOC(st.st_size);
+		/* Take temporary pointer for later use, freeing up the
+		 * original one. */
+		tmp_addr = ptr_addr;
+		tmp_addr =
+			(char *)(((unsigned long)tmp_addr + pagesize - 1) & ~(pagesize - 1));
+		file = tmp_addr;
+
+		/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
+		 * anon mem doesn't return -EBADF now, as now we support
+		 * swap prefretch. */
+		if ((tst_kvercmp(3, 9, 0)) > 0)
+			enable = 0;
+		break;
+
+	case 6:
+		/* Test for MADV_NORMAL ENOMEM */
+		SAFE_MUNMAP(file + st.st_size - pagesize, pagesize);
+		break;
 	}
-
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
-
-	TEST(madvise(file, st.st_size, MADV_MERGEABLE));
-	check_and_print(EINVAL);
-
-	SAFE_MUNMAP(cleanup, file, st.st_size);
 }
-#endif
 
-#if defined(MADV_UNMERGEABLE)
-static void test_unmergeable_einval(void)
+static void advice_test(unsigned int i)
 {
-	char *file;
-
-	if (access(KSM_SYS_DIR, F_OK) >= 0) {
-		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
-				 "skip EINVAL test for MADV_UNMERGEABLE.");
-		return;
+	struct tcase *tc = &tcases[i];
+
+	tcases_filter(i);
+
+	if (enable == 1) {
+		TEST(madvise(*(tc->addr), st.st_size, tc->advice));
+		if (TEST_RETURN == -1)
+			if (TEST_ERRNO == tc->exp_errno)
+				tst_res(TPASS | TTERRNO, "failed as expected");
+			else
+				tst_res(TFAIL | TTERRNO,
+						"failed unexpectedly; expected - %d : %s",
+						tc->exp_errno, tst_strerrno(TFAIL | TTERRNO));
+		else
+			tst_res(TFAIL, "madvise succeeded unexpectedly");
+	} else {
+		tst_res(TCONF, "%s is not supported", tc->name);
 	}
-
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
-
-	TEST(madvise(file, st.st_size, MADV_UNMERGEABLE));
-	check_and_print(EINVAL);
-
-	SAFE_MUNMAP(cleanup, file, st.st_size);
 }
-#endif
 
-static void test_enomem(void)
+static void cleanup(void)
 {
-	char *low;
-	char *high;
-	unsigned long len;
-
-	low = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
-					MAP_SHARED, fd, 0);
-
-	high = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
-					 MAP_SHARED, fd, st.st_size / 2);
-
-	/* Swap if necessary to make low < high */
-	if (low > high) {
-		char *tmp;
-		tmp = high;
-		high = low;
-		low = tmp;
-	}
-
-	len = (high - low) + pagesize;
-
-	SAFE_MUNMAP(cleanup, high, st.st_size / 2);
-
-	TEST(madvise(low, len, MADV_NORMAL));
-	check_and_print(ENOMEM);
-
-	SAFE_MUNMAP(cleanup, low, st.st_size / 2);
+	free(ptr_addr);
+	munmap(file, st.st_size - pagesize);
 }
 
-static void test_ebadf(void)
-{
-	char *ptr_memory_allocated = NULL;
-	char *tmp_memory_allocated = NULL;
-
-	/* Create one memory segment using malloc */
-	ptr_memory_allocated = malloc(5 * pagesize);
-	/*
-	 * Take temporary pointer for later use, freeing up the
-	 * original one.
-	 */
-	tmp_memory_allocated = ptr_memory_allocated;
-	tmp_memory_allocated =
-		(char *)(((unsigned long)tmp_memory_allocated +
-			pagesize - 1) & ~(pagesize - 1));
-
-	TEST(madvise(tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
-	if (tst_kvercmp(3, 9, 0) < 0) {
-		check_and_print(EBADF);
-	/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
-	 * mem doesn't return -EBADF now, as now we support swap
-	 * prefretch.
-	 */
-	} else {
-		tst_resm(TPASS, "madvise succeeded as expected, see "
-				"kernel commit 1998cc0 for details.");
-	}
-
-	free(ptr_memory_allocated);
-}
+static struct tst_test test = {
+	.tid = "madvise02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = advice_test,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
1.8.3.1

