Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TxJiU-0003DL-8h
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 15:55:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TxJiT-0005nt-1Y
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 15:55:22 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 21 Jan 2013 23:59:10 +0800
Message-Id: <4ef1b12514c08ad8ee67c571a9a9b79c8c184829.1358783800.git.zliu@redhat.com>
Subject: [LTP] [PATCH] syscalls/sendmsg01: using 'ip' command to replace
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
permission and checking capture unexpected signal.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/syscalls/sendmsg/sendmsg01.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index e1424ca..2376e3e 100644
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
@@ -586,12 +589,12 @@ static void setup(void)
 	strcpy(sun1.sun_path, tmpsunpath);
 
 	/* this test will fail or in some cases hang if no eth or lo is
-	 * configured, so making sure in setup that atleast lo is up
+	 * configured, so making sure in setup that at least lo is up
 	 */
-	ret = system("ifconfig lo up 127.0.0.1");
+	ret = system("ip link set lo up");
 	if (WEXITSTATUS(ret) != 0) {
 		tst_brkm(TBROK, cleanup,
-			 "ifconfig failed to bring up loop back device");
+			 "ip failed to bring up loop back device");
 		tst_exit();
 	}
 
@@ -607,7 +610,6 @@ static void cleanup(void)
 	unlink(tmpsunpath);
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
 static void setup0(void)
-- 
1.7.11.7


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
