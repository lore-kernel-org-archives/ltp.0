Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XX3N5-0000cT-Jn
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 07:21:47 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX3N4-0000bj-B5
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 07:21:47 +0000
Date: Thu, 25 Sep 2014 03:21:39 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1208219476.36874714.1411629699911.JavaMail.zimbra@redhat.com>
In-Reply-To: <34230333.34479260.1411109300536.JavaMail.zimbra@redhat.com>
References: <1143685925.31209960.1410431487838.JavaMail.zimbra@redhat.com>
	<5411B140.4030007@oracle.com>
	<34230333.34479260.1411109300536.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/3] fcntl14: only skip test block2 on NFS
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, ltp-list@lists.sourceforge.net


NFS does not support mandaroty locking.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c | 42 ++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index b110d35..9d20f00 100644
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
@@ -1027,21 +1027,29 @@ int main(int ac, char **av)
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
-		testcheck_end(fail, "Block 2, test 1");
-
-		/* Now try negative values for L_start and L_len */
-		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, S_ENFMT | S_IRUSR |
-			       S_IWUSR, 5, 36, 45);
-		testcheck_end(fail, "Block 2, test 2");
-
+		tst_resm(TINFO, "Enter block 2: with mandatory locking");
+		if (NO_NFS) {
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
+		} else
+			tst_resm(TCONF, "Skip block 2 as NFS does not"
+				" support mandatory locking");
 		tst_resm(TINFO, "Exit block 2");
 
 /* //block3: */
-- 
1.8.3.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
