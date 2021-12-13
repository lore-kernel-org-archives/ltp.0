Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01101C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D9D63C8A72
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:04:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DD3F3C89B1
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:04:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ED350601BF7
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:04:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0EC921136;
 Mon, 13 Dec 2021 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639411482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zIqhnq5BXha4k5LCANedMevNA21xCzP0R0Oi0h3UAbw=;
 b=iRP5zLfASXCKMzKs5rSN1Tvdsz8KkUgeqv6gq6VwrJLIxgee96dGNB4VmI4zKM+VWnzMLH
 KMUqav1sRMiZgOrS7tbRMC9D65GUY9AP2EJVcLrwgA+TLKmOR4iBd3Lk+SWdzdTGefEf8D
 0CuYuHW2w18Y6xW7vjUU627BsE0B1Q0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97BEE13E3A;
 Mon, 13 Dec 2021 16:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HIfLIhpvt2FzVAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Dec 2021 16:04:42 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 17:04:37 +0100
Message-Id: <20211213160437.32353-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Refactoring dio_append.c using LTP API
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
 testcases/kernel/io/ltp-aiodio/dio_append.c | 174 +++++++-------------
 1 file changed, 62 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index b1b4dc039..3b1ddfc40 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -1,143 +1,93 @@
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
- *               2004 Open Source Development Lab
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
+ *				 2004 Open Source Development Lab
+ *				 2004  Marty Ridgeway <mridge@us.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Change History:
- *
- * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
+/*\
+ * [Description]
  *
- */
-/*
  * dio_append - append zeroed data to a file using O_DIRECT while
  *	a 2nd process is doing buffered reads and check if the buffer
  *	reads always see zero.
  */
 #define _GNU_SOURCE
 
-#include <stdlib.h>
-#include <sys/types.h>
-#include <signal.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <memory.h>
-#include <limits.h>
-
-#include "test.h"
-#define NUM_CHILDREN 8
+#include "tst_test.h"
+#include "common.h"
 
-#include "common_checkzero.h"
+static int *run_child;
 
-int read_eof(char *filename)
-{
-	int fd;
-	int i;
-	int r;
-	char buf[4096];
+static char *str_numchildren;
+static char *str_writesize;
+static char *str_appends;
 
-	while ((fd = open(filename, O_RDONLY)) < 0) {
-		sleep(1);	/* wait for file to be created */
-	}
-
-	for (i = 0; i < 1000000; i++) {
-		off_t offset;
-		char *bufoff;
-
-		offset = lseek(fd, SEEK_END, 0);
-		r = read(fd, buf, 4096);
-		if (r > 0) {
-			if ((bufoff = check_zero(buf, r))) {
-				fprintf(stderr, "non-zero read at offset %p\n",
-					offset + bufoff);
-				exit(1);
-			}
-		}
-	}
-	return 0;
-}
+static int numchildren;
+static long long writesize;
+static int appends;
 
-void dio_append(char *filename)
+static void setup(void)
 {
-	int fd;
-	void *bufptr = NULL;
-	int i;
-	int w;
+	numchildren = 16;
+	writesize = 64 * 1024;
+	appends = 1000;
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
 
-	if (fd < 0) {
-		perror("cannot create file");
-		return;
-	}
+	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid write file size '%s'", str_writesize);
 
-	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
-		close(fd);
-		return;
-	}
+	if (tst_parse_int(str_appends, &appends, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of appends '%s'", str_appends);
 
-	memset(bufptr, 0, 64 * 1024);
-	for (i = 0; i < 1000; i++) {
-		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, "write %d returned %d\n", i, w);
-		}
-	}
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
-int main(void)
+static void cleanup(void)
 {
-	char filename[PATH_MAX];
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
+	SAFE_MUNMAP(run_child, sizeof(int));
+}
+
+static void run(void)
+{
+	char *filename = "dio_append";
+	int status;
 	int i;
 
-	snprintf(filename, sizeof(filename), "%s/aiodio/file",
-		 getenv("TMP") ? getenv("TMP") : "/tmp");
-
-	printf("Begin dio_append test...\n");
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
+	*run_child = 1;
+
+	for (i = 0; i < numchildren; i++) {
+		if (!SAFE_FORK()) {
+			io_read_eof(filename, run_child);
+			return;
 		}
 	}
 
-	/*
-	 * Parent appends to end of file using direct i/o
-	 */
+	tst_res(TINFO, "Parent append to file");
 
-	dio_append(filename);
+	io_append(filename, 0, O_DIRECT | O_WRONLY | O_CREAT, writesize, appends);
 
-	for (i = 0; i < num_children; i++) {
-		kill(pid[i], SIGTERM);
-	}
-	return 0;
+	if (SAFE_WAITPID(-1, &status, WNOHANG))
+		tst_res(TFAIL, "Non zero bytes read");
+	else
+		tst_res(TPASS, "All bytes read were zeroed");
+
+	*run_child = 0;
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"n:", &str_numchildren, "Number of threads (default 1000)"},
+		{"w:", &str_writesize, "Write size for each append (default 64K)"},
+		{"c:", &str_appends, "Number of appends (default 1000)"},
+		{}
+	},
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
