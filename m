Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62AC433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 15:16:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310C61A7D
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 15:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5310C61A7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C9733C891C
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 16:16:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A94D3C0CCD
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 16:16:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 822CA600815
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 16:16:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEFB2212C4;
 Thu, 18 Nov 2021 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637248593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KfFb+E8QXnFCAMxgEDEgntp0a9TejEMRlY7WQogm0iE=;
 b=iG0hcC5qcK7FCVunH5kCsRA4ptP7xzkk3WU6HKIVGG3eS+nF3BKQqaCvUbO19NczEayW1z
 4LdoAitDQhhNUv9lTRqo38T+6rbo6HFMimnpGXwHcbiUaHzS5zfxfQgGCCU62H15bRFOZM
 uLsDTAylqe+YKK29bu6mN0am0mv7IRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637248593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KfFb+E8QXnFCAMxgEDEgntp0a9TejEMRlY7WQogm0iE=;
 b=iYq8nJZZl+5GGw7ebKBubLGwFyNrp4TioR8hXspddlaUDp6IRs9ty2w5PlKbPFwcuHOgoL
 i/n3YqmGhnx0WjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FEA913D43;
 Thu, 18 Nov 2021 15:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8OwVHVFulmG4GgAAMHmgww
 (envelope-from <acervesato@suse.de>); Thu, 18 Nov 2021 15:16:33 +0000
From: Andrea Cervesato <acervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Nov 2021 16:16:31 +0100
Message-Id: <20211118151631.17893-1-acervesato@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] dio_truncate.c test refactory with LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 194 ++++++++----------
 1 file changed, 85 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 27cf01525..28e229d59 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -1,177 +1,153 @@
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
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Change History:
+/*\
+ * [Description]
  *
- * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
+ * This test is mixing DIO and truncate operations checking if they can be used
+ * together at the same time. Multiple children are spawned to read a file that
+ * is edited using DIO write/read operations. Algorithm:
+ * 
+ * - Spawn multiple children which start to read on 'file'
+ * - Parent start to fill and truncate 'file' many times with zero char when
+ *   children are reading
+ * - Parent start to fill and truncate a junk file many times with non-zero char
  *
+ * If no issues occures on DIO/truncate operations and the file always contains
+ * non-zero characters, test PASS. Otherwise, test will FAIL.
  */
+
 #define _GNU_SOURCE
 
 #include <stdlib.h>
+#include <stdio.h>
+#include <sys/stat.h>
 #include <sys/types.h>
-#include <signal.h>
-#include <errno.h>
 #include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <memory.h>
-#include <string.h>
-#include <limits.h>
+#include "tst_test.h"
 
-#include "test.h"
+#define NUM_CHILDREN 16
+#define FILE_SIZE (64 * 1024)
 
-#define NUM_CHILDREN 8
+static int *run_child;
 
-char *check_zero(unsigned char *buf, int size)
+static char *check_zero(char *buf, int size)
 {
-	unsigned char *p;
+	char *p;
 
 	p = buf;
 
 	while (size > 0) {
 		if (*buf != 0) {
-			fprintf(stderr,
-				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, "buf %p, p %p\n", buf, p);
+			tst_res(TINFO,
+					"non zero buffer at buf[%lu] => 0x%02x,%02x,%02x,%02x",
+					buf - p, (unsigned int)buf[0],
+					size > 1 ? (unsigned int)buf[1] : 0,
+					size > 2 ? (unsigned int)buf[2] : 0,
+					size > 3 ? (unsigned int)buf[3] : 0);
+			tst_res(TINFO, "buf %p, p %p", buf, p);
 			return buf;
 		}
 		buf++;
 		size--;
 	}
-	return 0;		/* all zeros */
+	return 0; /* all zeros */
 }
 
-int dio_read(char *filename)
+static void dio_read(const char *filename, size_t bs)
 {
 	int fd;
 	int r;
-	void *bufptr = NULL;
+	char *bufptr;
 
-	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
-		return -1;
-	}
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
 
-	while ((fd = open(filename, O_DIRECT | O_RDONLY)) < 0) {
-	}
-	fprintf(stderr, "dio_truncate: child reading file\n");
-	while (1) {
+	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
+		usleep(100);
+
+	tst_res(TINFO, "child reading file");
+	while (*run_child) {
 		off_t offset;
 		char *bufoff;
 
 		/* read the file, checking for zeros */
-		offset = lseek(fd, SEEK_SET, 0);
+		offset = SAFE_LSEEK(fd, SEEK_SET, 0);
 		do {
 			r = read(fd, bufptr, 64 * 1024);
 			if (r > 0) {
-				if ((bufoff = check_zero(bufptr, r))) {
-					fprintf(stderr,
-						"non-zero read at offset %p\n",
-						offset + bufoff);
-					exit(1);
+				bufoff = check_zero(bufptr, r);
+				if (bufoff) {
+					tst_res(TINFO, "non-zero read at offset %p", offset + bufoff);
+					SAFE_CLOSE(fd);
+					return;
 				}
 				offset += r;
 			}
 		} while (r > 0);
 	}
-	return 0;
+
+	SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "zero buffer only after truncate");
 }
 
-void dio_append(char *filename, int fill)
+static void dio_append(const char *path, char pattern, size_t bs, size_t bcount)
 {
 	int fd;
-	void *bufptr = NULL;
-	int i;
-	int w;
-
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	size_t i;
+	char *bufptr;
 
-	if (fd < 0) {
-		perror("cannot create file");
-		return;
-	}
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+	memset(bufptr, pattern, bs);
 
-	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
-		close(fd);
-		return;
-	}
+	fd = SAFE_OPEN(path, O_CREAT | O_WRONLY | O_DIRECT, 0666);
 
-	memset(bufptr, fill, 64 * 1024);
+	for (i = 0; i < bcount; i++)
+		SAFE_WRITE(1, fd, bufptr, bs);
 
-	for (i = 0; i < 1000; i++) {
-		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, "write %d returned %d\n", i, w);
-		}
-	}
-	close(fd);
+	SAFE_CLOSE(fd);
 }
 
-int main(void)
+static void run(void)
 {
-	char filename[PATH_MAX];
+	char *filename = "file";
+	int filesize = FILE_SIZE;
+	int num_children = NUM_CHILDREN;
 	int pid[NUM_CHILDREN];
-	int num_children = 1;
+	int status;
 	int i;
 
-	snprintf(filename, sizeof(filename), "%s/aiodio/file",
-		 getenv("TMP") ? getenv("TMP") : "/tmp");
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	*run_child = 1;
 
 	for (i = 0; i < num_children; i++) {
-		if ((pid[i] = fork()) == 0) {
-			/* child */
-			return dio_read(filename);
-		} else if (pid[i] < 0) {
-			/* error */
-			perror("fork error");
-			break;
-		} else {
-			/* Parent */
-			continue;
+		pid[i] = SAFE_FORK();
+		if (pid[i] == 0) {
+			dio_read(filename, filesize);
+			return;
 		}
 	}
 
-	/*
-	 * Parent creates a zero file using DIO.
-	 * Truncates it to zero
-	 * Create another file with '0xaa'
-	 */
-	for (i = 0; i < 100; i++) {
-		dio_append(filename, 0);
-		truncate(filename, 0);
-		dio_append("junkfile", 0xaa);
-		truncate("junkfile", 0);
-	}
-
 	for (i = 0; i < num_children; i++) {
-		kill(pid[i], SIGTERM);
+		dio_append(filename, 0, filesize, 200);
+		SAFE_TRUNCATE(filename, 0);
+		dio_append("junkfile", 0xaa, filesize, 200);
+		SAFE_TRUNCATE("junkfile", 0);
 	}
 
-	return 0;
+	*run_child = 0;
+
+	for (i = 0; i < num_children; i++)
+		SAFE_WAITPID(pid[i], &status, 0);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
