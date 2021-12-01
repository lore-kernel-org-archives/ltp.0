Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C635C433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 16:10:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FEB23C8F8E
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 17:10:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 344903C8AA2
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 17:09:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 435231A00CC0
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 17:09:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 776281FD5B;
 Wed,  1 Dec 2021 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638374997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oCXOerIMbT0wRSiFXexxjvnSEpmmZ2tu6t/3ohnMMSY=;
 b=RerbxiMA7rV6/utM0eO8CHobDvOnTYIYU+wTAuPr6c0+U6F265UJAoiLKU+pQO4OM8dt/y
 JMf4+E3tu4odPo5b3kRPZUpXin1U/bM1rV+MV5elRm6O88hT9BeltvQHaELiUv/hhsxURt
 as7VUIBaGMJrOBHRvbLbdKDsLiTKbxE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2580113D69;
 Wed,  1 Dec 2021 16:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CxJPA1Wep2EFEwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 01 Dec 2021 16:09:57 +0000
To: ltp@lists.linux.it
Date: Wed,  1 Dec 2021 17:09:54 +0100
Message-Id: <20211201160954.16442-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactoring aiodio_append.c using LTP API
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
 .../kernel/io/ltp-aiodio/aiodio_append.c      | 192 +++++++++---------
 1 file changed, 95 insertions(+), 97 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 5d97ed941..b79c3cea0 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -1,84 +1,77 @@
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
+
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
 
-	for (i = 0; i < 1000000; i++) {
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
@@ -91,21 +84,13 @@ void aiodio_append(char *filename)
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
@@ -115,14 +100,14 @@ void aiodio_append(char *filename)
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
 
@@ -131,56 +116,69 @@ void aiodio_append(char *filename)
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
+{
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
 {
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
+	SAFE_MUNMAP(run_child, sizeof(int));
+}
+
+static void run(void)
+{
+	char *filename = "file";
+	int filesize = FILE_SIZE;
+	int num_children = NUM_CHILDREN;
+	int status;
 	int i;
-	char *filename = argv[1];
 
-	printf("Starting aio/dio append test...\n");
+	*run_child = 1;
 
 	for (i = 0; i < num_children; i++) {
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
+		if (!SAFE_FORK()) {
+			read_eof(filename, filesize);
+			return;
 		}
 	}
 
-	/*
-	 * Parent appends to end of file using direct i/o
-	 */
+	tst_res(TINFO, "Parent append to file");
 
-	aiodio_append(filename);
+	aiodio_append(filename, 1000);
 
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
+static void run(void)
 {
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
+	tst_res(TCONF, "test requires libaio and it's development packages");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+};
 #endif
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
