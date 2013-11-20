Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vj5c5-0000JR-6W
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 11:06:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vj5c1-0000dW-Ke
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 11:06:29 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAKB6Ht7027398
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Nov 2013 19:06:18 +0800
Message-ID: <1384945570.1661.5.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2013 19:06:10 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fallocate/fallocate02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

cleanup of fallocate02.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate02.c | 278 ++++++++--------------
 1 file changed, 102 insertions(+), 176 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 37f0635..d95f682 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -65,23 +65,6 @@
  *		test is considered passed else test fails
  *		Provided TEST_DEFAULT to switch b/w modes
  *
- *		Total 7 Test Cases :-
- *		Various error messages from the man page
- *
- *	Setup:
- *		Setup files on which fallocate is to be called
- *
- *	Test:
- *		Loop if the proper options are given.
- *		Execute system call
- *		Check return code.
- *		If error obtained matches with the expected error
- *		PASS the test, otherwise TEST FAILS
- *		Provided TEST_DEFAULT to switch b/w modes
- *
- *	Cleanup:
- *		Cleanup the temporary folder
- *
 *************************************************************************/
 
 #include <stdio.h>
@@ -97,77 +80,117 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
+#include "safe_macros.h"
 
 #define BLOCKS_WRITTEN 12
 
 #ifdef TEST_DEFAULT
-#define DEFAULT_TEST_MODE 0	//DEFAULT MODE
+#define DEFAULT_TEST_MODE 0
 #else
-#define DEFAULT_TEST_MODE 1	//FALLOC_FL_KEEP_SIZE MODE
+#define DEFAULT_TEST_MODE 1
 #endif
 
 #define OFFSET 12
 
-static inline long fallocate();
-void populate_file();
-void create_fifo();
-void create_pipe();
-void get_blocksize(int fd);
+enum { RFILE, WFILE };
 
-char *TCID = "fallocate02";
-char fnamew[255];
-char fnamer[255];
-int fdw;
-int fdr;
-enum { RFILE, WFILE, PIPE, FIFO };
-struct test_data_t {
+static void setup(void);
+static void cleanup(void);
+static inline long fallocate(int, int, loff_t, loff_t);
+
+static char fnamew[255];
+static char fnamer[255];
+static int fdw;
+static int fdr;
+static int block_size;
+
+static struct test_data_t {
 	int file;
 	int mode;
 	loff_t offset;
 	loff_t len;
 	int error;
 } test_data[] = {
-	{
-	RFILE, DEFAULT_TEST_MODE, 0, 1, EBADF}, {
-	WFILE, DEFAULT_TEST_MODE, -1, 1, EINVAL}, {
-	WFILE, DEFAULT_TEST_MODE, 1, -1, EINVAL}, {
-	WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL}, {
-	WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL}, {
-	WFILE, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN + OFFSET), 1, EINVAL}, {
-	WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN - OFFSET, 1, 0}
+	{RFILE, DEFAULT_TEST_MODE, 0, 1, EBADF},
+	{WFILE, DEFAULT_TEST_MODE, -1, 1, EINVAL},
+	{WFILE, DEFAULT_TEST_MODE, 1, -1, EINVAL},
+	{WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
+	{WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
+	{WFILE, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN + OFFSET), 1, EINVAL},
+	{WFILE, DEFAULT_TEST_MODE, BLOCKS_WRITTEN - OFFSET, 1, 0},
 };
 
+char *TCID = "fallocate02";
+int TST_TOTAL = ARRAY_SIZE(test_data);
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
-int block_size;
-int buf_size;
-
-/******************************************************************************
- * Performs all one time clean up for this test on successful
- * completion,  premature exit or  failure. Closes all temporary
- * files, removes all temporary directories exits the test with
- * appropriate return code by calling tst_exit() function.
-******************************************************************************/
-extern void cleanup()
+int main(int ac, char **av)
 {
-	/* Close all open file descriptors. */
-	if (close(fdw) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fnamew);
+	int lc;
+	int i;
+	int fd;
+	char *fname;
 
-	if (close(fdr) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fnamer);
+	setup();
 
-	tst_rmdir();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+			switch (test_data[i].file) {
+			case RFILE:
+				fd = fdr;
+				fname = fnamer;
+				break;
+			case WFILE:
+				fd = fdw;
+				fname = fnamew;
+				break;
+			default:
+				tst_brkm(TCONF, cleanup,
+					 "invalid test setting");
+				tst_exit();
+			}
 
+			TEST(fallocate(fd, test_data[i].mode,
+				       test_data[i].offset * block_size,
+				       test_data[i].len * block_size));
+			if (TEST_ERRNO != test_data[i].error) {
+				if (TEST_ERRNO == EOPNOTSUPP ||
+				    TEST_ERRNO == ENOSYS) {
+					tst_brkm(TCONF, cleanup,
+						 "fallocate system call is not "
+						 "implemented");
+				}
+				tst_resm(TFAIL | TTERRNO,
+					 "fallocate(%s:%d, %d, %" PRId64 ", %"
+					 PRId64 ") failed, expected errno:%d",
+					 fname, fd, test_data[i].mode,
+					 test_data[i].offset * block_size,
+					 test_data[i].len * block_size,
+					 test_data[i].error);
+			} else {
+				tst_resm(TPASS,
+					 "fallocate(%s:%d, %d, %" PRId64 ", %"
+					 PRId64 ") returned %d", fname, fd,
+					 test_data[i].mode,
+					 test_data[i].offset * block_size,
+					 test_data[i].len * block_size,
+					 TEST_ERRNO);
+			}
+		}
+	}
+
+	cleanup();
+
+	tst_exit();
 }
 
-/*****************************************************************************
- * Performs all one time setup for this test. This function is
- * used to create temporary dirs and temporary files
- * that may be used in the course of this test
- ******************************************************************************/
-void setup()
+static void setup(void)
 {
+	int index;
+	int blocks;
+	struct stat file_stat;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -176,144 +199,47 @@ void setup()
 	tst_tmpdir();
 
 	sprintf(fnamer, "tfile_read_%d", getpid());
+
 	sprintf(fnamew, "tfile_write_%d", getpid());
 
-	fdr = open(fnamer, O_RDONLY | O_CREAT, S_IRUSR);
-	if (fdr == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDONLY|O_CREAT, S_IRUSR) failed", fnamer);
-	fdw = open(fnamew, O_RDWR | O_CREAT, S_IRWXU);
-	if (fdw == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, S_IRWXU) failed", fnamew);
-	get_blocksize(fdr);
-	populate_file();
-}
+	fdr = SAFE_OPEN(cleanup, fnamer, O_RDONLY | O_CREAT, S_IRUSR);
 
-/*****************************************************************************
- * Gets the block size for the file system
- ******************************************************************************/
-void get_blocksize(int fd)
-{
-	struct stat file_stat;
+	fdw = SAFE_OPEN(cleanup, fnamew, O_RDWR | O_CREAT, S_IRWXU);
 
-	if (fstat(fd, &file_stat) < 0)
+	if (fstat(fdr, &file_stat) < 0) {
 		tst_resm(TFAIL | TERRNO,
 			 "fstat failed while getting block_size");
+	}
 
 	block_size = (int)file_stat.st_blksize;
-	buf_size = block_size;
-}
 
-/*****************************************************************************
- * Writes data into the file
- ******************************************************************************/
-void populate_file()
-{
-	char buf[buf_size + 1];
-	int index;
-	int blocks;
-	int data;
+	char buf[block_size + 1];
 	for (blocks = 0; blocks < BLOCKS_WRITTEN; blocks++) {
-		for (index = 0; index < buf_size; index++)
+		for (index = 0; index < block_size; index++)
 			buf[index] = 'A' + (index % 26);
-		buf[buf_size] = '\0';
-		if ((data = write(fdw, buf, buf_size)) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Unable to write to %s", fnamew);
+		buf[block_size] = '\0';
+		SAFE_WRITE(cleanup, 0, fdw, buf, block_size);
 	}
 }
 
-/*****************************************************************************
- * Wraper function to call fallocate system call
- ******************************************************************************/
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 #if __WORDSIZE == 32
 	return (long)ltp_syscall(__NR_fallocate, fd, mode,
-			     __LONG_LONG_PAIR((off_t) (offset >> 32),
-					      (off_t) offset),
-			     __LONG_LONG_PAIR((off_t) (len >> 32),
-					      (off_t) len));
+				 __LONG_LONG_PAIR((off_t) (offset >> 32),
+				 (off_t) offset),
+				 __LONG_LONG_PAIR((off_t) (len >> 32),
+				 (off_t) len));
 #else
 	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
 #endif
 }
 
-/*****************************************************************************
- * Main function that calls the system call with the  appropriate parameters
- ******************************************************************************/
-/* ac: number of command line parameters */
-/* av: pointer to the array of the command line parameters */
-int main(int ac, char **av)
+static void cleanup(void)
 {
+	SAFE_CLOSE(NULL, fdw);
 
-	int test_index = 0;
-	int lc;
-	int fd;
-	char fname[255], *msg;
-
-	/***************************************************************
-	     * parse standard options
-     	***************************************************************/
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	SAFE_CLOSE(NULL, fdr);
 
-	/* perform global test setup, call setup() function. */
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-		for (test_index = 0; test_index < TST_TOTAL; test_index++) {
-			switch (test_data[test_index].file) {
-			case RFILE:
-				fd = fdr;
-				strcpy(fname, fnamer);
-				break;
-			case WFILE:
-				fd = fdw;
-				strcpy(fname, fnamew);
-				break;
-			default:
-				tst_brkm(TCONF, cleanup,
-					 "invalid test setting");
-				tst_exit();
-			}
-
-			TEST(fallocate
-			     (fd, test_data[test_index].mode,
-			      test_data[test_index].offset * block_size,
-			      test_data[test_index].len * block_size));
-			/* check return code */
-			if (TEST_ERRNO != test_data[test_index].error) {
-				if (TEST_ERRNO == EOPNOTSUPP
-				    || TEST_ERRNO == ENOSYS) {
-					tst_brkm(TCONF, cleanup,
-						 "fallocate system call is not implemented");
-				}
-				TEST_ERROR_LOG(TEST_ERRNO);
-				tst_resm(TFAIL | TTERRNO,
-					 "fallocate(%s:%d, %d, %" PRId64 ", %"
-					 PRId64 ") failed, expected errno:%d",
-					 fname, fd, test_data[test_index].mode,
-					 test_data[test_index].offset *
-					 block_size,
-					 test_data[test_index].len * block_size,
-					 test_data[test_index].error);
-			} else {
-				/* No Verification test, yet... */
-				tst_resm(TPASS,
-					 "fallocate(%s:%d, %d, %" PRId64 ", %"
-					 PRId64 ") returned %d", fname, fd,
-					 test_data[test_index].mode,
-					 test_data[test_index].offset *
-					 block_size,
-					 test_data[test_index].len * block_size,
-					 TEST_ERRNO);
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
+	tst_rmdir();
 }
-- 
1.8.2.1




------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
