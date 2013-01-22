Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TxTCL-0000Sh-3M
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 02:02:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TxTCJ-0002Z3-QP
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 02:02:49 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0M22ILu023366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Jan 2013 21:02:41 -0500
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 22 Jan 2013 10:00:42 +0800
Message-Id: <92867bc530123caf2e89e05551d79db89cb94e0b.1358819770.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2]] syscalls/sendmsg01: using 'ip' command to replace
	'ifconfig'
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
To: LTP List <ltp-list@lists.sourceforge.net>

'ip' tools is more general than 'ifconfig', and there are some
distros don't support to install 'ifconfig' tools under default,
which will cause such below error:

   sh: ifconfig: command not found
   sendmsg01    1  TBROK  :  ifconfig failed to bring up loop back device
   sendmsg01    2  TBROK  :  Remaining cases broken

the patch displaced 'ifconfig' using 'ip', and also the case need root
permission and to check capture unexpected signal.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/syscalls/sendmsg/sendmsg01.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

v2: added Cyril's suggestion: try ip and fallback to ifconfig if ip has failed.

diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index e1424ca..2a1b2c9 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -573,6 +573,9 @@ static void setup(void)
 {
 
 	int ret = 0;
+
+	tst_require_root(NULL);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
 	/* initialize sockaddr's */
@@ -586,13 +589,16 @@ static void setup(void)
 	strcpy(sun1.sun_path, tmpsunpath);
 
 	/* this test will fail or in some cases hang if no eth or lo is
-	 * configured, so making sure in setup that atleast lo is up
+	 * configured, so making sure in setup that at least lo is up
 	 */
-	ret = system("ifconfig lo up 127.0.0.1");
+	ret = system("ip link set lo up");
 	if (WEXITSTATUS(ret) != 0) {
-		tst_brkm(TBROK, cleanup,
-			 "ifconfig failed to bring up loop back device");
-		tst_exit();
+		ret = system("ifconfig lo up 127.0.0.1");
+		if (WEXITSTATUS(ret) != 0) {
+			tst_brkm(TBROK, cleanup,
+			    "ip/ifconfig failed to bring up loop back device");
+			tst_exit();
+		}
 	}
 
 	pid = start_server(&sin1, &sun1);
@@ -607,7 +613,6 @@ static void cleanup(void)
 	unlink(tmpsunpath);
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
 static void setup0(void)
-- 
1.7.11.7


------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
