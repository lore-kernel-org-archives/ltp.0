From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Dec 2016 16:36:35 +0300
Subject: [LTP] [PATCH 3/3] netstress.c: convert to new library API
In-Reply-To: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |  357 +++++++++++++------------------
 1 files changed, 150 insertions(+), 207 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 95be098..fcfa805 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -19,6 +19,8 @@
  */
 
 #include <pthread.h>
+#include <stdlib.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netdb.h>
@@ -30,11 +32,8 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "test.h"
 #include "lapi/posix_clocks.h"
-#include "safe_macros.h"
-
-char *TCID = "netstress";
+#include "tst_test.h"
 
 static const int max_msg_len = (1 << 16) - 1;
 
@@ -56,14 +55,14 @@ enum {
 	SERVER_HOST = 0,
 	CLIENT_HOST,
 };
-static int net_mode;
+static char *client_mode;
 
 enum {
 	TFO_DISABLED = 0,
 	TFO_ENABLED,
 };
 static int tfo_value = -1;
-static int fastopen_api;
+static char *fastopen_api;
 
 static const char tfo_cfg[]		= "/proc/sys/net/ipv4/tcp_fastopen";
 static const char tcp_tw_reuse[]	= "/proc/sys/net/ipv4/tcp_tw_reuse";
@@ -84,81 +83,28 @@ static char *server_msg;
 
 /*
  * The number of requests from client after
- *  which server has to close the connection.
+ * which server has to close the connection.
  */
 static int server_max_requests	= 3;
 static int client_max_requests	= 10;
-static int clients_num		= 2;
+static int clients_num;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
 static int busy_poll		= -1;
-static int use_udp;
+static char *use_udp;
 /* server socket */
 static int sfd;
 
 /* how long a client must wait for the server's reply, microsec */
-static long wait_timeout = 60000000;
+static long wait_timeout = 60000000L;
 
 /* in the end test will save time result in this file */
-static char *rpath		= "./tfo_result";
+static char *rpath = "tfo_result";
 
-static int verbose;
+static char *verbose;
 
 static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ;
 
-static const option_t options[] = {
-	/* server params */
-	{"R:", NULL, &Rarg},
-	{"q:", NULL, &qarg},
-
-	/* client params */
-	{"H:", NULL, &server_addr},
-	{"a:", NULL, &aarg},
-	{"n:", NULL, &narg},
-	{"N:", NULL, &Narg},
-	{"T:", NULL, &Targ},
-	{"r:", NULL, &rarg},
-	{"d:", NULL, &rpath},
-
-	/* common */
-	{"g:", NULL, &tcp_port},
-	{"b:", NULL, &barg},
-	{"U", &use_udp, NULL},
-	{"l", &net_mode, NULL},
-	{"f", &fastopen_api, NULL},
-	{"t:", NULL, &targ},
-	{"v", &verbose, NULL},
-	{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("\n  -v      Verbose\n");
-	printf("  -f      Use new TCP API, default is old TCP API\n");
-	printf("  -t x    Set tcp_fastopen value\n");
-	printf("  -l      Become TCP Client, default is TCP server\n");
-	printf("  -g x    x - server port, default is %s\n", tcp_port);
-	printf("  -b x    x - low latency busy poll timeout\n");
-	printf("  -U      use UDP\n");
-
-	printf("\n          Client:\n");
-	printf("  -H x    x - server name or ip address, default is '%s'\n",
-		server_addr);
-	printf("  -a x    x - num of clients running in parallel\n");
-	printf("  -r x    x - num of client requests\n");
-	printf("  -n x    Client message size, max msg size is '%d'\n",
-		max_msg_len);
-	printf("  -N x    Server message size, max msg size is '%d'\n",
-		max_msg_len);
-	printf("  -T x    Reply timeout, default is '%ld' (microsec)\n",
-		wait_timeout);
-	printf("  -d x    x is a path to the file where results are saved\n");
-
-	printf("\n          Server:\n");
-	printf("  -R x    x - num of requests, after which conn. closed\n");
-	printf("  -q x    x - server's limit on the queue of TFO requests\n");
-}
-
 /* common structure for TCP/UDP server and TCP/UDP client */
 struct net_func {
 	void (*init)(void);
@@ -193,14 +139,14 @@ static void do_cleanup(void)
 		net.cleanup();
 
 	if (tfo_cfg_changed) {
-		tst_resm(TINFO, "unset '%s' back to '%d'",
+		tst_res(TINFO, "unset '%s' back to '%d'",
 			tfo_cfg, tfo_cfg_value);
-		SAFE_FILE_PRINTF(NULL, tfo_cfg, "%d", tfo_cfg_value);
+		SAFE_FILE_PRINTF(tfo_cfg, "%d", tfo_cfg_value);
 	}
 
 	if (tw_reuse_changed) {
-		SAFE_FILE_PRINTF(NULL, tcp_tw_reuse, "0");
-		tst_resm(TINFO, "unset '%s' back to '0'", tcp_tw_reuse);
+		SAFE_FILE_PRINTF(tcp_tw_reuse, "0");
+		tst_res(TINFO, "unset '%s' back to '0'", tcp_tw_reuse);
 	}
 }
 TST_DECLARE_ONCE_FN(cleanup, do_cleanup)
@@ -263,7 +209,7 @@ static int client_recv(int *fd, char *buf)
 			continue;
 
 		if (verbose) {
-			tst_resm_hexd(TINFO, buf, offset,
+			tst_res_hexd(TINFO, buf, offset,
 				"msg recv from sock %d:", *fd);
 		}
 
@@ -274,7 +220,7 @@ static int client_recv(int *fd, char *buf)
 	}
 
 	shutdown(*fd, SHUT_WR);
-	SAFE_CLOSE(cleanup, *fd);
+	SAFE_CLOSE(*fd);
 	*fd = -1;
 	return (errno) ? -1 : 0;
 }
@@ -289,24 +235,24 @@ static int client_connect_send(const char *msg, int size)
 
 	init_socket_opts(cfd);
 
-	if (fastopen_api == TFO_ENABLED) {
+	if (fastopen_api) {
 		/* Replaces connect() + send()/write() */
 		if (sendto(cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
 		    remote_addrinfo->ai_addr,
 		    remote_addrinfo->ai_addrlen) != size) {
-			SAFE_CLOSE(cleanup, cfd);
+			SAFE_CLOSE(cfd);
 			return -1;
 		}
 	} else {
 		/* old TCP API */
 		if (connect(cfd, remote_addrinfo->ai_addr,
 		    remote_addrinfo->ai_addrlen)) {
-			SAFE_CLOSE(cleanup, cfd);
+			SAFE_CLOSE(cfd);
 			return -1;
 		}
 
 		if (send(cfd, msg, size, MSG_NOSIGNAL) != client_msg_size) {
-			SAFE_CLOSE(cleanup, cfd);
+			SAFE_CLOSE(cfd);
 			return -1;
 		}
 	}
@@ -344,7 +290,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		if (ret == 0) {
 			/* try to reconnect and send */
 			if (cfd != -1)
-				SAFE_CLOSE(cleanup, cfd);
+				SAFE_CLOSE(cfd);
 
 			cfd = client_connect_send(client_msg, client_msg_size);
 			if (cfd == -1) {
@@ -366,7 +312,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 
 send:
 		if (verbose) {
-			tst_resm_hexd(TINFO, client_msg, client_msg_size,
+			tst_res_hexd(TINFO, client_msg, client_msg_size,
 				"try to send msg[%d]", i);
 		}
 
@@ -382,7 +328,7 @@ send:
 	}
 
 	if (cfd != -1)
-		SAFE_CLOSE(cleanup, cfd);
+		SAFE_CLOSE(cfd);
 
 out:
 	return (void *) err;
@@ -424,14 +370,13 @@ static struct timespec tv_client_end;
 static void client_init(void)
 {
 	if (clients_num >= MAX_THREADS) {
-		tst_brkm(TBROK, cleanup,
-			"Unexpected num of clients '%d'",
+		tst_brk(TBROK, "Unexpected num of clients '%d'",
 			clients_num);
 	}
 
-	thread_ids = SAFE_MALLOC(NULL, sizeof(pthread_t) * clients_num);
+	thread_ids = SAFE_MALLOC(sizeof(pthread_t) * clients_num);
 
-	client_msg = SAFE_MALLOC(NULL, client_msg_size);
+	client_msg = SAFE_MALLOC(client_msg_size);
 	memset(client_msg, client_byte, client_msg_size);
 
 	make_client_request();
@@ -445,22 +390,17 @@ static void client_init(void)
 
 	int err = getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
 	if (err) {
-		tst_brkm(TBROK, cleanup, "getaddrinfo of '%s' failed, %s",
+		tst_brk(TBROK, "getaddrinfo of '%s' failed, %s",
 			server_addr, gai_strerror(err));
 	}
 
-	tst_resm(TINFO, "Running the test over IPv%s",
+	tst_res(TINFO, "Running the test over IPv%s",
 		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
 
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
 	int i;
-	for (i = 0; i < clients_num; ++i) {
-		if (pthread_create(&thread_ids[i], 0, client_fn, NULL) != 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				"pthread_create failed@%s:%d",
-				__FILE__, __LINE__);
-		}
-	}
+	for (i = 0; i < clients_num; ++i)
+		SAFE_PTHREAD_CREATE(&thread_ids[i], 0, client_fn, NULL);
 }
 
 static void client_run(void)
@@ -471,7 +411,7 @@ static void client_run(void)
 	for (i = 0; i < clients_num; ++i) {
 		pthread_join(thread_ids[i], &res);
 		if (res) {
-			tst_brkm(TBROK, cleanup, "client[%d] failed: %s",
+			tst_brk(TBROK, "client[%d] failed: %s",
 				i, strerror((intptr_t)res));
 		}
 	}
@@ -480,17 +420,19 @@ static void client_run(void)
 	clnt_time = (tv_client_end.tv_sec - tv_client_start.tv_sec) * 1000 +
 		(tv_client_end.tv_nsec - tv_client_start.tv_nsec) / 1000000;
 
-	tst_resm(TINFO, "total time '%ld' ms", clnt_time);
+	tst_res(TINFO, "total time '%ld' ms", clnt_time);
 
 	/* ask server to terminate */
 	client_msg[0] = start_fin_byte;
 	int cfd = client_connect_send(client_msg, client_msg_size);
 	if (cfd != -1) {
 		shutdown(cfd, SHUT_WR);
-		SAFE_CLOSE(NULL, cfd);
+		SAFE_CLOSE(cfd);
 	}
 	/* the script tcp_fastopen_run.sh will remove it */
-	SAFE_FILE_PRINTF(cleanup, rpath, "%ld", clnt_time);
+	SAFE_FILE_PRINTF(rpath, "%ld", clnt_time);
+
+	tst_res(TPASS, "test completed");
 }
 
 static void client_cleanup(void)
@@ -503,7 +445,7 @@ static void client_cleanup(void)
 
 static char *make_server_reply(int size)
 {
-	char *send_msg = SAFE_MALLOC(NULL, size);
+	char *send_msg = SAFE_MALLOC(size);
 	memset(send_msg, server_byte, size - 1);
 	send_msg[0] = start_byte;
 	send_msg[size - 1] = end_byte;
@@ -532,7 +474,7 @@ void *server_fn(void *cfd)
 		if (recv_len < 0 || (offset + recv_len) > max_msg_len ||
 		   (recv_msg[0] != start_byte &&
 		    recv_msg[0] != start_fin_byte)) {
-			tst_resm(TFAIL, "recv failed, sock '%d'", client_fd);
+			tst_res(TFAIL, "recv failed, sock '%d'", client_fd);
 			goto out;
 		}
 
@@ -548,7 +490,7 @@ void *server_fn(void *cfd)
 			goto out;
 
 		if (verbose) {
-			tst_resm_hexd(TINFO, recv_msg, offset,
+			tst_res_hexd(TINFO, recv_msg, offset,
 				"msg recv from sock %d:", client_fd);
 		}
 
@@ -556,7 +498,7 @@ void *server_fn(void *cfd)
 		if (!send_msg) {
 			send_msg_size = parse_client_request(recv_msg);
 			if (send_msg_size < 0) {
-				tst_resm(TFAIL, "wrong msg size '%d'",
+				tst_res(TFAIL, "wrong msg size '%d'",
 					send_msg_size);
 				goto out;
 			}
@@ -575,7 +517,7 @@ void *server_fn(void *cfd)
 		if (sendto(client_fd, send_msg, send_msg_size,
 		    MSG_NOSIGNAL, (struct sockaddr *)&remote_addr,
 		    remote_addr_len) < 0) {
-			tst_resm(TFAIL | TERRNO, "sendto failed");
+			tst_res(TFAIL | TERRNO, "sendto failed");
 			goto out;
 		}
 
@@ -587,23 +529,19 @@ void *server_fn(void *cfd)
 	}
 
 	free(send_msg);
-	SAFE_CLOSE(cleanup, client_fd);
+	SAFE_CLOSE(client_fd);
 	return NULL;
 
 out:
 	free(send_msg);
-	SAFE_CLOSE(cleanup, client_fd);
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(client_fd);
+	tst_brk(TBROK, "Server closed");
 }
 
 static pthread_t server_thread_add(intptr_t client_fd)
 {
 	pthread_t id;
-	if (pthread_create(&id, &attr, server_fn, (void *) client_fd)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"pthread_create failed@%s:%d", __FILE__, __LINE__);
-	}
+	SAFE_PTHREAD_CREATE(&id, &attr, server_fn, (void *) client_fd);
 	return id;
 }
 
@@ -615,20 +553,20 @@ static void server_init(void)
 	hints.ai_socktype = (use_udp) ? SOCK_DGRAM : SOCK_STREAM;
 	hints.ai_flags = AI_PASSIVE;
 
-	if (getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
+	int err = getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo);
+	if (err)
+		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
 
 	if (!local_addrinfo)
-		tst_brkm(TBROK, cleanup, "failed to get the address");
+		tst_brk(TBROK, "failed to get the address");
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
-	sfd = SAFE_SOCKET(cleanup, AF_INET6, local_addrinfo->ai_socktype, 0);
+	sfd = SAFE_SOCKET(AF_INET6, local_addrinfo->ai_socktype, 0);
 	const int flag = 1;
 	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
-	tst_resm(TINFO, "assigning a name to the server socket...");
-	SAFE_BIND(cleanup, sfd, local_addrinfo->ai_addr,
-		local_addrinfo->ai_addrlen);
+	tst_res(TINFO, "assigning a name to the server socket...");
+	SAFE_BIND(sfd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
 
 	freeaddrinfo(local_addrinfo);
 
@@ -637,27 +575,26 @@ static void server_init(void)
 
 	init_socket_opts(sfd);
 
-	if (fastopen_api == TFO_ENABLED) {
+	if (fastopen_api) {
 		if (setsockopt(sfd, IPPROTO_TCP, TCP_FASTOPEN, &tfo_queue_size,
 			sizeof(tfo_queue_size)) == -1)
-			tst_brkm(TBROK, cleanup, "Can't set TFO sock. options");
+			tst_brk(TBROK, "Can't set TFO sock. options");
 	}
 
-	SAFE_LISTEN(cleanup, sfd, max_queue_len);
-	tst_resm(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
+	SAFE_LISTEN(sfd, max_queue_len);
+	tst_res(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
 }
 
 static void server_cleanup(void)
 {
-	SAFE_CLOSE(NULL, sfd);
+	SAFE_CLOSE(sfd);
 }
 
 static void server_run_udp(void)
 {
 	pthread_t p_id = server_thread_add(sfd);
 
-	if (!pthread_join(p_id, NULL))
-		tst_brkm(TBROK | TERRNO, cleanup, "pthread_join() failed");
+	SAFE_PTHREAD_JOIN(p_id, NULL);
 }
 
 static void server_run(void)
@@ -673,18 +610,18 @@ static void server_run(void)
 	 * once a thread finishes its work.
 	 */
 	if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "setdetachstate failed");
+		tst_brk(TBROK | TERRNO, "setdetachstate failed");
 
 	while (1) {
 		int client_fd = accept(sfd, (struct sockaddr *)&addr6,
 			&addr_size);
 
 		if (client_fd == -1)
-			tst_brkm(TBROK, cleanup, "Can't create client socket");
+			tst_brk(TBROK, "Can't create client socket");
 
 		if (verbose) {
 			char addr_buf[INET6_ADDRSTRLEN];
-			tst_resm(TINFO, "conn: port '%d', addr '%s'",
+			tst_res(TINFO, "conn: port '%d', addr '%s'",
 				addr6.sin6_port, inet_ntop(AF_INET6,
 				&addr6.sin6_addr, addr_buf, INET6_ADDRSTRLEN));
 		}
@@ -693,28 +630,11 @@ static void server_run(void)
 	}
 }
 
-static void check_opt(const char *name, char *arg, int *val, int lim)
+static void require_root(const char *file)
 {
-	if (arg) {
-		if (sscanf(arg, "%i", val) != 1)
-			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
-				 name);
-		if (*val < lim)
-			tst_brkm(TBROK, NULL, "-%s option arg is less than %d",
-				name, lim);
-	}
-}
-
-static void check_opt_l(const char *name, char *arg, long *val, long lim)
-{
-	if (arg) {
-		if (sscanf(arg, "%ld", val) != 1)
-			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
-				 name);
-		if (*val < lim)
-			tst_brkm(TBROK, NULL, "-%s option arg is less than %ld",
-				name, lim);
-	}
+	if (!geteuid())
+		return;
+	tst_brk(TCONF, "Test needs to be run as root to change %s", file);
 }
 
 static void check_tfo_value(void)
@@ -725,13 +645,13 @@ static void check_tfo_value(void)
 	 */
 	if (access(tfo_cfg, W_OK) < 0) {
 		/* TODO check /proc/self/ns/ or TST_USE_NETNS env var */
-		tst_resm(TINFO, "can't read %s, assume server runs in netns",
+		tst_res(TINFO, "can't read %s, assume server runs in netns",
 			tfo_cfg);
 		return;
 	}
 
-	SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
-	tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
+	SAFE_FILE_SCANF(tfo_cfg, "%d", &tfo_cfg_value);
+	tst_res(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
 
 	/* The check can be the first in this function but set here
 	 * to allow to print information about the currently set config
@@ -742,11 +662,11 @@ static void check_tfo_value(void)
 	if (tfo_cfg_value == tfo_value)
 		return;
 
-	tst_require_root();
+	require_root(tfo_cfg);
 
-	tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, tfo_value);
+	tst_res(TINFO, "set '%s' to '%d'", tfo_cfg, tfo_value);
 
-	SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", tfo_value);
+	SAFE_FILE_PRINTF(tfo_cfg, "%d", tfo_value);
 	tfo_cfg_changed = 1;
 }
 
@@ -757,81 +677,79 @@ static void check_tw_reuse(void)
 
 	int reuse_value = 0;
 
-	SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
+	SAFE_FILE_SCANF(tcp_tw_reuse, "%d", &reuse_value);
 	if (reuse_value) {
-		tst_resm(TINFO, "tcp_tw_reuse is already set");
+		tst_res(TINFO, "tcp_tw_reuse is already set");
 		return;
 	}
 
-	tst_require_root();
+	require_root(tfo_cfg);
 
-	SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
+	SAFE_FILE_PRINTF(tcp_tw_reuse, "1");
 	tw_reuse_changed = 1;
-	tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
+	tst_res(TINFO, "set '%s' to '1'", tcp_tw_reuse);
 }
 
-static void setup(int argc, char *argv[])
+static void setup(void)
 {
-	tst_parse_opts(argc, argv, options, help);
+	if (tst_parse_int(aarg, &clients_num, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid client number '%s'", aarg);
+	if (tst_parse_int(rarg, &client_max_requests, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid client max requests '%s'", rarg);
+	if (tst_parse_int(Rarg, &server_max_requests, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid server max requests '%s'", Rarg);
+	if (tst_parse_int(narg, &client_msg_size, 3, max_msg_len))
+		tst_brk(TBROK, "Invalid client msg size '%s'", narg);
+	if (tst_parse_int(Narg, &server_msg_size, 3, max_msg_len))
+		tst_brk(TBROK, "Invalid server msg size '%s'", Narg);
+	if (tst_parse_int(qarg, &tfo_queue_size, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid TFO queue size '%s'", qarg);
+	if (tst_parse_long(Targ, &wait_timeout, 0L, LONG_MAX))
+		tst_brk(TBROK, "Invalid wait timeout '%s'", Targ);
+	if (tst_parse_int(barg, &busy_poll, 0, INT_MAX))
+		tst_brk(TBROK, "Invalid busy poll timeout'%s'", barg);
+	if (tst_parse_int(targ, &tfo_value, 0, INT_MAX))
+		tst_brk(TBROK, "Invalid net.ipv4.tcp_fastopen '%s'", targ);
 
 	/* if client_num is not set, use num of processors */
-	clients_num = sysconf(_SC_NPROCESSORS_ONLN);
-
-	check_opt("a", aarg, &clients_num, 1);
-	check_opt("r", rarg, &client_max_requests, 1);
-	check_opt("R", Rarg, &server_max_requests, 1);
-	check_opt("n", narg, &client_msg_size, 1);
-	check_opt("N", Narg, &server_msg_size, 1);
-	check_opt("q", qarg, &tfo_queue_size, 1);
-	check_opt_l("T", Targ, &wait_timeout, 0L);
-	check_opt("b", barg, &busy_poll, 0);
-	check_opt("t", targ, &tfo_value, 0);
-
-	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0) {
-		tst_brkm(TCONF, NULL,
-			"Test must be run with kernel 3.7 or newer");
-	}
+	if (!clients_num)
+		clients_num = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
-		tst_brkm(TCONF, NULL,
-			"Test must be run with kernel 3.11 or newer");
-	}
+	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0)
+		tst_brk(TCONF, "Test must be run with kernel 3.7 or newer");
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0)
+		tst_brk(TCONF, "Test must be run with kernel 3.11 or newer");
 
-	switch (net_mode) {
-	case SERVER_HOST:
-		tst_resm(TINFO, "max requests '%d'",
-			server_max_requests);
-		net.init	= server_init;
-		net.run		= (use_udp) ? server_run_udp : server_run;
-		net.cleanup	= (use_udp) ? NULL : server_cleanup;
-	break;
-	case CLIENT_HOST:
-		tst_resm(TINFO, "connection: addr '%s', port '%s'",
+	if (client_mode) {
+		tst_res(TINFO, "connection: addr '%s', port '%s'",
 			server_addr, tcp_port);
-		tst_resm(TINFO, "client max req: %d", client_max_requests);
-		tst_resm(TINFO, "clients num: %d", clients_num);
-		tst_resm(TINFO, "client msg size: %d", client_msg_size);
-		tst_resm(TINFO, "server msg size: %d", server_msg_size);
-
+		tst_res(TINFO, "client max req: %d", client_max_requests);
+		tst_res(TINFO, "clients num: %d", clients_num);
+		tst_res(TINFO, "client msg size: %d", client_msg_size);
+		tst_res(TINFO, "server msg size: %d", server_msg_size);
 		net.init	= client_init;
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
 
 		check_tw_reuse();
-	break;
+	} else {
+		tst_res(TINFO, "max requests '%d'",
+			server_max_requests);
+		net.init	= server_init;
+		net.run		= (use_udp) ? server_run_udp : server_run;
+		net.cleanup	= (use_udp) ? NULL : server_cleanup;
 	}
 
 	remote_addr_len = sizeof(struct sockaddr_storage);
 
 	if (use_udp) {
-		tst_resm(TINFO, "using UDP");
-		fastopen_api = TFO_DISABLED;
+		tst_res(TINFO, "using UDP");
+		fastopen_api = NULL;
 	} else {
-		tst_resm(TINFO, "TCP %s is using %s TCP API.",
-			(net_mode == SERVER_HOST) ? "server" : "client",
-			(fastopen_api == TFO_ENABLED) ? "Fastopen" : "old");
+		tst_res(TINFO, "TCP %s is using %s TCP API.",
+			(client_mode) ? "client" : "server",
+			(fastopen_api) ? "Fastopen" : "old");
 
 		check_tfo_value();
 	}
@@ -839,13 +757,38 @@ static void setup(int argc, char *argv[])
 	net.init();
 }
 
-int main(int argc, char *argv[])
+static void do_test(void)
 {
-	setup(argc, argv);
-
 	net.run();
+}
 
-	cleanup();
+static struct tst_option options[] = {
+	{"v", &verbose, "-v       Verbose"},
+	{"f", &fastopen_api, "-f       Use TFO API, default is old API"},
+	{"t:", &targ, "-t x     Set tcp_fastopen value"},
+
+	{"g:", &tcp_port, "-g x     x - server port"},
+	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
+	{"U", &use_udp, "-U       Use UDP\n"},
+
+	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
+	{"l", &client_mode, "-l       Become client, default is server"},
+	{"a:", &aarg, "-a x     Number of clients running in parallel"},
+	{"r:", &rarg, "-r x     Number of client requests"},
+	{"n:", &narg, "-n x     Client message size"},
+	{"N:", &Narg, "-N x     Server message size"},
+	{"T:", &Targ, "-T x     Reply timeout in microsec."},
+	{"d:", &rpath,"-d x     x is a path to file where results are saved\n"},
+
+	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
+	{"q:", &qarg, "-q x     x - TFO queue"},
+	{NULL, NULL, NULL}
+};
 
-	tst_exit();
-}
+static struct tst_test test = {
+	.tid = "netstress",
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = options
+};
-- 
1.7.1

