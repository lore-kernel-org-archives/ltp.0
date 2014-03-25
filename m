Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSIB-00027x-M8
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:27 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSIA-00013n-Rk
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:27 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPKND006676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:21 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPJGN005325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:19 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPJNE018219
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:19 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:37 +0400
Message-Id: <1395757480-27424-12-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 11/14] rpc-tirpc: fixes for the rpc_svc_getargs,
	rpc_svc_sendreply binaries
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

These tests originally had this logic:
1) start server
2) start client
3) check the exit code of rpc_svc_getargs (the server terminates)

This is not 100% suitable for the new wrapper, because
we only look for the client exit code, ignoring the server one.

This patch makes the client exit code to represent the entire test status.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/rpc_tests                                  |    5 ++---
 .../rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c  |    1 -
 .../rpc_svc_getargs_client.c                       |   10 ++++++----
 .../rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c  |    1 -
 .../rpc_svc_sendreply_client.c                     |    8 ++++++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/runtest/rpc_tests b/runtest/rpc_tests
index dcb2bcb..84c2960 100644
--- a/runtest/rpc_tests
+++ b/runtest/rpc_tests
@@ -51,6 +51,5 @@ rpc_clnt_geterr rpc_test.sh -s rpc_svc_1 -c rpc_clnt_geterr
 rpc_clnt_control rpc_test.sh -s rpc_svc_1 -c rpc_clnt_control
 rpc_svc_getcaller rpc_test.sh -s rpc_svc_1 -c rpc_svc_getcaller
 rpc_svc_freeargs rpc_test.sh -s rpc_svc_1 -c rpc_svc_freeargs
-#TODO 
-#rpc_svc_getargs
-#rpc_svc_sendreply
+rpc_svc_getargs rpc_test.sh -s rpc_svc_getargs -c rpc_svc_getargs_client
+rpc_svc_sendreply rpc_test.sh -s rpc_svc_sendreply -c rpc_svc_sendreply_client
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
index 4743a1c..c5bbafb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
@@ -134,5 +134,4 @@ void rcp_service(register struct svc_req *rqstp, register SVCXPRT * transp)
 	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
-	exit(test_status);
 }
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_client.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_client.c
index 9811ef2..df0a28c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_client.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_client.c
@@ -48,6 +48,7 @@ int main(int argn, char *argc[])
 	int progNum = atoi(argc[2]);
 	enum clnt_stat cs;
 	int varSnd = 1;
+	int varRcv = 0;
 
 	//Initialization
 	if (run_mode == 1) {
@@ -56,16 +57,17 @@ int main(int argn, char *argc[])
 
 	cs = callrpc(argc[1], progNum, VERSNUM, PROCNUM,
 		     (xdrproc_t) xdr_int, (char *)&varSnd,
-		     (xdrproc_t) xdr_int, (char *)&varSnd);
-
-	//test_status = varSnd;
+		     (xdrproc_t) xdr_int, (char *)&varRcv);
 
 	if (cs != RPC_SUCCESS)
 		clnt_perrno(cs);
 
+	if (varSnd == varRcv)
+		test_status = 0;
+
 	//This last printf gives the result status to the tests suite
 	//normally should be 0: test has passed or 1: test has failed
 	//printf("%d\n", test_status);
 
-	return 0;		//test_status;
+	return test_status;
 }
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
index e827989..6e87e13 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
@@ -134,5 +134,4 @@ void rcp_service(register struct svc_req *rqstp, register SVCXPRT * transp)
 	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
-	exit(test_status);
 }
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply_client.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply_client.c
index 9811ef2..f94edcd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply_client.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply_client.c
@@ -48,6 +48,7 @@ int main(int argn, char *argc[])
 	int progNum = atoi(argc[2]);
 	enum clnt_stat cs;
 	int varSnd = 1;
+	int varRcv = 0;
 
 	//Initialization
 	if (run_mode == 1) {
@@ -56,16 +57,19 @@ int main(int argn, char *argc[])
 
 	cs = callrpc(argc[1], progNum, VERSNUM, PROCNUM,
 		     (xdrproc_t) xdr_int, (char *)&varSnd,
-		     (xdrproc_t) xdr_int, (char *)&varSnd);
+		     (xdrproc_t) xdr_int, (char *)&varRcv);
 
 	//test_status = varSnd;
 
 	if (cs != RPC_SUCCESS)
 		clnt_perrno(cs);
 
+	if (varSnd == varRcv)
+		test_status = 0;
+
 	//This last printf gives the result status to the tests suite
 	//normally should be 0: test has passed or 1: test has failed
 	//printf("%d\n", test_status);
 
-	return 0;		//test_status;
+	return test_status;
 }
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
