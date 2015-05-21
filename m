Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YvJC6-0003TK-Mp
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 05:38:58 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvJC4-0005hB-Ja
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 05:38:58 +0000
Message-ID: <1432186777.16347.56.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 May 2015 13:39:37 +0800
In-Reply-To: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fallocate04: Use tst_kvercmp after lseek(SEEK_HOLE)
 return EINVAL
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net, vasily.isaenko@oracle.com

SEEK_HOLE is only supported since version 3.1. Just print some
information to remind users if kernel is before 3.1, if not print
'TBROK' and quit, instead of 'TWARN'.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 911bbe8..0c904a0 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -158,9 +158,15 @@ static void test02(void)
 			tst_brkm(TFAIL | TERRNO, cleanup,
 				 "fallocate() or lseek() failed");
 		}
-		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
+		if (tst_kvercmp(3, 1, 0) < 0)
+			tst_resm(TINFO, "lseek() doesn't support SEEK_HOLE, "
+				 "this is expected for < 3.1 kernels");
+		else
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "lseek() doesn't support SEEK_HOLE");
+	} else {
+		tst_resm(TINFO, "found a hole at '%ld' offset", ret);
 	}
-	tst_resm(TINFO, "found a hole at '%ld' offset", ret);
 
 	size_t alloc_size1 = get_allocsize();
 
-- 
1.9.3




------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
