Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YVI92-00049Y-3d
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 11:16:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVI8x-0007uP-NQ
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 11:16:16 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t2ABG5hU009197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Mar 2015 11:16:05 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t2ABG3QH011559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Mar 2015 11:16:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t2ABG32Q003466
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Mar 2015 11:16:03 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Mar 2015 14:18:29 +0300
Message-Id: <1425986309-12966-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] sctp/test_1_to_1_sockopt.c: set SO_SNDBUF above the
	defined minimum
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

SO_SNDBUF have the following minimum value:
TCP_SKB_MIN_TRUESIZE (2048 + sizeof(struct sk_buff))
SOCK_MIN_SNDBUF (TCP_SKB_MIN_TRUESIZE * 2)

The test set 'SO_SNDBUF' to 2048, then it gets the value back
with getsockopt(). But the value was defaulted in the kernel
to the SOCK_MIN_SNDBUF.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 utils/sctp/func_tests/test_1_to_1_sockopt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utils/sctp/func_tests/test_1_to_1_sockopt.c b/utils/sctp/func_tests/test_1_to_1_sockopt.c
index 4cd84da..436b344 100644
--- a/utils/sctp/func_tests/test_1_to_1_sockopt.c
+++ b/utils/sctp/func_tests/test_1_to_1_sockopt.c
@@ -340,7 +340,7 @@ main(void)
 			 "got value differs Set Value=%d Get Value=%d",
 			 (2*rcvbuf_val_set), rcvbuf_val_get);
 
-	sndbuf_val_set = 2048;
+	sndbuf_val_set = 5000;
 	/* TEST17: Test case for setsockopt SO_SNDBUF */
 	error = setsockopt(sk2, SOL_SOCKET, SO_SNDBUF, &sndbuf_val_set, len);
 	if (error < 0)
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
