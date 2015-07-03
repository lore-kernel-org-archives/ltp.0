Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1ZAryS-0004Dn-7u
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:49:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZAryQ-00014K-4E
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:49:12 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQW011EW7XQB780@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 12:49:02 +0900 (KST)
Date: Fri, 03 Jul 2015 03:49:02 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1367763050.223491435895342430.JavaMail.weblogic@ep2mlwas02a>
Subject: [LTP] [RESUBMIT PATCH 08/13] kernel/mq_timedsend: use ARRAY_SIZE
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
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 5b1cd53..53190d7 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -452,8 +452,7 @@ int main(int ac, char **av)
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
