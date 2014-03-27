Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnb-0007nc-Ga
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:51 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnZ-000283-KY
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:51 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDuhZL012899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:44 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDugTP013981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:43 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDugc9008557
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:42 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:28 +0400
Message-Id: <1395928590-28408-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 5/7] rpc-tirpc: tirpc_svc_5 fixes
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

This server binary has the following problems:
 * uses the "bottom level" API with RPC_ANYFD parameter (it violates the API)
 * the clients of tirpc_svc_5 use not only the UDP protocol, but TCP too. But the
   server does not listen a TCP port.

Fixed them.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c |   80 ++++++++++++++++----
 1 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
index d75e2eb..c899d0f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/tirpc_svc_5.c
@@ -1,5 +1,6 @@
 /*
 * Copyright (c) Bull S.A.  2007 All Rights Reserved.
+* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
@@ -34,42 +35,93 @@
 #include <tirpc/rpc/svc.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include <unistd.h>
+#include "librpc-tirpc.h"
 
 #define VERSNUM 1
 #define PROCSIMPLEPING	1
 
+struct server_def_t {
+	SVCXPRT *transp;
+	struct netconfig *nconf;
+	char netid[4];
+	int domain;
+	int type;
+	int sock;
+	SVCXPRT *(*svc_func)(const int, const u_int, const u_int);
+};
+
+static struct server_def_t server_defs[] = {
+	{ NULL, NULL, "tcp", AF_INET, SOCK_STREAM, -1, svc_vc_create },
+	{ NULL, NULL, "udp", AF_INET, SOCK_DGRAM, -1, svc_dg_create },
+};
+
+static int server_instances = sizeof(server_defs) / sizeof(*server_defs);
+
 static void exm_proc(struct svc_req *rqstp, SVCXPRT *transp);
 
 int main(int argn, char *argc[])
 {
 	int progNum = atoi(argc[1]);
-	SVCXPRT *transp = NULL;
-	struct netconfig *nconf;
+	int i;
+	struct server_def_t *this;
 
 	svc_unreg(progNum, VERSNUM);
 
-	if ((nconf = getnetconfigent("udp")) == NULL) {
-		fprintf(stderr, "Cannot get netconfig entry for UDP\n");
-		exit(1);
-	}
+	for (i = 0; i < server_instances; i++) {
+		this = &(server_defs[i]);
 
-	transp = svc_vc_create(RPC_ANYFD, 1024, 1024);
+		this->nconf = getnetconfigent(this->netid);
+		if (this->nconf == NULL) {
+			fprintf(stderr, "Cannot get a netconfig entry for %s",
+				this->netid);
+			goto cleanup;
+		}
 
-	if (transp == NULL) {
-		fprintf(stderr, "Cannot create service.\n");
-		exit(1);
-	}
+		this->sock = bound_socket(this->domain, this->type);
+		if (this->sock < 0) {
+			perror("bound_socket() failed");
+			goto cleanup;
+		}
 
-	if (!svc_reg(transp, progNum, VERSNUM, exm_proc, nconf)) {
-		fprintf(stderr, "svc_reg failed!!\n");
-		exit(1);
+		if (this->type == SOCK_STREAM) {
+			if (listen(this->sock, 10) < 0) {
+				perror("listen() failed");
+				goto cleanup;
+			}
+		}
+
+		this->transp = this->svc_func(this->sock, 1024, 1024);
+		if (this->transp == NULL) {
+			fprintf(stderr, "Cannot create service.\n");
+			goto cleanup;
+		}
+
+		if (!svc_reg(this->transp, progNum, VERSNUM,
+				exm_proc, this->nconf)) {
+			fprintf(stderr, "svc_reg failed!!\n");
+			goto cleanup;
+		}
 	}
 
+
 	svc_run();
 
 	fprintf(stderr, "svc_run() returned.  ERROR has occurred.\n");
+
+cleanup:
 	svc_unreg(progNum, VERSNUM);
 
+	for (i = 0; i < server_instances; i++) {
+		this = &(server_defs[i]);
+
+		if (this->transp != NULL)
+			svc_destroy(this->transp);
+
+		if (this->sock >= 0)
+			close(this->sock);
+	}
+
 	return 1;
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
