From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Mar 2017 15:46:00 +0100
Subject: [LTP] [PATCH v4 1/3] syscalls/mq_timedreceive: convert to new
	API
In-Reply-To: <20170308142154.25916-1-pvorel@suse.cz>
References: <20170308142154.25916-1-pvorel@suse.cz>
Message-ID: <20170310144600.GA2017@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following diff, thanks.

(90% of the changes fixes the -i looping argument as we have to close
 file descriptors, initialize timeouts correctly on each iteration, etc.)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index ab46bc6..cd2282d 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -30,11 +30,13 @@
 static struct sigaction act;
 static pid_t pid;
 static int fd, fd_root;
+static struct timespec timeout_ts;
+static struct timespec eintr_ts;
 
 struct test_case {
 	int len;
 	unsigned prio;
-	struct timespec rq;
+	struct timespec *rq;
 	int fd;
 	int invalid_msg;
 	int send;
@@ -51,12 +53,15 @@ struct test_case {
 static void create_queue(void);
 static void create_queue_nonblock(void);
 static void create_queue_sig(void);
+static void create_queue_timeout(void);
 static void open_fd(void);
 static void unlink_queue(void);
+static void unlink_queue_sig(void);
 
-static struct test_case tcase[] = {
+static const struct test_case tcase[] = {
 	{
 		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.send = 1,
 		.len = 0,
 		.ret = 0,
@@ -64,6 +69,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.send = 1,
 		.len = 1,
 		.ret = 0,
@@ -71,6 +77,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.send = 1,
 		.len = MAX_MSGSIZE,
 		.ret = 0,
@@ -78,6 +85,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.send = 1,
 		.len = 1,
 		.prio = 32767,	/* max priority */
@@ -86,6 +94,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.invalid_msg = 1,
 		.send = 1,
 		.len = 0,
@@ -119,7 +128,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.len = 16,
-		.rq = (struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.rq = &(struct timespec) {.tv_sec = -1, .tv_nsec = 0},
 		.ret = -1,
 		.err = EINVAL,
 		.setup = create_queue,
@@ -127,7 +136,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.len = 16,
-		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = -1},
 		.ret = -1,
 		.err = EINVAL,
 		.setup = create_queue,
@@ -135,7 +144,7 @@ static struct test_case tcase[] = {
 	},
 	{
 		.len = 16,
-		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
 		.ret = -1,
 		.err = EINVAL,
 		.setup = create_queue,
@@ -143,19 +152,19 @@ static struct test_case tcase[] = {
 	},
 	{
 		.len = 16,
-		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 999999999},
 		.ret = -1,
+		.rq = &timeout_ts,
 		.err = ETIMEDOUT,
-		.setup = create_queue,
+		.setup = create_queue_timeout,
 		.cleanup = unlink_queue,
 	},
 	{
 		.len = 16,
-		.rq = (struct timespec) {.tv_sec = 3, .tv_nsec = 0},
+		.rq = &eintr_ts,
 		.ret = -1,
 		.err = EINTR,
 		.setup = create_queue_sig,
-		.cleanup = unlink_queue,
+		.cleanup = unlink_queue_sig,
 	},
 };
 
@@ -175,6 +184,9 @@ static void cleanup(void)
 {
 	if (fd > 0)
 		SAFE_CLOSE(fd);
+
+	if (fd_root > 0)
+		SAFE_CLOSE(fd_root);
 }
 
 static void create_queue(void)
@@ -194,10 +206,23 @@ static void create_queue_nonblock(void)
 
 static void create_queue_sig(void)
 {
+	clock_gettime(CLOCK_REALTIME, &eintr_ts);
+	eintr_ts.tv_sec += 3;
+
 	create_queue();
 	pid = create_sig_proc(SIGINT, 40, 200000);
 }
 
+static void create_queue_timeout(void)
+{
+	clock_gettime(CLOCK_REALTIME, &timeout_ts);
+	timeout_ts.tv_nsec += 50000000;
+	timeout_ts.tv_sec += timeout_ts.tv_nsec / 1000000000;
+	timeout_ts.tv_nsec %= 1000000000;
+
+	create_queue();
+}
+
 static void open_fd(void)
 {
 	fd = fd_root;
@@ -224,16 +249,20 @@ static void unlink_queue(void)
 	mq_unlink(QUEUE_NAME);
 }
 
-static void do_test(unsigned int i)
+static void unlink_queue_sig(void)
 {
-	struct test_case *tc = &tcase[i];
+	SAFE_KILL(pid, SIGTERM);
+	SAFE_WAIT(NULL);
+
+	unlink_queue();
+}
 
+static void do_test(unsigned int i)
+{
+	const struct test_case *tc = &tcase[i];
 	char rmsg[MAX_MSGSIZE];
 	unsigned prio;
-	size_t msg_len;
-
-	fd = -1;
-	pid = 0;
+	size_t msg_len = MAX_MSGSIZE;
 
 	/*
 	 * When test ended with SIGTERM etc, mq descriptor is left remains.
@@ -250,46 +279,39 @@ static void do_test(unsigned int i)
 	if (tc->send)
 		send_msg(fd, tc->len, tc->prio);
 
-	msg_len = MAX_MSGSIZE;
 	if (tc->invalid_msg)
 		msg_len -= 1;
 
-	if (tc->rq.tv_sec >= 0 || tc->rq.tv_nsec != 0)
-		tc->rq.tv_sec += time(NULL);
+	TEST(mq_timedreceive(fd, rmsg, msg_len, &prio, tc->rq));
 
-	/* test */
-	TEST(mq_timedreceive(fd, rmsg, msg_len, &prio, &tc->rq));
-
-	/* cleanup */
 	if (tc->cleanup)
 		tc->cleanup();
 
-	if (pid) {
-		SAFE_KILL(pid, SIGTERM);
-		SAFE_WAIT(NULL);
+	if (TEST_RETURN < 0) {
+		if (TEST_ERRNO != tc->err) {
+			tst_res(TFAIL | TTERRNO,
+				"mq_timedreceive failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		} else {
+			tst_res(TPASS | TTERRNO, "mq_timedreceive failed expectedly");
+		}
+		return;
 	}
 
-	/* result */
-	if (TEST_RETURN != -1) {
-		if (TEST_RETURN != tc->len) {
-			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong msg_len returned %ld, expected %d",
-				TEST_RETURN, tc->len);
-			return;
-		}
 
-		if (tc->prio != prio) {
-			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong prio returned %d, expected %d",
-				prio, tc->prio);
-			return;
-		}
+	if (TEST_RETURN != tc->len) {
+		tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong msg_len returned %ld, expected %d",
+			TEST_RETURN, tc->len);
+		return;
+	}
+
+	if (tc->prio != prio) {
+		tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong prio returned %d, expected %d",
+			prio, tc->prio);
+		return;
 	}
 
-	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret)
-		|| (tc->ret >= 0 && TEST_RETURN < 0))
-		tst_res(TFAIL | TTERRNO, "%d returned: %ld, expected: %d, expected errno: %s (%d)",
-				i, TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
-	else
-		tst_res(TPASS | TTERRNO, "%d returned: %ld", i, TEST_RETURN);
+	tst_res(TPASS, "mq_timedreceive returned %ld prio %u", TEST_RETURN, prio);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
