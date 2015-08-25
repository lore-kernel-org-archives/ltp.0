Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZU9u5-00062B-7r
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 08:48:25 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZU9u3-0008Ek-2g
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 08:48:25 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t7P8mG53019796
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2015 08:48:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t7P8mG5c011248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2015 08:48:16 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7P8mG7B021948
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2015 08:48:16 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 25 Aug 2015 11:51:54 +0300
Message-Id: <1440492714-3600-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/tcp_fastopen: fix typo in check_opt() and
	check_opt_l()
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index 6c0d7b8..08a6019 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -669,7 +669,7 @@ static void check_opt(const char *name, char *arg, int *val, int lim)
 		if (sscanf(arg, "%i", val) != 1)
 			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
 				 name);
-		if (clients_num < lim)
+		if (*val < lim)
 			tst_brkm(TBROK, NULL, "-%s option arg is less than %d",
 				name, lim);
 	}
@@ -681,7 +681,7 @@ static void check_opt_l(const char *name, char *arg, long *val, long lim)
 		if (sscanf(arg, "%ld", val) != 1)
 			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
 				 name);
-		if (clients_num < lim)
+		if (*val < lim)
 			tst_brkm(TBROK, NULL, "-%s option arg is less than %ld",
 				name, lim);
 	}
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
