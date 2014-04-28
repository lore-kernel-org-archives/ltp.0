Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WekfY-00081D-VM
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 12:28:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WekfX-00054w-1J
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 12:28:24 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3SCSEmL014487
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 20:28:15 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 28 Apr 2014 20:26:09 +0800
Message-ID: <1398687969-16853-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] kernel/mem/lib/mem.c: make tests continue to run
	even though KSM is not enabled
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

When kernel KSM configuration is not enabled, we make testcases continue to run
instead of returning TCONF, e.g. oom01. And if KSM configuration is not enabled, in
the original code, "tst_brkm(TCONF, NULL, ...)" will be called, in this case, we
will forget to execute the restore operations defined in cleanup, which will forget
to restore the /proc/sys/vm/overcommit_memory to 0, and this will impact other test
cases in LTP, for example, fork14 in RHEL5 will succeed unexpectedly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/lib/mem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 188a5ef..b975c62 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -146,11 +146,13 @@ void testoom(int mempolicy, int lite)
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, lite);
 
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
-
-	tst_resm(TINFO, "start OOM testing for KSM pages.");
-	oom(KSM, lite);
+	if (access(PATH_KSM, F_OK) == -1) {
+		tst_resm(TINFO, "KSM configuration is not enabled, "
+			 "skip OOM test for KSM pags");
+	} else {
+		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		oom(KSM, lite);
+	}
 }
 
 /* KSM */
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
