Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a5n-0004Ns-Sg
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:06:31 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a5m-0003l2-56
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:06:31 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP014KIVQM7MB0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:06:22 +0900 (KST)
Date: Wed, 10 Jun 2015 07:06:09 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1545775498.810721433919969319.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 6/8] network/ns-mcast_receiver.c: remove explicit NULL
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
 .../network/stress/ns-tools/ns-mcast_receiver.c    |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/network/stress/ns-tools/ns-mcast_receiver.c b/testcases/network/stress/ns-tools/ns-mcast_receiver.c
index ab5224b..ba065d3 100644
--- a/testcases/network/stress/ns-tools/ns-mcast_receiver.c
+++ b/testcases/network/stress/ns-tools/ns-mcast_receiver.c
@@ -282,12 +282,9 @@ parse_options(int argc, char *argv[], struct mcast_rcv_info *info_p, int *bg_p)
 					 saddrs);
 	}
 
-	if (maddr)
-		free(maddr);
-	if (saddrs)
-		free(saddrs);
-	if (portnum)
-		free(portnum);
+	free(maddr);
+	free(saddrs);
+	free(portnum);
 }
 
 /*
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
