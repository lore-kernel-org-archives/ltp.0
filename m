Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnc-0008EE-Py
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:52 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAna-0005FX-S7
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:52 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDuibE020195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:45 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuhw1014021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:44 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuhLt008606
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:43 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:29 +0400
Message-Id: <1395928590-28408-7-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 6/7] rpc-tirpc: tirpc_rpcb_set and tirpc_rpcb_unset
	cleanup
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
 .../tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c    |   22 ++++--------------
 .../tirpc_rpcb_unset.c                             |   23 ++++---------------
 2 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
index 4b60586..eb42618 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set.c
@@ -33,35 +33,25 @@
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
 	SVCXPRT *transp = NULL;
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 
-	//Initialization
-	if (run_mode) {
-		printf("Before creation\n");
-		printf("nconf : %d\n", nconf);
-	}
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-		//syslog(LOG_ERR, "getnetconfigent for udp failed");
 		printf("err nconf\n");
 		exit(1);
 	}
@@ -70,8 +60,6 @@ int main(int argn, char *argc[])
 
 	test_status = !rpcb_set(progNum, VERSNUM, nconf, &svcaddr);
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
index 75155cf..adb951f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset.c
@@ -33,35 +33,24 @@
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
 	SVCXPRT *transp = NULL;
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 
-	//Initialization
-	if (run_mode) {
-		printf("Before creation\n");
-		printf("nconf : %d\n", nconf);
-	}
-
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
-		//syslog(LOG_ERR, "getnetconfigent for udp failed");
 		printf("err nconf\n");
 		exit(1);
 	}
@@ -72,8 +61,6 @@ int main(int argn, char *argc[])
 
 	test_status = !rpcb_unset(progNum, VERSNUM, nconf);
 
-	//This last printf gives the result status to the tests suite
-	//normally should be 0: test has passed or 1: test has failed
 	printf("%d\n", test_status);
 
 	return test_status;
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
