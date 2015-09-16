From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Sep 2015 12:47:17 +0300
Subject: [LTP] [PATCH 2/4] network/tcp_fastopen: add SO_BUSY_POLL sockoption
In-Reply-To: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1442396839-29900-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Introduce new parameter 'b'. That way we can control whether
sockets are using this feature or not.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen.c |   28 ++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index 08a6019..b42c8c2 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -44,6 +44,10 @@ static const int max_msg_len = 1500;
 #define TCP_FASTOPEN	23
 #endif
 
+#ifndef SO_BUSY_POLL
+#define SO_BUSY_POLL	46
+#endif
+
 /* TCP client requiers */
 #ifndef MSG_FASTOPEN
 #define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
@@ -89,6 +93,7 @@ static int client_max_requests	= 10;
 static int clients_num		= 2;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
+static int busy_poll		= -1;
 /* server socket */
 static int sfd;
 
@@ -101,7 +106,7 @@ static char *rpath		= "./tfo_result";
 static int force_run;
 static int verbose;
 
-static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ;
+static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg;
 
 static const option_t options[] = {
 	/* server params */
@@ -119,6 +124,7 @@ static const option_t options[] = {
 
 	/* common */
 	{"g:", NULL, &tcp_port},
+	{"b:", NULL, &barg},
 	{"F", &force_run, NULL},
 	{"l", &tcp_mode, NULL},
 	{"o", &fastopen_api, NULL},
@@ -135,6 +141,7 @@ static void help(void)
 	printf("  -O      TFO support is off, default is on\n");
 	printf("  -l      Become TCP Client, default is TCP server\n");
 	printf("  -g x    x - server port, default is %s\n", tcp_port);
+	printf("  -b x    x - low latency busy poll timeout\n");
 
 	printf("\n          Client:\n");
 	printf("  -H x    x - server name or ip address, default is '%s'\n",
@@ -269,11 +276,16 @@ static int client_connect_send(const char *msg, int size)
 {
 	int cfd = socket(remote_addrinfo->ai_family, SOCK_STREAM, 0);
 	const int flag = 1;
-	setsockopt(cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
 	if (cfd == -1)
 		return cfd;
 
+	setsockopt(cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
+	if (busy_poll >= 0) {
+		setsockopt(cfd, SOL_SOCKET, SO_BUSY_POLL,
+			   &busy_poll, sizeof(busy_poll));
+	}
+
 	if (fastopen_api == TFO_ENABLED) {
 		/* Replaces connect() + send()/write() */
 		if (sendto(cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
@@ -500,6 +512,11 @@ void *server_fn(void *cfd)
 	char recv_msg[max_msg_len];
 
 	setsockopt(client_fd, SOL_SOCKET, SO_LINGER, &clo, sizeof(clo));
+	if (busy_poll >= 0) {
+		setsockopt(client_fd, SOL_SOCKET, SO_BUSY_POLL,
+			   &busy_poll, sizeof(busy_poll));
+	}
+
 	ssize_t recv_len;
 
 	while (1) {
@@ -689,7 +706,6 @@ static void check_opt_l(const char *name, char *arg, long *val, long lim)
 
 static void setup(int argc, char *argv[])
 {
-	
 	tst_parse_opts(argc, argv, options, help);
 
 	/* if client_num is not set, use num of processors */
@@ -702,6 +718,7 @@ static void setup(int argc, char *argv[])
 	check_opt("N", Narg, &server_msg_size, 1);
 	check_opt("q", qarg, &tfo_queue_size, 1);
 	check_opt_l("T", Targ, &wait_timeout, 0L);
+	check_opt("b", barg, &busy_poll, 0);
 
 	if (!force_run)
 		tst_require_root();
@@ -711,6 +728,11 @@ static void setup(int argc, char *argv[])
 			"Test must be run with kernel 3.7 or newer");
 	}
 
+	if (!force_run && busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 3.11 or newer");
+	}
+
 	/* check tcp fast open knob */
 	if (!force_run && access(tfo_cfg, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "Failed to find '%s'", tfo_cfg);
-- 
1.7.1

