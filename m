From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:36 +0100
Subject: [LTP] [COMMITTED] [PATCH 14/23] syscalls/eventfd2_02: Small cleanup.
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-14-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c | 41 ++----------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index 3d42ebd..b2be520 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -66,52 +66,13 @@ char *TCID = "eventfd2_02";
 int testno;
 int TST_TOTAL = 1;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
 void cleanup(void)
 {
-
 	tst_rmdir();
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
 void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
@@ -120,6 +81,8 @@ int main(int argc, char *argv[])
 {
 	int fd, fl;
 
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	if ((tst_kvercmp(2, 6, 27)) < 0) {
 		tst_brkm(TCONF, NULL,
 			 "This test can only run on kernels that are 2.6.27 and higher");
-- 
2.10.2

