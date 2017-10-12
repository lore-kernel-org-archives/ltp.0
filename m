From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 16:03:45 +0300
Subject: [LTP] [PATCH 1/3] netstress: allow to resend requests for udp and
	dccp
Message-ID: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 4b211aa..78ef270 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -105,6 +105,7 @@ static int clients_num;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
 static int busy_poll		= -1;
+static int max_etime_cnt, etime_cnt;
 
 enum {
 	TYPE_TCP = 0,
@@ -216,6 +217,9 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset)
 		if (len == -1 && errno == EINTR)
 			continue;
 
+		if (len == 0)
+			errno = ESHUTDOWN;
+
 		break;
 	}
 
@@ -252,6 +256,12 @@ static int client_recv(int *fd, char *buf)
 		return 0;
 	}
 
+	if (errno == ETIME && sock_type != SOCK_STREAM) {
+		if (tst_atomic_inc(&etime_cnt) > max_etime_cnt)
+			tst_brk(TFAIL, "protocol timeout");
+		return 0;
+	}
+
 	SAFE_CLOSE(*fd);
 	return (errno) ? -1 : 0;
 }
@@ -436,6 +446,9 @@ static void client_run(void)
 	/* the script tcp_fastopen_run.sh will remove it */
 	SAFE_FILE_PRINTF(rpath, "%ld", clnt_time);
 
+	if (sock_type != SOCK_STREAM && etime_cnt > 0)
+		tst_res(TWARN, "timeout requests %d", etime_cnt);
+
 	tst_res(TPASS, "test completed");
 }
 
@@ -756,6 +769,13 @@ static void setup(void)
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
 
+		if (proto_type == TYPE_DCCP || proto_type == TYPE_UDP) {
+			max_etime_cnt = client_max_requests / 1000 *
+					clients_num + 3; /* ~0.1% */
+			tst_res(TINFO, "max timeout errors %d", max_etime_cnt);
+			wait_timeout = 100000L;
+		}
+
 		check_tw_reuse();
 	} else {
 		tst_res(TINFO, "max requests '%d'",
-- 
1.7.1

