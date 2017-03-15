From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Mar 2017 15:04:49 +0300
Subject: [LTP] [PATCH 1/2] netstress: add basic support for DCCP
Message-ID: <1489579490-24154-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   81 ++++++++++++++++++++++++-------
 1 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 8184716..c1fb875 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -38,6 +38,19 @@
 
 static const int max_msg_len = (1 << 16) - 1;
 
+#ifndef SOCK_DCCP
+#define SOCK_DCCP		6
+#endif
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP		33
+#endif
+#ifndef SOL_DCCP
+#define SOL_DCCP		269
+#endif
+#ifndef DCCP_SOCKOPT_SERVICE
+#define DCCP_SOCKOPT_SERVICE	2
+#endif
+
 /* TCP server requiers */
 #ifndef TCP_FASTOPEN
 #define TCP_FASTOPEN	23
@@ -92,7 +105,11 @@ static int clients_num;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
 static int busy_poll		= -1;
-static char *use_udp;
+static char *use_udp, *use_dccp;
+static int proto_type = SOCK_STREAM;
+static int protocol;
+static uint32_t service_code = 0xffff;
+
 /* server socket */
 static int sfd;
 
@@ -129,6 +146,11 @@ static void init_socket_opts(int sd)
 		SAFE_SETSOCKOPT(sd, SOL_SOCKET, SO_BUSY_POLL,
 			&busy_poll, sizeof(busy_poll));
 	}
+
+	if (proto_type == SOCK_DCCP) {
+		SAFE_SETSOCKOPT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
+				&service_code, sizeof(uint32_t));
+	}
 }
 
 static void do_cleanup(void)
@@ -227,7 +249,7 @@ static int client_recv(int *fd, char *buf)
 static int client_connect_send(const char *msg, int size)
 {
 	int cfd = SAFE_SOCKET(remote_addrinfo->ai_family,
-			 remote_addrinfo->ai_socktype, 0);
+			 remote_addrinfo->ai_socktype, protocol);
 
 	init_socket_opts(cfd);
 
@@ -264,7 +286,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 	}
 
 	for (i = 1; i < client_max_requests; ++i) {
-		if (use_udp)
+		if (proto_type == SOCK_DGRAM)
 			goto send;
 
 		if (cfd == -1) {
@@ -355,7 +377,7 @@ static void client_init(void)
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_UNSPEC;
-	hints.ai_socktype = (use_udp) ? SOCK_DGRAM : SOCK_STREAM;
+	hints.ai_socktype = proto_type;
 	hints.ai_flags = 0;
 	hints.ai_protocol = 0;
 
@@ -482,13 +504,15 @@ void *server_fn(void *cfd)
 		 * It will tell client that server is going
 		 * to close this connection.
 		 */
-		if (!use_udp && ++num_requests >= server_max_requests)
+		if (proto_type == SOCK_STREAM &&
+		    ++num_requests >= server_max_requests)
 			send_msg[0] = start_fin_byte;
 
 		SAFE_SENDTO(1, client_fd, send_msg, send_msg_size, MSG_NOSIGNAL,
 			(struct sockaddr *)&remote_addr, remote_addr_len);
 
-		if (!use_udp && num_requests >= server_max_requests) {
+		if (proto_type == SOCK_STREAM &&
+		    num_requests >= server_max_requests) {
 			/* max reqs, close socket */
 			shutdown(client_fd, SHUT_WR);
 			break;
@@ -516,7 +540,7 @@ static void server_init(void)
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_INET6;
-	hints.ai_socktype = (use_udp) ? SOCK_DGRAM : SOCK_STREAM;
+	hints.ai_socktype = proto_type;
 	hints.ai_flags = AI_PASSIVE;
 
 	int err = getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo);
@@ -528,7 +552,7 @@ static void server_init(void)
 		tst_brk(TBROK, "failed to get the address");
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
-	sfd = SAFE_SOCKET(AF_INET6, local_addrinfo->ai_socktype, 0);
+	sfd = SAFE_SOCKET(AF_INET6, local_addrinfo->ai_socktype, protocol);
 	const int flag = 1;
 	SAFE_SETSOCKOPT(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
@@ -537,7 +561,7 @@ static void server_init(void)
 
 	freeaddrinfo(local_addrinfo);
 
-	if (use_udp)
+	if (proto_type == SOCK_DGRAM)
 		return;
 
 	init_socket_opts(sfd);
@@ -687,6 +711,11 @@ static void setup(void)
 	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0)
 		tst_brk(TCONF, "Test must be run with kernel 3.11 or newer");
 
+	if (use_udp)
+		proto_type = SOCK_DGRAM;
+	else if (use_dccp)
+		proto_type = SOCK_DCCP;
+
 	if (client_mode) {
 		tst_res(TINFO, "connection: addr '%s', port '%s'",
 			server_addr, tcp_port);
@@ -703,21 +732,38 @@ static void setup(void)
 		tst_res(TINFO, "max requests '%d'",
 			server_max_requests);
 		net.init	= server_init;
-		net.run		= (use_udp) ? server_run_udp : server_run;
-		net.cleanup	= (use_udp) ? NULL : server_cleanup;
+		switch (proto_type) {
+		case SOCK_STREAM:
+		case SOCK_DCCP:
+			net.run		= server_run;
+			net.cleanup	= server_cleanup;
+		break;
+		case SOCK_DGRAM:
+			net.run		= server_run_udp;
+			net.cleanup	= NULL;
+		break;
+		}
 	}
 
 	remote_addr_len = sizeof(struct sockaddr_storage);
 
-	if (use_udp) {
-		tst_res(TINFO, "using UDP");
-		fastopen_api = NULL;
-	} else {
+	switch (proto_type) {
+	case SOCK_STREAM:
 		tst_res(TINFO, "TCP %s is using %s TCP API.",
 			(client_mode) ? "client" : "server",
 			(fastopen_api) ? "Fastopen" : "old");
-
 		check_tfo_value();
+	break;
+	case SOCK_DCCP:
+		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
+		protocol = IPPROTO_DCCP;
+		fastopen_api = NULL;
+		service_code = htonl(service_code);
+	break;
+	case SOCK_DGRAM:
+		tst_res(TINFO, "using UDP");
+		fastopen_api = NULL;
+	break;
 	}
 
 	net.init();
@@ -735,7 +781,8 @@ static struct tst_option options[] = {
 
 	{"g:", &tcp_port, "-g x     x - server port"},
 	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
-	{"U", &use_udp, "-U       Use UDP\n"},
+	{"U", &use_udp, "-U       Use UDP"},
+	{"D", &use_dccp, "-D       Use DCCP\n"},
 
 	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
 	{"l", &client_mode, "-l       Become client, default is server"},
-- 
1.7.1

