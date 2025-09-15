Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59184CAC597
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 14:49:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5429D3CDA31
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 16:48:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 786803C736D
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 16:48:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D8972200348
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 16:48:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6343B33731
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757947719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sBpPljYvvdl8307FRqK/+ZtqYQbel9bVfgCeJmD6EWc=;
 b=ybifhGVc0eE0GyqBAiY1uVLz+EdWsg4rnlSeyp6NPlMsWBkIqpnnEPiuHiWO+A1eDThA7V
 6oITb/uKb9Q2x+VC5lvPXKoacOjb2wwAh0z9BkEwpiY63Gke9s6J+n+CIlNyUtrqs3E67i
 /5t4A3Ct7/iAgku4KguYNPZRilWXgHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757947719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sBpPljYvvdl8307FRqK/+ZtqYQbel9bVfgCeJmD6EWc=;
 b=Zn+aUEQtv4aXvLkCo0UmFP1LN+UK2gRihRFL3eHIaZ4xy68EMTFY025Q/bXyJ9ZVfAbMK8
 DM8gIu2ow8XnHuAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757947719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sBpPljYvvdl8307FRqK/+ZtqYQbel9bVfgCeJmD6EWc=;
 b=ybifhGVc0eE0GyqBAiY1uVLz+EdWsg4rnlSeyp6NPlMsWBkIqpnnEPiuHiWO+A1eDThA7V
 6oITb/uKb9Q2x+VC5lvPXKoacOjb2wwAh0z9BkEwpiY63Gke9s6J+n+CIlNyUtrqs3E67i
 /5t4A3Ct7/iAgku4KguYNPZRilWXgHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757947719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sBpPljYvvdl8307FRqK/+ZtqYQbel9bVfgCeJmD6EWc=;
 b=Zn+aUEQtv4aXvLkCo0UmFP1LN+UK2gRihRFL3eHIaZ4xy68EMTFY025Q/bXyJ9ZVfAbMK8
 DM8gIu2ow8XnHuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506541372E
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 14:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zk5lE0cnyGgxaAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 14:48:39 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Sep 2025 16:48:35 +0200
Message-ID: <20250915144836.6201-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] aio_cancel_7-1: Rewrite test
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
Then wait for one of the writes to actually block on full socket buffer.
This fixes a race condition where aio_cancel() could be called while
no write is actually in progress (before the first write, after the last
one or between two writes) and the test would fail.

Also rewrite result checks to verify that all writes before the blocked
one actually completed and all writes after the blocked one were cancelled.

Add cleanup helper function that will flush socket buffers, free allocated
memory and close the sockets. Also make setup and cleanup simpler
by statically allocating the aiocb structure array.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Rebased to current master.

Changes since v2:
- Changed argsize from unsigned int to socklen_t
- Improved test cleanup using a helper function

Changes since v3:
- Update test description and copyright header
- Statically allocate aiocb array to avoid unnecessary calloc()
- Wait for write #2 to actually block
- Rewrite result checks to eliminate weird edge cases
- Flush socket buffers during cleanup

 .../conformance/interfaces/aio_cancel/7-1.c   | 209 ++++++++++--------
 1 file changed, 121 insertions(+), 88 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 34b263245..a8a6e4d9e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2025 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -14,145 +15,177 @@
  *
  * method:
  *
- *	queue a lot of aio_write() to a given file descriptor
- *	then cancel all operation belonging to this file descriptor
+ *	queue multiple aio_write()s to a given socket
+ *	wait for a specific task to start and block on full socket buffer
+ *	then cancel all operations belonging to this socket
  *	check result of each operation:
- *	- if aio_error() is EINPROGRESS and aio_cancel() is not AIO_NOTCANCELED
- *	  result is failed
- *	- if aio_error() is succes (0) and aio_cancel() is AIO_NOTCANCELED
- *	  result is susccess
- *	- otherwise result is unresolved
- *
+ *	- aio_cancel() must return AIO_NOTCANCELED
+ *	- aio_error() must return 0 for writes before the blocked task
+ *	- aio_error() must return EINPROGRESS for the blocked task
+ *	- aio_error() must return ECANCELED for writes after the blocked task
+ *	If any of the above conditions is not met, fail the test.
+ *	Otherwise pass.
  */
 
 #include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <time.h>
 #include <aio.h>
+#include <sys/socket.h>
 
 #include "posixtest.h"
-#include "tempfile.h"
 
 #define TNAME "aio_cancel/7-1.c"
 
-#define BUF_NB		128
-#define BUF_SIZE	1024
+#define BUF_NB		8
+#define BLOCKED_TASK	2
+
+static int fds[2];
+static struct aiocb aiocb[BUF_NB];
+
+static void cleanup(void)
+{
+	int i, ret;
+
+	for (i = 0; i < BUF_NB; i++) {
+		if (!aiocb[i].aio_buf)
+			break;
+
+		ret = aio_error(&aiocb[i]);
+
+		/* flush written data from the socket */
+		if (ret == 0 || ret == EINPROGRESS) {
+			read(fds[1], (void *)aiocb[i].aio_buf,
+				aiocb[i].aio_nbytes);
+		}
+
+		free((void *)aiocb[i].aio_buf);
+	}
+
+	close(fds[0]);
+	close(fds[1]);
+}
 
 int main(void)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
-	struct aiocb *aiocb[BUF_NB];
 	int i;
-	int in_progress;
 	int gret;
+	int bufsize;
+	int exp_ret;
+	socklen_t argsize = sizeof(bufsize);
+	const struct timespec sleep_ts = { .tv_sec = 0, .tv_nsec = 10000000 };
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_7_1");
-	unlink(tmpfname);
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
+	gret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
+	if (gret == -1) {
+		printf(TNAME " Error creating sockets(): %s\n",
+			strerror(errno));
+		return PTS_UNRESOLVED;
+	}
+
+	gret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
+	if (gret == -1) {
+		printf(TNAME " Error reading socket buffer size: %s\n",
+			strerror(errno));
+		cleanup();
 		return PTS_UNRESOLVED;
 	}
 
-	unlink(tmpfname);
+	/* Socket buffer size is twice the maximum message size */
+	bufsize /= 2;
 
 	/* create AIO req */
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = calloc(1, sizeof(struct aiocb));
+		aiocb[i].aio_fildes = fds[0];
+		aiocb[i].aio_buf = malloc(bufsize);
 
-		if (aiocb[i] == NULL) {
+		if (aiocb[i].aio_buf == NULL) {
 			printf(TNAME " Error at malloc(): %s\n",
 			       strerror(errno));
-			close(fd);
+			cleanup();
 			return PTS_UNRESOLVED;
 		}
 
-		aiocb[i]->aio_fildes = fd;
-		aiocb[i]->aio_buf = malloc(BUF_SIZE);
+		aiocb[i].aio_nbytes = bufsize;
+		aiocb[i].aio_offset = 0;
+		aiocb[i].aio_sigevent.sigev_notify = SIGEV_NONE;
 
-		if (aiocb[i]->aio_buf == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			close(fd);
-			return PTS_UNRESOLVED;
-		}
-
-		aiocb[i]->aio_nbytes = BUF_SIZE;
-		aiocb[i]->aio_offset = 0;
-		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
-
-		if (aio_write(aiocb[i]) == -1) {
+		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
 			       i, strerror(errno));
-			close(fd);
+			cleanup();
 			return PTS_FAIL;
 		}
 	}
 
-	/* try to cancel all
-	 * we hope to have enough time to cancel at least one
-	 */
-	gret = aio_cancel(fd, NULL);
+	/* wait for write #2 to start and get blocked by full socket buffer */
+	for (i = 0; i < 1000; i++) {
+		gret = aio_error(&aiocb[BLOCKED_TASK - 1]);
+		nanosleep(&sleep_ts, NULL);
+
+		if (gret <= 0)
+			break;
+	}
+
+	if (gret) {
+		printf(TNAME " Task #%d failed to complete: %s\n",
+			BLOCKED_TASK - 1, strerror(gret == -1 ? errno : gret));
+		cleanup();
+		return PTS_FAIL;
+	}
+
+	/* try to cancel all */
+	gret = aio_cancel(fds[0], NULL);
 	if (gret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
-		close(fd);
+		cleanup();
 		return PTS_FAIL;
 	}
 
-	do {
-		in_progress = 0;
-		for (i = 0; i < BUF_NB; i++) {
-			int ret = aio_error(aiocb[i]);
-
-			switch (ret) {
-			case -1:
-				printf(TNAME " Error at aio_error(): %s\n",
-				       strerror(errno));
-				close(fd);
-				return PTS_FAIL;
-				break;
-			case EINPROGRESS:
-				/* at this point, all operations should be:
-				 *    canceled
-				 * or in progress
-				 *    with aio_cancel() == AIO_NOTCANCELED
-				 */
-				if (gret != AIO_NOTCANCELED) {
-					printf(TNAME
-					       " Error at aio_error(): %s\n",
-					       strerror(errno));
-					close(fd);
-					return PTS_FAIL;
-				}
-
-				in_progress = 1;
-				break;
-			case 0:
-				/* we seek one not canceled and check why.
-				 * (perhaps) it has not been canceled
-				 * because it was in progress
-				 * during the cancel operation
-				 */
-				if (gret == AIO_NOTCANCELED) {
-					printf("Test PASSED\n");
-					close(fd);
-					return PTS_PASS;
-				}
-				break;
+	if (gret != AIO_NOTCANCELED) {
+		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
+			strerror(gret));
+		cleanup();
+		return PTS_FAIL;
+	}
+
+	/*
+	 * check write results, expected values:
+	 * - 0 for the first two writes
+	 * - EINPROGRESS for the third
+	 * - ECANCELED for the rest
+	 */
+	for (i = 0, exp_ret = 0; i < BUF_NB; i++) {
+		int ret = aio_error(&aiocb[i]);
+
+		if (i == BLOCKED_TASK) {
+			if (ret == EINPROGRESS) {
+				exp_ret = ECANCELED;
+				continue;
 			}
+
+			printf(TNAME " Bad task #%d result: %s "
+				"(expected EINPROGRESS)\n",
+				i, strerror(ret));
+			cleanup();
+			return PTS_FAIL;
 		}
-	} while (in_progress);
 
-	close(fd);
+		if (ret != exp_ret) {
+			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
+				i, strerror(ret), strerror(exp_ret));
+			cleanup();
+			return PTS_FAIL;
+		}
+	}
 
-	return PTS_UNRESOLVED;
+	cleanup();
+	return PTS_PASS;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
