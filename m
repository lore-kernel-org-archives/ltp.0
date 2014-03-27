Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnc-0005I9-6H
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnb-0005Fb-AS
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:52 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDuj9S012937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:45 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuiYv008659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:45 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuiZx008650
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:44 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:30 +0400
Message-Id: <1395928590-28408-8-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 7/7] rpc-tirpc: fix arguments to rpcb_set and
	rpcb_unset test cases
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

Both testcases utilise an unset variable - svcaddr.
It's incorrect.

Also added some simple checks of the transport creation.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c    |   13 ++++++++++---
 .../tirpc_rpcb_unset.c                             |   10 ++++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
index eb42618..f68b045 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
@@ -47,8 +47,6 @@ int main(int argn, char *argc[])
 	int progNum = atoi(argc[2]);
 	SVCXPRT *transp = NULL;
 	struct netconfig *nconf = NULL;
-	struct netbuf svcaddr;
-
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
@@ -57,8 +55,17 @@ int main(int argn, char *argc[])
 	}
 
 	transp = svc_tli_create(RPC_ANYFD, nconf, (struct t_bind *)NULL, 0, 0);
+	if (transp == NULL) {
+		printf("svc_tli_create() failed\n");
+		exit(1);
+	}
 
-	test_status = !rpcb_set(progNum, VERSNUM, nconf, &svcaddr);
+	test_status = !rpcb_set(progNum, VERSNUM, nconf, &(transp->xp_ltaddr));
+
+	if (!rpcb_unset(progNum, VERSNUM, nconf)) {
+		printf("rpcb_unset() failed\n");
+		exit(1);
+	}
 
 	printf("%d\n", test_status);
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
index adb951f..9e3d67f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
@@ -47,7 +47,6 @@ int main(int argn, char *argc[])
 	int progNum = atoi(argc[2]);
 	SVCXPRT *transp = NULL;
 	struct netconfig *nconf = NULL;
-	struct netbuf svcaddr;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
@@ -56,8 +55,15 @@ int main(int argn, char *argc[])
 	}
 
 	transp = svc_tli_create(RPC_ANYFD, nconf, (struct t_bind *)NULL, 0, 0);
+	if (transp == NULL) {
+		printf("svc_tli_create() failed\n");
+		exit(1);
+	}
 
-	rpcb_set(progNum, VERSNUM, nconf, &svcaddr);
+	if (!rpcb_set(progNum, VERSNUM, nconf, &(transp->xp_ltaddr))) {
+		printf("rpcb_set() failed\n");
+		exit(1);
+	}
 
 	test_status = !rpcb_unset(progNum, VERSNUM, nconf);
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
