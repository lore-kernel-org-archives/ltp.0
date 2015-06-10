Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a4y-0004CB-9M
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:05:40 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a4w-0005cM-Io
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:05:40 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP027E7VP7E120@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:05:31 +0900 (KST)
Date: Wed, 10 Jun 2015 07:05:31 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1556567987.810641433919931262.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 5/8] network/ns-igmp_querier.c: remove explicit NULL
 check before free
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

No need of NULL check before free

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 .../network/stress/ns-tools/ns-igmp_querier.c      |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/ns-tools/ns-igmp_querier.c b/testcases/network/stress/ns-tools/ns-igmp_querier.c
index 933c1da..fad84d8 100644
--- a/testcases/network/stress/ns-tools/ns-igmp_querier.c
+++ b/testcases/network/stress/ns-tools/ns-igmp_querier.c
@@ -334,10 +334,8 @@ void parse_options(int argc, char *argv[], struct igmp_info *info_p, int *bg_p)
 	if ((info_p->query = create_query(max_resp, maddr, saddrs)) == NULL)
 		usage(program_name, EXIT_FAILURE);
 
-	if (maddr)
-		free(maddr);
-	if (saddrs)
-		free(saddrs);
+	free(maddr);
+	free(saddrs);
 }
 
 /*
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
