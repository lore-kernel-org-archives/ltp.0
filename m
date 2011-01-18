Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pf6LP-0004Ba-TT
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 07:51:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf6LN-0003SH-SJ
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 07:51:11 +0000
Message-ID: <4D35466D.60000@cn.fujitsu.com>
Date: Tue, 18 Jan 2011 15:51:09 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] float_bessel: fix error of infinite loop
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
To: yanegomi@gmail.com, ltp-list@lists.sourceforge.net

Hi Garrett,

exit() should be modified to tst_exit() in function myexit().

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/misc/math/float/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
index 18757e7..8998c33 100644
--- a/testcases/misc/math/float/main.c
+++ b/testcases/misc/math/float/main.c
@@ -42,7 +42,7 @@ myexit (int x)
 		tst_resm (TFAIL, "Test failed");
 	else
 		tst_resm (TPASS, "Test passed");
-	exit(0);
+	tst_exit();
 }
 
 TH_DATA *pcom;
@@ -428,4 +428,4 @@ static void sys_error(const char *msg, int line)
 
 	sprintf(syserr_msg, "%s: %s", msg, strerror(errno));
 	error(syserr_msg, line);
-}
\ No newline at end of file
+}
-- 
1.7.0.4

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
