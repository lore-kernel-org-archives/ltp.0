Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSIC-0007wj-AP
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSIB-00013s-Er
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:28 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPLUD031079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:22 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPKg2015457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:21 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPKVH018272
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:20 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:38 +0400
Message-Id: <1395757480-27424-13-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 12/14] rpc-tirpc: fixed timeout values for some of
	the tirpc tests
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

The same way as it was done for the rpc tests.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c  |    4 ++--
 .../tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c  |    4 ++--
 .../tirpc_svcerr_progvers.c                        |    4 ++--
 .../tirpc_svcerr_systemerr.c                       |    4 ++--
 .../tirpc_svcerr_weakauth.c                        |    4 ++--
 .../tirpc_expertlevel_clnt_call.c                  |    4 ++--
 .../tirpc_rpcb_rmtcall.c                           |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
index 6076395..3273a1c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc.c
@@ -67,8 +67,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
index 8666ca7..99960b5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog.c
@@ -67,8 +67,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
index c272c4c..095fdb3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers.c
@@ -67,8 +67,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
index 8db8d77..6df46f7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr.c
@@ -67,8 +67,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
index ae08509..563c672 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth.c
@@ -67,8 +67,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
index 5796900..8a2e4ed 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call.c
@@ -68,8 +68,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
index 6d4af68..4409115 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
@@ -68,8 +68,8 @@ int main(int argn, char *argc[])
 		printf("nconf : %d\n", nconf);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
