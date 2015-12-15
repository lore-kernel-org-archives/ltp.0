From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 15 Dec 2015 15:48:15 +0300
Subject: [LTP] [PATCH] network/tcp_fastopen: use UDP optionally
Message-ID: <1450183695-7867-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With minor changes the test can be run over UDP.
'-U' parameter should be provided to tcp_fastopen.

Changes in server:
* recv() changed to recvfrom() to get client address and port,
* server creates only one thread that manages requests from clients,
  and sends replies with sendto().
* increase default timeout, 10s -> 60s (waiting for requests).

Also rename some variables and test messages to more general form.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen.c |  162 +++++++++++++++----------
 1 files changed, 100 insertions(+), 62 deletions(-)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index c63e7f0..c75e1d1 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -12,8 +12,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  *
  * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
  *
@@ -54,10 +53,10 @@ static const int max_msg_len = 1500;
 #endif
 
 enum {
-	TCP_SERVER = 0,
-	TCP_CLIENT,
+	SERVER_HOST = 0,
+	CLIENT_HOST,
 };
-static int tcp_mode;
+static int net_mode;
 
 enum {
 	TFO_ENABLED = 0,
@@ -94,11 +93,12 @@ static int clients_num		= 2;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
 static int busy_poll		= -1;
+static int use_udp;
 /* server socket */
 static int sfd;
 
 /* how long a client must wait for the server's reply, microsec */
-static long wait_timeout = 10000000;
+static long wait_timeout = 60000000;
 
 /* in the end test will save time result in this file */
 static char *rpath		= "./tfo_result";
@@ -125,8 +125,9 @@ static const option_t options[] = {
 	/* common */
 	{"g:", NULL, &tcp_port},
 	{"b:", NULL, &barg},
+	{"U", &use_udp, NULL},
 	{"F", &force_run, NULL},
-	{"l", &tcp_mode, NULL},
+	{"l", &net_mode, NULL},
 	{"o", &fastopen_api, NULL},
 	{"O", &tfo_support, NULL},
 	{"v", &verbose, NULL},
@@ -142,6 +143,7 @@ static void help(void)
 	printf("  -l      Become TCP Client, default is TCP server\n");
 	printf("  -g x    x - server port, default is %s\n", tcp_port);
 	printf("  -b x    x - low latency busy poll timeout\n");
+	printf("  -U      use UDP\n");
 
 	printf("\n          Client:\n");
 	printf("  -H x    x - server name or ip address, default is '%s'\n",
@@ -161,13 +163,13 @@ static void help(void)
 	printf("  -q x    x - server's limit on the queue of TFO requests\n");
 }
 
-/* common structure for TCP server and TCP client */
-struct tcp_func {
+/* common structure for TCP/UDP server and TCP/UDP client */
+struct net_func {
 	void (*init)(void);
 	void (*run)(void);
 	void (*cleanup)(void);
 };
-static struct tcp_func tcp;
+static struct net_func net;
 
 #define MAX_THREADS	10000
 static pthread_attr_t attr;
@@ -175,6 +177,9 @@ static pthread_t *thread_ids;
 
 static struct addrinfo *remote_addrinfo;
 static struct addrinfo *local_addrinfo;
+static struct sockaddr_storage remote_addr;
+static socklen_t remote_addr_len;
+
 static const struct linger clo = { 1, 3 };
 
 static void do_cleanup(void)
@@ -182,7 +187,8 @@ static void do_cleanup(void)
 	free(client_msg);
 	free(server_msg);
 
-	tcp.cleanup();
+	if (net.cleanup)
+		net.cleanup();
 
 	if (tfo_cfg_changed) {
 		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
@@ -206,6 +212,7 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset)
 	pfd.fd = fd;
 	pfd.events = POLLIN;
 	int len = -1;
+
 	while (1) {
 		errno = 0;
 		int ret = poll(&pfd, 1, wait_timeout / 1000);
@@ -224,8 +231,9 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset)
 			break;
 
 		errno = 0;
-		len = recv(fd, buf + offset,
-			buf_size - offset, MSG_DONTWAIT);
+		len = recvfrom(fd, buf + offset, buf_size - offset,
+			       MSG_DONTWAIT, (struct sockaddr *)&remote_addr,
+			       &remote_addr_len);
 
 		if (len == -1 && errno == EINTR)
 			continue;
@@ -274,7 +282,8 @@ static int client_recv(int *fd, char *buf)
 
 static int client_connect_send(const char *msg, int size)
 {
-	int cfd = socket(remote_addrinfo->ai_family, SOCK_STREAM, 0);
+	int cfd = socket(remote_addrinfo->ai_family,
+			 remote_addrinfo->ai_socktype, 0);
 	const int flag = 1;
 
 	if (cfd == -1)
@@ -330,6 +339,8 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 	}
 
 	for (i = 1; i < client_max_requests; ++i) {
+		if (use_udp)
+			goto send;
 
 		/* check connection, it can be closed */
 		int ret = 0;
@@ -359,6 +370,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 			break;
 		}
 
+send:
 		if (verbose) {
 			tst_resm_hexd(TINFO, client_msg, client_msg_size,
 				"try to send msg[%d]", i);
@@ -432,14 +444,18 @@ static void client_init(void)
 
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
-	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_socktype = (use_udp) ? SOCK_DGRAM : SOCK_STREAM;
+	hints.ai_flags = 0;
+	hints.ai_protocol = 0;
+
 	int err = getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
 	if (err) {
 		tst_brkm(TBROK, cleanup, "getaddrinfo of '%s' failed, %s",
 			server_addr, gai_strerror(err));
 	}
 
-	tst_resm(TINFO, "TCP Fast Open over IPv%s",
+	tst_resm(TINFO, "Running the test over IPv%s",
 		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
 
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
@@ -560,22 +576,23 @@ void *server_fn(void *cfd)
 			send_msg = make_server_reply(send_msg_size);
 		}
 
+		offset = 0;
+
 		/*
 		 * It will tell client that server is going
 		 * to close this connection.
 		 */
-		if (++num_requests >= server_max_requests)
+		if (!use_udp && ++num_requests >= server_max_requests)
 			send_msg[0] = start_fin_byte;
 
-		if (send(client_fd, send_msg, send_msg_size,
-		    MSG_NOSIGNAL) == -1) {
-			tst_resm(TFAIL | TERRNO, "send failed");
+		if (sendto(client_fd, send_msg, send_msg_size,
+		    MSG_NOSIGNAL, (struct sockaddr *)&remote_addr,
+		    remote_addr_len) < 0) {
+			tst_resm(TFAIL | TERRNO, "sendto failed");
 			goto out;
 		}
 
-		offset = 0;
-
-		if (num_requests >= server_max_requests) {
+		if (!use_udp && num_requests >= server_max_requests) {
 			/* max reqs, close socket */
 			shutdown(client_fd, SHUT_WR);
 			break;
@@ -593,13 +610,14 @@ out:
 	tst_exit();
 }
 
-static void server_thread_add(intptr_t client_fd)
+static pthread_t server_thread_add(intptr_t client_fd)
 {
 	pthread_t id;
 	if (pthread_create(&id, &attr, server_fn, (void *) client_fd)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			"pthread_create failed at %s:%d", __FILE__, __LINE__);
 	}
+	return id;
 }
 
 static void server_init(void)
@@ -607,23 +625,27 @@ static void server_init(void)
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_INET6;
-	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_socktype = (use_udp) ? SOCK_DGRAM : SOCK_STREAM;
 	hints.ai_flags = AI_PASSIVE;
+
 	if (getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
 
-	/* IPv6 socket is also able to access IPv4 protocol stack */
-	sfd = SAFE_SOCKET(cleanup, AF_INET6, SOCK_STREAM, 0);
-
-	tst_resm(TINFO, "assigning a name to the server socket...");
 	if (!local_addrinfo)
 		tst_brkm(TBROK, cleanup, "failed to get the address");
 
+	/* IPv6 socket is also able to access IPv4 protocol stack */
+	sfd = SAFE_SOCKET(cleanup, AF_INET6, local_addrinfo->ai_socktype, 0);
+
+	tst_resm(TINFO, "assigning a name to the server socket...");
 	SAFE_BIND(cleanup, sfd, local_addrinfo->ai_addr,
 		local_addrinfo->ai_addrlen);
 
 	freeaddrinfo(local_addrinfo);
 
+	if (use_udp)
+		return;
+
 	const int flag = 1;
 	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
@@ -642,6 +664,14 @@ static void server_cleanup(void)
 	SAFE_CLOSE(NULL, sfd);
 }
 
+static void server_run_udp(void)
+{
+	pthread_t p_id = server_thread_add(sfd);
+
+	if (!pthread_join(p_id, NULL))
+		tst_brkm(TBROK | TERRNO, cleanup, "pthread_join() failed");
+}
+
 static void server_run(void)
 {
 	/* IPv4 source address will be mapped to IPv6 address */
@@ -739,20 +769,16 @@ static void setup(int argc, char *argv[])
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	tst_resm(TINFO, "TCP %s is using %s TCP API.",
-		(tcp_mode == TCP_SERVER) ? "server" : "client",
-		(fastopen_api == TFO_ENABLED) ? "Fastopen" : "old");
-
-	switch (tcp_mode) {
-	case TCP_SERVER:
+	switch (net_mode) {
+	case SERVER_HOST:
 		tst_resm(TINFO, "max requests '%d'",
 			server_max_requests);
-		tcp.init	= server_init;
-		tcp.run		= server_run;
-		tcp.cleanup	= server_cleanup;
+		net.init	= server_init;
+		net.run		= (use_udp) ? server_run_udp : server_run;
+		net.cleanup	= (use_udp) ? NULL : server_cleanup;
 		tfo_bit_num = 2;
 	break;
-	case TCP_CLIENT:
+	case CLIENT_HOST:
 		tst_resm(TINFO, "connection: addr '%s', port '%s'",
 			server_addr, tcp_port);
 		tst_resm(TINFO, "client max req: %d", client_max_requests);
@@ -760,41 +786,53 @@ static void setup(int argc, char *argv[])
 		tst_resm(TINFO, "client msg size: %d", client_msg_size);
 		tst_resm(TINFO, "server msg size: %d", server_msg_size);
 
-		tcp.init	= client_init;
-		tcp.run		= client_run;
-		tcp.cleanup	= client_cleanup;
+		net.init	= client_init;
+		net.run		= client_run;
+		net.cleanup	= client_cleanup;
 		tfo_bit_num = 1;
 	break;
 	}
 
-	tfo_support = TFO_ENABLED == tfo_support;
-	if (((tfo_cfg_value & tfo_bit_num) == tfo_bit_num) != tfo_support) {
-		int value = (tfo_cfg_value & ~tfo_bit_num)
-			| (tfo_support << (tfo_bit_num - 1));
-		tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, value);
-		SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", value);
-		tfo_cfg_changed = 1;
-	}
+	remote_addr_len = sizeof(struct sockaddr_storage);
 
-	int reuse_value = 0;
-	SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
-	if (!reuse_value) {
-		SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
-		tw_reuse_changed = 1;
-		tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
-	}
+	if (use_udp) {
+		tst_resm(TINFO, "using UDP");
+		fastopen_api = TFO_DISABLED;
+	} else {
+		tst_resm(TINFO, "TCP %s is using %s TCP API.",
+			(net_mode == SERVER_HOST) ? "server" : "client",
+			(fastopen_api == TFO_ENABLED) ? "Fastopen" : "old");
+
+		tfo_support = TFO_ENABLED == tfo_support;
+		if (((tfo_cfg_value & tfo_bit_num) == tfo_bit_num)
+		      != tfo_support) {
+			int value = (tfo_cfg_value & ~tfo_bit_num)
+				| (tfo_support << (tfo_bit_num - 1));
+			tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, value);
+			SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", value);
+			tfo_cfg_changed = 1;
+		}
 
-	tst_resm(TINFO, "TFO support %s",
-		(tfo_support) ? "enabled" : "disabled");
+		int reuse_value = 0;
+		SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
+		if (!reuse_value) {
+			SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
+			tw_reuse_changed = 1;
+			tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
+		}
+
+		tst_resm(TINFO, "TFO support %s",
+			(tfo_support) ? "enabled" : "disabled");
+	}
 
-	tcp.init();
+	net.init();
 }
 
 int main(int argc, char *argv[])
 {
 	setup(argc, argv);
 
-	tcp.run();
+	net.run();
 
 	cleanup();
 
-- 
1.7.1

