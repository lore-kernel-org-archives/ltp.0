From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  5 Apr 2018 13:56:50 +0300
Subject: [LTP] [PATCH COMMITTED 1/3] netstress: handle pmtu update on
	EMSGSIZE error
Message-ID: <1522925812-17200-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After the error we should get a new route cache with updated
pmtu, resend datagram again using the new one.

The exact number of errors during the test may depend on the
route cache expire time, by defualt it is 600 sec:
  net.ipv4.route.mtu_expires
  net.ipv6.route.mtu_expires

and the total test time. Therefore it is difficult to anticipate
what value we would need, especially for the server that don't
have the requests number parameter. Set it to 10, it should be
enough for most of the test scenarios.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 369a5ee..72f4a40 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -89,6 +89,7 @@ static char *source_addr;
 static char *server_bg;
 static int busy_poll		= -1;
 static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */
+static int max_pmtu_err = 10;
 
 enum {
 	TYPE_TCP = 0,
@@ -139,6 +140,7 @@ struct sock_info {
 	struct sockaddr_storage raddr;
 	socklen_t raddr_len;
 	int etime_cnt;
+	int pmtu_err_cnt;
 	int timeout;
 };
 
@@ -255,8 +257,15 @@ static int client_recv(char *buf, int srv_msg_len, struct sock_info *i)
 		/* socket closed or msg is not valid */
 		if (len < 1 || (offset + len) > srv_msg_len ||
 		   (buf[0] != start_byte && buf[0] != start_fin_byte)) {
-			if (!errno)
+			/* packet too big message, resend with new pmtu */
+			if (errno == EMSGSIZE) {
+				if (++(i->pmtu_err_cnt) < max_pmtu_err)
+					return 0;
+				tst_brk(TFAIL, "too many pmtu errors %d",
+					i->pmtu_err_cnt);
+			} else if (!errno) {
 				errno = ENOMSG;
+			}
 			break;
 		}
 		offset += len;
@@ -357,6 +366,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 	inf.raddr_len = sizeof(inf.raddr);
 	inf.etime_cnt = 0;
 	inf.timeout = wait_timeout;
+	inf.pmtu_err_cnt = 0;
 
 	make_client_request(client_msg, &cln_len, &srv_len);
 
-- 
1.7.1

