Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnm-0008Fk-1N
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:57:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnW-0007gR-L5
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:57:02 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDuefW012840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:41 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuewC008491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:40 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuddk005457
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:39 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:26 +0400
Message-Id: <1395928590-28408-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/7] rpc-tirpc: cleanup of the "bottom level" TI-RPC
	test binaries
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../tirpc_bottomlevel_clnt_call.c                  |   34 +++---------------
 .../tirpc_clnt_dg_create.c                         |   37 +++----------------
 .../tirpc_clnt_vc_create.c                         |   33 +++--------------
 .../tirpc_svc_dg_create.c                          |   15 +-------
 .../tirpc_svc_vc_create.c                          |   15 +-------
 .../rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c |   30 +++-------------
 6 files changed, 27 insertions(+), 137 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
index 98450f3..2498965 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
@@ -33,24 +33,18 @@
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
 
-//Standard define
 #define PROCNUM 1
 #define VERSNUM 1
-
-//Sys define
 #define ADDRBUFSIZE 100
 
 int main(int argn, char *argc[])
 {
-	//Program parameters : argc[1] : HostName or Host IP
-	//                                         argc[2] : Server Program Number
-	//                                         other arguments depend on test case
+	/*
+	 * argc[1] - HostName or Host IP
+	 * argc[2] - Server Program Number
+	 */
 
-	//run_mode can switch into stand alone program or program launch by shell script
-	//1 : stand alone, debug mode, more screen information
-	//0 : launch by shell script as test case, only one printf -> result status
-	int run_mode = 0;
-	int test_status = 1;	//Default test result set to FAILED
+	int test_status = 1;
 	int progNum = atoi(argc[2]);
 	CLIENT *client = NULL;
 	struct netconfig *nconf = NULL;
@@ -61,19 +55,11 @@ int main(int argn, char *argc[])
 	int var_rec = -1;
 	struct timeval tv;
 
-	//Initialization
-	if (run_mode) {
-		printf("Before creation\n");
-		printf("client : %d\n", client);
-		printf("nconf : %d\n", nconf);
-	}
-
 	tv.tv_sec = 0;
 	tv.tv_usec = 100;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-		//syslog(LOG_ERR, "getnetconfigent for udp failed");
 		fprintf(stderr, "err nconf\n");
 		printf("5\n");
 		exit(1);
@@ -83,19 +69,11 @@ int main(int argn, char *argc[])
 	svcaddr.maxlen = ADDRBUFSIZE;
 	svcaddr.buf = addrbuf;
 
-	if (svcaddr.buf == NULL) {
-		/* if malloc() failed, print error messages and exit */
-		printf("5\n");
-		exit(1);
-	}
-	//printf("svcaddr reserved (%s)\n", argc[1]);
-
 	if (!rpcb_getaddr(progNum, VERSNUM, nconf, &svcaddr, argc[1])) {
 		fprintf(stderr, "rpcb_getaddr failed!!\n");
 		printf("5\n");
 		exit(1);
 	}
-	//printf("svc get\n");
 
 	client = clnt_dg_create(RPC_ANYFD, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
@@ -112,8 +90,6 @@ int main(int argn, char *argc[])
 
 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	clnt_destroy(client);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
index 6031d9b..88a86f8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
@@ -33,41 +33,26 @@
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
 
-//Standard define
 #define PROCNUM 1
 #define VERSNUM 1
-
-//Sys define
 #define ADDRBUFSIZE 100
 
 int main(int argn, char *argc[])
 {
-	//Program parameters : argc[1] : HostName or Host IP
-	//                                         argc[2] : Server Program Number
-	//                                         other arguments depend on test case
+	/*
+	 * argc[1] - HostName or Host IP
+	 * argc[2] - Server Program Number
+	 */
 
-	//run_mode can switch into stand alone program or program launch by shell script
-	//1 : stand alone, debug mode, more screen information
-	//0 : launch by shell script as test case, only one printf -> result status
-	int run_mode = 0;
-	int test_status = 1;	//Default test result set to FAILED
+	int test_status = 1;
 	int progNum = atoi(argc[2]);
 	CLIENT *client = NULL;
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 	char addrbuf[ADDRBUFSIZE];
-	bool_t rpcb_rslt;
-
-	//Initialization
-	if (run_mode) {
-		printf("Before creation\n");
-		printf("client : %d\n", client);
-		printf("nconf : %d\n", nconf);
-	}
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-		//syslog(LOG_ERR, "getnetconfigent for udp failed");
 		fprintf(stderr, "err nconf\n");
 		printf("5\n");
 		exit(1);
@@ -77,26 +62,16 @@ int main(int argn, char *argc[])
 	svcaddr.maxlen = ADDRBUFSIZE;
 	svcaddr.buf = addrbuf;
 
-	if (svcaddr.buf == NULL) {
-		/* if malloc() failed, print error messages and exit */
-		printf("5\n");
-		return 1;
-	}
-	//printf("svcaddr reserved (%s)\n", argc[1]);
-
 	if (!rpcb_getaddr(progNum, VERSNUM, nconf, &svcaddr, argc[1])) {
 		fprintf(stderr, "rpcb_getaddr failed!!\n");
 		printf("5\n");
 		exit(1);
 	}
-	//printf("svc get\n");
 
 	client = clnt_dg_create(RPC_ANYFD, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
-	/**/ test_status = ((CLIENT *) client != NULL) ? 0 : 1;
+	test_status = ((CLIENT *) client != NULL) ? 0 : 1;
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
index 855359a..e547f1f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
@@ -42,32 +42,20 @@
 
 int main(int argn, char *argc[])
 {
-	//Program parameters : argc[1] : HostName or Host IP
-	//                                         argc[2] : Server Program Number
-	//                                         other arguments depend on test case
+	/*
+	 * argc[1] - HostName or Host IP
+	 * argc[2] - Server Program Number
+	 */
 
-	//run_mode can switch into stand alone program or program launch by shell script
-	//1 : stand alone, debug mode, more screen information
-	//0 : launch by shell script as test case, only one printf -> result status
-	int run_mode = 0;
-	int test_status = 1;	//Default test result set to FAILED
+	int test_status = 1;
 	int progNum = atoi(argc[2]);
 	CLIENT *client = NULL;
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 	char addrbuf[ADDRBUFSIZE];
-	bool_t rpcb_rslt;
-
-	//Initialization
-	if (run_mode) {
-		printf("Before creation\n");
-		printf("client : %d\n", client);
-		printf("nconf : %d\n", nconf);
-	}
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-		//syslog(LOG_ERR, "getnetconfigent for udp failed");
 		printf("err nconf\n");
 		exit(1);
 	}
@@ -76,24 +64,15 @@ int main(int argn, char *argc[])
 	svcaddr.maxlen = ADDRBUFSIZE;
 	svcaddr.buf = addrbuf;
 
-	if (svcaddr.buf == NULL) {
-		/* if malloc() failed, print error messages and exit */
-		return 1;
-	}
-	//printf("svcaddr reserved (%s)\n", argc[1]);
-
 	if (!rpcb_getaddr(progNum, VERSNUM, nconf, &svcaddr, argc[1])) {
 		fprintf(stderr, "rpcb_getaddr failed!!\n");
 		exit(1);
 	}
-	//printf("svc get\n");
 
 	client = clnt_vc_create(RPC_ANYFD, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
-	/**/ test_status = ((CLIENT *) client != NULL) ? 0 : 1;
+	test_status = ((CLIENT *) client != NULL) ? 0 : 1;
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
index 4ac17de..8f1953e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
@@ -33,28 +33,17 @@
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
 
-//Standard define
 #define PROCNUM 1
 #define VERSNUM 1
 
 int main(int argn, char *argc[])
 {
-	//Program parameters : argc[1] : HostName or Host IP
-	//                                         argc[2] : Server Program Number
-	//                                         other arguments depend on test case
-
-	//run_mode can switch into stand alone program or program launch by shell script
-	//1 : stand alone, debug mode, more screen information
-	//0 : launch by shell script as test case, only one printf -> result status
-	int run_mode = 0;
-	int test_status = 1;	//Default test result set to FAILED
+	int test_status = 1;
 	SVCXPRT *transp = NULL;
 
 	transp = svc_dg_create(RPC_ANYFD, 0, 0);
-	/**/ test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
+	test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
index ae83ee1..4245586 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
@@ -33,28 +33,17 @@
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
 
-//Standard define
 #define PROCNUM 1
 #define VERSNUM 1
 
 int main(int argn, char *argc[])
 {
-	//Program parameters : argc[1] : HostName or Host IP
-	//                                         argc[2] : Server Program Number
-	//                                         other arguments depend on test case
-
-	//run_mode can switch into stand alone program or program launch by shell script
-	//1 : stand alone, debug mode, more screen information
-	//0 : launch by shell script as test case, only one printf -> result status
-	int run_mode = 0;
-	int test_status = 1;	//Default test result set to FAILED
+	int test_status = 1;
 	SVCXPRT *transp = NULL;
 
 	transp = svc_vc_create(RPC_ANYFD, 0, 0);
-	/**/ test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
+	test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
index cfab9b2..d75e2eb 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
@@ -35,27 +35,17 @@
 #include <errno.h>
 #include <netinet/in.h>
 
-//Standard define
 #define VERSNUM 1
 #define PROCSIMPLEPING	1
 
-static void exm_proc();
+static void exm_proc(struct svc_req *rqstp, SVCXPRT *transp);
 
-//****************************************//
-//***           Main Function          ***//
-//****************************************//
 int main(int argn, char *argc[])
 {
-	//Server parameter is : argc[1] : Server Program Number
-	//                                          others arguments depend on server program
-	int run_mode = 0;
 	int progNum = atoi(argc[1]);
-	bool_t rslt;
 	SVCXPRT *transp = NULL;
 	struct netconfig *nconf;
-	struct netbuf svcaddr;
 
-	//Initialization
 	svc_unreg(progNum, VERSNUM);
 
 	if ((nconf = getnetconfigent("udp")) == NULL) {
@@ -83,37 +73,29 @@ int main(int argn, char *argc[])
 	return 1;
 }
 
-//****************************************//
-//***        Remotes Procedures        ***//
-//****************************************//
+/* Remote Procedures */
 char *simplePing(char *in)
 {
-	//printf("*** in Ping Func.\n");
-	//Simple function, returns what received
 	static int result = 0;
 	result = *in;
 	return (char *)&result;
 }
 
-//****************************************//
-//***       Dispatch Function          ***//
-//****************************************//
-static void exm_proc(struct svc_req *rqstp, SVCXPRT * transp)
+/* Dispatch Function */
+static void exm_proc(struct svc_req *rqstp, SVCXPRT *transp)
 {
-	//printf("* in Dispatch Func.\n");
 	union {
 		int varIn;
 	} argument;
 
 	char *result;
-	xdrproc_t xdr_argument;
-	xdrproc_t xdr_result;
+	xdrproc_t xdr_argument = NULL;
+	xdrproc_t xdr_result = NULL;
 	char *(*proc) (char *);
 
 	switch (rqstp->rq_proc) {
 	case PROCSIMPLEPING:
 		{
-			//printf("** in PROCPONG dispatch Func.\n");
 			xdr_argument = (xdrproc_t) xdr_int;
 			xdr_result = (xdrproc_t) xdr_int;
 			proc = (char *(*)(char *))simplePing;
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
