From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 16:03:46 +0300
Subject: [LTP] [PATCH 2/3] netstress: remove verbose output
In-Reply-To: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
References: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1507813427-3737-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's not really helpful, can be done with tcpdump.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 78ef270..463e2b0 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -130,8 +130,6 @@ static long wait_timeout = 60000000L;
 /* in the end test will save time result in this file */
 static char *rpath = "tfo_result";
 
-static char *verbose;
-
 static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ;
 
 /* common structure for TCP/UDP server and TCP/UDP client */
@@ -245,11 +243,6 @@ static int client_recv(int *fd, char *buf)
 		if (buf[offset - 1] != end_byte)
 			continue;
 
-		if (verbose) {
-			tst_res_hexd(TINFO, buf, offset,
-				"msg recv from sock %d:", *fd);
-		}
-
 		/* recv last msg, close socket */
 		if (buf[0] == start_fin_byte)
 			break;
@@ -323,11 +316,6 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		}
 
 send:
-		if (verbose) {
-			tst_res_hexd(TINFO, client_msg, client_msg_size,
-				"try to send msg[%d]", i);
-		}
-
 		SAFE_SEND(1, cfd, client_msg, client_msg_size, MSG_NOSIGNAL);
 
 		if (client_recv(&cfd, buf)) {
@@ -506,11 +494,6 @@ void *server_fn(void *cfd)
 		if (recv_msg[0] == start_fin_byte)
 			goto out;
 
-		if (verbose) {
-			tst_res_hexd(TINFO, recv_msg, offset,
-				"msg recv from sock %d:", client_fd);
-		}
-
 		/* if we send reply for the first time, construct it here */
 		if (send_msg[0] != start_byte) {
 			send_msg_size = parse_client_request(recv_msg);
@@ -642,13 +625,6 @@ static void server_run(void)
 		if (client_fd == -1)
 			tst_brk(TBROK, "Can't create client socket");
 
-		if (verbose) {
-			char addr_buf[INET6_ADDRSTRLEN];
-			tst_res(TINFO, "conn: port '%d', addr '%s'",
-				addr6.sin6_port, inet_ntop(AF_INET6,
-				&addr6.sin6_addr, addr_buf, INET6_ADDRSTRLEN));
-		}
-
 		server_thread_add(client_fd);
 	}
 }
@@ -832,7 +808,6 @@ static void do_test(void)
 }
 
 static struct tst_option options[] = {
-	{"v", &verbose, "-v       Verbose"},
 	{"f", &fastopen_api, "-f       Use TFO API, default is old API"},
 	{"t:", &targ, "-t x     Set tcp_fastopen value"},
 
-- 
1.7.1

