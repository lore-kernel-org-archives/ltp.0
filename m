Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC8C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 16:47:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB3761BFB
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DB3761BFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5763C88E0
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 17:47:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0BD23C0BB5
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 17:47:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED70910011C7
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 17:47:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D1971FD29;
 Wed, 17 Nov 2021 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637167652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pW7jkPa85bBKy16IavyP63JHhcQz4VkKeT5Fkzfk3ss=;
 b=txM2UZ6RhiF/u3c+W4HPm4T6sQHPoEreSRjpDv9xVlQCiN5uM0vCoALDlUW9C/R+nlyMEK
 p9fN5J+UyX4hbIURvHzvxoZdwqAVdLhPkFS3uXKFBBh2I2AotxNhyx2aDFBnELmzGInqUu
 YLtpVkzr5Uo+L52/HDD2ya4epn2k688=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637167652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pW7jkPa85bBKy16IavyP63JHhcQz4VkKeT5Fkzfk3ss=;
 b=S2CL6Xd43wParfm4vif1/I05vAkTydr3p0AKIcXuyYq8+NMfwv1X2i1mmZ0pZm5owA3XlR
 FXkWEsvug3La4dDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB6A813AB7;
 Wed, 17 Nov 2021 16:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HghOLiMylWG9MAAAMHmgww
 (envelope-from <acervesato@suse.de>); Wed, 17 Nov 2021 16:47:31 +0000
From: Andrea Cervesato <acervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 17 Nov 2021 17:47:29 +0100
Message-Id: <20211117164729.29586-1-acervesato@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] dio_truncate.c test refactory with LTP API
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

---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 195 ++++++------------
 1 file changed, 65 insertions(+), 130 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 27cf01525..d0d120614 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -1,159 +1,91 @@
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
+ *			    2004 Open Source Development Lab
+ *	Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Change History:
- *
- * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
- *
- */
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
-
-#include "test.h"
+#include "tst_test.h"
 
-#define NUM_CHILDREN 8
+#define NUM_CHILDREN 10
+#define FILE_SIZE (64 * 1024)
 
-char *check_zero(unsigned char *buf, int size)
-{
-	unsigned char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			fprintf(stderr,
-				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, "buf %p, p %p\n", buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-	return 0;		/* all zeros */
-}
-
-int dio_read(char *filename)
+static void dio_read(const char *filename, size_t bs, size_t bcount)
 {
 	int fd;
-	int r;
-	void *bufptr = NULL;
-
-	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
-	if (TEST_RETURN) {
-		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
-		return -1;
-	}
-
-	while ((fd = open(filename, O_DIRECT | O_RDONLY)) < 0) {
-	}
-	fprintf(stderr, "dio_truncate: child reading file\n");
-	while (1) {
-		off_t offset;
-		char *bufoff;
-
-		/* read the file, checking for zeros */
-		offset = lseek(fd, SEEK_SET, 0);
-		do {
-			r = read(fd, bufptr, 64 * 1024);
-			if (r > 0) {
-				if ((bufoff = check_zero(bufptr, r))) {
-					fprintf(stderr,
-						"non-zero read at offset %p\n",
-						offset + bufoff);
-					exit(1);
+	size_t i;
+	char *bufptr;
+	size_t iter = 0;
+
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+
+	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
+		;
+	tst_res(TINFO, "child reading file");
+	while (iter < bcount) {
+		SAFE_LSEEK(fd, SEEK_SET, 0);
+
+		if (read(fd, bufptr, bs) > 0) {
+			for (i = 0; i < bs; i++) {
+				if (*bufptr != 0) {
+					tst_res(TFAIL, "non zero buffer at %lu", i);
+					SAFE_CLOSE(fd);
+					return;
 				}
-				offset += r;
+				bufptr++;
 			}
-		} while (r > 0);
+		}
+		iter++;
+		usleep(150);
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
+	size_t i;
+	char *bufptr;
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+	memset(bufptr, pattern, bs);
 
-	if (fd < 0) {
-		perror("cannot create file");
-		return;
-	}
-
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
 	int i;
 
-	snprintf(filename, sizeof(filename), "%s/aiodio/file",
-		 getenv("TMP") ? getenv("TMP") : "/tmp");
-
 	for (i = 0; i < num_children; i++) {
-		if ((pid[i] = fork()) == 0) {
+		pid[i] = fork();
+		if (pid[i] == 0) {
 			/* child */
-			return dio_read(filename);
+			dio_read(filename, filesize, 1000);
+			return;
 		} else if (pid[i] < 0) {
 			/* error */
-			perror("fork error");
+			tst_brk(TBROK, "fork error");
 			break;
-		} else {
-			/* Parent */
-			continue;
 		}
 	}
 
@@ -161,17 +93,20 @@ int main(void)
 	 * Parent creates a zero file using DIO.
 	 * Truncates it to zero
 	 * Create another file with '0xaa'
+	 * Truncates it to zero
 	 */
 	for (i = 0; i < 100; i++) {
-		dio_append(filename, 0);
-		truncate(filename, 0);
-		dio_append("junkfile", 0xaa);
-		truncate("junkfile", 0);
+		dio_append(filename, 0, filesize, 200);
+		SAFE_TRUNCATE(filename, 0);
+		dio_append("junkfile", 0xaa, filesize, 200);
+		SAFE_TRUNCATE("junkfile", 0);
 	}
 
-	for (i = 0; i < num_children; i++) {
-		kill(pid[i], SIGTERM);
-	}
-
-	return 0;
+	for (i = 0; i < num_children; i++)
+		SAFE_KILL(pid[i], SIGTERM);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+};
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
