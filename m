From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  2 Feb 2017 14:22:26 +0100
Subject: [LTP] [PATCH] aio_suspend_4-1: Fix failures on s390x
Message-ID: <20170202132226.32352-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase often fails on s390x due to fast I/O. The AIO request we
wanted to timeout on finishes too fast most of the time.

While this is not a complete fix it's good enough so that the test works
fine if executed 1000 times, previously the success ratio was between
20% and 80%.

This patch changes:

* The file is written instead of read
  - this simplifies the code and also ensures that we are not just
    reading data from kernel caches

* The file is opened with O_SYNC
  - which increases chance that the buffers are not written too fast

* The timeout is decreased

* The buffer sizes are increased, especially for the AIO operation we
  want to timeout on

+ Simplifications in error paths

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

Jan: Have you seen this test failing on s390x as well?
     Can you please test the patch on RHEL on s390x?

 .../conformance/interfaces/aio_suspend/4-1.c       | 158 +++++++++------------
 1 file changed, 65 insertions(+), 93 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
index 7cf377d..f859aa4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
@@ -13,8 +13,7 @@
  *
  * method: Testing for a non NULL timeout
  *
- *	- write to a file
- *	- submit a list of read requests
+ *	- submit a list of write requests
  *	- check that the selected request has not completed
  *	- suspend on selected request
  *	- check that the suspend timed out
@@ -38,37 +37,38 @@
 #define TNAME "aio_suspend/4-1.c"
 
 #define NUM_AIOCBS	10
-#define BUF_SIZE	(1024*1024)
+#define BUF_SIZE	(2 * 1024 * 1024)
 #define WAIT_FOR_AIOCB	6
+#define WAIT_FOR_AIOCB_BUF_SIZE (20 * 1024 * 1024)
 
-static int received_selected;
-static int received_all;
+static volatile int received_selected;
+static volatile int received_all;
 
-static void sigrt1_handler(int signum, siginfo_t *info, void *context)
+static void sigrt1_handler(int signum)
 {
+	(void)signum;
+
 	received_selected = 1;
 }
 
-static void sigrt2_handler(int signum, siginfo_t *info, void *context)
+static void sigrt2_handler(int signum)
 {
+	(void)signum;
+
 	received_all = 1;
 }
 
 int main(void)
 {
 	char tmpfname[256];
-	int fd;
-
-	struct aiocb **aiocbs;
+	struct aiocb aiocbs[NUM_AIOCBS];
+	struct aiocb *aiolist[NUM_AIOCBS];
 	struct aiocb *plist[2];
-	char *bufs;
 	struct sigaction action;
 	struct sigevent event;
-	struct timespec ts = { 0, 1000 };	/* 1 us */
+	struct timespec ts = {0, 10};
 	int errors = 0;
-	int ret;
-	int err;
-	int i;
+	int ret, err, i, rval, fd;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
@@ -77,7 +77,7 @@ int main(void)
 		 getpid());
 	unlink(tmpfname);
 
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
+	fd = open(tmpfname, O_SYNC | O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
 	if (fd == -1) {
 		printf(TNAME " Error at open(): %s\n", strerror(errno));
@@ -86,41 +86,35 @@ int main(void)
 
 	unlink(tmpfname);
 
-	bufs = malloc(NUM_AIOCBS * BUF_SIZE);
-
-	if (bufs == NULL) {
-		printf(TNAME " Error at malloc(): %s\n", strerror(errno));
-		close(fd);
-		exit(PTS_UNRESOLVED);
-	}
-
-	if (write(fd, bufs, NUM_AIOCBS * BUF_SIZE) != (NUM_AIOCBS * BUF_SIZE)) {
-		printf(TNAME " Error@write(): %s\n", strerror(errno));
-		free(bufs);
-		close(fd);
-		exit(PTS_UNRESOLVED);
-	}
-
-	aiocbs = malloc(sizeof(struct aiocb *) * NUM_AIOCBS);
+	memset(aiocbs, 0, sizeof(aiocbs));
+	size_t buf_offset = 0;
 
 	/* Queue up a bunch of aio reads */
 	for (i = 0; i < NUM_AIOCBS; i++) {
-
-		aiocbs[i] = malloc(sizeof(struct aiocb));
-		memset(aiocbs[i], 0, sizeof(struct aiocb));
-
-		aiocbs[i]->aio_fildes = fd;
-		aiocbs[i]->aio_offset = i * BUF_SIZE;
-		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
-		aiocbs[i]->aio_nbytes = BUF_SIZE;
-		aiocbs[i]->aio_lio_opcode = LIO_READ;
+		size_t buf_size = (i == WAIT_FOR_AIOCB) ?
+		                   WAIT_FOR_AIOCB_BUF_SIZE : BUF_SIZE;
+
+		aiocbs[i].aio_fildes = fd;
+		aiocbs[i].aio_offset = buf_offset;
+		aiocbs[i].aio_buf = malloc(buf_size);
+		aiocbs[i].aio_nbytes = buf_size;
+		aiocbs[i].aio_lio_opcode = LIO_WRITE;
+
+		if (!aiocbs[i].aio_buf) {
+			perror("malloc()");
+			rval = PTS_UNRESOLVED;
+			goto exit;
+		}
 
 		/* Use SIGRTMIN+1 for individual completions */
 		if (i == WAIT_FOR_AIOCB) {
-			aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
-			aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN + 1;
-			aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
+			aiocbs[i].aio_sigevent.sigev_notify = SIGEV_SIGNAL;
+			aiocbs[i].aio_sigevent.sigev_signo = SIGRTMIN + 1;
+			aiocbs[i].aio_sigevent.sigev_value.sival_int = i;
 		}
+
+		buf_offset += buf_size;
+		aiolist[i] = &aiocbs[i];
 	}
 
 	/* Use SIGRTMIN+2 for list completion */
@@ -129,45 +123,37 @@ int main(void)
 	event.sigev_value.sival_ptr = NULL;
 
 	/* Setup handler for individual operation completion */
-	action.sa_sigaction = sigrt1_handler;
+	action.sa_handler = sigrt1_handler;
 	sigemptyset(&action.sa_mask);
 	action.sa_flags = SA_SIGINFO | SA_RESTART;
 	sigaction(SIGRTMIN + 1, &action, NULL);
 
 	/* Setup handler for list completion */
-	action.sa_sigaction = sigrt2_handler;
+	action.sa_handler = sigrt2_handler;
 	sigemptyset(&action.sa_mask);
 	action.sa_flags = SA_SIGINFO | SA_RESTART;
 	sigaction(SIGRTMIN + 2, &action, NULL);
 
 	/* Setup suspend list */
 	plist[0] = NULL;
-	plist[1] = aiocbs[WAIT_FOR_AIOCB];
+	plist[1] = &aiocbs[WAIT_FOR_AIOCB];
 
 	/* Submit request list */
-	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
+	ret = lio_listio(LIO_NOWAIT, aiolist, NUM_AIOCBS, &event);
 
 	if (ret) {
 		printf(TNAME " Error at lio_listio() %d: %s\n",
 		       errno, strerror(errno));
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_UNRESOLVED);
+		rval = PTS_UNRESOLVED;
+		goto exit;
 	}
 
 	/* Check selected request has not completed yet */
 	if (received_selected) {
 		printf(TNAME " Error : AIOCB %d already completed"
 		       " before suspend\n", WAIT_FOR_AIOCB);
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_FAIL);
+		rval = PTS_FAIL;
+		goto exit;
 	}
 
 	/* Suspend on selected request */
@@ -177,63 +163,49 @@ int main(void)
 	if (received_selected) {
 		printf(TNAME " Error : AIOCB %d should not have completed"
 		       " after timed out suspend\n", WAIT_FOR_AIOCB);
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_FAIL);
+		rval = PTS_FAIL;
+		goto exit;
 	}
 
 	/* timed out aio_suspend should return -1 and set errno to EAGAIN */
 	if (ret != -1) {
 		printf(TNAME " aio_suspend() should return -1\n");
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_FAIL);
+		rval = PTS_FAIL;
+		goto exit;
 	}
 
 	if (errno != EAGAIN) {
 		printf(TNAME " aio_suspend() should set errno to EAGAIN:"
 		       " %d (%s)\n", errno, strerror(errno));
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_FAIL);
+		rval = PTS_FAIL;
+		goto exit;
 	}
 
 	/* Wait for list processing completion */
 	while (!received_all)
-		sleep(1);
+		usleep(50000);
 
-	/* Check return code and free things */
 	for (i = 0; i < NUM_AIOCBS; i++) {
-		err = aio_error(aiocbs[i]);
-		ret = aio_return(aiocbs[i]);
+		err = aio_error(&aiocbs[i]);
+		ret = aio_return(&aiocbs[i]);
 
 		if ((err != 0) && (ret != BUF_SIZE)) {
 			printf(TNAME " req %d: error = %d - return = %d\n",
 			       i, err, ret);
 			errors++;
 		}
-
-		free(aiocbs[i]);
 	}
 
-	free(bufs);
-	free(aiocbs);
+	if (errors == 0) {
+		printf(TNAME " PASSED\n");
+		rval = PTS_PASS;
+	} else {
+		rval = PTS_FAIL;
+	}
 
+exit:
+	for (i = 0; i < NUM_AIOCBS; i++)
+		free((void*)aiocbs[i].aio_buf);
 	close(fd);
-
-	if (errors != 0)
-		exit(PTS_FAIL);
-
-	printf(TNAME " PASSED\n");
-
-	return PTS_PASS;
+	return rval;
 }
-- 
2.10.2

