Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfQuN-0001kc-Gn
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:11:51 +0000
Received: from smtp109.biz.mail.re2.yahoo.com ([206.190.53.8])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfQuH-0004HM-AT
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:11:51 +0000
Date: Mon, 24 Aug 2009 12:15:38 +0800 (CST)
Message-Id: <20090824.121538.48518939.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Subject: [LTP] [PATCH 3/3] Fix unshare02
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
To: ltp-list@lists.sourceforge.net

When no unshare function found during the build-time checking or the
kernel returns ENOSYS, it reports TCONF. It also simplify logic a little
bit and fix some coding style issues. In addition, the original test
expects the following call to return 0,

  TEST_RETURN = unshare(-1);

and checking TEST_ERRNO for errors. Those look like incorrect, since
"-1" looks like an invalid flag, and TEST_ERRNO does not set to errno
from the syscall. It has been modified to expect,

  TEST_RETURN = -1;
  errno = EINVAL;

Signed-off-by: CAI Qian <caiqian@cclom.cn>

 testcases/kernel/syscalls/unshare/unshare02.c |   88 +++++++++++++++++--------
 1 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index 1075936..01f5572 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -56,7 +56,7 @@
 /* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
-#include "linux_syscall_numbers.h"
+#include "config.h"
 
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
@@ -67,6 +67,9 @@ char *TCID = "unshare02";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
 
+#ifdef HAVE_UNSHARE
+#include "linux_syscall_numbers.h"
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -141,37 +144,62 @@ int main(int ac, char **av) {
  *fork a child process;testing which one is a child or a parent;
  * */
 		        TEST(pid1=fork());    //call to fork()
-			if (TEST_RETURN == -1){
-			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-			cleanup();
-			tst_exit();
-			}
-			else if (TEST_RETURN == 0){
-				if((TEST_RETURN = unshare(-1)) == 0) {
-	        		tst_resm(TPASS, "Call succeeded");
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL,
+					"fork() Failed, errno=%d : %s",
+					TEST_ERRNO,
+					strerror(TEST_ERRNO));
+				cleanup();
 				tst_exit();
+			} else if (TEST_RETURN == 0) {
+				TEST_RETURN = unshare(-1);
+				if (TEST_RETURN == 0)
+					tst_resm(TFAIL,
+						"Call unexpectedly succeeded.");
+				else if (TEST_RETURN == -1) {
+					if (errno == EINVAL)
+						tst_resm(TPASS,
+							"Expect EINVAL.");
+					else if (errno == ENOSYS)
+						tst_resm(TCONF,
+							"unshare is not "
+							"implemented in kernel."
+							);
+					else
+						tst_resm(TFAIL,
+							"Test Failed, "
+							"errno=%d : %s",
+							errno,
+							strerror(errno));
 				}
-				else if (TEST_RETURN == -1 ){
-					tst_resm(TFAIL,"Test Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-					tst_exit();
-                     			}
+				tst_exit();
 			}
 
 			TEST(pid1=fork());    //call to fork()
-                        if (pid1 == -1){
-                        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-                        cleanup();
-                        tst_exit();
-                        }
-                        else if (TEST_RETURN == 0){
-                                if((TEST_RETURN = unshare((int)NULL)) == 0) {
-                                tst_resm(TPASS, "Call succeeded");
+			if (pid1 == -1) {
+				tst_resm(TFAIL,
+					"fork() Failed, errno=%d : %s",
+					TEST_ERRNO, strerror(TEST_ERRNO));
+				cleanup();
+				tst_exit();
+			} else if (TEST_RETURN == 0) {
+				TEST_RETURN = unshare((int)NULL);
+				if (TEST_RETURN == 0)
+					tst_resm(TPASS, "Call succeeded");
+				else if (TEST_RETURN == -1) {
+					if (errno == ENOSYS)
+						tst_resm(TCONF,
+							"unshare is not "
+							"implemented in kernel."
+							);
+					else
+						tst_resm(TFAIL,
+							"Test Failed 2, "
+							"errno=%d : %s",
+							errno,
+							strerror(errno));
+				}
 				tst_exit();
-                                }
-                                else if (TEST_RETURN == -1 ){
-                                        tst_resm(TFAIL,"Test Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-					tst_exit();
-                                        }
                         }
 
 
@@ -180,4 +208,10 @@ int main(int ac, char **av) {
 	cleanup();
         tst_exit();
 }
-
+#else
+int main(void)
+{
+	tst_resm(TCONF, "unshare is undefined.");
+	return 0;
+}
+#endif

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
