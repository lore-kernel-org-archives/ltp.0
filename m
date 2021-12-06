Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45389C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 09:57:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF323C1DE7
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 10:57:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4221E3C0B78
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:56:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CF04140027A
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:56:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A6D81FD2F;
 Mon,  6 Dec 2021 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638784615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bTmaZ3GiDcUNudP56jF5t8qSkPC4hjYP8TzQ8AV+uVg=;
 b=QSOvrvlvmeRujTOsKEdvnv0dn2bFHKzcGjE9w5Z5xJ/VC59mxNL5Nc00Ep33hoUaYGWSGc
 YYE45pIR4LXKS+mhrbJVatV2l4PLqRzLccC+etgUQZfTj534VRmHOUfHQRujZY4Mfox1Ty
 +wUPL1oodyTj3SMs/Ayo8DcCMzJHZaU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BA2213AED;
 Mon,  6 Dec 2021 09:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0jROGGferWG8NgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 06 Dec 2021 09:56:55 +0000
To: ltp@lists.linux.it
Date: Mon,  6 Dec 2021 10:56:52 +0100
Message-Id: <20211206095652.6181-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactoring aiodio_append.c test using LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/io/ltp-aiodio/aiodio_append.c      | 193 +++++++++---------
 1 file changed, 91 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 5d97ed941..31a24393d 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -1,84 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
  *               2004 Open Source Development Lab
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Module: .c
- * Change History:
- *
- * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
+ *               2004  Marty Ridgeway <mridge@us.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
-*/
+ * Append zeroed data to a file using libaio while other processes are doing
+ * buffered reads and check if the buffer reads always see zero.
+ */
 
 #define _GNU_SOURCE
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <signal.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-
-#include "config.h"
-#include "test.h"
-
-char *TCID = "aiodio_append";
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
 #include <libaio.h>
+#include "common.h"
 
+#define FILE_NAME "aiodio_append"
 #define NUM_CHILDREN 8
+#define NUM_AIO 16
+#define AIO_SIZE (64 * 1024)
+#define FILE_SIZE (64 * 1024)
 
-#include "common_checkzero.h"
+static int *run_child;
 
-int read_eof(char *filename)
+static void read_eof(const char *filename, size_t bs)
 {
 	int fd;
-	int i;
 	int r;
-	char buf[4096];
+	char *bufptr;
 
-	while ((fd = open(filename, O_RDONLY)) < 0) {
-		sleep(1);	/* wait for file to be created */
-	}
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+		usleep(100);
 
-	for (i = 0; i < 1000000; i++) {
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+
+	tst_res(TINFO, "child %i reading file", getpid());
+	while (*run_child) {
 		off_t offset;
 		char *bufoff;
 
-		offset = lseek(fd, SEEK_END, 0);
-		r = read(fd, buf, 4096);
-		if (r > 0) {
-			if ((bufoff = check_zero(buf, r))) {
-				fprintf(stderr, "non-zero read at offset %p\n",
-					offset + bufoff);
-				exit(1);
+		offset = SAFE_LSEEK(fd, 0, SEEK_END);
+		do {
+			r = SAFE_READ(0, fd, bufptr, bs);
+			if (r > 0) {
+				bufoff = check_zero(bufptr, r);
+				if (bufoff) {
+					tst_res(TINFO, "non-zero read at offset %zu",
+						offset + (bufoff - bufptr));
+					free(bufptr);
+					SAFE_CLOSE(fd);
+					return;
+				}
+				offset += r;
 			}
-		}
+		} while (r > 0);
 	}
-	return 0;
-}
 
-#define NUM_AIO 16
-#define AIO_SIZE 64*1024
+	free(bufptr);
+	SAFE_CLOSE(fd);
+}
 
 /*
  * append to the end of a file using AIO DIRECT.
  */
-void aiodio_append(char *filename)
+static void aiodio_append(char *filename, int bcount)
 {
 	int fd;
 	void *bufptr;
@@ -91,21 +85,13 @@ void aiodio_append(char *filename)
 	struct io_event event;
 	struct timespec timeout;
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
-	if (fd < 0) {
-		perror("cannot create file");
-		return;
-	}
+	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
 	memset(&myctx, 0, sizeof(myctx));
 	io_queue_init(NUM_AIO, &myctx);
 
 	for (i = 0; i < NUM_AIO; i++) {
-		TEST(posix_memalign(&bufptr, 4096, AIO_SIZE));
-		if (TEST_RETURN) {
-			tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
-			return;
-		}
+		bufptr = SAFE_MEMALIGN(getpagesize(), AIO_SIZE);
 		memset(bufptr, 0, AIO_SIZE);
 		io_prep_pwrite(&iocb_array[i], fd, bufptr, AIO_SIZE, offset);
 		iocbs[i] = &iocb_array[i];
@@ -115,14 +101,14 @@ void aiodio_append(char *filename)
 	/*
 	 * Start the 1st NUM_AIO requests
 	 */
-	if ((w = io_submit(myctx, NUM_AIO, iocbs)) < 0) {
-		fprintf(stderr, "io_submit write returned %d\n", w);
-	}
+	w = io_submit(myctx, NUM_AIO, iocbs);
+	if (w < 0)
+		tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
 
 	/*
 	 * As AIO requests finish, keep issuing more AIOs.
 	 */
-	for (; i < 1000; i++) {
+	for (; i < bcount; i++) {
 		int n = 0;
 		struct iocb *iocbp;
 
@@ -131,56 +117,59 @@ void aiodio_append(char *filename)
 			iocbp = (struct iocb *)event.obj;
 
 			if (n > 0) {
-				io_prep_pwrite(iocbp, fd, iocbp->u.c.buf,
-					       AIO_SIZE, offset);
+				io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, AIO_SIZE, offset);
 				offset += AIO_SIZE;
-				if ((w = io_submit(myctx, 1, &iocbp)) < 0) {
-					fprintf(stderr,
-						"write %d returned %d\n", i, w);
-				}
+				w = io_submit(myctx, 1, &iocbp);
+				if (w < 0)
+					tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
 			}
 		}
 	}
 }
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(run_child, sizeof(int));
+}
+
+static void run(void)
+{
+	int status;
 	int i;
-	char *filename = argv[1];
-
-	printf("Starting aio/dio append test...\n");
-
-	for (i = 0; i < num_children; i++) {
-		if ((pid[i] = fork()) == 0) {
-			/* child */
-			return read_eof(filename);
-		} else if (pid[i] < 0) {
-			/* error */
-			perror("fork error");
-			break;
-		} else {
-			/* Parent */
-			continue;
+
+	*run_child = 1;
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		if (!SAFE_FORK()) {
+			read_eof(FILE_NAME, FILE_SIZE);
+			return;
 		}
 	}
 
-	/*
-	 * Parent appends to end of file using direct i/o
-	 */
+	tst_res(TINFO, "Parent append to file");
 
-	aiodio_append(filename);
+	aiodio_append(FILE_NAME, 1000);
 
-	for (i = 0; i < num_children; i++) {
-		kill(pid[i], SIGTERM);
-	}
+	if (SAFE_WAITPID(-1, &status, WNOHANG))
+		tst_res(TFAIL, "Non zero bytes read");
+	else
+		tst_res(TPASS, "All bytes read were zeroed");
 
-	return 0;
+	*run_child = 0;
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
-}
+TST_TEST_TCONF("test requires libaio and its development packages");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
