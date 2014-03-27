Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnY-0008Dr-R5
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:48 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnX-0005FS-QJ
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:48 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDufnb012855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:42 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDufNg005514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:41 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDufgF005506
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:41 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:27 +0400
Message-Id: <1395928590-28408-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/7] rpc-tirpc: the "bottom level" fixes
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

The functions from the "bottom level" TI-RPC API:
 * svc_dg_create
 * svc_vc_create
 * clnt_dg_create
 * clnt_vc_create
do not accept RPC_ANYFD parameter. This parameter is for the "expert level" API.

These functions should be passed with a bound socket.

Implemented it using bound_socket() function.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../tirpc_bottomlevel_clnt_call.c                  |   18 ++++++++++++++--
 .../tirpc_clnt_dg_create.c                         |   16 ++++++++++++++-
 .../tirpc_clnt_vc_create.c                         |   18 +++++++++++++++-
 .../tirpc_svc_dg_create.c                          |   16 ++++++++++++++-
 .../tirpc_svc_vc_create.c                          |   21 +++++++++++++++++++-
 5 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
index 2498965..28d14ff 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
@@ -32,6 +32,8 @@
 #include <netinet/in.h>
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
@@ -54,9 +56,10 @@ int main(int argn, char *argc[])
 	int var_snd = 10;
 	int var_rec = -1;
 	struct timeval tv;
+	int sock;
 
-	tv.tv_sec = 0;
-	tv.tv_usec = 100;
+	tv.tv_sec = 1;
+	tv.tv_usec = 0;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
@@ -75,12 +78,19 @@ int main(int argn, char *argc[])
 		exit(1);
 	}
 
-	client = clnt_dg_create(RPC_ANYFD, &svcaddr,
+	sock = bound_socket(AF_INET, SOCK_DGRAM);
+	if (sock < 0) {
+		perror("bound_socket() failed");
+		exit(1);
+	}
+
+	client = clnt_dg_create(sock, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
 
 	if (client == NULL) {
 		clnt_pcreateerror("ERR");
 		printf("5\n");
+		close(sock);
 		exit(1);
 	}
 
@@ -94,5 +104,7 @@ int main(int argn, char *argc[])
 
 	clnt_destroy(client);
 
+	close(sock);
+
 	return test_status;
 }
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
index 88a86f8..b38bc9e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create.c
@@ -32,6 +32,8 @@
 #include <netinet/in.h>
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
@@ -50,6 +52,7 @@ int main(int argn, char *argc[])
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 	char addrbuf[ADDRBUFSIZE];
+	int sock;
 
 	nconf = getnetconfigent("udp");
 	if (nconf == (struct netconfig *)NULL) {
@@ -68,10 +71,21 @@ int main(int argn, char *argc[])
 		exit(1);
 	}
 
-	client = clnt_dg_create(RPC_ANYFD, &svcaddr,
+	sock = bound_socket(AF_INET, SOCK_DGRAM);
+	if (sock < 0) {
+		perror("bound_socket() failed");
+		exit(1);
+	}
+
+	client = clnt_dg_create(sock, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
 	test_status = ((CLIENT *) client != NULL) ? 0 : 1;
 
+	if (client != NULL)
+		clnt_destroy(client);
+
+	close(sock);
+
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
index e547f1f..acbb55f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create.c
@@ -32,6 +32,8 @@
 #include <netinet/in.h>
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 //Standard define
 #define PROCNUM 1
@@ -53,8 +55,9 @@ int main(int argn, char *argc[])
 	struct netconfig *nconf = NULL;
 	struct netbuf svcaddr;
 	char addrbuf[ADDRBUFSIZE];
+	int sock;
 
-	nconf = getnetconfigent("udp");
+	nconf = getnetconfigent("tcp");
 	if (nconf == (struct netconfig *)NULL) {
 		printf("err nconf\n");
 		exit(1);
@@ -69,10 +72,21 @@ int main(int argn, char *argc[])
 		exit(1);
 	}
 
-	client = clnt_vc_create(RPC_ANYFD, &svcaddr,
+	sock = bound_socket(AF_INET, SOCK_DGRAM);
+	if (sock < 0) {
+		perror("bound_socket() failed");
+		exit(1);
+	}
+
+	client = clnt_vc_create(sock, &svcaddr,
 				progNum, VERSNUM, 1024, 1024);
 	test_status = ((CLIENT *) client != NULL) ? 0 : 1;
 
+	if (client != NULL)
+		clnt_destroy(client);
+
+	close(sock);
+
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
index 8f1953e..b93e4d6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create.c
@@ -32,6 +32,8 @@
 #include <netinet/in.h>
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
@@ -40,10 +42,22 @@ int main(int argn, char *argc[])
 {
 	int test_status = 1;
 	SVCXPRT *transp = NULL;
+	int sock;
 
-	transp = svc_dg_create(RPC_ANYFD, 0, 0);
+	sock = bound_socket(AF_INET, SOCK_DGRAM);
+	if (sock < 0) {
+		perror("bound_socket() failed");
+		return 1;
+	}
+
+	transp = svc_dg_create(sock, 0, 0);
 	test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
 
+	if (transp != NULL)
+		svc_destroy(transp);
+
+	close(sock);
+
 	printf("%d\n", test_status);
 
 	return test_status;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
index 4245586..491ac82 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create.c
@@ -32,6 +32,8 @@
 #include <netinet/in.h>
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 #define PROCNUM 1
 #define VERSNUM 1
@@ -40,10 +42,27 @@ int main(int argn, char *argc[])
 {
 	int test_status = 1;
 	SVCXPRT *transp = NULL;
+	int sock;
 
-	transp = svc_vc_create(RPC_ANYFD, 0, 0);
+	sock = bound_socket(AF_INET, SOCK_STREAM);
+	if (sock < 0) {
+		perror("bound_socket() failed");
+		return 1;
+	}
+
+	if (listen(sock, 10) < 0) {
+		perror("listen() failed");
+		return 1;
+	}
+
+	transp = svc_vc_create(sock, 0, 0);
 	test_status = ((SVCXPRT *) transp != NULL) ? 0 : 1;
 
+	if (transp != NULL)
+		svc_destroy(transp);
+
+	close(sock);
+
 	printf("%d\n", test_status);
 
 	return test_status;
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
