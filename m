Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA6BF3C9A8
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 16:27:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007F33E8B94
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 17:27:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25B633CB264
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 17:27:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8ABD71400BE4
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 17:27:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A662D5BCEC
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771950447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+y8ojt+NGv6a9pncEHOQPKiRZU8EMhX8vYZVefQaKk=;
 b=oSmh956oahMqCmb9hZnJhTg8yGC+gmyH6ECechbvchpBNGgfuXzJtEdjzrgp7a0JNUUSll
 uOwBW3FRJiN+U6FI9XPF5RehjEtew56Aki8BY9ic5fPW31Gc/xft90yWT6j3G7Hep6+6CU
 qjp+MAKEGAzbZgmmm075BqRmp9fWggg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771950447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+y8ojt+NGv6a9pncEHOQPKiRZU8EMhX8vYZVefQaKk=;
 b=Yg0NMUFLKAVOPNmfaZvP6T0dopoZq03ka4ZXMdEUBzLBA1lEMuxxQABP/KHhOb8MCaybYk
 1ehKQtY+wzwSFPDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771950447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+y8ojt+NGv6a9pncEHOQPKiRZU8EMhX8vYZVefQaKk=;
 b=oSmh956oahMqCmb9hZnJhTg8yGC+gmyH6ECechbvchpBNGgfuXzJtEdjzrgp7a0JNUUSll
 uOwBW3FRJiN+U6FI9XPF5RehjEtew56Aki8BY9ic5fPW31Gc/xft90yWT6j3G7Hep6+6CU
 qjp+MAKEGAzbZgmmm075BqRmp9fWggg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771950447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+y8ojt+NGv6a9pncEHOQPKiRZU8EMhX8vYZVefQaKk=;
 b=Yg0NMUFLKAVOPNmfaZvP6T0dopoZq03ka4ZXMdEUBzLBA1lEMuxxQABP/KHhOb8MCaybYk
 1ehKQtY+wzwSFPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D023EA68
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 16:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cJ4rI2/RnWlMSwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 16:27:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Feb 2026 17:27:25 +0100
Message-ID: <20260224162726.28933-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio_cancel_3-1: Rewrite test
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

The test schedules multiple async writes into a file and then hopes that
at least one will block long enough that it can be canceled
before completion. Use a socket pair instead of a file to force async
writes to block indefinitely and make sure at least one can be canceled.
Then cancel all requests on the input socket and check that all signals
have been delivered and the expected number of requests has been canceled.
This fixes a race condition where aio_cancel() could be delayed until
after all writes have already completed, making the test unreliable.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../conformance/interfaces/aio_cancel/3-1.c   | 125 +++++++-----------
 1 file changed, 48 insertions(+), 77 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
index b74d11c6c..4a002d6ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2026 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -14,44 +15,39 @@
  *
  * method:
  *
- *	we queue a lot of aio_write() with a valid sigevent to a file descriptor
- *	next we try to cancel all operations on this file descriptor
- *	we guess some have been finished, other are in progress,
- *	other are waiting
- *	we guess we can cancel all operations waiting
- *	then we analyze aio_error() in the event handler
- *	if aio_error() is ECANCELED, the test is passed
- *	otherwise, we don't know (perhaps we haven't cancel any operation ?)
- *	if number of sig event is not equal to number of aio_write()
- *	the test fails (in fact it hangs).
+ *	open a pair of sockets and queue writes to them with aio_write()
+ *	execute aio_cancel() on the socket
+ *	then analyze aio_error() in the event handler
+ *	if number of sig events is not equal to number of write requests,
+ *	the test fails
+ *	if aio_error() returns ECANCELED for the expected requests,
+ *	the test passes
  *
  */
 
-#include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <string.h>
-#include <errno.h>
 #include <signal.h>
-#include <stdlib.h>
-#include <aio.h>
 #include <time.h>
 
 #include "posixtest.h"
-#include "tempfile.h"
+#include "aio_test.h"
 
 #define TNAME "aio_cancel/3-1.c"
 
-#define BUF_NB		128
-#define BUF_SIZE	(1024 * 1024)
+#define WRITE_COUNT	8
+#define MAX_COMPLETE	3
+#define MAX_WAIT_RETRIES 100
 
-static volatile int countdown = BUF_NB;
+static volatile int countdown = WRITE_COUNT;
 static volatile int canceled;
+static int fds[2];
+static struct aiocb aiocb[WRITE_COUNT];
 
 static void sig_handler(int signum PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
-    void *context PTS_ATTRIBUTE_UNUSED)
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	struct aiocb *a = info->si_value.sival_ptr;
 
@@ -59,98 +55,73 @@ static void sig_handler(int signum PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
 		canceled++;
 
 	aio_return(a);		/* free entry */
-
 	countdown--;
 }
 
 int main(void)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
-	struct aiocb *aiocb_list[BUF_NB];
-	struct aiocb *aiocb;
 	struct sigaction action;
 	struct timespec processing_completion_ts = {0, 10000000};
 	int i;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L) {
-		printf(TNAME " %ld\n", sysconf(_SC_ASYNCHRONOUS_IO));
+		printf(TNAME " Unsupported AIO version: %ld\n",
+			sysconf(_SC_ASYNCHRONOUS_IO));
 		return PTS_UNSUPPORTED;
 	}
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_3_1");
-	unlink(tmpfname);
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
-		return PTS_UNRESOLVED;
-	}
-
-	unlink(tmpfname);
-
 	/* install signal handler */
-
 	action.sa_sigaction = sig_handler;
 	sigemptyset(&action.sa_mask);
 	action.sa_flags = SA_SIGINFO | SA_RESTART;
+
 	if (sigaction(SIGRTMIN + 1, &action, NULL)) {
 		printf(TNAME " Error at sigaction(): %s\n", strerror(errno));
-		return PTS_FAIL;
+		return PTS_UNRESOLVED;
 	}
 
-	/* create AIO req */
-
-	for (i = 0; i < BUF_NB; i++) {
-		aiocb = malloc(sizeof(struct aiocb));
-		if (aiocb == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_FAIL;
-		}
-
-		aiocb->aio_fildes = fd;
-		aiocb->aio_buf = malloc(BUF_SIZE);
-		if (aiocb->aio_buf == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_FAIL;
-		}
-
-		aiocb->aio_nbytes = BUF_SIZE;
-		aiocb->aio_offset = 0;
-
-		aiocb->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
-		aiocb->aio_sigevent.sigev_signo = SIGRTMIN + 1;
-		aiocb->aio_sigevent.sigev_value.sival_ptr = aiocb;
-		aiocb->aio_reqprio = 0;
+	if (setup_aio(TNAME, fds, aiocb, WRITE_COUNT))
+		return PTS_UNRESOLVED;
 
-		aiocb_list[i] = aiocb;
-	}
+	/* submit AIO req */
+	for (i = 0; i < WRITE_COUNT; i++) {
+		aiocb[i].aio_sigevent.sigev_notify = SIGEV_SIGNAL;
+		aiocb[i].aio_sigevent.sigev_signo = SIGRTMIN + 1;
+		aiocb[i].aio_sigevent.sigev_value.sival_ptr = &aiocb[i];
+		aiocb[i].aio_reqprio = 0;
 
-	for (i = 0; i < BUF_NB; i++) {
-		if (aio_write(aiocb_list[i]) == -1) {
+		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-			       i, strerror(errno));
+				i, strerror(errno));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
 			return PTS_FAIL;
 		}
 	}
 
-	/* try to cancel all
-	 * we hope to have enough time to cancel at least one
-	 */
-
-	if (aio_cancel(fd, NULL) == -1) {
+	/* cancel all requests */
+	if (aio_cancel(fds[0], NULL) == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
+		cleanup_aio(fds, aiocb, WRITE_COUNT);
 		return PTS_FAIL;
 	}
 
-	close(fd);
+	cleanup_aio(fds, aiocb, WRITE_COUNT);
 
-	while (countdown)
+	/* wait for signal delivery */
+	for (i = 0; countdown && i < MAX_WAIT_RETRIES; i++)
 		nanosleep(&processing_completion_ts, NULL);
 
-	if (!canceled)
-		return PTS_UNRESOLVED;
+	if (countdown) {
+		printf(TNAME " %d task completion signals were not delivered",
+			countdown);
+		return PTS_FAIL;
+	}
+
+	if (canceled < WRITE_COUNT - MAX_COMPLETE) {
+		printf(TNAME " %d AIO requests got canceled, expected %d",
+			canceled, WRITE_COUNT - MAX_COMPLETE);
+		return PTS_FAIL;
+	}
 
 	printf("Test PASSED\n");
 	return PTS_PASS;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
