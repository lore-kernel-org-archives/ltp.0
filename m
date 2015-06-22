Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z73e9-0006LA-PV
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 15:28:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z73e7-0004Yu-S5
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 15:28:29 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5MFSLOW016060
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 15:28:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5MFSLuu003314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 15:28:21 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5MFRp9M005763
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 15:28:19 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Jun 2015 18:31:05 +0300
Message-Id: <1434987065-23739-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] sctp: sctputils.c: fix test_peer_addr()
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
Cc: vasily.isaenko@oracle.com

Test always fails with TBROK because inner loop will reset all the
previous set values if we use else branch.

Fixes 7cfe1586b8ed ("sctp: sctputil.c: make 'found' a static array")

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 utils/sctp/testlib/sctputil.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
index c678072..564925c 100644
--- a/utils/sctp/testlib/sctputil.c
+++ b/utils/sctp/testlib/sctputil.c
@@ -371,6 +371,7 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 	socklen_t addrs_size = 0;
 	void *addrbuf;
 	char found[count];
+	memset(found, 0, count);
 
 	error = sctp_getpaddrs(sk, asoc, &addrs);
 	if (-1 == error) {
@@ -404,8 +405,6 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 			if (cmp_addr((sockaddr_storage_t *)sa_addr,
 				     &peers[j]) == 0) {
 				found[j] = 1;
-			} else {
-				found[j] = 0;
 			}
 		}
 	}
-- 
1.7.1


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
