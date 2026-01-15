Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB8D46603
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 17:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9C013CA390
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 18:19:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B54E63C9DEF
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 18:18:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F3DF200047
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 18:18:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF4605BD01
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768497527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QWqGHN4EK0OnZuHv3KAXVJLpLBCglbjdqzj+ZJdcz7w=;
 b=Sgsur5abXkPvmajQu1FgiWvsxr9hVV9lcKpGdy6YcN6vDe7d8N8UHkLQc/XvpWs+rjut+F
 W0Pi3gcDSKMpDYimjbHw+lJTKoP3nnhzUWmNacV1fQwCDDv217oclnlrWzR9XmyIQI5jLb
 13lVy2Oriru0XsWQZmzH//jstfT/Pjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768497527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QWqGHN4EK0OnZuHv3KAXVJLpLBCglbjdqzj+ZJdcz7w=;
 b=44u+3C3zDGy9IGk4m5DxgxLvEdf0s3ee0ylw1MPiYQgzK2taEiIRMa1xmis6tk4sQMMmBP
 SaqTOVDmLAlxVNCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768497527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QWqGHN4EK0OnZuHv3KAXVJLpLBCglbjdqzj+ZJdcz7w=;
 b=Sgsur5abXkPvmajQu1FgiWvsxr9hVV9lcKpGdy6YcN6vDe7d8N8UHkLQc/XvpWs+rjut+F
 W0Pi3gcDSKMpDYimjbHw+lJTKoP3nnhzUWmNacV1fQwCDDv217oclnlrWzR9XmyIQI5jLb
 13lVy2Oriru0XsWQZmzH//jstfT/Pjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768497527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QWqGHN4EK0OnZuHv3KAXVJLpLBCglbjdqzj+ZJdcz7w=;
 b=44u+3C3zDGy9IGk4m5DxgxLvEdf0s3ee0ylw1MPiYQgzK2taEiIRMa1xmis6tk4sQMMmBP
 SaqTOVDmLAlxVNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B08AB3EA63
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NAEJ3chaWmtCgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:18:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Jan 2026 18:18:46 +0100
Message-ID: <20260115171847.28091-1-mdoucha@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lio_listio_2-1: Rewrite test
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
at least one will block long enough that a variable can be checked before
the completion signal arrives. Use a socket pair instead of file
to force async writes to block indefinitely. Then drain the socket after
the first signal check and wait for the signal.

Add cleanup helper function that will flush socket buffers, free allocated
memory and close the sockets. Also make setup and cleanup simpler
by statically allocating the aiocb structure array.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Another race condition fix by filling socket pair buffers until they
block. Tested on kernel v4.4 and v6.12.

 .../conformance/interfaces/lio_listio/2-1.c   | 133 +++++++++++-------
 1 file changed, 81 insertions(+), 52 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
index efcd5b3fc..b21c6d04d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
@@ -13,30 +13,33 @@
  *
  * method:
  *
- *	- open a file for writing
+ *	- open a socket pair
  *	- submit a list of writes to lio_listio in LIO_NOWAIT mode
  *	- check that upon return some I/Os are still running
+ *	- drain the sockets
+ *	- check that I/O finish signal was received
  *
  */
 
-#include <sys/stat.h>
 #include <aio.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/socket.h>
 
 #include "posixtest.h"
 #include "tempfile.h"
 
 #define TNAME "lio_listio/2-1.c"
 
-#define NUM_AIOCBS	256
-#define BUF_SIZE	1024
+#define NUM_AIOCBS	8
 
+static int fds[2];
+static struct aiocb aiocbs[NUM_AIOCBS];
+static char *bufs;
 static volatile int received_all;
 
 static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
@@ -46,54 +49,81 @@ static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
 	received_all = 1;
 }
 
-int main(void)
+static void read_all(void)
+{
+	int i, ret;
+
+	for (i = 0; i < NUM_AIOCBS; i++) {
+		if (!aiocbs[i].aio_buf)
+			break;
+
+		ret = aio_error(&aiocbs[i]);
+
+		/* flush written data from the socket */
+		if (ret == 0 || ret == EINPROGRESS) {
+			read(fds[1], (void *)aiocbs[i].aio_buf,
+				aiocbs[i].aio_nbytes);
+			aiocbs[i].aio_buf = NULL;
+		}
+	}
+}
+
+static void cleanup(void)
 {
-	char tmpfname[PATH_MAX];
-	int fd;
+	read_all();
+	free(bufs);
+	close(fds[0]);
+	close(fds[1]);
+}
 
-	struct aiocb *aiocbs[NUM_AIOCBS];
-	char *bufs;
+int main(void)
+{
+	struct aiocb *liocbs[NUM_AIOCBS];
 	struct sigaction action;
 	struct sigevent event;
 	int errors = 0;
 	int ret;
 	int err;
 	int i;
+	int bufsize;
+	socklen_t argsize = sizeof(bufsize);
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_2_1");
-	unlink(tmpfname);
-
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n", strerror(errno));
-		exit(PTS_UNRESOLVED);
+	ret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fds);
+	if (ret == -1) {
+		printf(TNAME " Error creating sockets(): %s\n",
+			strerror(errno));
+		return PTS_UNRESOLVED;
 	}
 
-	unlink(tmpfname);
+	ret = getsockopt(fds[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
+	if (ret == -1) {
+		printf(TNAME " Error reading socket buffer size: %s\n",
+			strerror(errno));
+		cleanup();
+		return PTS_UNRESOLVED;
+	}
 
-	bufs = malloc(NUM_AIOCBS * BUF_SIZE);
+	/* Socket buffer size is twice the maximum message size */
+	bufsize /= 2;
+	bufs = malloc(NUM_AIOCBS * bufsize);
 
 	if (bufs == NULL) {
 		printf(TNAME " Error at malloc(): %s\n", strerror(errno));
-		close(fd);
+		cleanup();
 		exit(PTS_UNRESOLVED);
 	}
 
 	/* Queue up a bunch of aio writes */
 	for (i = 0; i < NUM_AIOCBS; i++) {
-
-		aiocbs[i] = malloc(sizeof(struct aiocb));
-		memset(aiocbs[i], 0, sizeof(struct aiocb));
-
-		aiocbs[i]->aio_fildes = fd;
-		aiocbs[i]->aio_offset = i * BUF_SIZE;
-		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
-		aiocbs[i]->aio_nbytes = BUF_SIZE;
-		aiocbs[i]->aio_lio_opcode = LIO_WRITE;
+		liocbs[i] = &aiocbs[i];
+		aiocbs[i].aio_fildes = fds[0];
+		aiocbs[i].aio_offset = i * bufsize;
+		aiocbs[i].aio_buf = &bufs[i * bufsize];
+		aiocbs[i].aio_nbytes = bufsize;
+		aiocbs[i].aio_lio_opcode = LIO_WRITE;
 	}
 
 	/* Use SIGRTMIN+2 for list completion */
@@ -108,53 +138,52 @@ int main(void)
 	sigaction(SIGRTMIN + 2, &action, NULL);
 
 	/* Submit request list */
-	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
+	ret = lio_listio(LIO_NOWAIT, liocbs, NUM_AIOCBS, &event);
 
 	if (ret) {
 		printf(TNAME " Error at lio_listio() %d: %s\n", errno,
-		       strerror(errno));
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		close(fd);
+			strerror(errno));
+		/* Clear the aiocbs or cleanup() will get stuck */
+		memset(aiocbs, 0, NUM_AIOCBS * sizeof(struct aiocb));
+		cleanup();
 		exit(PTS_FAIL);
 	}
 
 	if (received_all != 0) {
 		printf(TNAME
-		       " Error lio_listio() waited for list completion\n");
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		close(fd);
+			" Error lio_listio() signaled completion too early\n");
+		cleanup();
 		exit(PTS_FAIL);
 	}
 
-	while (received_all == 0)
+	read_all();
+
+	for (i = 0; i < 5 && !received_all; i++)
 		sleep(1);
 
+	if (received_all == 0) {
+		printf(TNAME " Test did not receive I/O completion signal\n");
+		cleanup();
+		exit(PTS_FAIL);
+	}
+
 	/* Check return code and free things */
 	for (i = 0; i < NUM_AIOCBS; i++) {
-		err = aio_error(aiocbs[i]);
-		ret = aio_return(aiocbs[i]);
+		err = aio_error(&aiocbs[i]);
+		ret = aio_return(&aiocbs[i]);
 
-		if ((err != 0) && (ret != BUF_SIZE)) {
+		if ((err != 0) && (ret != bufsize)) {
 			printf(TNAME " req %d: error = %d - return = %d\n", i,
-			       err, ret);
+				err, ret);
 			errors++;
 		}
-
-		free(aiocbs[i]);
 	}
 
-	free(bufs);
-
-	close(fd);
+	cleanup();
 
 	if (errors != 0)
 		exit(PTS_FAIL);
 
 	printf(TNAME " PASSED\n");
-
 	return PTS_PASS;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
