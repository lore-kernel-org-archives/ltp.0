From: Steve Muckle <smuckle@google.com>
Date: Thu, 27 Dec 2018 14:41:36 -0800
Subject: [LTP] [PATCH] syscalls/remap_file_pages: convert remap_file_pages02
	to new lib
Message-ID: <20181227224136.150457-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert remap_file_pages02 to new test library. Use direct syscall
instead of libc wrapper for remap_file_pages to expand compatibility.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 .../remap_file_pages/remap_file_pages02.c     | 317 ++++++------------
 1 file changed, 101 insertions(+), 216 deletions(-)

diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index 62b0966f2..437ff5522 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -1,27 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Ricardo Salveti de Araujo, 2007
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/*
  * NAME
  *     remap_file_pages02
  *
@@ -77,206 +57,128 @@
 #include <sys/syscall.h>
 #include <linux/unistd.h>
 
-#include "test.h"		/*LTP Specific Include File */
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-/* Test case defines */
 #define WINDOW_START 0x48000000
 
 static int page_sz;
-size_t page_words;
-size_t cache_pages;
-size_t cache_sz;
-size_t window_pages;
-size_t window_sz;
+static size_t cache_sz;
+
+static char *cache_contents;
+static int fd;
+static char *data = NULL;
+static char *data01 = NULL;
 
-static void setup();
 static int setup01(int test);
 static int setup02(int test);
 static int setup03(int test);
 static int setup04(int test);
-static void cleanup();
-
-char *TCID = "remap_file_pages02";
-int TST_TOTAL = 4;
-
-static char *cache_contents;
-int fd;				/* File descriptor used at the test */
-char *data = NULL;
-char *data01 = NULL;
 
 static struct test_case_t {
-	char *err_desc;		/* Error description */
-	int exp_errno;		/* Expected error number */
-	char *exp_errval;	/* Expected error value string */
-	int (*setupfunc) (int);	/* Test setup function */
-	int (*cleanfunc) (int);	/* Test clean function */
-	void *start;		/* Start argument */
-	size_t size;		/* Size argument */
-	int prot;		/* Prot argument */
-	ssize_t pgoff;		/* Pgoff argument */
-	int flags;		/* Flags argument */
-} testcase[] = {
-	{
-	"start does not refer to a valid mapping created with the "
-		    "MAP_SHARED flag", EINVAL, "EINVAL", setup01, NULL,
-		    NULL, 0, 0, 2, 0}, {
-	"start is invalid", EINVAL, "EINVAL", setup02, NULL, NULL, 0, 0, 2, 0},
-	{
-	"size is invalid", EINVAL, "EINVAL", setup03, NULL, NULL, 0, 0, 0, 0},
-	{
-	"prot is invalid", EINVAL, "EINVAL", setup04, NULL, NULL, 0, 0,
-		    2, 0}
+	char *err_desc;
+	int exp_errno;
+	char *exp_errval;
+	int (*setupfunc) (int);
+	int (*cleanfunc) (int);
+
+	/* test arguments to remap_file_pages */
+	void *start;
+	size_t size;
+	int prot;
+	ssize_t pgoff;
+	int flags;
+} testcases[] = {
+	{"start does not refer to a valid mapping created with the MAP_SHARED flag",
+	 EINVAL, "EINVAL", setup01, NULL, NULL, 0, 0, 2, 0},
+	{"start is invalid", EINVAL, "EINVAL", setup02, NULL, NULL, 0, 0, 2, 0},
+	{"size is invalid", EINVAL, "EINVAL", setup03, NULL, NULL, 0, 0, 0, 0},
+	{"prot is invalid", EINVAL, "EINVAL", setup04, NULL, NULL, 0, 0, 2, 0}
 };
 
-int main(int ac, char **av)
+static void run(unsigned i)
 {
-	int lc, i;
-
-#if defined (__s390__) || (__s390x__) || (__ia64__)
-	/* Disables the test in case the kernel version is lower than 2.6.12 and arch is s390 */
-	if ((tst_kvercmp(2, 6, 12)) < 0) {
-		tst_resm(TWARN,
-			 "This test can only run on kernels that are 2.6.12 and higher");
-		exit(0);
-	}
-#endif
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/* do the setup if the test have one */
-			if (testcase[i].setupfunc
-			    && testcase[i].setupfunc(i) == -1) {
-				tst_resm(TWARN,
-					 "Failed to setup test %d"
-					 " Skipping test", i);
-				continue;
-			}
-
-			/* run the test */
-			TEST(remap_file_pages
-			     (testcase[i].start, testcase[i].size,
-			      testcase[i].prot, testcase[i].pgoff,
-			      testcase[i].flags));
-
-			/* do the cleanup if the test have one */
-			if (testcase[i].cleanfunc
-			    && testcase[i].cleanfunc(i) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "Failed to cleanup test %d,"
-					 " quitting the test", i);
-			}
-
-			/* verify the return code */
-			if ((TEST_RETURN == -1)
-			    && (TEST_ERRNO == testcase[i].exp_errno)) {
-				tst_resm(TPASS,
-					 "remap_file_pages(2) expected failure;"
-					 " Got errno - %s : %s",
-					 testcase[i].exp_errval,
-					 testcase[i].err_desc);
-			} else {
-				tst_resm(TFAIL,
-					 "remap_file_pages(2) failed to produce"
-					 " expected error: %d, errno: %s."
-					 " because got error %d",
-					 testcase[i].exp_errno,
-					 testcase[i].exp_errval, TEST_ERRNO);
-			}
-		}		/* end of test loops */
-	}			/* end of  test looping */
-
-	/* clean up and exit */
-	cleanup();
-
-	tst_exit();
+	if (testcases[i].setupfunc
+	    && testcases[i].setupfunc(i) == -1)
+		tst_brk(TBROK, "Failed to setup test %d", i);
+
+	TEST(tst_syscall(__NR_remap_file_pages,
+			 testcases[i].start, testcases[i].size,
+			 testcases[i].prot, testcases[i].pgoff,
+			 testcases[i].flags));
+
+	if (testcases[i].cleanfunc
+	    && testcases[i].cleanfunc(i) == -1)
+		tst_brk(TBROK, "Failed to cleanup test %d,"
+			" quitting the test", i);
+
+	if ((TST_RET == -1)
+	    && (TST_ERR == testcases[i].exp_errno))
+		tst_res(TPASS,
+			"remap_file_pages(2) expected failure;"
+			" Got errno - %s : %s",
+			testcases[i].exp_errval,
+			testcases[i].err_desc);
+	else
+		tst_res(TFAIL,
+			"remap_file_pages(2) failed to produce"
+			" expected error: %d, errno: %s."
+			" because got error %d",
+			testcases[i].exp_errno,
+			testcases[i].exp_errval, TST_ERR);
 }
 
-/*
- * setup01() - create a mmap area without MAP_SHARED flag
- * - it uses the fd created@the main setup function
- */
-int setup01(int test)
+/* setup01() - create a mmap area without MAP_SHARED flag */
+static int setup01(int test)
 {
-	data01 = mmap(NULL, cache_sz, PROT_READ | PROT_WRITE,
-		      MAP_PRIVATE, fd, 0);
-
-	if (data01 == MAP_FAILED) {
-		tst_resm(TWARN, "mmap Error, errno=%d : %s", errno,
-			 strerror(errno));
-		return -1;
-	}
-
-	/* set up the test case struct for this test */
-	testcase[test].start = data01;
-	testcase[test].size = page_sz;
-
+	/* Use fd from setup() */
+	data01 = SAFE_MMAP(NULL, cache_sz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
+			   fd, 0);
+	testcases[test].start = data01;
+	testcases[test].size = page_sz;
 	return 0;
 }
 
-/*
- * setup02() - start is invalid
- */
-int setup02(int test)
+/* setup02() - start is invalid */
+static int setup02(int test)
 {
-	/* set up the test case struct for this test */
-	testcase[test].start = data + cache_sz;
-	testcase[test].size = page_sz;
-
+	testcases[test].start = data + cache_sz;
+	testcases[test].size = page_sz;
 	return 0;
 }
 
-/*
- * setup03() - size is invalid
- */
-int setup03(int test)
+/* setup03() - size is invalid */
+static int setup03(int test)
 {
-	/* set up the test case struct for this test */
-	testcase[test].start = data;
-	testcase[test].size = cache_sz + page_sz;
-
+	testcases[test].start = data;
+	testcases[test].size = cache_sz + page_sz;
 	return 0;
 }
 
-/*
- * setup04() - prot is invalid
- */
-int setup04(int test)
+/* setup04() - prot is invalid */
+static int setup04(int test)
 {
-	/* set up the test case struct for this test */
-	testcase[test].start = data;
-	testcase[test].size = page_sz;
-	testcase[test].prot = -1;
-
+	testcases[test].start = data;
+	testcases[test].size = page_sz;
+	testcases[test].prot = -1;
 	return 0;
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- * - creates a defaul mmaped area to be able to run remap_file_pages
- */
-void setup(void)
+static void setup(void)
 {
-	int i, j;
+	unsigned int i, j;
+	size_t page_words;
+	size_t cache_pages;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get page size */
-	if ((page_sz = getpagesize()) < 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "getpagesize() fails to get system page size");
-	}
+#if defined (__s390__) || (__s390x__) || (__ia64__)
+	if ((tst_kvercmp(2, 6, 12)) < 0)
+		tst_brk(TCONF,
+			 "This test can only run on kernels that are 2.6.12 and higher");
+#endif
 
+	if ((page_sz = getpagesize()) < 0)
+		tst_brk(TFAIL,
+			"getpagesize() fails to get system page size");
 	page_words = (page_sz / sizeof(char));
 
 	/* Set the cache size */
@@ -291,35 +193,13 @@ void setup(void)
 			page[j] = i;
 	}
 
-	if ((fd = open("cache", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT|O_TRUNC,S_IRWXU) Failed, errno=%d : %s",
-			 "cache", errno, strerror(errno));
-	}
-
-	if (write(fd, cache_contents, cache_sz) != cache_sz) {
-		tst_resm(TFAIL,
-			 "Write Error for \"cache_contents\" to \"cache_sz\" of %zu (errno=%d : %s)",
-			 cache_sz, errno, strerror(errno));
-		cleanup();
-	}
-
-	data = mmap((void *)WINDOW_START,
-		    cache_sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-
-	if (data == MAP_FAILED) {
-		tst_resm(TFAIL, "mmap Error, errno=%d : %s", errno,
-			 strerror(errno));
-		cleanup();
-	}
-
+	fd = SAFE_OPEN("cache", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
+	SAFE_WRITE(1, fd, cache_contents, cache_sz);
+	data = SAFE_MMAP((void *)WINDOW_START, cache_sz, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, 0);
 }
 
-/*
-* cleanup() - Performs one time cleanup for this test at
-* completion or premature exit
-*/
-void cleanup(void)
+static void cleanup(void)
 {
 	/* Close the file descriptor */
 	close(fd);
@@ -328,7 +208,12 @@ void cleanup(void)
 		munmap(data, cache_sz);
 	if (data01)
 		munmap(data01, cache_sz);
-
-	tst_rmdir();
-
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(testcases),
+	.test = run,
+	.cleanup = cleanup,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.20.1.415.g653613c723-goog

