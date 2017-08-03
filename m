From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Aug 2017 17:33:47 +0200
Subject: [LTP] [RFC PATCH 2/4] Convert cve-2016-7117 test to use long
	running threads
In-Reply-To: <20170803153349.32766-1-rpalethorpe@suse.com>
References: <20170803153349.32766-1-rpalethorpe@suse.com>
Message-ID: <20170803153349.32766-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/cve/cve-2016-7117.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index deb667761..e047f5001 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -103,15 +103,18 @@ static void cleanup(void)
 
 static void *send_and_close(void *arg)
 {
-	send(socket_fds[0], MSG, sizeof(MSG), 0);
-	send(socket_fds[0], MSG, sizeof(MSG), 0);
+	while(tst_fzsync_pair_wait_update(&fzsync_pair)) {
+		send(socket_fds[0], MSG, sizeof(MSG), 0);
+		send(socket_fds[0], MSG, sizeof(MSG), 0);
 
-	tst_fzsync_delay_b(&fzsync_pair);
-
-	close(socket_fds[0]);
-	close(socket_fds[1]);
-	tst_fzsync_time_b(&fzsync_pair);
+		tst_fzsync_delay_b(&fzsync_pair);
 
+		close(socket_fds[0]);
+		close(socket_fds[1]);
+		tst_fzsync_time_b(&fzsync_pair);
+		if (!tst_fzsync_pair_wait(&fzsync_pair))
+			return arg;
+	}
 	return arg;
 }
 
@@ -121,13 +124,13 @@ static void run(void)
 	int i, stat, too_early_count = 0;
 
 	msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;
+	SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
 
 	for (i = 1; i < ATTEMPTS; i++) {
 		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
 
-		SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
-
+		tst_fzsync_pair_wait_update(&fzsync_pair);
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		stat = tst_syscall(__NR_recvmmsg,
@@ -140,16 +143,11 @@ static void run(void)
 		else if (stat < 0)
 			tst_res(TWARN | TERRNO, "recvmmsg failed unexpectedly");
 
-		SAFE_PTHREAD_JOIN(pt_send, 0);
-
-		tst_fzsync_pair_update(i, &fzsync_pair);
-		if (!(i & 0x7FFFF)) {
-			tst_res(TINFO, "Too early: %.1f%%",
-				100 * too_early_count / (float)i);
-			tst_fzsync_pair_info(&fzsync_pair);
-		}
+		tst_fzsync_pair_wait(&fzsync_pair);
 	}
 
+	tst_fzsync_pair_exit(&fzsync_pair);
+	SAFE_PTHREAD_JOIN(pt_send, 0);
 	tst_res(TPASS, "Nothing happened after %d attempts", ATTEMPTS);
 }
 
-- 
2.13.3

