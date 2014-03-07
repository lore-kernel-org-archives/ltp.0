Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WLpa1-0004In-Dd
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 07:52:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLpZx-000068-RE
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 07:52:29 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s277q9If013277
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 15:52:09 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 7 Mar 2014 15:50:31 +0800
Message-Id: <1394178632-14462-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/2] munmap/munmap03.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Delete the useless code doing mmap operation on a file, which
makes no sense in this case.

Use safe macros and do some code re-arrangement.

Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/munmap/munmap03.c | 223 ++++++----------------------
 1 file changed, 48 insertions(+), 175 deletions(-)

diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index bead61a..f906e4d 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -18,53 +18,16 @@
  */
 
 /*
- * Test Name: munmap03
- *
  * Test Description:
- *  Verify that, munmap call will fail to unmap a mapped file or anonymous
- *  shared memory region from the calling process's address space if the
- *  address and the length of the region to be unmapped points outside the
- *  calling process's address space
- *
- * Expected Result:
- *  munmap call should fail with return value -1 and sets errno EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  munmap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ *  Verify that,
+ *   1. munmap() fails with -1 return value and sets errno to EINVAL
+ *      if addresses in the range [addr,addr+len) are outside the valid
+ *	range for the address space of a process.
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
  */
+
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -74,175 +37,85 @@
 
 #include "test.h"
 #include "usctest.h"
-
-#define TEMPFILE	"mmapfile"
+#include "safe_macros.h"
 
 char *TCID = "munmap03";
-int TST_TOTAL = 1;
 
-size_t page_sz;			/* system page size */
-char *addr;			/* addr of memory mapped region */
-char *faddr;			/* addr of memory mapped region */
-int fildes;			/* file descriptor for tempfile */
-size_t map_len;			/* length of the region to be mapped */
+static size_t page_sz;
+static int exp_enos[] = { EINVAL, 0 };
 
-int exp_enos[] = { EINVAL, 0 };
+static void setup(void);
+static void cleanup(void);
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+static void test_einval1(void);
+static void (*testfunc[])(void) = { test_einval1 };
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		setup();
-
-		/*
-		 * Attempt to unmap the mapped region of the temporary file
-		 * from the address that points outside the process's
-		 * address space.
-		 */
-		TEST(munmap(addr, map_len));
-
-		/* Check for the return value of munmap() */
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "munmap() returned %ld, expected -1",
-				 TEST_RETURN);
-			continue;
-		}
-
-		/* Check for expected errno. */
-		if (TEST_ERRNO == EINVAL) {
-			tst_resm(TPASS | TTERRNO, "munmap failed as expected");
-		} else {
-			tst_resm(TPASS | TTERRNO,
-				 "munmap didn't fail as expected");
-		}
-
-		cleanup();
-
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
 	}
+
+	cleanup();
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size, create a temporary file for reading/writing,
- * write one byte data into it, map the open file for the specified
- * map length.
- */
-void setup()
+static void setup(void)
 {
-	struct rlimit brkval;	/* variable to hold max. break val */
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	TEST_EXP_ENOS(exp_enos);
+
 	TEST_PAUSE;
 
-	/* call getrlimit function to get the maximum possible break value */
-	getrlimit(RLIMIT_DATA, &brkval);
+	page_sz = (size_t)sysconf(_SC_PAGESIZE);
+}
 
-	/* Get the system page size */
-	if ((page_sz = getpagesize()) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "getpagesize() fails to get system page size");
+static void check_and_print(int expected_errno)
+{
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == expected_errno) {
+			tst_resm(TPASS | TTERRNO, "failed as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO,
+				 "failed unexpectedly; expected - %d : %s",
+				 expected_errno, strerror(expected_errno));
+		}
+	} else {
+		tst_resm(TFAIL, "munmap succeeded unexpectedly");
 	}
+}
 
-	/*
-	 * Get the length of the open file to be mapped into process
-	 * address space.
-	 */
-	map_len = 3 * page_sz;
-
-	tst_tmpdir();
+static void test_einval1(void)
+{
+	struct rlimit brkval;
+	char *addr;
+	size_t map_len;
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_GETRLIMIT(cleanup, RLIMIT_DATA, &brkval);
 
-	/*
-	 * move the file pointer to maplength position from the beginning
-	 * of the file.
-	 */
-	if (lseek(fildes, map_len, SEEK_SET) == -1) {
-		tst_brkm(TBROK, cleanup, "lseek() fails on %s, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-
-	/* Write one byte into temporary file */
-	if (write(fildes, "a", 1) != 1) {
-		tst_brkm(TBROK, cleanup, "write() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	addr = (char *)brkval.rlim_max;
+	map_len = page_sz * 2;
 
-	/*
-	 * map the open file 'TEMPFILE' from its beginning up to the maplength
-	 * into the calling process's address space at the system choosen
-	 * with read/write permissions to the the mapped region.
-	 */
-#ifdef UCLINUX
-	/* MAP_SHARED not implemented on uClinux */
-	faddr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		     MAP_FILE | MAP_PRIVATE, fildes, 0);
-#else
-	faddr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		     MAP_FILE | MAP_SHARED, fildes, 0);
-#endif
-
-	/* check for the return value of mmap system call */
-	if (faddr == (char *)MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap() Failed on %s, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-		tst_exit();
-	}
+	TEST(munmap(addr, map_len));
 
-	/* convert the MAX. possible break value */
-	addr = (char *)brkval.rlim_max;
+	check_and_print(EINVAL);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  	       Unmap the mapped region of the file.
- *  	       Close the temporary file.
- *  	       Remove the temporary directory.
- */
-void cleanup()
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	/*
-	 * unmap the mapped region of the file from the process
-	 * address space
-	 */
-	if (munmap(faddr, map_len) < 0) {
-		tst_brkm(TBROK, NULL, "munmap() fails to unmap the mapped "
-			 "region of the file");
-	}
-
-	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-
-	tst_rmdir();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
