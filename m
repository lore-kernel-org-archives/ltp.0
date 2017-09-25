From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 25 Sep 2017 11:51:35 +0200
Subject: [LTP] [PATCH v4 5/7] Convert cve-2016-7117 test to use long running
	threads
In-Reply-To: <20170925095137.31491-1-rpalethorpe@suse.com>
References: <20170925095137.31491-1-rpalethorpe@suse.com>
Message-ID: <20170925095137.31491-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/cve-2016-7117.c | 47 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index deb667761..3cb7efcdf 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -71,7 +71,7 @@ struct mmsghdr {
 };
 #endif
 
-static int socket_fds[2];
+static volatile int socket_fds[2];
 static struct mmsghdr msghdrs[2] = {
 	{
 		.msg_hdr = {
@@ -94,40 +94,53 @@ static struct mmsghdr msghdrs[2] = {
 static char rbuf[sizeof(MSG)];
 static struct timespec timeout = { .tv_sec = RECV_TIMEOUT };
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
+static pthread_t pt_send;
+static void *send_and_close(void *);
+
+static void setup(void)
+{
+	SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
+}
 
 static void cleanup(void)
 {
 	close(socket_fds[0]);
 	close(socket_fds[1]);
+
+	if (pt_send) {
+		tst_fzsync_pair_exit(&fzsync_pair);
+		SAFE_PTHREAD_JOIN(pt_send, 0);
+	}
 }
 
 static void *send_and_close(void *arg)
 {
-	send(socket_fds[0], MSG, sizeof(MSG), 0);
-	send(socket_fds[0], MSG, sizeof(MSG), 0);
-
-	tst_fzsync_delay_b(&fzsync_pair);
+	while (tst_fzsync_wait_update_b(&fzsync_pair)) {
+		send(socket_fds[0], MSG, sizeof(MSG), 0);
+		send(socket_fds[0], MSG, sizeof(MSG), 0);
 
-	close(socket_fds[0]);
-	close(socket_fds[1]);
-	tst_fzsync_time_b(&fzsync_pair);
+		tst_fzsync_delay_b(&fzsync_pair);
 
+		close(socket_fds[0]);
+		close(socket_fds[1]);
+		tst_fzsync_time_b(&fzsync_pair);
+		if (!tst_fzsync_wait_b(&fzsync_pair))
+			break;
+	}
 	return arg;
 }
 
 static void run(void)
 {
-	pthread_t pt_send;
 	int i, stat, too_early_count = 0;
 
 	msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;
 
 	for (i = 1; i < ATTEMPTS; i++) {
-		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, socket_fds))
+		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
 
-		SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
-
+		tst_fzsync_wait_update_a(&fzsync_pair);
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		stat = tst_syscall(__NR_recvmmsg,
@@ -140,20 +153,14 @@ static void run(void)
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
+		tst_fzsync_wait_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "Nothing happened after %d attempts", ATTEMPTS);
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
-- 
2.14.1

