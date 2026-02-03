Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CEAE87823
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 12:51:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE20A3CD15B
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 13:51:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12833CD28F
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5306A1000946
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B63F65BCC7
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdpivvdZPCWK/chmI2Smvs6jTl5hpnfBX2AYqBfwsQQ=;
 b=d6+EJvFADC3LSGVw25rYGxvHDQpZMeHvTORh97bQGZi4AdqTP5KHEsKHWphll0CZNY8pox
 fN2pfaIgisW1yWAoQCmYePXL9GtmaW72UosaqS44rcOEsKlJslpoO2VdhXbumSH35/tE/n
 nxc3zMOXjuD+tCj+KQjzumhx4nldyjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdpivvdZPCWK/chmI2Smvs6jTl5hpnfBX2AYqBfwsQQ=;
 b=2GStFPPb7tm8zkG6xBCBiWeLakmMj+uSG6yri4n1UQraet2+0SHIOZwQcX7IdNN3LNuDUW
 ox5k1V9yvMy+wDBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdpivvdZPCWK/chmI2Smvs6jTl5hpnfBX2AYqBfwsQQ=;
 b=d6+EJvFADC3LSGVw25rYGxvHDQpZMeHvTORh97bQGZi4AdqTP5KHEsKHWphll0CZNY8pox
 fN2pfaIgisW1yWAoQCmYePXL9GtmaW72UosaqS44rcOEsKlJslpoO2VdhXbumSH35/tE/n
 nxc3zMOXjuD+tCj+KQjzumhx4nldyjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdpivvdZPCWK/chmI2Smvs6jTl5hpnfBX2AYqBfwsQQ=;
 b=2GStFPPb7tm8zkG6xBCBiWeLakmMj+uSG6yri4n1UQraet2+0SHIOZwQcX7IdNN3LNuDUW
 ox5k1V9yvMy+wDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EFFB3EA64
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gJauJhXvgWkNcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Feb 2026 12:50:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 13:50:25 +0100
Message-ID: <20260203125029.15413-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203125029.15413-1-mdoucha@suse.cz>
References: <20260203125029.15413-1-mdoucha@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] openposix/aio_cancel: Use setup helper functions
 in tests 5 and 7
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

Simplify setup and cleanup in recently rewritten tests.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../conformance/interfaces/aio_cancel/5-1.c   | 79 +++----------------
 .../conformance/interfaces/aio_cancel/7-1.c   | 79 +++----------------
 2 files changed, 23 insertions(+), 135 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index 559625b13..e7dfca124 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -25,18 +25,13 @@
  *
  */
 
-#include <stdio.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <string.h>
-#include <errno.h>
-#include <stdlib.h>
 #include <time.h>
-#include <aio.h>
-#include <sys/socket.h>
 
 #include "posixtest.h"
+#include "aio_test.h"
 
 #define TNAME "aio_cancel/5-1.c"
 
@@ -46,29 +41,6 @@
 static int fds[2];
 static struct aiocb aiocb[BUF_NB];
 
-static void cleanup(void)
-{
-	int i, ret;
-
-	for (i = 0; i < BUF_NB; i++) {
-		if (!aiocb[i].aio_buf)
-			break;
-
-		ret = aio_error(&aiocb[i]);
-
-		/* flush written data from the socket */
-		if (ret == 0 || ret == EINPROGRESS) {
-			read(fds[1], (void *)aiocb[i].aio_buf,
-				aiocb[i].aio_nbytes);
-		}
-
-		free((void *)aiocb[i].aio_buf);
-	}
-
-	close(fds[0]);
-	close(fds[1]);
-}
-
 int main(void)
 {
 	char *buf[BUF_NB];
@@ -76,49 +48,24 @@ int main(void)
 	int ret;
 	int bufsize;
 	int exp_ret;
-	socklen_t argsize = sizeof(bufsize);
 	const struct timespec sleep_ts = { .tv_sec = 0, .tv_nsec = 10000000 };
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	ret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
-	if (ret == -1) {
-		printf(TNAME " Error creating sockets(): %s\n",
-			strerror(errno));
+	if (setup_aio(TNAME, fds, aiocb, BUF_NB))
 		return PTS_UNRESOLVED;
-	}
 
-	ret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
-	if (ret == -1) {
-		printf(TNAME " Error reading socket buffer size: %s\n",
-			strerror(errno));
-		cleanup();
-		return PTS_UNRESOLVED;
-	}
+	bufsize = aiocb[0].aio_nbytes;
 
-	/* Socket buffer size is twice the maximum message size */
-	bufsize /= 2;
-
-	/* create AIO req */
+	/* submit AIO req */
 	for (i = 0; i < BUF_NB; i++) {
-		buf[i] = malloc(bufsize);
-		if (buf[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-				strerror(errno));
-			cleanup();
-			return PTS_UNRESOLVED;
-		}
-		aiocb[i].aio_fildes = fds[0];
-		aiocb[i].aio_buf = buf[i];
-		aiocb[i].aio_nbytes = bufsize;
-		aiocb[i].aio_offset = 0;
-		aiocb[i].aio_sigevent.sigev_notify = SIGEV_NONE;
+		buf[i] = (char *)aiocb[i].aio_buf;
 
 		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
 				i, strerror(errno));
-			cleanup();
+			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
 	}
@@ -135,7 +82,7 @@ int main(void)
 	if (ret) {
 		printf(TNAME " Task #%d failed to complete: %s\n",
 			BLOCKED_TASK - 1, strerror(ret == -1 ? errno : ret));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
@@ -143,14 +90,14 @@ int main(void)
 	ret = aio_cancel(fds[0], NULL);
 	if (ret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
 	if (ret != AIO_NOTCANCELED) {
 		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
 			strerror(ret));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
@@ -162,7 +109,7 @@ int main(void)
 				printf(TNAME " Bad task #%d result: %s "
 					"(expected EINPROGRESS)\n",
 					i, strerror(ret));
-				cleanup();
+				cleanup_aio(fds, aiocb, BUF_NB);
 				return PTS_FAIL;
 			}
 
@@ -175,7 +122,7 @@ int main(void)
 				SIGEV_NONE)) {
 
 				printf(TNAME " aiocbp modified\n");
-				cleanup();
+				cleanup_aio(fds, aiocb, BUF_NB);
 				return PTS_FAIL;
 			}
 
@@ -186,12 +133,12 @@ int main(void)
 		if (ret != exp_ret) {
 			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
 				i, strerror(ret), strerror(exp_ret));
-			cleanup();
+			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
 	}
 
-	cleanup();
+	cleanup_aio(fds, aiocb, BUF_NB);
 	printf("Test PASSED\n");
 	return PTS_PASS;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 75cd838a3..9fb584656 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -27,16 +27,11 @@
  *	Otherwise pass.
  */
 
-#include <stdio.h>
 #include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <stdlib.h>
 #include <time.h>
-#include <aio.h>
-#include <sys/socket.h>
 
 #include "posixtest.h"
+#include "aio_test.h"
 
 #define TNAME "aio_cancel/7-1.c"
 
@@ -46,79 +41,25 @@
 static int fds[2];
 static struct aiocb aiocb[BUF_NB];
 
-static void cleanup(void)
-{
-	int i, ret;
-
-	for (i = 0; i < BUF_NB; i++) {
-		if (!aiocb[i].aio_buf)
-			break;
-
-		ret = aio_error(&aiocb[i]);
-
-		/* flush written data from the socket */
-		if (ret == 0 || ret == EINPROGRESS) {
-			read(fds[1], (void *)aiocb[i].aio_buf,
-				aiocb[i].aio_nbytes);
-		}
-
-		free((void *)aiocb[i].aio_buf);
-	}
-
-	close(fds[0]);
-	close(fds[1]);
-}
-
 int main(void)
 {
 	int i;
 	int gret;
-	int bufsize;
 	int exp_ret;
-	socklen_t argsize = sizeof(bufsize);
 	const struct timespec sleep_ts = { .tv_sec = 0, .tv_nsec = 10000000 };
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	gret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
-	if (gret == -1) {
-		printf(TNAME " Error creating sockets(): %s\n",
-			strerror(errno));
+	if (setup_aio(TNAME, fds, aiocb, BUF_NB))
 		return PTS_UNRESOLVED;
-	}
 
-	gret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
-	if (gret == -1) {
-		printf(TNAME " Error reading socket buffer size: %s\n",
-			strerror(errno));
-		cleanup();
-		return PTS_UNRESOLVED;
-	}
-
-	/* Socket buffer size is twice the maximum message size */
-	bufsize /= 2;
-
-	/* create AIO req */
+	/* submit AIO req */
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i].aio_fildes = fds[0];
-		aiocb[i].aio_buf = malloc(bufsize);
-
-		if (aiocb[i].aio_buf == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
-			       strerror(errno));
-			cleanup();
-			return PTS_UNRESOLVED;
-		}
-
-		aiocb[i].aio_nbytes = bufsize;
-		aiocb[i].aio_offset = 0;
-		aiocb[i].aio_sigevent.sigev_notify = SIGEV_NONE;
-
 		if (aio_write(&aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
 			       i, strerror(errno));
-			cleanup();
+			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
 	}
@@ -135,7 +76,7 @@ int main(void)
 	if (gret) {
 		printf(TNAME " Task #%d failed to complete: %s\n",
 			BLOCKED_TASK - 1, strerror(gret == -1 ? errno : gret));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
@@ -143,14 +84,14 @@ int main(void)
 	gret = aio_cancel(fds[0], NULL);
 	if (gret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
 	if (gret != AIO_NOTCANCELED) {
 		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
 			strerror(gret));
-		cleanup();
+		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
 
@@ -172,19 +113,19 @@ int main(void)
 			printf(TNAME " Bad task #%d result: %s "
 				"(expected EINPROGRESS)\n",
 				i, strerror(ret));
-			cleanup();
+			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
 
 		if (ret != exp_ret) {
 			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
 				i, strerror(ret), strerror(exp_ret));
-			cleanup();
+			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
 	}
 
-	cleanup();
+	cleanup_aio(fds, aiocb, BUF_NB);
 	printf("Test PASSED\n");
 	return PTS_PASS;
 }
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
