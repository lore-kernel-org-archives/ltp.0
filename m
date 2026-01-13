Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A2FCF45DF
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 15:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7E63C76A5
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 16:02:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 653993C29F5
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 16:02:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 049BB20097C
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 16:02:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DEB75BCCA
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768316523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5Q0l73oB0c2bFSm58aeRpPc90P5JeNPQ5nD4DdQCd20=;
 b=07BLntfaQMsXaN1ifVLvEI7tZE4slW9MYB0Os6Mch/1e+h+VRBwOjjQe9YNdc42FjEL2qT
 cwGNrc8E9GJbLNP6TOz9Bf4Jis4iqr1YMpqmCZOwY2VTRFmVpiaqasEgOqZ12EPq47zBDv
 2MCxX8o+ezOGYqFWJA5ZN1NRPU2oe2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768316523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5Q0l73oB0c2bFSm58aeRpPc90P5JeNPQ5nD4DdQCd20=;
 b=qLHuspAD/lPkWOD4dt1NS7TOgj7BtsZk0+S2pc7nOHL0CjG9tmb/3wSAlMtpi6rVCeved0
 WHfWT9zJIqsbdfDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=07BLntfa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qLHuspAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768316523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5Q0l73oB0c2bFSm58aeRpPc90P5JeNPQ5nD4DdQCd20=;
 b=07BLntfaQMsXaN1ifVLvEI7tZE4slW9MYB0Os6Mch/1e+h+VRBwOjjQe9YNdc42FjEL2qT
 cwGNrc8E9GJbLNP6TOz9Bf4Jis4iqr1YMpqmCZOwY2VTRFmVpiaqasEgOqZ12EPq47zBDv
 2MCxX8o+ezOGYqFWJA5ZN1NRPU2oe2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768316523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5Q0l73oB0c2bFSm58aeRpPc90P5JeNPQ5nD4DdQCd20=;
 b=qLHuspAD/lPkWOD4dt1NS7TOgj7BtsZk0+S2pc7nOHL0CjG9tmb/3wSAlMtpi6rVCeved0
 WHfWT9zJIqsbdfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A3A53EA63
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 15:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y4kiCmteZmnZbwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 15:02:03 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Jan 2026 16:01:55 +0100
Message-ID: <20260113150202.68070-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bull.net:email,suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3DEB75BCCA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio_cancel_5-1: Rewrite test
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
at least one will block long enough that aio_cancel() will fail to cancel
it. Use a socket pair instead of a file to force async writes to block
indefinitely. Then wait for one of the writes to actually block on full
socket buffer. This fixes a race condition where aio_cancel() could be
called while no write is actually in progress (before the first write,
after the last one or between two writes) and the test would fail.

Also rewrite result checks to verify that all writes before the blocked
one actually completed and all writes after the blocked one were cancelled.

Add cleanup helper function that will flush socket buffers, free allocated
memory and close the sockets. Also make setup and cleanup simpler
by statically allocating the aiocb structure array.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Race condition fix using the same socket approach as the earlier rewrite
of aio_cancel_7-1. Tested on kernel v4.4 and v6.12.

 .../conformance/interfaces/aio_cancel/5-1.c   | 185 +++++++++++-------
 1 file changed, 119 insertions(+), 66 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index 5ed4f6d42..559625b13 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2025 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -13,7 +14,7 @@
  *
  * method:
  *
- *	queue a some aio_write() to a file descriptor
+ *	queue some aio_write() to a file descriptor
  *	cancel all operations for this file descriptor
  *	for all operations not canceled at end of operations
  *	verify that values in aiocb is the good ones
@@ -28,117 +29,169 @@
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
 
 #define TNAME "aio_cancel/5-1.c"
 
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
 	char *buf[BUF_NB];
 	int i;
-	int in_progress;
-	static int check_one;
+	int ret;
+	int bufsize;
+	int exp_ret;
+	socklen_t argsize = sizeof(bufsize);
+	const struct timespec sleep_ts = { .tv_sec = 0, .tv_nsec = 10000000 };
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_5_1");
-	unlink(tmpfname);
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
+	ret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
+	if (ret == -1) {
+		printf(TNAME " Error creating sockets(): %s\n",
+			strerror(errno));
+		return PTS_UNRESOLVED;
+	}
+
+	ret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
+	if (ret == -1) {
+		printf(TNAME " Error reading socket buffer size: %s\n",
+			strerror(errno));
+		cleanup();
 		return PTS_UNRESOLVED;
 	}
 
-	unlink(tmpfname);
+	/* Socket buffer size is twice the maximum message size */
+	bufsize /= 2;
 
 	/* create AIO req */
-
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = calloc(1, sizeof(struct aiocb));
-		if (aiocb[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_UNRESOLVED;
-		}
-		buf[i] = malloc(BUF_SIZE);
+		buf[i] = malloc(bufsize);
 		if (buf[i] == NULL) {
 			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
+				strerror(errno));
+			cleanup();
 			return PTS_UNRESOLVED;
 		}
-		aiocb[i]->aio_fildes = fd;
-		aiocb[i]->aio_buf = buf[i];
-		aiocb[i]->aio_nbytes = BUF_SIZE;
-		aiocb[i]->aio_offset = 0;
-		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+		aiocb[i].aio_fildes = fds[0];
+		aiocb[i].aio_buf = buf[i];
+		aiocb[i].aio_nbytes = bufsize;
+		aiocb[i].aio_offset = 0;
+		aiocb[i].aio_sigevent.sigev_notify = SIGEV_NONE;
 
-		if (aio_write(aiocb[i]) == -1) {
+		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-			       i, strerror(errno));
+				i, strerror(errno));
+			cleanup();
 			return PTS_FAIL;
 		}
 	}
 
-	/* try to cancel all
-	 * we hope to have enough time to cancel at least one
-	 */
+	/* wait for write #2 to start and get blocked by full socket buffer */
+	for (i = 0; i < 1000; i++) {
+		ret = aio_error(&aiocb[BLOCKED_TASK - 1]);
+		nanosleep(&sleep_ts, NULL);
 
-	if (aio_cancel(fd, NULL) == -1) {
+		if (ret <= 0)
+			break;
+	}
+
+	if (ret) {
+		printf(TNAME " Task #%d failed to complete: %s\n",
+			BLOCKED_TASK - 1, strerror(ret == -1 ? errno : ret));
+		cleanup();
+		return PTS_FAIL;
+	}
+
+	/* try to cancel all */
+	ret = aio_cancel(fds[0], NULL);
+	if (ret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
+		cleanup();
 		return PTS_FAIL;
 	}
 
-	close(fd);
+	if (ret != AIO_NOTCANCELED) {
+		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
+			strerror(ret));
+		cleanup();
+		return PTS_FAIL;
+	}
 
-	check_one = 0;
-	do {
-		in_progress = 0;
-		for (i = 0; i < BUF_NB; i++) {
-			int ret;
+	for (i = 0, exp_ret = 0; i < BUF_NB; i++) {
+		ret = (aio_error(&aiocb[i]));
 
-			ret = (aio_error(aiocb[i]));
+		if (i == BLOCKED_TASK) {
+			if (ret != EINPROGRESS) {
+				printf(TNAME " Bad task #%d result: %s "
+					"(expected EINPROGRESS)\n",
+					i, strerror(ret));
+				cleanup();
+				return PTS_FAIL;
+			}
 
-			if (ret == -1) {
-				printf(TNAME " Error at aio_error(): %s\n",
-				       strerror(errno));
+			/* check iocb is not modified */
+			if ((aiocb[i].aio_fildes != fds[0]) ||
+				(aiocb[i].aio_buf != buf[i]) ||
+				(aiocb[i].aio_nbytes != (size_t)bufsize) ||
+				(aiocb[i].aio_offset != 0) ||
+				(aiocb[i].aio_sigevent.sigev_notify !=
+				SIGEV_NONE)) {
+
+				printf(TNAME " aiocbp modified\n");
+				cleanup();
 				return PTS_FAIL;
-			} else if ((ret == EINPROGRESS) || (ret == 0)) {
-				if (ret == EINPROGRESS)
-					in_progress = 1;
-
-				check_one = 1;
-
-				/* check iocb is not modified */
-
-				if ((aiocb[i]->aio_fildes != fd) ||
-				    (aiocb[i]->aio_buf != buf[i]) ||
-				    (aiocb[i]->aio_nbytes != BUF_SIZE) ||
-				    (aiocb[i]->aio_offset != 0) ||
-				    (aiocb[i]->aio_sigevent.sigev_notify !=
-				     SIGEV_NONE)) {
-					printf(TNAME " aiocbp modified\n");
-					return PTS_FAIL;
-				}
 			}
+
+			exp_ret = ECANCELED;
+			continue;
 		}
-	} while (in_progress);
 
-	if (!check_one)
-		return PTS_UNRESOLVED;
+		if (ret != exp_ret) {
+			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
+				i, strerror(ret), strerror(exp_ret));
+			cleanup();
+			return PTS_FAIL;
+		}
+	}
 
+	cleanup();
+	printf("Test PASSED\n");
 	return PTS_PASS;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
