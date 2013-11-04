Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VdCiE-0006Xz-Le
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 05:28:30 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdCiD-0004e5-Qo
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 05:28:30 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA45SNmm002793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 05:28:24 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA45SMbs001481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 05:28:23 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA45SMcp001476
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 05:28:22 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Mon,  4 Nov 2013 13:28:15 +0800
Message-Id: <1383542895-14069-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] sctp: enlarge SO_RCVBUF option value
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

When using setsockopt() with recent Linux kernels, it doesn't make sense to
use a value smaller than SOCK_MIN_RCVBUF/2 for SO_RCVBUF and expect getting
a SO_RCVBUF value by getsockopt() which is doubled.  See the following code
in linux/net/core/sock.c:

	if ((val * 2) < SOCK_MIN_RCVBUF)
		sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
	else
		sk->sk_rcvbuf = val * 2;
	break;

SOCK_MIN_RCVBUF is defined as (2048 + sizeof(struct sk_buff)) which is 2240.
---
 testcases/network/sctp/func_tests/test_1_to_1_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c b/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
index b12313b..c36f502 100644
--- a/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
+++ b/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
@@ -299,9 +299,9 @@ int main(void)
 	tst_resm(TPASS, "getsockopt() SCTP_STATUS - SUCCESS");
 
 	/* Reducing the SO_RCVBUF value using setsockopt() */
-	/*Minimum value is 128 and hence I am using it */
 	len = sizeof(int);
-	rcvbuf_val_set = 128;
+	/* (rcvbuf len)*2 should be no less than SOCK_MIN_RCVBUF in kernel */
+	rcvbuf_val_set = 1500;
 	/* TEST16: Test case for setsockopt SO_RCVBUF */
 	error = setsockopt(sk2, SOL_SOCKET, SO_RCVBUF, &rcvbuf_val_set, len);
 	if (error < 0)
-- 
1.8.1.2


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
