Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B9606A32D
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMz9kaDr
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5D773E9A8B
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 14:04:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D97C83E26C4
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 14:03:56 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0775F60086B
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 14:03:56 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2613508f8f.2
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793106235; x=1793711035; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=suny6ici4fgiBRkmrr19rqD/pCK7yh7QkglN1byeuUs=;
 b=NMz9kaDr0++XcS3n2O8TOrYCsTWqR+IpAdaImVGv+pn4j6H6Xt+FgFJsGGr/NNeasN
 EOYOTEZT+SsMmSdXhdQxe7p6RaE1pshvPK6m5wA+rtW9RgDJS/4eeRxBX+V9K3sNhtq4
 lqGnS925uOM08b+u0jKO0MX6W6CxNLpsMeB/Xex0AaYrIw1022jf4279yJ84FiCDrUTf
 exNFZIcCFx80JtIUXSSiN7LFpYIKhn3Z2d+axLpVQGFz3mIdAErMbpOYW0b8Hcs2dSqH
 AtzKYPVjnfYWLqpablV95e7Mc05l5Bdba+2OrlhwZgzzWi7CTgya4+WYtcEOkWwKct1u
 yiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106235; x=1793711035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=suny6ici4fgiBRkmrr19rqD/pCK7yh7QkglN1byeuUs=;
 b=JM1wOeokpDAAWoDoRKWH7lgdohu5q71R+m3jjgGN9SnXBXEiDsuUgT0pmS4fwjV5JI
 qVeuv3iSi/VSK0oDVoqDuQIH9qnnOhaCLM/Or67pbZDIa0FTFJ8ECArUo/Nnc7pF/8Oy
 wEqNj2XxbPAhGYNXVYvgg+IfS2eHIqHUIkZmY0ZBtVH+tu3XC0A+vNBiW0OQmNdzf2gm
 hrh6wiDFlSZO5AyFCB7eg5xfUtgrchl3XGGkp7bAB2a/kjoscmifK+qaTA0EPkJG2BBK
 SyuHCZz2ot2iXmLhwPMPL/uQ/hEex0Ne0xxok48j5fgwUzP2HqTMj+SDiW2CoML0wuDT
 GAnA==
X-Gm-Message-State: AFq9FYKmUkQAkHDHfJwvY5L0ZXKznT0kueCoBhRLNoZsgmrxQO/S4Y+X
 1RQvL0wyWgIZ0CirSlt5GsCaCT9/MwyU/wWcVrelV9LS8zd+EwuPsccWgFbA8Wy8
X-Gm-Gg: AYBFou2YNtMiWlBAQXvH8N0QPJppF2E4elwWUNXsaILgUHgrpG21ENs5B/1SwnNIzxo
 MT4sBUfLoLHXPy8VF2amxLYvLZh3QUba2sidaMaMUwLUJgq2dlovyVtKiIEsyyPRyD6eZB8ib0N
 pirj1M6JopyX56XPPlRUG9j1nLoCj8V2Gqfu9XmbyMz3QiWHnJxP0Uks7MUU3p5W3jF938S7TvI
 bVvTiVy2WAKCRrErxSsTs2MzQI0vx+JAj3HOHh16XSLABSfCpUtauOv4+nHv9gR2Os+g80+vmRO
 i5/KTGlr8GoTpzftbvwtN7OeWU/zIyD8UbuF2nMVim+90JzfGNrlmNxY51ZjEJyZuOQjIUQ95WQ
 2f913BwZqnjZsty4ASX/nfgBg/SKKS+pFhsaV3TMqBdJoGuJWhSjKPs6yFrnthFKB4343f0fjwQ
 tRa0R1Kox6TMwY/Sf0qsfjCXn0L2R3BSSlBtksZCBihDaUdAjRz206VUxdrV/X6k+zZUAUho9io
 GW/7WQJzpp3z2KZl0JwgJaycfxj4rMXrOl+Cn26nDLk4h83+Hl3g1hteo6pB1AyrVmQXiMOtSk1
 mQj36OqSWF1DxkAA7CSq7EBpDo+vngokWOGKOjFY8lc5dwhdXB3YhcccT6tn1Ekmgec=
X-Received: by 2002:a05:6000:481a:b0:48e:4e00:b72d with SMTP id
 ffacd0b85a97d-48e4e00b7c2mr13352745f8f.38.1793106234996; 
 Tue, 27 Oct 2026 06:03:54 -0700 (PDT)
Received: from localhost.suse.org (apn-37-248-176-17.dynamic.gprs.plus.pl.
 [37.248.176.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4d8dsm24161211f8f.36.2026.10.27.06.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:03:54 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 14:03:51 +0100
Message-ID: <20261027130351.26537-1-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] openposix: Fix aio_suspend/1-1 completion race
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@linux.dev>

Regular-file I/O can finish before the pending-request check, making
this test depend on I/O speed and scheduling. Removing the check
would weaken coverage of suspension while I/O is pending.

Use the existing AIO socket helpers and a coordinated draining thread
to keep the selected write pending until the main thread sleeps.
Retain the pending-request check and verify completion after
aio_suspend() returns.

Signed-off-by: Andrea Cervesato <andrea.cervesato@linux.dev>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Co-developed-by: Sebastian Chlad <sebastianchlad@gmail.com>
Signed-off-by: Sebastian Chlad <sebastianchlad@gmail.com>
Assisted-by: ClaudeCode:claude-opus-5-5
---
Andrea has left SUSE, so I'm picking this up and addressing the v2
review comments. The test logic is unchanged from v2.

Tested: 100 runs, plus 100 runs pinned to one CPU, all PASS.

Changes in v3:
- Restore the POSIX "assertion:" section and rename "Steps" to
  "method:", keeping the common Open POSIX header format (Petr, Martin).
- Add SUSE copyright for the rewrite (Petr).
- Link to v2:
  https://lore.kernel.org/ltp/20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com/

 .../conformance/interfaces/aio_suspend/1-1.c  | 268 ++++++++----------
 1 file changed, 118 insertions(+), 150 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
index 8f0c9ae95..ec75c151d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2026 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -23,200 +24,167 @@
  *
  * method: Testing for a NULL timeout
  *
- *	- write to a file
- *	- submit a list of read requests
- *	- check that the selected request has not completed
- *	- suspend on selected request
- *	- check that the selected request has completed using aio_error and
- *	  aio_return
+ *	- queue enough asynchronous writes to fill a socket buffer
+ *	- check that the last write is still pending
+ *	- have a second thread wait for the main thread to sleep before
+ *	  draining the socket
+ *	- suspend on the last write
+ *	- check that the write has completed using aio_error and aio_return
  *
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
+/* Shared with the draining thread; result is read after pthread_join(). */
+static int fds[2];
+static struct aiocb aiocbs[WRITE_COUNT];
+static sem_t start;
+static int drain_result;
 
-static volatile int received_all;
-
-static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
-	siginfo_t *info PTS_ATTRIBUTE_UNUSED, void *context PTS_ATTRIBUTE_UNUSED)
-{
-	received_all = 1;
-}
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
+static void *drain_socket(void *arg PTS_ATTRIBUTE_UNUSED)
 {
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
+
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
 
-	bufs = malloc(NUM_AIOCBS * BUF_SIZE);
+	if (setup_aio(TNAME, fds, aiocbs, WRITE_COUNT))
+		return PTS_UNRESOLVED;
 
-	if (bufs == NULL) {
-		printf(TNAME " Error at malloc(): %s\n", strerror(errno));
-		close(fd);
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
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
