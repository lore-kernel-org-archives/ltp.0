Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B86D105F7AD
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C23E3E492A
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:23:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714933CB05E
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 14:23:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0EBF91401279
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 14:23:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22D7F4D315
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773408190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vpV4kuKbrq9MkF8M+oxsmQ2Ea0TsbW7+WDvsB4B0ra0=;
 b=fb9H1ttHHoBA/MYtIHQ/gwMEFaOIYePTd1WVZXvNUHa0YWY/XS6+gO6/ixhRFMe9wiXA8d
 jqFjGlT1ZpOE0hXCBkBNQZG8iHORXvY1hEnT+u9yOg9fT0JxB3wFsNv6TdakDfbk8EzRXr
 bmX2Duh07l+qryUdv73KXH5olacnzgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773408190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vpV4kuKbrq9MkF8M+oxsmQ2Ea0TsbW7+WDvsB4B0ra0=;
 b=jXrAiolC3S+j4uVTQm8cR94PQmKJid0JZB1/8RWpeKcN47lptbqOW2oSeM7E9t1hQoJPvJ
 EcYRkDjvCJ2kT1AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773408190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vpV4kuKbrq9MkF8M+oxsmQ2Ea0TsbW7+WDvsB4B0ra0=;
 b=fb9H1ttHHoBA/MYtIHQ/gwMEFaOIYePTd1WVZXvNUHa0YWY/XS6+gO6/ixhRFMe9wiXA8d
 jqFjGlT1ZpOE0hXCBkBNQZG8iHORXvY1hEnT+u9yOg9fT0JxB3wFsNv6TdakDfbk8EzRXr
 bmX2Duh07l+qryUdv73KXH5olacnzgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773408190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vpV4kuKbrq9MkF8M+oxsmQ2Ea0TsbW7+WDvsB4B0ra0=;
 b=jXrAiolC3S+j4uVTQm8cR94PQmKJid0JZB1/8RWpeKcN47lptbqOW2oSeM7E9t1hQoJPvJ
 EcYRkDjvCJ2kT1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B68640545
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 13:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LJqKBr4PtGkEfgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 13:23:10 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 14:23:01 +0100
Message-ID: <20260313132305.16232-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio_cancel_4-1: Rewrite test
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
Then cancel all requests on the input socket and check that request errors
and return values have been set correctly for the canceled requests.
This fixes a race condition where aio_cancel() could be delayed until
after all writes have already completed, making the test unreliable.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Tested on kernels v4.4 and v6.12 as usual.

 .../conformance/interfaces/aio_cancel/4-1.c   | 136 +++++++-----------
 1 file changed, 49 insertions(+), 87 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
index ef615ae64..ac19d8b1a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2026 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -14,122 +15,83 @@
  *
  * method:
  *
- *	we queue a lot of aio_write() operation to a file descriptor
- *	then we try to cancel all aio operation of this file descriptor
- *	we check with aio_error() state of each operation
- *	if aio_error() is ECANCELED and aio_return() is -1
- *	test is passed
- *	if aio_error() is ECANCELED and aio_return() is NOT -1
- *	test fails
- *	otherwise
- *	test is unresolved
+ *	open a pair of sockets and queue writes to them with aio_write()
+ *	execute aio_cancel() on the socket
+ *	check aio_error() and aio_return() results for writes which should
+ *	have been canceled
+ *	if any aio_error() is not ECANCELED or aio_return() is not -1,
+ *	the test fails
+ *	otherwise the test passes
  *
  */
 
-#include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <string.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <aio.h>
 
 #include "posixtest.h"
-#include "tempfile.h"
+#include "aio_test.h"
 
 #define TNAME "aio_cancel/4-1.c"
 
-#define BUF_NB		128
-#define BUF_SIZE	(1024*1024)
+#define WRITE_COUNT	8
+#define MAX_COMPLETE	3
+
+static int fds[2];
+static struct aiocb aiocb[WRITE_COUNT];
 
 int main(void)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
-	struct aiocb *aiocb[BUF_NB];
 	int i;
-	int in_progress;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_4_1");
-	unlink(tmpfname);
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
+	if (setup_aio(TNAME, fds, aiocb, WRITE_COUNT))
 		return PTS_UNRESOLVED;
-	}
-
-	unlink(tmpfname);
-
-	/* create AIO req */
-
-	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = malloc(sizeof(struct aiocb));
-		if (aiocb[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_UNRESOLVED;
-		}
-		memset(aiocb[i], 0, sizeof(struct aiocb));
-		aiocb[i]->aio_fildes = fd;
-		aiocb[i]->aio_buf = malloc(BUF_SIZE);
-		if (aiocb[i]->aio_buf == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_UNRESOLVED;
-		}
-		aiocb[i]->aio_nbytes = BUF_SIZE;
-		aiocb[i]->aio_offset = 0;
-		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
-	}
 
-	for (i = 0; i < BUF_NB; i++) {
-		if (aio_write(aiocb[i]) == -1) {
+	/* submit AIO req */
+	for (i = 0; i < WRITE_COUNT; i++) {
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
+	/* cancel all */
+	if (aio_cancel(fds[0], NULL) == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
+		cleanup_aio(fds, aiocb, WRITE_COUNT);
 		return PTS_FAIL;
 	}
 
-	close(fd);
-
-	do {
-		in_progress = 0;
-		for (i = 0; i < BUF_NB; i++) {
-			int ret;
-
-			ret = (aio_error(aiocb[i]));
-
-			if (ret == -1) {
-				printf(TNAME " Error at aio_error(): %s\n",
-				       strerror(errno));
-				return PTS_FAIL;
-			} else if (ret == EINPROGRESS)
-				in_progress = 1;
-			else if (ret == ECANCELED) {
-				if (aio_return(aiocb[i]) == -1) {
-					printf("Test PASSED\n");
-					return PTS_PASS;
-				}
-
-				printf(TNAME " aio_return is not -1\n");
-				return PTS_FAIL;
-			}
+	/* check results of requests that should have been canceled */
+	for (i = MAX_COMPLETE; i < WRITE_COUNT; i++) {
+		int ret = aio_error(&aiocb[i]);
+
+		if (ret == -1) {
+			printf(TNAME " Error at aio_error(): %s\n",
+			       strerror(errno));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
+			return PTS_FAIL;
+		} else if (ret != ECANCELED) {
+			printf(TNAME " Bad task #%d result: %s "
+				"(expected ECANCELED)\n", i, strerror(ret));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
+			return PTS_FAIL;
+		}
+
+		ret = aio_return(&aiocb[i]);
+
+		if (ret != -1) {
+			printf(TNAME " aio_return(): %d (expected -1)\n", ret);
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
+			return PTS_FAIL;
 		}
-	} while (in_progress);
+	}
 
-	return PTS_UNRESOLVED;
+	cleanup_aio(fds, aiocb, WRITE_COUNT);
+	printf("Test PASSED\n");
+	return PTS_PASS;
 }
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
