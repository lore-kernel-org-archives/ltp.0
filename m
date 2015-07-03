Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1ZArxL-0001Y6-7A
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:48:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZArxJ-0001w6-Dg
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:48:03 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQW01S907VTX990@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 12:47:53 +0900 (KST)
Date: Fri, 03 Jul 2015 03:47:53 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1089678615.223411435895273665.JavaMail.weblogic@ep2mlwas02a>
Subject: [LTP] [RESUBMIT PATCH 04/13] kernel/mq_timedreceive: use ARRAY_SIZE
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: PANKAJ MISHRA <pankaj.m@samsung.com>

use ARRAY_SIZE instead of sizeof(a)/sizeof(a[0])

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 945e2fa..b524e45 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -449,8 +449,7 @@ int main(int ac, char **av)
 			/*
 			 * Execute test
 			 */
-			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
-			     i++) {
+			for (i = 0; i < (int)ARRAY_SIZE(tcase); i++) {
 				int ret;
 				tst_resm(TINFO, "(case%02d) START", i);
 				ret = do_test(&tcase[i]);
-- 
1.7.9.5
------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
