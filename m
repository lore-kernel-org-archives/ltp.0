Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pii8o-0004OV-4j
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 06:49:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pii8m-0006Hz-AG
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 06:49:06 +0000
Message-ID: <4D4266E2.9070001@cn.fujitsu.com>
Date: Fri, 28 Jan 2011 14:49:06 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] sigrelse01.c: cleanup() should be called only once
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

cleanup() call the function tst_rmdir() to remove the temporary
directory, so cleanup() should be called only once.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sigrelse/sigrelse01.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 0d0e12b..da612df 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -373,9 +373,6 @@ static void parent()
 		tst_resm(TBROK, "Unexpected exit code %d from child", rv);
 		break;
 	}
-
-	cleanup();
-
 }				/* end of parent */
 
 /****************************************************************************
@@ -797,8 +794,7 @@ void setup()
 
 	/* set up pipe for parent/child communications */
 	if (pipe(pipe_fd) < 0) {
-		tst_resm(TBROK|TERRNO, "pipe() failed");
-		cleanup();
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe() failed");
 	}
 
 	/*
@@ -812,8 +808,7 @@ void setup()
 
 	/* set up pipe for parent/child communications */
 	if (pipe(pipe_fd2) < 0) {
-		tst_resm(TBROK|TERRNO, "pipe() failed");
-		cleanup();
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe() failed");
 	}
 
 	/*
@@ -840,4 +835,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
-- 
1.7.0.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
