Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vv7OP-0007aY-DC
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:05 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vv7ON-0002vx-DV
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:05 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBNFPvWl011377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:57 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPu0D008967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:57 GMT
Received: from ubhmt102.oracle.com (ubhmt102.oracle.com [156.151.24.7])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPuvR025253
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 23 Dec 2013 19:25:48 +0400
Message-Id: <1387812348-23017-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/3] rpc01: fix compile-time warnings
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

And also removed host_address logic from rpc_server (since it is not
used there anyway).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/librpc01.c |    4 ++--
 testcases/network/rpc/basic_tests/rpc01/librpc01.h |    4 ++--
 testcases/network/rpc/basic_tests/rpc01/rpc1.c     |   15 +++++++++------
 .../network/rpc/basic_tests/rpc01/rpc_server.c     |   17 ++++++-----------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.c b/testcases/network/rpc/basic_tests/rpc01/librpc01.c
index b726aa0..447b7cd 100644
--- a/testcases/network/rpc/basic_tests/rpc01/librpc01.c
+++ b/testcases/network/rpc/basic_tests/rpc01/librpc01.c
@@ -19,7 +19,7 @@
 #include <rpc/xdr.h>
 #include "librpc01.h"
 
-int xdr_receive_data(XDR *xdrs, struct data **buffer)
+bool_t xdr_receive_data(XDR *xdrs, struct data **buffer)
 {
 	struct data *bp;
 	int i, rc;
@@ -35,7 +35,7 @@ int xdr_receive_data(XDR *xdrs, struct data **buffer)
 	return rc;
 }
 
-int xdr_send_data(XDR *xdrs, struct data *buffer)
+bool_t xdr_send_data(XDR *xdrs, struct data *buffer)
 {
 	int i, rc;
 	char *p;
diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.h b/testcases/network/rpc/basic_tests/rpc01/librpc01.h
index aae3901..0fa7969 100644
--- a/testcases/network/rpc/basic_tests/rpc01/librpc01.h
+++ b/testcases/network/rpc/basic_tests/rpc01/librpc01.h
@@ -28,7 +28,7 @@ struct data {
 	char *data;
 };
 
-int xdr_receive_data(XDR *xdrs, struct data **buffer);
-int xdr_send_data(XDR *xdrs, struct data *buffer);
+bool_t xdr_receive_data(XDR *xdrs, struct data **buffer);
+bool_t xdr_send_data(XDR *xdrs, struct data *buffer);
 
 #endif /* __LIBRPC_H__ */
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
index 57a338e..570c39c 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -125,8 +125,9 @@ int main(int argc, char *argv[])
 		*p = getc(fp);
 	fclose(fp);
 
-	rc = callrpc(server, program, version, 1, xdr_send_data, &buffer,
-		     xdr_receive_data, &return_buffer);
+	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
+			(char *)&buffer, (xdrproc_t)xdr_receive_data,
+			(char *)&return_buffer);
 	do_compare(rc, "callrpc", &buffer, return_buffer->data);
 
 	server_sin.sin_port = 0;
@@ -140,8 +141,9 @@ int main(int argc, char *argv[])
 	}
 	timeout.tv_usec = 0;
 	timeout.tv_sec = 30;
-	rc = (int)clnt_call(clnt, 1, xdr_send_data, &buffer,
-			    xdr_receive_data, &return_buffer, timeout);
+	rc = (int)clnt_call(clnt, 1, (xdrproc_t)xdr_send_data,
+				(char *)&buffer, (xdrproc_t)xdr_receive_data,
+				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
 	do_compare(rc, "udp transport", &buffer, return_buffer->data);
 
@@ -154,8 +156,9 @@ int main(int argc, char *argv[])
 	}
 	timeout.tv_usec = 0;
 	timeout.tv_sec = 30;
-	rc = (int)clnt_call(clnt, 1, xdr_send_data, &buffer,
-			    xdr_receive_data, &return_buffer, timeout);
+	rc = (int)clnt_call(clnt, 1, (xdrproc_t)xdr_send_data,
+				(char *)&buffer, (xdrproc_t)xdr_receive_data,
+				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
 	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
 
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
index e0b5001..61c383b 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
@@ -11,8 +11,6 @@
 int debug = 0;
 int program = 2000333;
 int version = 10;
-char host_name[100];
-long host_address;
 
 void breakpoint(void);
 void service_request(struct svc_req *rqstp, SVCXPRT * transp);
@@ -20,7 +18,6 @@ void service_request(struct svc_req *rqstp, SVCXPRT * transp);
 int main(int argc, char *argv[])
 {
 	SVCXPRT *transp;
-	struct hostent *hp;
 	int i, n;
 
 	for (i = 1; i < argc; i++) {
@@ -70,7 +67,7 @@ int main(int argc, char *argv[])
 			close(i);
 		open("/dev/null", O_RDONLY);
 		open("/dev/null", O_WRONLY);
-		dup(1);
+		i = dup(1);
 
 		if ((i = open("/dev/tty", O_RDWR)) >= 0) {
 			ioctl(i, TIOCNOTTY, 0);
@@ -78,10 +75,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	gethostname(host_name, 100);
-	if (hp = gethostbyname(host_name))
-		host_address = *((long *)hp->h_addr_list[0]);
-
 	pmap_unset(program, version);
 	transp = svcudp_create(RPC_ANYSOCK);
 	svc_register(transp, program, version, service_request, IPPROTO_UDP);
@@ -97,7 +90,7 @@ void service_request(struct svc_req *rqstp, SVCXPRT * transp)
 
 	switch (rqstp->rq_proc) {
 	case 0:
-		svc_sendreply(transp, xdr_void, (char *)0);
+		svc_sendreply(transp, (xdrproc_t)xdr_void, (char *)0);
 		breakpoint();
 		return;
 
@@ -105,8 +98,10 @@ void service_request(struct svc_req *rqstp, SVCXPRT * transp)
 		exit(0);
 
 	case 1:
-		svc_getargs(transp, xdr_receive_data, (unsigned char *)&buffer);
-		svc_sendreply(transp, xdr_send_data, (unsigned char *)buffer);
+		svc_getargs(transp, (xdrproc_t)xdr_receive_data,
+				(char *)&buffer);
+		svc_sendreply(transp, (xdrproc_t)xdr_send_data,
+				(char *)buffer);
 		free(buffer->data);
 		free(buffer);
 		return;
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
