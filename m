Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VoYRd-00054W-Nr
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:54:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoYRb-0003MQ-Sv
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:54:17 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB5Cs8KP030477
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 20:54:08 +0800
Message-ID: <1386248044.1542.11.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 20:54:04 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 3/4] fallocate/fallocate02.c: cleanup
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
 testcases/kernel/syscalls/fallocate/fallocate02.c | 308 ++++++----------------
 1 file changed, 83 insertions(+), 225 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index e5e482c..8838cff 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -2,7 +2,7 @@
  *			 fallocate02.c
  *	Mon Dec 24 2007
  *	Copyright (c) International Business Machines  Corp., 2007
- *	Emali : sharyathi@in.ibm.com
+ *	Author: Sharyathi Nagesh <sharyathi@in.ibm.com>
  ******************************************************************************/
 
 /***************************************************************************
@@ -21,68 +21,9 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 ***************************************************************************/
 
-/*****************************************************************************
- *
- *	OS Test - International Business Machines Corp. 2007.
- *
- *	TEST IDENTIFIER	: fallocate02
- *
- *	EXECUTED BY		: anyone
- *
- *	TEST TITLE		: Checks for Errors from fallocate()
- *
- *	TEST CASE TOTAL	: 7
- *
- *	CPU ARCHITECTURES	: PPC,X86, X86_64
- *
- *	AUTHOR			: Sharyathi Nagesh
- *
- *	CO-PILOT			:
- *
- *	DATE STARTED		: 24/12/2007
- *
- *	TEST CASES
- *	(Tests fallocate() for different test cases as reported in map page)
- *
- *	INPUT SPECIFICATIONS
- *		No input needs to be specified
- *		  fallocate() in-puts are specified through test_data
- *
- *	OUTPUT SPECIFICATIONS
- *		fallocate Error message matches with the expected error message.
- *
- *	ENVIRONMENTAL NEEDS
- *		Test Needs to be executed on file system supporting ext4
- *   LTP {TMP} Needs to be set to such a folder
- *
- *	SPECIAL PROCEDURAL REQUIREMENTS
- *		None
- *
- *	DETAILED DESCRIPTION
- *		This is a test case for fallocate() system call.
- *		This test suite tests various error messages from fallocate
- *		If the error message received matches with the expected
- *		test is considered passed else test fails
- *		Provided TEST_DEFAULT to switch b/w modes
- *
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
-*************************************************************************/
+/*
+ * Test ERRORS for fallocate(2)
+ */
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -96,207 +37,124 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 #include "fallocate.h"
 
-#define BLOCKS_WRITTEN 12
-
-#ifdef TEST_DEFAULT
-#define DEFAULT_TEST_MODE 0	//DEFAULT MODE
+#define	BLOCKS_WRITTEN		12
+#ifdef	TEST_DEFAULT
+#define	DEFAULT_TEST_MODE	0
 #else
-#define DEFAULT_TEST_MODE 1	//FALLOC_FL_KEEP_SIZE MODE
+#define	DEFAULT_TEST_MODE	1
 #endif
+#define OFFSET			12
+#define	FNAMER			"test_file1"
+#define	FNAMEW			"test_file2"
 
-#define OFFSET 12
+static void setup(void);
+static void cleanup(void);
 
-void populate_file();
-void create_fifo();
-void create_pipe();
-void get_blocksize(int fd);
+static int fdw;
+static int fdr;
+static int block_size;
 
-char *TCID = "fallocate02";
-char fnamew[255];
-char fnamer[255];
-int fdw;
-int fdr;
-enum { RFILE, WFILE, PIPE, FIFO };
-struct test_data_t {
-	int file;
+static struct test_data_t {
+	int *fd;
+	char *fname;
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
+	{&fdr, FNAMER, DEFAULT_TEST_MODE, 0, 1, EBADF},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -1, 1, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, -1, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN-OFFSET, 1, 0},
 };
 
+TCID_DEFINE(fallocate02);
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
-{
-	/* Close all open file descriptors. */
-	if (close(fdw) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fnamew);
-
-	if (close(fdr) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fnamer);
-
-	tst_rmdir();
-
-}
-
-/*****************************************************************************
- * Performs all one time setup for this test. This function is
- * used to create temporary dirs and temporary files
- * that may be used in the course of this test
- ******************************************************************************/
-void setup()
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fnamer, "tfile_read_%d", getpid());
-	sprintf(fnamew, "tfile_write_%d", getpid());
-
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
-
-/*****************************************************************************
- * Gets the block size for the file system
- ******************************************************************************/
-void get_blocksize(int fd)
-{
-	struct stat file_stat;
-
-	if (fstat(fd, &file_stat) < 0)
-		tst_resm(TFAIL | TERRNO,
-			 "fstat failed while getting block_size");
-
-	block_size = (int)file_stat.st_blksize;
-	buf_size = block_size;
-}
-
-/*****************************************************************************
- * Writes data into the file
- ******************************************************************************/
-void populate_file()
-{
-	char buf[buf_size + 1];
-	int index;
-	int blocks;
-	int data;
-	for (blocks = 0; blocks < BLOCKS_WRITTEN; blocks++) {
-		for (index = 0; index < buf_size; index++)
-			buf[index] = 'A' + (index % 26);
-		buf[buf_size] = '\0';
-		if ((data = write(fdw, buf, buf_size)) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Unable to write to %s", fnamew);
-	}
-}
-
-/*****************************************************************************
- * Main function that calls the system call with the  appropriate parameters
- ******************************************************************************/
-/* ac: number of command line parameters */
-/* av: pointer to the array of the command line parameters */
 int main(int ac, char **av)
 {
-
-	int test_index = 0;
 	int lc;
-	int fd;
-	char fname[255], *msg;
+	int i;
+	char *msg;
 
-	/***************************************************************
-	     * parse standard options
-     	***************************************************************/
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	/* perform global test setup, call setup() function. */
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
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
 
-			TEST(fallocate
-			     (fd, test_data[test_index].mode,
-			      test_data[test_index].offset * block_size,
-			      test_data[test_index].len * block_size));
-			/* check return code */
-			if (TEST_ERRNO != test_data[test_index].error) {
-				if (TEST_ERRNO == EOPNOTSUPP
-				    || TEST_ERRNO == ENOSYS) {
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			TEST(fallocate(*test_data[i].fd, test_data[i].mode,
+				       test_data[i].offset * block_size,
+				       test_data[i].len * block_size));
+			if (TEST_ERRNO != test_data[i].error) {
+				if (TEST_ERRNO == EOPNOTSUPP ||
+				    TEST_ERRNO == ENOSYS) {
 					tst_brkm(TCONF, cleanup,
-						 "fallocate system call is not implemented");
+						 "fallocate system call is not "
+						 "implemented");
 				}
-				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL | TTERRNO,
 					 "fallocate(%s:%d, %d, %" PRId64 ", %"
 					 PRId64 ") failed, expected errno:%d",
-					 fname, fd, test_data[test_index].mode,
-					 test_data[test_index].offset *
-					 block_size,
-					 test_data[test_index].len * block_size,
-					 test_data[test_index].error);
+					 test_data[i].fname, *test_data[i].fd,
+					 test_data[i].mode,
+					 test_data[i].offset * block_size,
+					 test_data[i].len * block_size,
+					 test_data[i].error);
 			} else {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "fallocate(%s:%d, %d, %" PRId64 ", %"
-					 PRId64 ") returned %d", fname, fd,
-					 test_data[test_index].mode,
-					 test_data[test_index].offset *
-					 block_size,
-					 test_data[test_index].len * block_size,
+					 PRId64 ") returned %d",
+					 test_data[i].fname, *test_data[i].fd,
+					 test_data[i].mode,
+					 test_data[i].offset * block_size,
+					 test_data[i].len * block_size,
 					 TEST_ERRNO);
 			}
 		}
 	}
+
 	cleanup();
+
 	tst_exit();
 }
+
+static void setup(void)
+{
+	struct stat file_stat;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	fdr = SAFE_OPEN(cleanup, FNAMER, O_RDONLY | O_CREAT, S_IRUSR);
+
+	fdw = SAFE_OPEN(cleanup, FNAMEW, O_RDWR | O_CREAT, S_IRWXU);
+
+	SAFE_FSTAT(cleanup, fdr, &file_stat);
+
+	block_size = (int)file_stat.st_blksize;
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(NULL, fdw);
+
+	SAFE_CLOSE(NULL, fdr);
+
+	tst_rmdir();
+}
-- 
1.8.2.1





------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
