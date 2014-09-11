Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XS1f5-0003XW-Bx
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:31:35 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XS1f4-0006Wm-2K
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:31:35 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s8BAVR5L004805
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 06:31:27 -0400
Date: Thu, 11 Sep 2014 06:31:27 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1143685925.31209960.1410431487838.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] fcntl14: only skip test block2 on NFS
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

NFS does not support mandaroty locking.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c | 53 ++++++++++++++++---------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 9db88e8..e1ae565 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -546,6 +546,7 @@ void catch_alarm(int sig);
 
 char *TCID = "fcntl14";
 int TST_TOTAL = 1;
+int NO_NFS = 1;
 
 #ifdef UCLINUX
 static char *argv0;		/* Set by main(), passed to self_exec() */
@@ -1000,10 +1001,9 @@ int main(int ac, char **av)
 
 	setup();		/* global setup */
 
-	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do fcntl on a file on NFS filesystem");
-	}
+	/* Check if test on NFS or not*/
+	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
+		NO_NFS = 0;
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -1027,30 +1027,31 @@ int main(int ac, char **av)
 		tst_resm(TINFO, "Exit block 1");
 
 /* //block2: */
-		tst_resm(TINFO, "Enter block 2: with mandatory locking");
-		fail = 0;
 		/*
-		 * Try various locks on a file with mandatory record locking
-		 * this should behave the same as an ordinary file
+		 * Skip block2 if test on NFS, since NFS does not support
+		 * mandatory locking
 		 */
-		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, S_ENFMT | S_IRUSR |
-			       S_IWUSR, 0, 0, 36);
-		if (fail) {
-			tst_resm(TFAIL, "Block 2, test 1 FAILED");
-		} else {
-			tst_resm(TPASS, "Block 2, test 1 PASSED");
-		}
-
-		/* Now try negative values for L_start and L_len */
-		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, S_ENFMT | S_IRUSR |
-			       S_IWUSR, 5, 36, 45);
-		if (fail) {
-			tst_resm(TFAIL, "Block 2, test 2 FAILED");
-		} else {
-			tst_resm(TPASS, "Block 2, test 2 PASSED");
-		}
-
-		tst_resm(TINFO, "Exit block 2");
+		if (NO_NFS) {
+			tst_resm(TINFO, "Enter block 2: with"
+					" mandatory locking");
+			fail = 0;
+			/*
+			 * Try various locks on a file with mandatory
+			 * record locking this should behave the same
+			 * as an ordinary file
+			 */
+			(void)run_test(O_CREAT | O_RDWR | O_TRUNC,
+				S_ENFMT | S_IRUSR | S_IWUSR, 0, 0, 36);
+			testcheck_end(fail, "Block 2, test 1");
+
+			/* Now try negative values for L_start and L_len */
+			(void)run_test(O_CREAT | O_RDWR | O_TRUNC,
+				S_ENFMT | S_IRUSR | S_IWUSR, 5, 36, 45);
+			testcheck_end(fail, "Block 2, test 2");
+
+			tst_resm(TINFO, "Exit block 2");
+		} else
+			tst_resm(TINFO, "Skip block 2 on NFS");
 
 /* //block3: */
 		tst_resm(TINFO, "Enter block 3");
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
