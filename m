Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCFCA5FCB
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 13:22:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0F53E57FB
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 15:22:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52D523E54DC
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 15:22:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BC7F600195
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 15:22:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBB0721E46;
 Thu,  1 Oct 2026 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790860934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C3MNYsJ8BN3fEq+oRLbRom84fCEMpuxInJwxYP0UJb8=;
 b=qeFht+kkmgPoVrV0Qw1izE+53zBGnHXRvhI6yNZ4T7b0iZKFuN2+1iQRbwFX3KwyP42OS6
 qDHLvPDfiHtZ9invT8Tqghm/ll7m3baar9BkY/Cpu1mdKjnladQDwLG8HEWn4N7JduHk78
 WZ0t8FRdqD6qYCDpG5I0B6GteNQAAZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790860934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C3MNYsJ8BN3fEq+oRLbRom84fCEMpuxInJwxYP0UJb8=;
 b=t3A48RAmB62LTnAmF+WpSa2fmXQsYKqq466f1NnVCG7gcm9SUGuwaLZ/q/EIUgUjOKabhn
 xNMXw55+/Q92mtBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790860929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C3MNYsJ8BN3fEq+oRLbRom84fCEMpuxInJwxYP0UJb8=;
 b=lEZSDuXkOXEBloOXtiaP1KsgPzrHoqvYcmGzqx8RJIQj/vvW65e/lsILk8ItK3ideKdibq
 XyPt53Y886UjiPrPZVBEQWYMmj6t3rdHDpI3b1rWZgWuYXrklt7W/zK7beD9IN3PArxdv/
 HNuTz6NMYtrlD2MSJTuk6FFJt9gOHuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790860929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C3MNYsJ8BN3fEq+oRLbRom84fCEMpuxInJwxYP0UJb8=;
 b=Co+uW9Ct+/FbIBkbVJAPdOOb7cUqB21QSUtT5y6SbIjj0NF4y12gojZ56xsxGvP2+bCHI9
 4MopAt2jqJDoI2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1ACF134B3;
 Thu,  1 Oct 2026 13:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zsiTIYFevmrOKQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Oct 2026 13:22:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Oct 2026 15:22:08 +0200
MIME-Version: 1.0
Message-Id: <20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com>
X-B4-Tracking: v=1; b=H4sIAH9evmoC/32N0QqDMAxFf0XyPEdbVzf2tP8YIrWNM4NZaVQ2p
 P++1r2PQOCQk3s3YAyEDNdig4ArMfkxgToUYAczPrAklxiUULUUQpY9vVtDvuWFJxxdKdOoTmi
 je+ecriB9TgGTtqfemx/z0j3RzjkqGwPx7MNnr11l9v43rHkZW9Xa2cv5hP0tXfFo/QuaGOMXi
 weAbMcAAAA=
X-Change-ID: 20261001-fix_aio_suspend-1-1-2b05a5fddd53
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790860929; l=11781;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Q6tCx1caR35K1IGhhwOo4oB6MM3jhmsHYP1q/qFQYtk=;
 b=KaUkS5n/SuSVqNBMScrVeZHixoXPok/FYrSx20VsObwI5SVESUJUum+Objd5N5Zd91zS17Mvk
 TaqhvW4aN8XC8q9Cp7lvEVBv8gsBYSLA7d9bUOOxMByZKWW+Q/KikQG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: Fix aio_suspend/1-1 completion race
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Regular-file I/O can finish before the pending-request check, making
this test depend on I/O speed and scheduling. Removing the check
would weaken coverage of suspension while I/O is pending.

Use the existing AIO socket helpers and a coordinated draining thread
to keep the selected write pending until the main thread sleeps.
Retain the pending-request check and verify completion after
aio_suspend() returns.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
The aio_suspend/1-1 test relies on regular-file I/O remaining pending
until the test checks its status. If the selected request completes
too quickly, the test reports an unresolved result.

Replace regular-file I/O with writes to a socket pair, using the
existing AIO setup and cleanup helpers. A second thread waits for the
main thread to sleep before draining the socket. This preserves the
pending-request check and exercises aio_suspend() waiting for I/O.

The test passed 100 normal runs and 100 runs pinned to one CPU.
It also rejected all 30 injected cases where aio_suspend() returned
success without waiting. Build, checkpatch, and whitespace checks
passed.

Changes in v2:
- Preserve the pending-I/O check, following Martin Doucha's feedback.
- Use a full socket and a coordinated draining thread.
- Reuse setup_aio() and cleanup_aio().
- Link to v1:
  https://lore.kernel.org/20261001-fix_aio_suspend-1-1-v1-1-ac365dc874ef@suse.com
---
 .../conformance/interfaces/aio_suspend/1-1.c       | 284 +++++++++------------
 1 file changed, 118 insertions(+), 166 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
index 8f0c9ae95..d08709ee9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
@@ -7,216 +7,168 @@
  */
 
 /*
- * assertion:
- *
- *	The aio_suspend() function shall suspend the calling thread until at
- *	least one of the asynchronous I/O operations referenced by the list
- *	argument has completed, until a signal interrupts the function, or,
- *	if timeout is not NULL, until the time interval specified by timeout
- *	has passed.
- *
- *	The application may determine which AIO completed by scanning operations
- *	using aio_error() and aio_return().
- *
- *	aio_supend() shall return zero after one or more AIO operations have
- *	completed.
- *
- * method: Testing for a NULL timeout
- *
- *	- write to a file
- *	- submit a list of read requests
- *	- check that the selected request has not completed
- *	- suspend on selected request
- *	- check that the selected request has completed using aio_error and
- *	  aio_return
+ * Test that aio_suspend() with a NULL timeout waits for pending I/O.
  *
+ * Steps:
+ * 1. Queue enough asynchronous writes to fill a socket buffer.
+ * 2. Check that the last write is still pending.
+ * 3. Have a second thread wait for the main thread to sleep before
+ *    draining the socket.
+ * 4. Call aio_suspend() and check that the write has completed on return.
  */
 
-#include <sys/stat.h>
-#include <aio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
+#include <pthread.h>
+#include <semaphore.h>
 #include <unistd.h>
 
 #include "posixtest.h"
-#include "tempfile.h"
+#include "aio_test.h"
+#include "proc.h"
 
 #define TNAME "aio_suspend/1-1.c"
+#define WRITE_COUNT 8
+#define WAIT_FOR_AIOCB (WRITE_COUNT - 1)
 
-#define NUM_AIOCBS	10
-#define BUF_SIZE	(1024*1024)
-#define WAIT_FOR_AIOCB	6
-
-static volatile int received_all;
+/* Shared with the draining thread; result is read after pthread_join(). */
+static int fds[2];
+static struct aiocb aiocbs[WRITE_COUNT];
+static sem_t start;
+static int drain_result;
 
-static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
-	siginfo_t *info PTS_ATTRIBUTE_UNUSED, void *context PTS_ATTRIBUTE_UNUSED)
+static void *drain_socket(void *arg PTS_ATTRIBUTE_UNUSED)
 {
-	received_all = 1;
-}
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	char tmpfname[PATH_MAX];
-	int fd;
-
-	struct aiocb **aiocbs;
-	struct aiocb *plist[2];
-	char *bufs;
-	struct sigaction action;
-	struct sigevent event;
-	int errors = 0;
-	int ret;
-	int err;
+	char buf;
 	int i;
+	ssize_t ret;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
-		return PTS_UNSUPPORTED;
+	while (sem_wait(&start) == -1) {
+		if (errno == EINTR)
+			continue;
+		perror(TNAME " sem_wait()");
+		exit(PTS_UNRESOLVED);
+	}
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_1_1");
-	unlink(tmpfname);
+	/* getpid() identifies the main thread, not this draining thread. */
+	if (tst_process_state_wait3(getpid(), 'S', 10))
+		drain_result = PTS_UNRESOLVED;
 
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
+	/* Leave one datagram for cleanup_aio(); discard the other payloads. */
+	for (i = 0; i < WRITE_COUNT - 1; i++) {
+		do {
+			ret = read(fds[1], &buf, sizeof(buf));
+		} while (ret == -1 && errno == EINTR);
 
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
-		exit(PTS_UNRESOLVED);
+		if (ret != sizeof(buf)) {
+			printf(TNAME " Error reading socket: %zd (%s)\n",
+			       ret, ret == -1 ? strerror(errno) : "short read");
+			exit(PTS_UNRESOLVED);
+		}
 	}
 
-	unlink(tmpfname);
+	return NULL;
+}
 
-	bufs = malloc(NUM_AIOCBS * BUF_SIZE);
+int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
+{
+	const struct aiocb *list[] = {NULL, &aiocbs[WAIT_FOR_AIOCB]};
+	pthread_t thread;
+	int i, ret, err;
+	int result = PTS_PASS;
+	ssize_t len;
+
+	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L) {
+		printf(TNAME " Test UNSUPPORTED: asynchronous I/O\n");
+		return PTS_UNSUPPORTED;
+	}
 
-	if (bufs == NULL) {
-		printf(TNAME " Error at malloc(): %s\n", strerror(errno));
-		close(fd);
+	if (setup_aio(TNAME, fds, aiocbs, WRITE_COUNT))
+		return PTS_UNRESOLVED;
+
+	if (sem_init(&start, 0, 0) == -1) {
+		perror(TNAME " sem_init()");
 		exit(PTS_UNRESOLVED);
 	}
 
-	if (write(fd, bufs, NUM_AIOCBS * BUF_SIZE) != (NUM_AIOCBS * BUF_SIZE)) {
-		printf(TNAME " Error at write(): %s\n", strerror(errno));
-		free(bufs);
-		close(fd);
+	ret = pthread_create(&thread, NULL, drain_socket, NULL);
+	if (ret) {
+		printf(TNAME " pthread_create(): %s\n", strerror(ret));
 		exit(PTS_UNRESOLVED);
 	}
 
-	aiocbs = malloc(sizeof(struct aiocb *) * NUM_AIOCBS);
-
-	/* Queue up a bunch of aio reads */
-	for (i = 0; i < NUM_AIOCBS; i++) {
-		aiocbs[i] = malloc(sizeof(struct aiocb));
-		memset(aiocbs[i], 0, sizeof(struct aiocb));
-
-		aiocbs[i]->aio_fildes = fd;
-		aiocbs[i]->aio_offset = i * BUF_SIZE;
-		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
-		aiocbs[i]->aio_nbytes = BUF_SIZE;
-		aiocbs[i]->aio_lio_opcode = LIO_READ;
+	for (i = 0; i < WRITE_COUNT; i++) {
+		if (aio_write(&aiocbs[i]) == -1) {
+			perror(TNAME " aio_write()");
+			exit(PTS_UNRESOLVED);
+		}
 	}
 
-	/* Use SIGRTMIN + 1 for list completion */
-	event.sigev_notify = SIGEV_SIGNAL;
-	event.sigev_signo = SIGRTMIN + 1;
-	event.sigev_value.sival_ptr = NULL;
-
-	/* Setup handler for list completion */
-	action.sa_sigaction = sigrt1_handler;
-	sigemptyset(&action.sa_mask);
-	action.sa_flags = SA_SIGINFO | SA_RESTART;
-	sigaction(SIGRTMIN + 1, &action, NULL);
-
-	/* Setup suspend list */
-	plist[0] = NULL;
-	plist[1] = aiocbs[WAIT_FOR_AIOCB];
-
-	/* Submit request list */
-	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
-	if (ret) {
-		printf(TNAME " Error at lio_listio() %d: %s\n",
-		       errno, strerror(errno));
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
+	err = aio_error(&aiocbs[WAIT_FOR_AIOCB]);
+	if (err != EINPROGRESS) {
+		printf(TNAME " Expected pending write, got status %d\n", err);
 		exit(PTS_UNRESOLVED);
 	}
 
-	/* Check selected request has not completed yet */
-	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
-	if (!err) {
-		printf(TNAME " Error : AIOCB %d already completed before "
-		       "suspend\n", WAIT_FOR_AIOCB);
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
+	/* After releasing the drainer, only aio_suspend() should block us. */
+	if (sem_post(&start) == -1) {
+		perror(TNAME " sem_post()");
 		exit(PTS_UNRESOLVED);
 	}
 
-	/* Suspend on selected request */
-	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
+	ret = aio_suspend(list, 2, NULL);
 	if (ret) {
-		printf(TNAME " Error at aio_suspend() %d: %s\n",
-		       errno, strerror(errno));
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
+		perror(TNAME " aio_suspend()");
 		exit(PTS_FAIL);
 	}
 
-	/* Check selected request has completed */
-	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
-	ret = aio_return(aiocbs[WAIT_FOR_AIOCB]);
-
-	if ((err != 0) && (ret != BUF_SIZE)) {
-		printf(TNAME " Error : AIOCB %d should have completed"
-		       " after suspend\n", WAIT_FOR_AIOCB);
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
+	err = aio_error(&aiocbs[WAIT_FOR_AIOCB]);
+	if (err != 0) {
+		printf(TNAME " Test FAILED: write status after suspend: %d\n", err);
 		exit(PTS_FAIL);
 	}
 
-	/* Wait for list processing completion */
-	while (!received_all)
-		sleep(1);
-
-	/* Check return code and free things */
-	for (i = 0; i < NUM_AIOCBS; i++) {
-		if (i == WAIT_FOR_AIOCB)
-			continue;
-
-		err = aio_error(aiocbs[i]);
-		ret = aio_return(aiocbs[i]);
-
-		if ((err != 0) && (ret != BUF_SIZE)) {
-			printf(TNAME " req %d: error = %d - return = %d\n",
-			       i, err, ret);
-			errors++;
+	ret = pthread_join(thread, NULL);
+	if (ret) {
+		printf(TNAME " pthread_join(): %s\n", strerror(ret));
+		exit(PTS_UNRESOLVED);
+	}
+	if (drain_result != PTS_PASS)
+		result = drain_result;
+
+	/* All writes can now complete, regardless of their execution order. */
+	for (i = 0; i < WRITE_COUNT; i++) {
+		const struct aiocb *req = &aiocbs[i];
+
+		while ((err = aio_error(req)) == EINPROGRESS) {
+			if (aio_suspend(&req, 1, NULL) == -1 && errno != EINTR) {
+				perror(TNAME " aio_suspend() during cleanup");
+				exit(PTS_UNRESOLVED);
+			}
+		}
+		if (err) {
+			printf(TNAME " Test FAILED: write %d status %d\n", i, err);
+			exit(PTS_FAIL);
 		}
-
-		free(aiocbs[i]);
 	}
 
-	free(bufs);
-	free(aiocbs);
-
-	close(fd);
-
-	if (errors != 0)
-		exit(PTS_FAIL);
+	/* Only one datagram remains; the helper frees its buffer and sockets. */
+	cleanup_aio(fds, &aiocbs[WAIT_FOR_AIOCB], 1);
+	for (i = 0; i < WRITE_COUNT; i++) {
+		len = aio_return(&aiocbs[i]);
+		if (len != (ssize_t)aiocbs[i].aio_nbytes) {
+			printf(TNAME " Test FAILED: write %d returned %zd, expected %zu\n",
+			       i, len, aiocbs[i].aio_nbytes);
+			result = PTS_FAIL;
+		}
+		if (i != WAIT_FOR_AIOCB)
+			free((void *)aiocbs[i].aio_buf);
+	}
 
-	printf("Test PASSED\n");
+	if (sem_destroy(&start) == -1) {
+		perror(TNAME " sem_destroy()");
+		result = PTS_UNRESOLVED;
+	}
+	if (result == PTS_PASS)
+		printf("Test PASSED\n");
 
-	return PTS_PASS;
+	return result;
 }

---
base-commit: 65c0cffc7dda79320e551f6437327a5625e88d65
change-id: 20261001-fix_aio_suspend-1-1-2b05a5fddd53

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
