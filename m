From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:25 +0300
Subject: [LTP] [PATCH 3/6] netstress: support setting local source address
In-Reply-To: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1511874508-12360-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   41 ++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 5d7c657..41d5952 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 
 #include "lapi/posix_clocks.h"
+#include "tst_safe_stdio.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
 
@@ -108,6 +109,7 @@ static int client_max_requests	= 10;
 static int clients_num;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
+static char *source_addr;
 static int busy_poll		= -1;
 static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */
 
@@ -278,6 +280,10 @@ static int client_connect_send(const char *msg, int size)
 		SAFE_SENDTO(1, cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
 			remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
 	} else {
+		if (local_addrinfo) {
+			SAFE_BIND(cfd, local_addrinfo->ai_addr,
+				  local_addrinfo->ai_addrlen);
+		}
 		/* old TCP API */
 		SAFE_CONNECT(cfd, remote_addrinfo->ai_addr,
 			     remote_addrinfo->ai_addrlen);
@@ -390,6 +396,19 @@ static int parse_client_request(const char *msg)
 static struct timespec tv_client_start;
 static struct timespec tv_client_end;
 
+static void setup_addrinfo(const char *src_addr, const char *port,
+			   const struct addrinfo *hints,
+			   struct addrinfo **addr_info)
+{
+	int err = getaddrinfo(src_addr, port, hints, addr_info);
+
+	if (err)
+		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
+
+	if (!*addr_info)
+		tst_brk(TBROK, "failed to get the address");
+}
+
 static void client_init(void)
 {
 	if (clients_num >= MAX_THREADS) {
@@ -406,11 +425,9 @@ static void client_init(void)
 	hints.ai_flags = 0;
 	hints.ai_protocol = 0;
 
-	int err = getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
-	if (err) {
-		tst_brk(TBROK, "getaddrinfo of '%s' failed, %s",
-			server_addr, gai_strerror(err));
-	}
+	if (source_addr)
+		setup_addrinfo(source_addr, NULL, &hints, &local_addrinfo);
+	setup_addrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
 
 	tst_res(TINFO, "Running the test over IPv%s",
 		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
@@ -570,6 +587,7 @@ static pthread_t server_thread_add(intptr_t client_fd)
 
 static void server_init(void)
 {
+	char *src_addr = NULL;
 	struct addrinfo hints;
 
 	memset(&hints, 0, sizeof(struct addrinfo));
@@ -577,13 +595,11 @@ static void server_init(void)
 	hints.ai_socktype = sock_type;
 	hints.ai_flags = AI_PASSIVE;
 
-	int err = getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo);
-
-	if (err)
-		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
-
-	if (!local_addrinfo)
-		tst_brk(TBROK, "failed to get the address");
+	if (source_addr && !strchr(source_addr, ':'))
+		SAFE_ASPRINTF(&src_addr, "::ffff:%s", source_addr);
+	setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
+		       &hints, &local_addrinfo);
+	free(src_addr);
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
 	sfd = SAFE_SOCKET(family, sock_type, protocol);
@@ -842,6 +858,7 @@ static struct tst_option options[] = {
 		"-F       TCP_FASTOPEN_CONNECT socket option and standard API"},
 	{"t:", &targ, "-t x     Set tcp_fastopen value"},
 
+	{"S:", &source_addr, "-S x     Source address to bind"},
 	{"g:", &tcp_port, "-g x     x - server port"},
 	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
 	{"T:", &type, "-T x     tcp (default), udp, dccp, sctp\n"},
-- 
1.7.1

