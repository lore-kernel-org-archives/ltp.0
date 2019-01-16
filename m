From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jan 2019 16:58:10 +0100
Subject: [LTP] [PATCH] syscalls/remap_file_pages: convert
 remap_file_pages02 to new lib
In-Reply-To: <20181227224136.150457-1-smuckle@google.com>
References: <20181227224136.150457-1-smuckle@google.com>
Message-ID: <20190116155810.GF24833@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've further cleaned up the test and pushed, thanks.

Some parts of it didn't really make any sense, for example getpagesize()
nevere fails, sizeof(char) == 1 by definition, the testcase structure
defined cleanup that was not used at all, etc. See full patch below.

diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index 437ff5522..1d8f620ca 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Ricardo Salveti de Araujo, 2007
- *
- * NAME
- *     remap_file_pages02
+ * Copyright (C) Ricardo Salveti de Araujo <rsalvetidev@gmail.com>, 2007
  *
  * DESCRIPTION
  *     The remap_file_pages() system call is used to create a non-linear
@@ -25,25 +22,11 @@
  *       3. Test with a invalid size argument
  *       4. Test with a invalid prot argument
  *
- *     Cleanup:
- *       Remove the file and erase the tmp directory
- *
- * Usage:  <for command-line>
- *  remap_file_pages02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
  * HISTORY
  *
  *     02/11/2008 - Removed the pgoff test case, as the latest kernels doesn't
  *     verify the page offset (http://lkml.org/lkml/2007/11/29/325) - Ricardo
  *     Salveti de Araujo, <rsalvetidev@gmail.com>
- *
- *     19/10/2007 - Created by Ricardo Salveti de Araujo, <rsalvetidev@gmail.com>
  */
 
 #define _GNU_SOURCE
@@ -62,113 +45,81 @@
 
 #define WINDOW_START 0x48000000
 
-static int page_sz;
-static size_t cache_sz;
+static unsigned int page_sz;
 
-static char *cache_contents;
 static int fd;
 static char *data = NULL;
 static char *data01 = NULL;
 
-static int setup01(int test);
-static int setup02(int test);
-static int setup03(int test);
-static int setup04(int test);
+static void setup01(int test);
+static void setup02(int test);
+static void setup03(int test);
+static void setup04(int test);
 
-static struct test_case_t {
+static struct tcase {
 	char *err_desc;
 	int exp_errno;
-	char *exp_errval;
-	int (*setupfunc) (int);
-	int (*cleanfunc) (int);
+	void (*setup)(int);
 
-	/* test arguments to remap_file_pages */
 	void *start;
 	size_t size;
 	int prot;
 	ssize_t pgoff;
 	int flags;
-} testcases[] = {
-	{"start does not refer to a valid mapping created with the MAP_SHARED flag",
-	 EINVAL, "EINVAL", setup01, NULL, NULL, 0, 0, 2, 0},
-	{"start is invalid", EINVAL, "EINVAL", setup02, NULL, NULL, 0, 0, 2, 0},
-	{"size is invalid", EINVAL, "EINVAL", setup03, NULL, NULL, 0, 0, 0, 0},
-	{"prot is invalid", EINVAL, "EINVAL", setup04, NULL, NULL, 0, 0, 2, 0}
+} tcases[] = {
+	{"start is not valid MAP_SHARED mapping",
+	 EINVAL, setup01, NULL, 0, 0, 2, 0},
+	{"start is invalid", EINVAL, setup02, NULL, 0, 0, 2, 0},
+	{"size is invalid", EINVAL, setup03,  NULL, 0, 0, 0, 0},
+	{"prot is invalid", EINVAL, setup04, NULL, 0, 0, 2, 0}
 };
 
 static void run(unsigned i)
 {
-	if (testcases[i].setupfunc
-	    && testcases[i].setupfunc(i) == -1)
-		tst_brk(TBROK, "Failed to setup test %d", i);
-
 	TEST(tst_syscall(__NR_remap_file_pages,
-			 testcases[i].start, testcases[i].size,
-			 testcases[i].prot, testcases[i].pgoff,
-			 testcases[i].flags));
-
-	if (testcases[i].cleanfunc
-	    && testcases[i].cleanfunc(i) == -1)
-		tst_brk(TBROK, "Failed to cleanup test %d,"
-			" quitting the test", i);
-
-	if ((TST_RET == -1)
-	    && (TST_ERR == testcases[i].exp_errno))
-		tst_res(TPASS,
-			"remap_file_pages(2) expected failure;"
-			" Got errno - %s : %s",
-			testcases[i].exp_errval,
-			testcases[i].err_desc);
-	else
-		tst_res(TFAIL,
-			"remap_file_pages(2) failed to produce"
-			" expected error: %d, errno: %s."
-			" because got error %d",
-			testcases[i].exp_errno,
-			testcases[i].exp_errval, TST_ERR);
+			 tcases[i].start, tcases[i].size,
+			 tcases[i].prot, tcases[i].pgoff,
+			 tcases[i].flags));
+
+	if ((TST_RET == -1) && (TST_ERR == tcases[i].exp_errno)) {
+		tst_res(TPASS | TTERRNO, "remap_file_pages(2) %s",
+			tcases[i].err_desc);
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO,
+		"remap_file_pages(2) %s expected %s got",
+		tcases[i].err_desc, tst_strerrno(tcases[i].exp_errno));
 }
 
-/* setup01() - create a mmap area without MAP_SHARED flag */
-static int setup01(int test)
+static void setup01(int test)
 {
-	/* Use fd from setup() */
-	data01 = SAFE_MMAP(NULL, cache_sz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
-			   fd, 0);
-	testcases[test].start = data01;
-	testcases[test].size = page_sz;
-	return 0;
+	tcases[test].start = data01;
+	tcases[test].size = page_sz;
 }
 
-/* setup02() - start is invalid */
-static int setup02(int test)
+static void setup02(int test)
 {
-	testcases[test].start = data + cache_sz;
-	testcases[test].size = page_sz;
-	return 0;
+	tcases[test].start = data + page_sz;
+	tcases[test].size = page_sz;
 }
 
-/* setup03() - size is invalid */
-static int setup03(int test)
+static void setup03(int test)
 {
-	testcases[test].start = data;
-	testcases[test].size = cache_sz + page_sz;
-	return 0;
+	tcases[test].start = data;
+	tcases[test].size = 2 * page_sz;
 }
 
-/* setup04() - prot is invalid */
-static int setup04(int test)
+static void setup04(int test)
 {
-	testcases[test].start = data;
-	testcases[test].size = page_sz;
-	testcases[test].prot = -1;
-	return 0;
+	tcases[test].start = data;
+	tcases[test].size = page_sz;
+	tcases[test].prot = -1;
 }
 
 static void setup(void)
 {
-	unsigned int i, j;
-	size_t page_words;
-	size_t cache_pages;
+	unsigned int i;
 
 #if defined (__s390__) || (__s390x__) || (__ia64__)
 	if ((tst_kvercmp(2, 6, 12)) < 0)
@@ -176,42 +127,36 @@ static void setup(void)
 			 "This test can only run on kernels that are 2.6.12 and higher");
 #endif
 
-	if ((page_sz = getpagesize()) < 0)
-		tst_brk(TFAIL,
-			"getpagesize() fails to get system page size");
-	page_words = (page_sz / sizeof(char));
+	page_sz = getpagesize();
 
-	/* Set the cache size */
-	cache_pages = 32;
-	cache_sz = cache_pages * page_sz;
-	cache_contents = malloc(cache_sz * sizeof(char));
+	fd = SAFE_OPEN("cache", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
+	SAFE_FTRUNCATE(fd, page_sz);
 
-	for (i = 0; i < cache_pages; i++) {
-		char *page = cache_contents + i * page_sz;
+	data = SAFE_MMAP((void *)WINDOW_START, page_sz, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, 0);
 
-		for (j = 0; j < page_words; j++)
-			page[j] = i;
-	}
+	data01 = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
+			   fd, 0);
 
-	fd = SAFE_OPEN("cache", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
-	SAFE_WRITE(1, fd, cache_contents, cache_sz);
-	data = SAFE_MMAP((void *)WINDOW_START, cache_sz, PROT_READ | PROT_WRITE,
-			 MAP_SHARED, fd, 0);
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		if (tcases[i].setup)
+			tcases[i].setup(i);
+	}
 }
 
 static void cleanup(void)
 {
-	/* Close the file descriptor */
-	close(fd);
+	SAFE_CLOSE(fd);
 
 	if (data)
-		munmap(data, cache_sz);
+		SAFE_MUNMAP(data, page_sz);
+
 	if (data01)
-		munmap(data01, cache_sz);
+		SAFE_MUNMAP(data01, page_sz);
 }
 
 static struct tst_test test = {
-	.tcnt = ARRAY_SIZE(testcases),
+	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.cleanup = cleanup,
 	.setup = setup,

-- 
Cyril Hrubis
chrubis@suse.cz
