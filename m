Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC13EE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 09:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994103CE84E
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:41:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 537C63CB385
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:40:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 147B51A05C6F
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:40:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29A811F8A3;
 Mon, 11 Sep 2023 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694425248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+sjgYuriO3RQSx8QRrsA7omQ08izUNY8DC3ldj88EZg=;
 b=rA89Ce5159lN47sGVFK0ltOOoYuMav/kTmWl7WGRLORF59rJagEkiz2rsIQ8nsfCLRrn/d
 MOOPUMUxUnRCInToT4U4aQlY3NoeVX7hKkuZszJe/ZCSZdABEpoSuQotFXbDm9fwaRujzK
 MmT/VqIRI4aWi0kweuzEwlROZWDaGb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694425248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+sjgYuriO3RQSx8QRrsA7omQ08izUNY8DC3ldj88EZg=;
 b=HmEzsZ2q1S8lnX6pgnoBimQaEU+c4YdNbRozw5MkFtpAP7eQeAQ/KHXO7xwhzukmXlwlIE
 2TY5lp42JuEgMMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 494C6139CC;
 Mon, 11 Sep 2023 09:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m/IqCJ/g/mQBLwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 11 Sep 2023 09:40:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Sep 2023 11:40:43 +0200
Message-Id: <20230911094043.25511-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor getdtablesize01 using new LTP API
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
 .../syscalls/getdtablesize/getdtablesize01.c  | 146 +++++++-----------
 1 file changed, 52 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
index d25cac261..80321e24f 100644
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
@@ -1,119 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2005
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ *     Prashant P Yendigeri <prashant.yendigeri@wipro.com>
+ *     Robbie Williamson <robbiew@us.ibm.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : getdtablesize01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for getdtablesize01(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Prashant P Yendigeri
- *                        <prashant.yendigeri@wipro.com>
- *                        Robbie Williamson
- *                        <robbiew@us.ibm.com>
- *
- *    DESCRIPTION
- *      This is a Phase I test for the getdtablesize01(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *
- **********************************************************/
 
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <unistd.h>
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * This test verifies that getdtablesize() syscall returns the right max number
+ * of files which can be opened by a process. We test this in 2 ways: firstly by
+ * comparing its return value with RLIMIT_NOFILE, secondly by opening as many
+ * files as possible and then checking when open() raises EMFILE.
+ */
 
-void setup();
-void cleanup();
+#include <stdlib.h>
+#include "tst_test.h"
 
-char *TCID = "getdtablesize01";
-int TST_TOTAL = 1;
+#define FILENAME "rofile"
 
-int main(void)
+static void run(void)
 {
-	int table_size, fd = 0, count = 0;
-	int max_val_opfiles;
+	int *fds;
+	int overfd;
+	int open_files;
 	struct rlimit rlp;
 
-	setup();
-	table_size = getdtablesize();
-	getrlimit(RLIMIT_NOFILE, &rlp);
-	max_val_opfiles = (rlim_t) rlp.rlim_cur;
-
-	tst_resm(TINFO,
-		 "Maximum number of files a process can have opened is %d",
-		 table_size);
-	tst_resm(TINFO,
-		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
-
-	if (table_size == max_val_opfiles)
-		tst_resm(TPASS, "got correct dtablesize, value is %d",
-			 max_val_opfiles);
-	else {
-		tst_resm(TFAIL, "got incorrect table size, value is %d",
-			 max_val_opfiles);
-		cleanup();
-	}
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlp);
+
+	TST_EXP_EQ_LI(getdtablesize(), rlp.rlim_cur);
+
+	tst_res(TINFO, "Start opening as many files as possible");
+
+	overfd = rlp.rlim_cur + 5;
 
-	tst_resm(TINFO,
-		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
-	for (;;) {
-		fd = open("/etc/hosts", O_RDONLY);
+	fds = (int *)SAFE_MALLOC(overfd * sizeof(int));
 
-		if (fd == -1)
+	for (open_files = 0; open_files < overfd; open_files++) {
+		TEST(open(FILENAME, O_RDONLY));
+
+		if (TST_RET == -1 && TST_ERR == EMFILE) {
+			tst_res(TINFO, "Reached max amount of open files per process");
 			break;
-		count = fd;
+		}
 
-#ifdef DEBUG
-		printf("Opened file num %d\n", fd);
-#endif
+		fds[open_files] = TST_RET;
 	}
 
-//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
+	--open_files;
 
-	if (count > 0)
-		close(count);
-	if (count == (max_val_opfiles - 1))
-		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
-	else if (fd < 0 && errno == ENFILE)
-		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
-	else
-		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
+	tst_res(TINFO, "Opened %d files", open_files);
 
-	cleanup();
-	tst_exit();
-}
+	for (int i = 0; i <= open_files; i++)
+		SAFE_CLOSE(fds[i]);
 
-void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	free(fds);
 
-	TEST_PAUSE;
+	TST_EXP_EXPR(getdtablesize() >= open_files,
+		"max amount of open files per process hasn't been overflowed");
 }
 
-void cleanup(void)
+static void setup(void)
 {
+	int fd;
+
+	fd = SAFE_CREAT(FILENAME, 0644);
+	SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
