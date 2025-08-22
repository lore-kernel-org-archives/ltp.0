Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A1CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 13:57:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA0CC3CCFDC
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 15:57:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08C3D3CCC6B
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 15:57:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECF2C60012A
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 15:57:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E0C01F38E
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755871023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEf8G4y1dCZ1fJ8ffW/SShSMw3r4M9Y81MI7h6zHhS4=;
 b=QRJiJNuAGqRcLz9EEJOb9E6wAeHYlHcmGYjsUBWph6XlvtMgg+CERsbgQmptEvuat1knU2
 kYhbnKNnEet/I4OP9D9yUcvbgsFmQtjC/q+spo6O7HKpfZwrj6/c7VT95uVGI+kHMPnt0H
 tK2BN/4jicT1VzNHJbHfKTSE+RFqwcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755871023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEf8G4y1dCZ1fJ8ffW/SShSMw3r4M9Y81MI7h6zHhS4=;
 b=LQUEA1NZgEm2PTkRoJ2/H3MPeLef4vPEP3+aAaXdozealbiirMfFVz1QKyUQIU4YKinDis
 RARHMFDTbitgggAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755871023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEf8G4y1dCZ1fJ8ffW/SShSMw3r4M9Y81MI7h6zHhS4=;
 b=QRJiJNuAGqRcLz9EEJOb9E6wAeHYlHcmGYjsUBWph6XlvtMgg+CERsbgQmptEvuat1knU2
 kYhbnKNnEet/I4OP9D9yUcvbgsFmQtjC/q+spo6O7HKpfZwrj6/c7VT95uVGI+kHMPnt0H
 tK2BN/4jicT1VzNHJbHfKTSE+RFqwcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755871023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEf8G4y1dCZ1fJ8ffW/SShSMw3r4M9Y81MI7h6zHhS4=;
 b=LQUEA1NZgEm2PTkRoJ2/H3MPeLef4vPEP3+aAaXdozealbiirMfFVz1QKyUQIU4YKinDis
 RARHMFDTbitgggAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FF7B139B7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 13:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XLHWHi93qGhDAQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 13:57:03 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 15:57:01 +0200
Message-ID: <20250822135702.23337-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.50.1
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
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] aio_cancel_7-1: Write into a socket
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

Changes since v1: Rebased to current master.

Changes since v2:
- Changed argsize from unsigned int to socklen_t
- Improved test cleanup using a helper function

 .../conformance/interfaces/aio_cancel/7-1.c   | 85 +++++++++++++------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 34b263245..9ab72da87 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -29,71 +29,90 @@
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
+
+static int fds[2];
+static struct aiocb *aiocb[BUF_NB];
+
+static void cleanup(void)
+{
+	int i;
+
+	close(fds[1]);
+	close(fds[0]);
+
+	for (i = 0; i < BUF_NB; i++)
+		free((void *)aiocb[i]->aio_buf);
+}
 
 int main(void)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
-	struct aiocb *aiocb[BUF_NB];
 	int i;
 	int in_progress;
 	int gret;
+	int bufsize;
+	socklen_t argsize = sizeof(bufsize);
 
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
 		aiocb[i] = calloc(1, sizeof(struct aiocb));
 
 		if (aiocb[i] == NULL) {
-			printf(TNAME " Error at malloc(): %s\n",
+			printf(TNAME " Error at calloc(): %s\n",
 			       strerror(errno));
-			close(fd);
+			cleanup();
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
+			cleanup();
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
+			cleanup();
 			return PTS_FAIL;
 		}
 	}
@@ -101,10 +120,10 @@ int main(void)
 	/* try to cancel all
 	 * we hope to have enough time to cancel at least one
 	 */
-	gret = aio_cancel(fd, NULL);
+	gret = aio_cancel(fds[0], NULL);
 	if (gret == -1) {
 		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
-		close(fd);
+		cleanup();
 		return PTS_FAIL;
 	}
 
@@ -117,9 +136,8 @@ int main(void)
 			case -1:
 				printf(TNAME " Error at aio_error(): %s\n",
 				       strerror(errno));
-				close(fd);
+				cleanup();
 				return PTS_FAIL;
-				break;
 			case EINPROGRESS:
 				/* at this point, all operations should be:
 				 *    canceled
@@ -130,12 +148,24 @@ int main(void)
 					printf(TNAME
 					       " Error at aio_error(): %s\n",
 					       strerror(errno));
-					close(fd);
+					cleanup();
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
+					cleanup();
+					return PTS_PASS;
+				}
+				break;
 			case 0:
 				/* we seek one not canceled and check why.
 				 * (perhaps) it has not been canceled
@@ -144,7 +174,7 @@ int main(void)
 				 */
 				if (gret == AIO_NOTCANCELED) {
 					printf("Test PASSED\n");
-					close(fd);
+					cleanup();
 					return PTS_PASS;
 				}
 				break;
@@ -152,7 +182,6 @@ int main(void)
 		}
 	} while (in_progress);
 
-	close(fd);
-
+	cleanup();
 	return PTS_UNRESOLVED;
 }
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
