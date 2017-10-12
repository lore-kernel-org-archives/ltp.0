From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 16:03:47 +0300
Subject: [LTP] [PATCH 3/3] netstress: randomize payload length
In-Reply-To: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
References: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1507813427-3737-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not default, needs '-A x' option, where x is the upper limit
of the random payload.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |  141 ++++++++++++++++++-------------
 1 files changed, 82 insertions(+), 59 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 463e2b0..484278d 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -37,6 +37,7 @@
 #include "tst_test.h"
 
 static const int max_msg_len = (1 << 16) - 1;
+static const int min_msg_len = 5;
 
 #ifndef SOCK_DCCP
 #define SOCK_DCCP		6
@@ -90,10 +91,9 @@ static const int server_byte	= 0x53;
 static const int start_byte	= 0x24;
 static const int start_fin_byte	= 0x25;
 static const int end_byte	= 0x0a;
-static int client_msg_size	= 32;
-static int server_msg_size	= 128;
-static char *client_msg;
-static char *server_msg;
+static int init_cln_msg_len	= 32;
+static int init_srv_msg_len	= 128;
+static int max_rand_msg_len;
 
 /*
  * The number of requests from client after
@@ -130,7 +130,8 @@ static long wait_timeout = 60000000L;
 /* in the end test will save time result in this file */
 static char *rpath = "tfo_result";
 
-static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ;
+static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ,
+	    *Aarg;
 
 /* common structure for TCP/UDP server and TCP/UDP client */
 struct net_func {
@@ -164,9 +165,6 @@ static void init_socket_opts(int sd)
 
 static void do_cleanup(void)
 {
-	free(client_msg);
-	free(server_msg);
-
 	if (net.cleanup)
 		net.cleanup();
 
@@ -224,16 +222,16 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset)
 	return len;
 }
 
-static int client_recv(int *fd, char *buf)
+static int client_recv(int *fd, char *buf, int srv_msg_len)
 {
 	int len, offset = 0;
 
 	while (1) {
 		errno = 0;
-		len = sock_recv_poll(*fd, buf, server_msg_size, offset);
+		len = sock_recv_poll(*fd, buf, srv_msg_len, offset);
 
 		/* socket closed or msg is not valid */
-		if (len < 1 || (offset + len) > server_msg_size ||
+		if (len < 1 || (offset + len) > srv_msg_len ||
 		   (buf[0] != start_byte && buf[0] != start_fin_byte)) {
 			if (!errno)
 				errno = ENOMSG;
@@ -279,20 +277,48 @@ static int client_connect_send(const char *msg, int size)
 	return cfd;
 }
 
+union net_size_field {
+	char bytes[2];
+	uint16_t value;
+};
+
+static void make_client_request(char client_msg[], int *cln_len, int *srv_len)
+{
+	if (max_rand_msg_len)
+		*cln_len = *srv_len = min_msg_len + rand() % max_rand_msg_len;
+
+	memset(client_msg, client_byte, *cln_len);
+	client_msg[0] = start_byte;
+
+	/* set size for reply */
+	union net_size_field net_size;
+
+	net_size.value = htons(*srv_len);
+	client_msg[1] = net_size.bytes[0];
+	client_msg[2] = net_size.bytes[1];
+
+	client_msg[*cln_len - 1] = end_byte;
+}
+
 void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	char buf[server_msg_size];
+	int cln_len = init_cln_msg_len,
+	    srv_len = init_srv_msg_len;
+	char buf[max_msg_len];
+	char client_msg[max_msg_len];
 	int cfd, i = 0;
 	intptr_t err = 0;
 
+	make_client_request(client_msg, &cln_len, &srv_len);
+
 	/* connect & send requests */
-	cfd = client_connect_send(client_msg, client_msg_size);
+	cfd = client_connect_send(client_msg, cln_len);
 	if (cfd == -1) {
 		err = errno;
 		goto out;
 	}
 
-	if (client_recv(&cfd, buf)) {
+	if (client_recv(&cfd, buf, srv_len)) {
 		err = errno;
 		goto out;
 	}
@@ -302,13 +328,13 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 			goto send;
 
 		if (cfd == -1) {
-			cfd = client_connect_send(client_msg, client_msg_size);
+			cfd = client_connect_send(client_msg, cln_len);
 			if (cfd == -1) {
 				err = errno;
 				goto out;
 			}
 
-			if (client_recv(&cfd, buf)) {
+			if (client_recv(&cfd, buf, srv_len)) {
 				err = errno;
 				break;
 			}
@@ -316,9 +342,12 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		}
 
 send:
-		SAFE_SEND(1, cfd, client_msg, client_msg_size, MSG_NOSIGNAL);
+		if (max_rand_msg_len)
+			make_client_request(client_msg, &cln_len, &srv_len);
+
+		SAFE_SEND(1, cfd, client_msg, cln_len, MSG_NOSIGNAL);
 
-		if (client_recv(&cfd, buf)) {
+		if (client_recv(&cfd, buf, srv_len)) {
 			err = errno;
 			break;
 		}
@@ -334,24 +363,6 @@ out:
 	return (void *) err;
 }
 
-union net_size_field {
-	char bytes[2];
-	uint16_t value;
-};
-
-static void make_client_request(void)
-{
-	client_msg[0] = start_byte;
-
-	/* set size for reply */
-	union net_size_field net_size;
-	net_size.value = htons(server_msg_size);
-	client_msg[1] = net_size.bytes[0];
-	client_msg[2] = net_size.bytes[1];
-
-	client_msg[client_msg_size - 1] = end_byte;
-}
-
 static int parse_client_request(const char *msg)
 {
 	union net_size_field net_size;
@@ -376,11 +387,6 @@ static void client_init(void)
 
 	thread_ids = SAFE_MALLOC(sizeof(pthread_t) * clients_num);
 
-	client_msg = SAFE_MALLOC(client_msg_size);
-	memset(client_msg, client_byte, client_msg_size);
-
-	make_client_request();
-
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_UNSPEC;
@@ -424,9 +430,13 @@ static void client_run(void)
 
 	tst_res(TINFO, "total time '%ld' ms", clnt_time);
 
+	char client_msg[min_msg_len];
+	int msg_len = min_msg_len;
+	max_rand_msg_len = 0;
+	make_client_request(client_msg, &msg_len, &msg_len);
 	/* ask server to terminate */
 	client_msg[0] = start_fin_byte;
-	int cfd = client_connect_send(client_msg, client_msg_size);
+	int cfd = client_connect_send(client_msg, msg_len);
 	if (cfd != -1) {
 		shutdown(cfd, SHUT_WR);
 		SAFE_CLOSE(cfd);
@@ -461,7 +471,7 @@ void *server_fn(void *cfd)
 	int num_requests = 0, offset = 0;
 	/* Reply will be constructed from first client request */
 	char send_msg[max_msg_len];
-	int send_msg_size = 0;
+	int send_msg_len = 0;
 	char recv_msg[max_msg_len];
 	ssize_t recv_len;
 
@@ -494,16 +504,13 @@ void *server_fn(void *cfd)
 		if (recv_msg[0] == start_fin_byte)
 			goto out;
 
-		/* if we send reply for the first time, construct it here */
-		if (send_msg[0] != start_byte) {
-			send_msg_size = parse_client_request(recv_msg);
-			if (send_msg_size < 0) {
-				tst_res(TFAIL, "wrong msg size '%d'",
-					send_msg_size);
-				goto out;
-			}
-			make_server_reply(send_msg, send_msg_size);
+		send_msg_len = parse_client_request(recv_msg);
+		if (send_msg_len < 0) {
+			tst_res(TFAIL, "wrong msg size '%d'",
+				send_msg_len);
+			goto out;
 		}
+		make_server_reply(send_msg, send_msg_len);
 
 		offset = 0;
 
@@ -517,11 +524,11 @@ void *server_fn(void *cfd)
 
 		switch (proto_type) {
 		case TYPE_SCTP:
-			SAFE_SEND(1, client_fd, send_msg, send_msg_size,
+			SAFE_SEND(1, client_fd, send_msg, send_msg_len,
 				MSG_NOSIGNAL);
 		break;
 		default:
-			SAFE_SENDTO(1, client_fd, send_msg, send_msg_size,
+			SAFE_SENDTO(1, client_fd, send_msg, send_msg_len,
 				MSG_NOSIGNAL, (struct sockaddr *)&remote_addr,
 				remote_addr_len);
 		}
@@ -709,9 +716,9 @@ static void setup(void)
 		tst_brk(TBROK, "Invalid client max requests '%s'", rarg);
 	if (tst_parse_int(Rarg, &server_max_requests, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid server max requests '%s'", Rarg);
-	if (tst_parse_int(narg, &client_msg_size, 3, max_msg_len))
+	if (tst_parse_int(narg, &init_cln_msg_len, min_msg_len, max_msg_len))
 		tst_brk(TBROK, "Invalid client msg size '%s'", narg);
-	if (tst_parse_int(Narg, &server_msg_size, 3, max_msg_len))
+	if (tst_parse_int(Narg, &init_srv_msg_len, min_msg_len, max_msg_len))
 		tst_brk(TBROK, "Invalid server msg size '%s'", Narg);
 	if (tst_parse_int(qarg, &tfo_queue_size, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid TFO queue size '%s'", qarg);
@@ -721,6 +728,16 @@ static void setup(void)
 		tst_brk(TBROK, "Invalid busy poll timeout'%s'", barg);
 	if (tst_parse_int(targ, &tfo_value, 0, INT_MAX))
 		tst_brk(TBROK, "Invalid net.ipv4.tcp_fastopen '%s'", targ);
+	if (tst_parse_int(Aarg, &max_rand_msg_len, 10, max_msg_len))
+		tst_brk(TBROK, "Invalid max randome payload size '%s'", Aarg);
+
+	if (max_rand_msg_len) {
+		max_rand_msg_len -= min_msg_len;
+		unsigned int seed = max_rand_msg_len ^ client_max_requests;
+
+		srand(seed);
+		tst_res(TINFO, "srand() seed 0x%x", seed);
+	}
 
 	/* if client_num is not set, use num of processors */
 	if (!clients_num)
@@ -739,8 +756,13 @@ static void setup(void)
 			server_addr, tcp_port);
 		tst_res(TINFO, "client max req: %d", client_max_requests);
 		tst_res(TINFO, "clients num: %d", clients_num);
-		tst_res(TINFO, "client msg size: %d", client_msg_size);
-		tst_res(TINFO, "server msg size: %d", server_msg_size);
+		if (max_rand_msg_len) {
+			tst_res(TINFO, "random msg size [%d %d]",
+				min_msg_len, max_rand_msg_len);
+		} else {
+			tst_res(TINFO, "client msg size: %d", init_cln_msg_len);
+			tst_res(TINFO, "server msg size: %d", init_srv_msg_len);
+		}
 		net.init	= client_init;
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
@@ -822,7 +844,8 @@ static struct tst_option options[] = {
 	{"n:", &narg, "-n x     Client message size"},
 	{"N:", &Narg, "-N x     Server message size"},
 	{"m:", &Targ, "-m x     Reply timeout in microsec."},
-	{"d:", &rpath, "-d x     x is a path to file where result is saved\n"},
+	{"d:", &rpath, "-d x     x is a path to file where result is saved"},
+	{"A:", &Aarg, "-A x     x max payload length (generated randomly)\n"},
 
 	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
 	{"q:", &qarg, "-q x     x - TFO queue"},
-- 
1.7.1

