Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B49FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:54:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CBA23E49C1
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:54:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDB443E49D4
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:53:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D50C60065B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:53:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7A9A5BD55
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777474399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=borK3gJBk7NQ4DzFfIEDBqNotbvP1I1zcVnM2qUmBlk=;
 b=ijikGZitqQP9V4SNVy7hxS8RG9ESgXmLSykwVENHzY2YozE3zKj6WKda+d02e6sUUQh2x2
 LUcLWBbX6gQ8AXuFBqWcyC3E6yhtFuvohbsw0L6cYaCdxxvW9487/x9AZCxAWBdOr/ghdP
 y/2NaZB+0VrgThHJ/uleOH9zBXY+ogA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777474399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=borK3gJBk7NQ4DzFfIEDBqNotbvP1I1zcVnM2qUmBlk=;
 b=DKjowcMHbsI3JMo7TNS/mfTUC6f5BC+vOnyDjPAvcMXNd26VEfGmNhNyhAUvNZ6f7rOXSL
 Ydf+mXD4wb/0ycDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777474395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=borK3gJBk7NQ4DzFfIEDBqNotbvP1I1zcVnM2qUmBlk=;
 b=PV/wAz2RnkuuSaIHX5mfSxGGjhc1ealRoyGr0JnbGeGlz50p/vV/Uw2/GSFRCeINCdb0sj
 +EkaAnkzyHxBqI52P+xLCarw+CgrBS+cQJQhXhmDGNXXvCOh2c/RhS/hq5DjUf7sq9NzsI
 +vaW7IfrC6z7JBtN3k8qB2Ftrz1Ujxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777474395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=borK3gJBk7NQ4DzFfIEDBqNotbvP1I1zcVnM2qUmBlk=;
 b=8uDsvs4m2kkGFCnAxiWBnfwZpXSLSOsXt/LWzges5vW72Jf6vo5/Vu/b/2QMmsYIcLCKJQ
 PNfQbt5LoHc0tqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D9E593B1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IGxqLFsb8mlPfwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 16:53:12 +0200
Message-ID: <20260429145314.79256-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429145314.79256-1-mdoucha@suse.cz>
References: <20260429145314.79256-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] aio_cancel_6-1: Rewrite test
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
at least one will block long enough that aio_cancel() will cancel it.
Use a socket pair instead of a file to force async writes to block
indefinitely, then cancel one of the blocked writes.  This fixes a race
condition where aio_cancel() could be called after the target write
has already finished. Also improve result checks to verify that
non-canceled writes are still pending.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Removed strerror() call on aio_cancel() return value

 .../conformance/interfaces/aio_cancel/6-1.c   | 135 +++++++-----------
 1 file changed, 48 insertions(+), 87 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
index 2e3d64742..623dcd8e5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, Bull SA. All rights reserved.
+ * Copyright (c) 2026 SUSE LLC
  * Created by:  Laurent.Vivier@bull.net
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
@@ -14,128 +15,88 @@
  *
  * method:
  *
- *	queue a lot of aio_write() to a given fildes.
- *	try to cancel the last one submited
- *	if aio_error() is ECANCELED and aio_cancel() is AIO_CANCELED
- *	test is passed
- *	if aio_error() is ECANCELED and aio_cancel() is NOT AIO_CANCELED
- *	test is failed
- *	if there is no aio_error() with ECANCELED and
- *	aio_cancel() is AIO_CANCELED
- *	test is failed
- *	otherwise test is unresolved
+ *	queue multiple aio_write()s to a given socket
+ *	try to cancel a task which hasn't been started yet
+ *	if aio_cancel() return value is not AIO_CANCELED, the test failed
+ *	for blocked tasks, aio_error() must be:
+ *	- ECANCELED if aio_cancel() was called on it
+ *	- EINPROGRESS otherwise
+ *	if all aio_error() values match, the test passed, otherwise it failed
  *
  */
 
-#include <stdio.h>
-#include <sys/types.h>
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
 
 #define TNAME "aio_cancel/6-1.c"
 
-#define BUF_NB		128
-#define BUF_SIZE	1024
+#define WRITE_COUNT	8
+#define MAX_COMPLETE	3
+#define CANCELED_TASK	5
+
+static int fds[2];
+static struct aiocb aiocb[WRITE_COUNT];
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
-	struct aiocb *aiocb[BUF_NB];
 	int i;
-	int in_progress;
 	int gret;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_6_1");
-	unlink(tmpfname);
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
+	if (setup_aio(TNAME, fds, aiocb, WRITE_COUNT))
 		return PTS_UNRESOLVED;
-	}
-
-	unlink(tmpfname);
 
 	/* create AIO req */
-
-	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = calloc(1, sizeof(struct aiocb));
-		if (aiocb[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			return PTS_UNRESOLVED;
-		}
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
-
-		if (aio_write(aiocb[i]) == -1) {
+	for (i = 0; i < WRITE_COUNT; i++) {
+		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-			       i, strerror(errno));
+				i, strerror(errno));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
 			return PTS_FAIL;
 		}
 	}
 
 	/* try to cancel the last one queued */
-
-	gret = aio_cancel(fd, aiocb[i - 1]);
+	gret = aio_cancel(fds[0], &aiocb[CANCELED_TASK]);
 
 	if (gret == -1) {
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
-				if (gret == AIO_CANCELED) {
-					printf("Test PASSED\n");
-					return PTS_PASS;
-				}
-
-				printf(TNAME
-				       " aio_cancel() is not AIO_CANCELED\n");
-				return PTS_FAIL;
-			}
+	if (gret != AIO_CANCELED) {
+		printf(TNAME " Unexpected aio_cancel() return value %d\n",
+			gret);
+		cleanup_aio(fds, aiocb, WRITE_COUNT);
+		return PTS_FAIL;
+	}
+
+	for (i = MAX_COMPLETE; i < WRITE_COUNT; i++) {
+		int exp_ret = (i == CANCELED_TASK) ? ECANCELED : EINPROGRESS;
+		int ret = aio_error(&aiocb[i]);
+
+		if (ret == -1) {
+			printf(TNAME " Error at aio_error(): %s\n",
+				strerror(errno));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
+			return PTS_FAIL;
 		}
-	} while (in_progress);
 
-	if (gret == AIO_CANCELED) {
-		printf(TNAME
-		       " aio_cancel() is AIO_CANCELED without ECANCELED\n");
-		return PTS_FAIL;
+		if (ret != exp_ret) {
+			printf(TNAME " Bad task #%d result %s",
+				i, strerror(ret));
+			printf(" (expected: %s)\n", strerror(exp_ret));
+			cleanup_aio(fds, aiocb, WRITE_COUNT);
+			return PTS_FAIL;
+		}
 	}
 
-	return PTS_UNRESOLVED;
+	cleanup_aio(fds, aiocb, WRITE_COUNT);
+	printf("Test PASSED\n");
+	return PTS_PASS;
 }
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
