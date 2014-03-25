Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI9-0003hq-Lm
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:25 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI8-0005wO-PN
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:25 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPIUG031007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:19 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2PEPI4E006830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:18 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPHvJ018175
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:17 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:36 +0400
Message-Id: <1395757480-27424-11-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 10/14] rpc-tirpc: increased the timeout value for
	the rpc test cases
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

The modified binaries use a low value for timeout - 100 ms.
Because of this in my environment these test cases fail.

I think it's not a problem if we just increase the timeout to 1 sec.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc_pmap_rmtcall.c                             |    4 ++--
 .../rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c      |    4 ++--
 .../rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c  |    4 ++--
 .../rpc_err_svcerr_progvers/rpc_svcerr_progvers.c  |    4 ++--
 .../rpc_svcerr_systemerr.c                         |    4 ++--
 .../rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c  |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
index 26e2995..0fe8668 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
@@ -68,8 +68,8 @@ int main(int argn, char *argc[])
 	sin.sin_addr.s_addr = *(u_int *) hp->h_addr;
 	port = pmap_getport(&sin, progNum, VERSNUM, IPPROTO_UDP);
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	if (run_mode) {
 		printf("port : %d\n", port);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
index 27e5cd7..a6b0b9d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
@@ -58,8 +58,8 @@ int main(int argn, char *argc[])
 		printf("client : %d\n", client);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call AuthErr RP */
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
index ab1c058..a094ecb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
@@ -61,8 +61,8 @@ int main(int argn, char *argc[])
 		printf("client : %d\n", client);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
index fa57f7d..b3d21cd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
@@ -58,8 +58,8 @@ int main(int argn, char *argc[])
 		printf("client : %d\n", client);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call wrong version RP */
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
index 4a6a039..219c6e7 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
@@ -58,8 +58,8 @@ int main(int argn, char *argc[])
 		printf("client : %d\n", client);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call SysErr RP */
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
index f8a1e08..e4b0106 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
@@ -58,8 +58,8 @@ int main(int argn, char *argc[])
 		printf("client : %d\n", client);
 	}
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call WeakAuthErr RP */
 
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
