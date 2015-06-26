Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SQ1-00085z-9j
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:07:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SPz-0008Sc-6t
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:07:41 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ00HEJWCJQB40@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:07:31 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:43 +0530
Message-id: <1435320294-45783-3-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 02/13] kernel/fsstress: use ARRAY_SIZE
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
To: ltp-list@lists.sourceforge.net
Cc: pankaj.m@samsung.com

Adding ARRAY_SIZE macro, adding compiler.h,
As it fails to get defination of ARRAY_SIZE.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 07158ac..2f89903 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -32,6 +32,7 @@
 
 #include "config.h"
 #include "global.h"
+#include <compiler.h>
 #ifdef HAVE_SYS_PRCTL_H
 # include <sys/prctl.h>
 #endif
@@ -311,7 +312,7 @@ int main(int argc, char **argv)
 
 	errrange = errtag = 0;
 	umask(0);
-	nops = sizeof(ops) / sizeof(ops[0]);
+	nops = ARRAY_SIZE(ops);
 	ops_end = &ops[nops];
 	myprog = argv[0];
 	while ((c = getopt(argc, argv, "cd:e:f:i:l:n:p:rs:vwzHSX")) != -1) {
@@ -1066,7 +1067,7 @@ void namerandpad(int id, char *buf, int i)
 
 	if (namerand == 0)
 		return;
-	bucket = (id ^ namerand) % (sizeof(buckets) / sizeof(buckets[0]));
+	bucket = (id ^ namerand) % ARRAY_SIZE(buckets);
 	padmod = buckets[bucket] + 1 - i;
 	if (padmod <= 0)
 		return;
@@ -1548,7 +1549,7 @@ void attr_set_f(int opno, long r)
 	if (!get_fname(FT_ANYm, r, &f, NULL, NULL, &v))
 		append_pathname(&f, ".");
 	sprintf(aname, "a%x", nameseq++);
-	li = (int)(random() % (sizeof(lengths) / sizeof(lengths[0])));
+	li = (int)(random() % ARRAY_SIZE(lengths));
 	len = (int)(random() % lengths[li]);
 	if (len == 0)
 		len = 1;
-- 
1.7.9.5


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
