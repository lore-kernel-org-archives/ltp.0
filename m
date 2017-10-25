From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Oct 2017 19:11:57 +0300
Subject: [LTP] [PATCH 2/4] netstress: add support for TCP_FASTOPEN_CONNECT
	socket option
In-Reply-To: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
References: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1508947919-3553-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Support added in Linux 4.11 by the following commit:
19f6d3f3c842 ("net/tcp-fastopen: Add new API support")

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   36 ++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 6fda536..423c25a 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -57,6 +57,10 @@ static const int min_msg_len = 5;
 #define TCP_FASTOPEN	23
 #endif
 
+#ifndef TCP_FASTOPEN_CONNECT
+#define TCP_FASTOPEN_CONNECT	30	/* Attempt FastOpen with connect */
+#endif
+
 #ifndef SO_BUSY_POLL
 #define SO_BUSY_POLL	46
 #endif
@@ -77,7 +81,7 @@ enum {
 	TFO_ENABLED,
 };
 static int tfo_value = -1;
-static char *fastopen_api;
+static char *fastopen_api, *fastopen_sapi;
 
 static const char tfo_cfg[]		= "/proc/sys/net/ipv4/tcp_fastopen";
 static const char tcp_tw_reuse[]	= "/proc/sys/net/ipv4/tcp_tw_reuse";
@@ -152,15 +156,16 @@ static socklen_t remote_addr_len;
 
 static void init_socket_opts(int sd)
 {
-	if (busy_poll >= 0) {
-		SAFE_SETSOCKOPT(sd, SOL_SOCKET, SO_BUSY_POLL,
-			&busy_poll, sizeof(busy_poll));
-	}
+	if (busy_poll >= 0)
+		SAFE_SETSOCKOPT_INT(sd, SOL_SOCKET, SO_BUSY_POLL, busy_poll);
 
 	if (proto_type == TYPE_DCCP) {
-		SAFE_SETSOCKOPT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
-				&service_code, sizeof(uint32_t));
+		SAFE_SETSOCKOPT_INT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
+			service_code);
 	}
+
+	if (client_mode && fastopen_sapi)
+		SAFE_SETSOCKOPT_INT(sd, IPPROTO_TCP, TCP_FASTOPEN_CONNECT, 1);
 }
 
 static void do_cleanup(void)
@@ -576,8 +581,7 @@ static void server_init(void)
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
 	sfd = SAFE_SOCKET(family, sock_type, protocol);
-	const int flag = 1;
-	SAFE_SETSOCKOPT(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
+	SAFE_SETSOCKOPT_INT(sfd, SOL_SOCKET, SO_REUSEADDR, 1);
 
 	tst_res(TINFO, "assigning a name to the server socket...");
 	SAFE_BIND(sfd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
@@ -589,9 +593,9 @@ static void server_init(void)
 
 	init_socket_opts(sfd);
 
-	if (fastopen_api) {
-		SAFE_SETSOCKOPT(sfd, IPPROTO_TCP, TCP_FASTOPEN,
-			&tfo_queue_size, sizeof(tfo_queue_size));
+	if (fastopen_api || fastopen_sapi) {
+		SAFE_SETSOCKOPT_INT(sfd, IPPROTO_TCP, TCP_FASTOPEN,
+			tfo_queue_size);
 	}
 
 	SAFE_LISTEN(sfd, max_queue_len);
@@ -803,19 +807,19 @@ static void setup(void)
 	break;
 	case TYPE_UDP:
 		tst_res(TINFO, "using UDP");
-		fastopen_api = NULL;
+		fastopen_api = fastopen_sapi = NULL;
 		sock_type = SOCK_DGRAM;
 	break;
 	case TYPE_DCCP:
 		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
-		fastopen_api = NULL;
+		fastopen_api = fastopen_sapi = NULL;
 		sock_type = SOCK_DCCP;
 		protocol = IPPROTO_DCCP;
 		service_code = htonl(service_code);
 	break;
 	case TYPE_SCTP:
 		tst_res(TINFO, "SCTP %s", (client_mode) ? "client" : "server");
-		fastopen_api = NULL;
+		fastopen_api = fastopen_sapi = NULL;
 		protocol = IPPROTO_SCTP;
 	break;
 	}
@@ -830,6 +834,8 @@ static void do_test(void)
 
 static struct tst_option options[] = {
 	{"f", &fastopen_api, "-f       Use TFO API, default is old API"},
+	{"F", &fastopen_sapi,
+		"-F       TCP_FASTOPEN_CONNECT socket option and standard API"},
 	{"t:", &targ, "-t x     Set tcp_fastopen value"},
 
 	{"g:", &tcp_port, "-g x     x - server port"},
-- 
1.7.1

