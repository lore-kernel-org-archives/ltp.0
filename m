Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1FEC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:11:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052803C9B44
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:11:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0DB3C9B4A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63E97200B08
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1584F1F388;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngoryU9dng2iKTJWdEj/pwpzH0iliNqLc2B3cLpmw00=;
 b=xs7Dufbv7k/YWYfdLErBxMfjekvcK2f3dTAM62AF5sqq/tMl8qYOWTL/Kx5DxAJlXh8Zr8
 YWBFHR8/xsxsyoMJc1Py34I+lqo+tS9VRRZ0CwkCnUx+aIqf9loVHHgvr6Yks1J8TxACc2
 YehsR+zm0BFayrtHzLCmi8BdDhPcLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngoryU9dng2iKTJWdEj/pwpzH0iliNqLc2B3cLpmw00=;
 b=qme75Nws2oVt5NqszzNYULIwwaek5fSkUochJhQhBDo8QdTkLo4u579WyT88QwQk2QADIm
 C2pByfpXTDeL/aCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1BDA13BF9;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EDsMNXBBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:44 +0100
Message-Id: <20220208100948.22913-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 5/9] Rewrite sem_nstest.c using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 .../kernel/containers/sysvipc/sem_nstest.c    | 221 ++++++++----------
 1 file changed, 101 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index 72e04fe4f..cf206feb3 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -1,158 +1,139 @@
-/* *************************************************************************
-* Copyright (c) International Business Machines Corp., 2009
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*
-* In Parent Process , create semaphore with key 154326L
-* Now create container by passing 1 of the below flag values..
-*	clone(NONE), clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In cloned process, try to access the created semaphore
-* Test PASS: If the semaphore is readable when flag is None.
-* Test FAIL: If the semaphore is readable when flag is Unshare or Clone.
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * In Parent Process , create semaphore with key 154326L
+ * Now create container by passing 1 of the below flag values..
+ *	clone(NONE), clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+ * In cloned process, try to access the created semaphore
+ * Test PASS: If the semaphore is readable when flag is None.
+ * Test FAIL: If the semaphore is readable when flag is Unshare or Clone.
+ */
+
+#define _GNU_SOURCE
+
 #include <sys/ipc.h>
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
 #include <sys/sem.h>
-#include <libclone.h>
-#include "test.h"
-#include "ipcns_helper.h"
+#include "tst_test.h"
+#include "common.h"
+
+#define MY_KEY 154326L
 
-#define MY_KEY     154326L
-#define UNSHARESTR "unshare"
-#define CLONESTR   "clone"
-#define NONESTR    "none"
+static char *str_op = "clone";
 
-char *TCID = "sem_nstest";
-int TST_TOTAL = 1;
-int p1[2];
-int p2[2];
+static int p1[2];
+static int p2[2];
 
-int check_semaphore(void *vtest)
+static int check_semaphore(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
 	char buf[3];
 	int id;
 
-	(void) vtest;
+	SAFE_CLOSE(p1[1]);
+	SAFE_CLOSE(p2[0]);
 
-	close(p1[1]);
-	close(p2[0]);
+	SAFE_READ(1, p1[0], buf, 3);
 
-	read(p1[0], buf, 3);
 	id = semget(MY_KEY, 1, 0);
-	if (id == -1)
-		write(p2[1], "notfnd", 7);
-	else {
-		write(p2[1], "exists", 7);
-		tst_resm(TINFO, "PID %d: Fetched existing semaphore..id = %d",
-			 getpid(), id);
+	if (id < 0) {
+		SAFE_WRITE(1, p2[1], "notfnd", 7);
+	} else {
+		SAFE_WRITE(1, p2[1], "exists", 7);
+		tst_res(TINFO, "PID %d: Fetched existing semaphore..id = %d",
+			getpid(), id);
 	}
-	tst_exit();
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int ret, use_clone = T_NONE, id;
-	char *tsttype = NONESTR;
+	int use_clone = T_NONE, id;
 	char buf[7];
 
-	setup();
-
-	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone| unshare| none>", argv[0]);
-		tst_brkm(TFAIL, NULL, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-	}
-
 	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
+	SAFE_PIPE(p1);
+	SAFE_PIPE(p2);
 
-	if (strcmp(argv[1], "clone") == 0) {
+	if (!strcmp(str_op, "clone"))
 		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
+	else if (!strcmp(str_op, "unshare"))
 		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
 
 	/* 1. Create (or fetch if existing) the binary semaphore */
 	id = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
-	if (id == -1) {
-		perror("Semaphore create");
-		if (errno != EEXIST) {
-			perror("semget failure");
-			tst_brkm(TBROK, NULL, "Semaphore creation failed");
-		}
+	if (id < 0) {
+		tst_res(TINFO, "semget failure. Checking existing semaphore");
+
+		if (errno != EEXIST)
+			tst_brk(TBROK, "Semaphore creation failed");
+
 		id = semget(MY_KEY, 1, 0);
-		if (id == -1) {
-			perror("Semaphore create");
-			tst_brkm(TBROK, NULL, "Semaphore operation failed");
-		}
+		if (id < 0)
+			tst_brk(TBROK, "Semaphore operation failed");
 	}
 
-	tst_resm(TINFO, "Semaphore namespaces Isolation test : %s", tsttype);
-	/* fire off the test */
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore,
-				  NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
-	}
+	tst_res(TINFO, "Semaphore namespaces Isolation test : %s", str_op);
 
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-	read(p2[0], buf, 7);
-
-	if (strcmp(buf, "exists") == 0) {
-		if (use_clone == T_NONE)
-			tst_resm(TPASS, "Plain cloned process found semaphore "
-				 "inside container");
-		else
-			tst_resm(TFAIL,
-				 "%s: Container init process found semaphore",
-				 tsttype);
+	/* fire off the test */
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore, NULL);
+
+	SAFE_CLOSE(p1[0]);
+	SAFE_CLOSE(p2[1]);
+	SAFE_WRITE(1, p1[1], "go", 3);
+	SAFE_READ(1, p2[0], buf, 7);
+
+	if (!strcmp(buf, "exists")) {
+		if (use_clone == T_NONE) {
+			tst_res(TPASS, "Plain cloned process found semaphore "
+				       "inside container");
+		} else {
+			tst_res(TFAIL,
+				"%s: Container init process found semaphore",
+				str_op);
+		}
 	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "Plain cloned process didn't find semaphore");
-		else
-			tst_resm(TPASS, "%s: Container didn't find semaphore",
-				 tsttype);
+		if (use_clone == T_NONE) {
+			tst_res(TFAIL,
+				"Plain cloned process didn't find semaphore");
+		} else {
+			tst_res(TPASS, "%s: Container didn't find semaphore",
+				str_op);
+		}
 	}
 
 	/* Delete the semaphore */
 	id = semget(MY_KEY, 1, 0);
 	semctl(id, IPC_RMID, 0);
+}
 
-	tst_exit();
+static void setup(void)
+{
+	check_newipc();
+
+	if (strcmp(str_op, "clone") && strcmp(str_op, "unshare") &&
+	    strcmp(str_op, "none"))
+		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options =
+		(struct tst_option[]){
+			{ "m:", &str_op,
+			  "Test execution mode <clone|unshare|none>" },
+			{},
+		},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
