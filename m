From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Feb 2019 21:07:46 +0300
Subject: [LTP] [PATCH 3/4] netstress: handle zero length message for
	datagram sockets
In-Reply-To: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1549908467-15609-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't treat them as errors unless there are too many of them.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 63d02c9..63fbaed 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -89,6 +89,7 @@ static char *source_addr;
 static char *server_bg;
 static int busy_poll		= -1;
 static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */
+static int max_eshutdown_cnt = 10;
 static int max_pmtu_err = 10;
 
 enum {
@@ -142,6 +143,7 @@ struct sock_info {
 	socklen_t raddr_len;
 	int etime_cnt;
 	int pmtu_err_cnt;
+	int eshutdown_cnt;
 	int timeout;
 };
 
@@ -287,14 +289,22 @@ static int client_recv(char *buf, int srv_msg_len, struct sock_info *i)
 		return 0;
 	}
 
-	if (errno == ETIME && sock_type != SOCK_STREAM) {
-		if (++(i->etime_cnt) > max_etime_cnt)
-			tst_brk(TFAIL, "client requests timeout %d times, last timeout %dms",
-				i->etime_cnt, i->timeout);
-		/* Increase timeout in poll up to 3.2 sec */
-		if (i->timeout < 3000)
-			i->timeout <<= 1;
-		return 0;
+	if (sock_type != SOCK_STREAM) {
+		if (errno == ETIME) {
+			if (++(i->etime_cnt) > max_etime_cnt)
+				tst_brk(TFAIL, "client requests timeout %d times, last timeout %dms",
+					i->etime_cnt, i->timeout);
+			/* Increase timeout in poll up to 3.2 sec */
+			if (i->timeout < 3000)
+				i->timeout <<= 1;
+			return 0;
+		}
+		if (errno == ESHUTDOWN) {
+			if (++(i->eshutdown_cnt) > max_eshutdown_cnt)
+				tst_brk(TFAIL, "too many zero-length msgs");
+			tst_res(TINFO, "%d-length msg on sock %d", len, i->fd);
+			return 0;
+		}
 	}
 
 	SAFE_CLOSE(i->fd);
-- 
1.7.1

