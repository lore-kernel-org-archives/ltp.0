Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEFBC43334
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 15:58:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4823B3CA1EC
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 17:58:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AD1D3C527F
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 17:58:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0713514010E0
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 17:58:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7E01F747;
 Wed,  6 Jul 2022 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657123104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoo7+v+duH/zxI0EudDTf1N8mh4+LSFXcXIqtvh7tU4=;
 b=BXtIJHbPNh6raNvDFIw6Rm9lgptArYdavD6jN/Alu3bCBq8UzRsZVOnmFImAXQZyX9YSA9
 i325nglTS9qiBBSkHJiBTuftq9qP/UmvxZTAaYYOpgGslQ5kQcJ6vA1OPd/xS28VzwmddF
 C20//1wdaS3FjSJaJuzzS0KfPp5f60E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657123104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoo7+v+duH/zxI0EudDTf1N8mh4+LSFXcXIqtvh7tU4=;
 b=Hnyi8dyShjy9ZLzWsef+ujas+1c0V/62m4QUSrxfV4U3lUZP9kVtO1wxerRx3S+qzI1tKq
 Z3w/LWeIU5MPQTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9087213A7D;
 Wed,  6 Jul 2022 15:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MjEgFB+xxWK5bQAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 06 Jul 2022 15:58:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed,  6 Jul 2022 21:28:17 +0530
Message-Id: <20220706155817.28340-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] dup07.c: Rewrite using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup07.c | 180 +++++++++-----------------
 1 file changed, 59 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
index a100f5d58..b696d54e0 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -1,142 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2002
  *    ported from SPIE, section2/iosuite/dup3.c, by Airong Zhang
  *   Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
- *
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
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
-  WHAT:  Is the access mode the same for both file descriptors?
-          0: read only?
-          1: write only?
-          2: read/write?
-  HOW:   Creat a file with each access mode; dup each file descriptor;
-         stat each file descriptor and compare mode of each pair
-*/
-
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * Verify that new file descriptor allocated by dup() has the same
+ * permissions mode as oldfd.
+ */
 
-char *TCID = "dup07";
-int TST_TOTAL = 3;
+#include "tst_test.h"
 
-static const char *testfile = "dup07";
+static const char *temp_file1 = "tmpfile1";
+static const char *temp_file2 = "tmpfile2";
+static const char *temp_file3 = "tmpfile3";
 
-static void setup(void);
-static void cleanup(void);
+static int rdo_fd, wro_fd, rdwr_fd;
+static struct stat rdo_st_buf, wro_st_buf, rdwr_st_buf;
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	struct stat retbuf;
-	struct stat dupbuf;
-	int rdoret, wroret, rdwret;
-	int duprdo, dupwro, duprdwr;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	rdo_fd = SAFE_CREAT(temp_file1, 0444);
+	wro_fd = SAFE_CREAT(temp_file2, 0222);
+	rdwr_fd = SAFE_CREAT(temp_file3, 0666);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		if ((rdoret = creat(testfile, 0444)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
-		} else {
-			if ((duprdo = dup(rdoret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(rdoret, &retbuf);
-				fstat(duprdo, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "rdonly and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in read mode.");
-				}
-				close(duprdo);
-			}
-			close(rdoret);
-		}
-
-		unlink(testfile);
-		
-		if ((wroret = creat(testfile, 0222)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
-		} else {
-			if ((dupwro = dup(wroret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(wroret, &retbuf);
-				fstat(dupwro, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "wronly and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in write mode.");
-				}
-				close(dupwro);
-			}
-			close(wroret);
-
-		}
-
-		unlink(testfile);
+	SAFE_FSTAT(rdo_fd, &rdo_st_buf);
+	SAFE_FSTAT(wro_fd, &wro_st_buf);
+	SAFE_FSTAT(rdwr_fd, &rdwr_st_buf);
+}
 
-		if ((rdwret = creat(testfile, 0666)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
-		} else {
-			if ((duprdwr = dup(rdwret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(rdwret, &retbuf);
-				fstat(duprdwr, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "rdwr and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in read/write mode.");
-				}
-				close(duprdwr);
-			}
-			close(rdwret);
-		}
-		
-		unlink(testfile);
+static void run(void)
+{
+	struct stat dup_st_buf;
+
+	TEST(dup(rdo_fd));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file1);
+	else {
+		SAFE_FSTAT(TST_RET, &dup_st_buf);
+		TST_EXP_EQ_LI(rdo_st_buf.st_mode, dup_st_buf.st_mode);
+		SAFE_CLOSE(TST_RET);
 	}
 
-	cleanup();
-	tst_exit();
-}
+	TEST(dup(wro_fd));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file2);
+	else {
+		SAFE_FSTAT(TST_RET, &dup_st_buf);
+		TST_EXP_EQ_LI(wro_st_buf.st_mode, dup_st_buf.st_mode);
+		SAFE_CLOSE(TST_RET);
+	}
 
-static void setup(void)
-{
-	tst_tmpdir();
+	TEST(dup(rdwr_fd));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TERRNO, "Unable to dup '%s'", temp_file3);
+	else {
+		SAFE_FSTAT(TST_RET, &dup_st_buf);
+		TST_EXP_EQ_LI(rdwr_st_buf.st_mode, dup_st_buf.st_mode);
+		SAFE_CLOSE(TST_RET);
+	}
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	SAFE_CLOSE(rdo_fd);
+	SAFE_CLOSE(wro_fd);
+	SAFE_CLOSE(rdwr_fd);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
