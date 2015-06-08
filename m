Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Z1oEQ-0002iw-BD
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 04:00:14 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z1oEO-0000Z6-BV
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 04:00:14 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPL00RKHXS4D8A0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 13:00:04 +0900 (KST)
Date: Mon, 08 Jun 2015 04:00:04 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <96265675.666421433736004552.JavaMail.weblogic@epmlwas09a>
Subject: [LTP]  [PATCH]: Fix memory leak
Reply-To: manjeet.p@samsung.com
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, akhilesh.k@samsung.com

From: Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] utils/sctp/testlib/sctputil.c: Fix memory leak

This patch frees the allocated memory (used for checking peer addresses) before returning from function.

Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 utils/sctp/testlib/sctputil.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
index c670af6..283b5a7 100644
--- a/utils/sctp/testlib/sctputil.c
+++ b/utils/sctp/testlib/sctputil.c
@@ -376,6 +376,7 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 	error = sctp_getpaddrs(sk, asoc, &addrs);
 	if (-1 == error) {
 		tst_brkm(TBROK, tst_exit, "sctp_getpaddrs: %s", strerror(errno));
+		free(found);
 		return error;
 	}
 	if (error != count) {
@@ -399,6 +400,7 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 			errno = EINVAL;
 			sctp_freepaddrs(addrs);
 			tst_brkm(TBROK, tst_exit, "sctp_getpaddrs: %s", strerror(errno));
+			free(found);
 			return -1;
 		}
 		for (j = 0; j < count; j++) {
@@ -414,5 +416,6 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 		}
 	}
 	sctp_freepaddrs(addrs);
+	free(found);
 	return 0;
 }
-- 
1.7.1

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
