Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VdHBm-00062d-QU
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 10:15:18 +0000
Received: from lgeamrelo01.lge.com ([156.147.1.125])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdHBk-0008Ja-TT
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 10:15:18 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Mon, 4 Nov 2013 19:15:09 +0900
Message-ID: <028e01ced946$bdc140a0$3943c1e0$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] acct01: fix cleanup function
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

Currently, additional test for acct is done in cleanup.
This was not originally intended because TCONF case will also invoke cleanup
function to finish and it will finally goes to TBROK, not TCONF.
This patch removes the additional acct execution in cleanup.

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 testcases/kernel/syscalls/acct/acct01.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 0fe973b..53376ae 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -165,8 +165,5 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-	if (acct(NULL) == -1)
-		tst_resm(TBROK | TERRNO, "acct(NULL) failed");
-
 	tst_rmdir();
 }
-- 
1.7.9.5



------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
