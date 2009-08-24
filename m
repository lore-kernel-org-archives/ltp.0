Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfaFB-0007c4-5g
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 14:09:57 +0000
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfaF4-0005CA-Vm
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 14:09:57 +0000
Date: Mon, 24 Aug 2009 21:47:07 +0800 (CST)
Message-Id: <20090824.214707.245407769.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/3 v3] Fix unshare01
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

v3: simplify reporting by using TERRNO.

v2: remove unneeded linux_syscall_numbers.h and simplify the checking of
errno according to Mike's suggestion.

When no unshare function found during the build-time checking or the
kernel returns ENOSYS, it reports TCONF. It also simplify logic a little
bit and fix some coding style issues.

Signed-off-by: CAI Qian <caiqian@cclom.cn>

 testcases/kernel/syscalls/unshare/unshare01.c |   94 +++++++++++++++++-------
 1 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index 2a7cc1b..a928e65 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -92,7 +92,7 @@
 /* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
-#include "linux_syscall_numbers.h"
+#include "config.h"
 
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
@@ -103,6 +103,8 @@ char *TCID = "unshare01";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL =1;                   /* total number of tests in this file.   */
 
+#ifdef HAVE_UNSHARE
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -177,47 +179,77 @@ int main(int ac, char **av) {
  *fork a child process;testing which one is a child or a parent;
  * */
 		        TEST(pid1=fork());    //call to fork()
-			if (TEST_RETURN == -1){
-				tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL|TTERRNO, "fork() failed.");
 				cleanup();
 				tst_exit();
-			}else if (TEST_RETURN == 0){
-				if((TEST_RETURN = unshare(CLONE_FILES)) == 0) {
-	        		tst_resm(TPASS, "unshare with CLONE_FILES call succeeded");
+			} else if (TEST_RETURN == 0) {
+				TEST_RETURN = unshare(CLONE_FS);
+				if (TEST_RETURN == 0)
+					tst_resm(TPASS,
+						"unshare with CLONE_FILES call "
+						"succeeded");
+				else if (TEST_RETURN == -1) {
+					if (errno == ENOSYS)
+						tst_resm(TCONF,
+							"unshare is not "
+							"implemented in kernel."
+							);
+					else
+						tst_resm(TFAIL|TERRNO,
+							"unshare failed.");
+				}
 				tst_exit();
-				}else if (TEST_RETURN == -1 )
-					tst_resm(TFAIL,"unshare Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-					tst_exit();
 			}else{
 			}
 
 			TEST(pid1=fork());    //call to fork()
-                        if (TEST_RETURN == -1){
-                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL|TTERRNO, "fork() failed.");
 	                        cleanup();
                         	tst_exit();
-                        }else if (TEST_RETURN == 0){
-                                if((TEST_RETURN = unshare(CLONE_FS)) == 0) {
-                                	tst_resm(TPASS, "unshare with CLONE_FS call succeeded");
-					tst_exit();
-                                }else if (TEST_RETURN == -1 )
-                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-					tst_exit();
+			} else if (TEST_RETURN == 0) {
+				TEST_RETURN = unshare(CLONE_FS);
+				if (TEST_RETURN == 0)
+					tst_resm(TPASS,
+						"unshare with CLONE_FS call "
+						"succeeded");
+				else if (TEST_RETURN == -1) {
+					if (errno == ENOSYS)
+						tst_resm(TCONF,
+							"unshare is not "
+							"implemented in kernel."
+							);
+					else
+						tst_resm(TFAIL|TERRNO,
+							"unshare failed 2.");
+				}
+				tst_exit();
                         }else{
 			}
 
 			TEST(pid1=fork());    //call to fork()
-                        if (TEST_RETURN == -1){
-                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL|TTERRNO, "fork() failed.");
 	                        cleanup();
                         	tst_exit();
-                        }else if (TEST_RETURN == 0){
-                                if((TEST_RETURN = unshare(CLONE_NEWNS)) == 0) {
-                                	tst_resm(TPASS, "unshare call with CLONE_NEWNS succeeded");
-					tst_exit();
-                                }else if (TEST_RETURN == -1 )
-                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-					tst_exit();
+			} else if (TEST_RETURN == 0) {
+				TEST_RETURN = unshare(CLONE_NEWNS);
+				if (TEST_RETURN == 0) {
+					tst_resm(TPASS,
+						"unshare call with CLONE_NEWNS "
+						"succeeded");
+				} else if (TEST_RETURN == -1) {
+					if (errno == ENOSYS)
+						tst_resm(TCONF,
+							"unshare is not "
+							"implemented in kernel."
+							);
+					else
+						tst_resm(TFAIL|TERRNO,
+							"unshare failed 2.");
+				}
+				tst_exit();
                         }else{
 			}
 
@@ -228,4 +260,10 @@ int main(int ac, char **av) {
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
