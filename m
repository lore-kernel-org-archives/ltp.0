Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XS1eP-0003TO-QD
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:30:53 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XS1eN-0003HL-UO
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:30:53 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8BAUkXX018303
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 06:30:46 -0400
Date: Thu, 11 Sep 2014 06:30:46 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
In-Reply-To: <1397094487.31209591.1410431434756.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] fcntl14: dup code clean up
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

And block3 description message fix from "mandatory locking"
to "negative whence".

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c | 36 +++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 30a1ea9..9db88e8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -969,6 +969,15 @@ void catch1(int sig)
 	got1++;
 }
 
+static void testcheck_end(int check_fail, char *msg)
+{
+	if (check_fail) {
+		tst_resm(TFAIL, "%s FAILED", msg);
+	} else {
+		tst_resm(TPASS, "%s PASSED", msg);
+	}
+}
+
 int main(int ac, char **av)
 {
 	int lc;
@@ -1009,20 +1018,11 @@ int main(int ac, char **av)
 		 * mandatory locking
 		 */
 		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 0, 36);
-		if (fail) {
-			tst_resm(TFAIL, "Block 1, test 1 FAILED");
-		} else {
-			tst_resm(TPASS, "Block 1, test 1 PASSED");
-		}
+		testcheck_end(fail, "Block 1, test 1");
 
 		/* Now try with negative values for L_start and L_len */
 		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 5, 36, 45);
-
-		if (fail) {
-			tst_resm(TFAIL, "Block 1, test 2 FAILED");
-		} else {
-			tst_resm(TPASS, "Block 1, test 2 PASSED");
-		}
+		testcheck_end(fail, "Block 1, test 2");
 
 		tst_resm(TINFO, "Exit block 1");
 
@@ -1094,13 +1094,7 @@ int main(int ac, char **av)
 		close(fd);
 		unlink(tmpname);
 
-		if (fail) {
-			tst_resm(TINFO, "Test with mandatory "
-				 "locking FAILED");
-		} else {
-			tst_resm(TINFO, "Test with mandatory "
-				 "locking PASSED");
-		}
+		testcheck_end(fail, "Test with negative whence locking");
 		tst_resm(TINFO, "Exit block 3");
 
 /* //block4: */
@@ -1223,11 +1217,7 @@ int main(int ac, char **av)
 		close(fd);
 		unlink(tmpname);
 
-		if (fail) {
-			tst_resm(TINFO, "Test of locks on file FAILED");
-		} else {
-			tst_resm(TINFO, "Test of locks on file PASSED");
-		}
+		testcheck_end(fail, "Test of locks on file");
 		tst_resm(TINFO, "Exit block 4");
 	}
 	cleanup();
-- 
1.8.3.1


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
