Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B92DCA0EDC
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 13:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D88B23CBB58
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 15:16:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28D973CB133
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:16:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C4FA100040D
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:16:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3ADEC219C7
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755177382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HE0qGOxw38tplh62/Epi2GYgMcQl7yAH7TEqp0Y/olE=;
 b=lUisLAeBbX5GY1cN9PzAma8GMi1eUV0SgyVsqJFQnXucbq2qMuPjT6HljeUe84nEBdd6bc
 TAlq54olwIRpkzkczxWhg6r7UxAX4A26d9gjLHQw5wOjvONmUWOw1BDJPeCxh+SKLD+875
 B4WOgEaLUPrR69GSXeeDnjnkWLmeHOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755177382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HE0qGOxw38tplh62/Epi2GYgMcQl7yAH7TEqp0Y/olE=;
 b=1niK/SpNmHPhwKe7ImLPeH0pDczUstzK2YBvViZyx0P/EGHuLR2+eZwO4HQrXtaHiGop/z
 Am4+DLS7JU3YiYBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lUisLAeB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1niK/SpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755177382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HE0qGOxw38tplh62/Epi2GYgMcQl7yAH7TEqp0Y/olE=;
 b=lUisLAeBbX5GY1cN9PzAma8GMi1eUV0SgyVsqJFQnXucbq2qMuPjT6HljeUe84nEBdd6bc
 TAlq54olwIRpkzkczxWhg6r7UxAX4A26d9gjLHQw5wOjvONmUWOw1BDJPeCxh+SKLD+875
 B4WOgEaLUPrR69GSXeeDnjnkWLmeHOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755177382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HE0qGOxw38tplh62/Epi2GYgMcQl7yAH7TEqp0Y/olE=;
 b=1niK/SpNmHPhwKe7ImLPeH0pDczUstzK2YBvViZyx0P/EGHuLR2+eZwO4HQrXtaHiGop/z
 Am4+DLS7JU3YiYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 313581368C
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 13:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c73SC6bhnWj4ZAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 13:16:22 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Aug 2025 15:16:13 +0200
Message-ID: <20250814131615.19626-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 3ADEC219C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio_cancel_7-1: Write into a socket
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

Also add another case to the final result check because the aio_cancel()
call may happen between one write finishing and another write starting.
Then the cancel will be successful and all non-zero task results will be
ECANCELED.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../conformance/interfaces/aio_cancel/7-1.c   | 81 ++++++++++++-------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 268408ab1..28c8fe78a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -29,71 +29,82 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <aio.h>
+#include <sys/socket.h>
 
 #include "posixtest.h"
-#include "tempfile.h"
 
 #define TNAME "aio_cancel/7-1.c"
 
-#define BUF_NB		128
-#define BUF_SIZE	1024
+#define BUF_NB		8
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
+	int fds[2];
 	struct aiocb *aiocb[BUF_NB];
 	int i;
 	int in_progress;
 	int gret;
+	int bufsize;
+	unsigned int argsize = sizeof(bufsize);
 
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
 		return PTS_UNRESOLVED;
 	}
 
-	unlink(tmpfname);
+	gret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
+	if (gret == -1) {
+		printf(TNAME " Error reading socket buffer size: %s\n",
+			strerror(errno));
+		close(fds[0]);
+		close(fds[1]);
+		return PTS_UNRESOLVED;
+	}
+
+	/* Socket buffer size is twice the maximum message size */
+	bufsize /= 2;
 
 	/* create AIO req */
 	for (i = 0; i < BUF_NB; i++) {
 		aiocb[i] = calloc(1, sizeof(struct aiocb));
 
 		if (aiocb[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
+			printf(TNAME " Error at calloc(): %s\n",
 			       strerror(errno));
-			close(fd);
+			close(fds[0]);
+			close(fds[1]);
 			return PTS_UNRESOLVED;
 		}
 
-		aiocb[i]->aio_fildes = fd;
-		aiocb[i]->aio_buf = malloc(BUF_SIZE);
+		aiocb[i]->aio_fildes = fds[0];
+		aiocb[i]->aio_buf = malloc(bufsize);
 
 		if (aiocb[i]->aio_buf == NULL) {
 			printf(TNAME " Error at malloc(): %s\n",
 			       strerror(errno));
-			close(fd);
+			close(fds[0]);
+			close(fds[1]);
 			return PTS_UNRESOLVED;
 		}
 
-		aiocb[i]->aio_nbytes = BUF_SIZE;
+		aiocb[i]->aio_nbytes = bufsize;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
 
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
 			       i, strerror(errno));
-			close(fd);
+			close(fds[0]);
+			close(fds[1]);
 			return PTS_FAIL;
 		}
 	}
@@ -101,10 +112,11 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	/* try to cancel all
 	 * we hope to have enough time to cancel at least one
 	 */
-	gret = aio_cancel(fd, NULL);
+	gret = aio_cancel(fds[0], NULL);
 	if (gret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
-		close(fd);
+		close(fds[0]);
+		close(fds[1]);
 		return PTS_FAIL;
 	}
 
@@ -117,9 +129,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			case -1:
 				printf(TNAME " Error at aio_error(): %s\n",
 				       strerror(errno));
-				close(fd);
+				close(fds[0]);
+				close(fds[1]);
 				return PTS_FAIL;
-				break;
 			case EINPROGRESS:
 				/* at this point, all operations should be:
 				 *    canceled
@@ -130,12 +142,26 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 					printf(TNAME
 					       " Error at aio_error(): %s\n",
 					       strerror(errno));
-					close(fd);
+					close(fds[0]);
+					close(fds[1]);
 					return PTS_FAIL;
 				}
 
 				in_progress = 1;
 				break;
+			case ECANCELED:
+				/* aio_cancel() happened between one
+				 * write finishing and another starting.
+				 * aio_cancel() returned AIO_CANCELED
+				 * and the first non-zero result is ECANCELED.
+				 */
+				if (gret == AIO_CANCELED) {
+					printf("Test PASSED\n");
+					close(fds[0]);
+					close(fds[1]);
+					return PTS_PASS;
+				}
+				break;
 			case 0:
 				/* we seek one not canceled and check why.
 				 * (perhaps) it has not been canceled
@@ -144,7 +170,8 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 				 */
 				if (gret == AIO_NOTCANCELED) {
 					printf("Test PASSED\n");
-					close(fd);
+					close(fds[0]);
+					close(fds[1]);
 					return PTS_PASS;
 				}
 				break;
@@ -152,7 +179,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		}
 	} while (in_progress);
 
-	close(fd);
-
+	close(fds[0]);
+	close(fds[1]);
 	return PTS_UNRESOLVED;
 }
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
