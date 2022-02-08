Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CD4C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:11:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E93713C9B49
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:11:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8EE93C9B3D
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3AF461001182
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E19DA21102;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rwivpPMl3kPVQhrIIR3Zr3PLD9XqSKRcODdSNTDkqQ=;
 b=s0ljzQHYTOBcJQQyg83k9y2UkM6GsqM8BdKzf7bMbh0GC0iqSEEfdWvkEHz6i4Aaw5mzIz
 CQ5m1Y55MZZvz9dsZmeFN9C1HDWi2/z214M0/OndlZjOAcDcgpoqvioXDXUMptg+HR7iM7
 ijAScUIgLdAKpRQU8drEM1lCYUP5Dko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rwivpPMl3kPVQhrIIR3Zr3PLD9XqSKRcODdSNTDkqQ=;
 b=tzeF5usIXUIBwT1PoPcZRyVMs2q8Err0UZJ+bfNfL2extQATmq9TmNwF6/bbTTFCbQDJAk
 NwxFx3BRVRH0rAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBAF913BF9;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EO3RK3FBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:48 +0100
Message-Id: <20220208100948.22913-10-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 9/9] Rewrite shmnstest.c using new LTP API
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
 .../kernel/containers/sysvipc/shmnstest.c     | 185 ++++++++----------
 1 file changed, 83 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index cf69cab21..55f76a0be 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -1,144 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) International Business Machines Corp., 2007
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
-* Author: Serge Hallyn <serue@us.ibm.com>
-*
-* Create shm with key 0xEAEAEA
-* clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In cloned process, try to get the created shm
-
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
+ * Copyright (c) International Business Machines Corp., 2007
+ *				Serge Hallyn <serue@us.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Create shm with key 0xEAEAEA and in cloned process try to get the shm.
+ */
+
+#define _GNU_SOURCE
+
 #include <sys/ipc.h>
 #include <sys/shm.h>
-#include "ipcns_helper.h"
-#include "test.h"
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "common.h"
 
-char *TCID = "sysvipc_namespace";
-int TST_TOTAL = 1;
 #define TESTKEY 0xEAEAEA
 
-int p1[2];
-int p2[2];
+static char *str_op = "clone";
+
+static int p1[2];
+static int p2[2];
 
-int check_shmid(void *vtest)
+static int check_shmid(LTP_ATTRIBUTE_UNUSED void *vtest)
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
 	id = shmget(TESTKEY, 100, 0);
-	if (id == -1) {
-		write(p2[1], "notfnd", 7);
+	if (id < 0) {
+		SAFE_WRITE(1, p2[1], "notfnd", 7);
 	} else {
-		write(p2[1], "exists", 7);
+		SAFE_WRITE(1, p2[1], "exists", 7);
 		shmctl(id, IPC_RMID, NULL);
 	}
 
-	tst_exit();
+	return 0;
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-	check_newipc();
-}
-
-#define UNSHARESTR "unshare"
-#define CLONESTR "clone"
-#define NONESTR "none"
-int main(int argc, char *argv[])
-{
-	int r, use_clone = T_NONE;
+	int use_clone = T_NONE;
 	int id;
-	char *tsttype = NONESTR;
 	char buf[7];
 
-	setup();
+	/* Using PIPE's to sync between container and Parent */
+	SAFE_PIPE(p1);
+	SAFE_PIPE(p2);
 
-	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
-		tst_brkm(TFAIL,
-			 NULL,
-			 " where clone, unshare, or fork specifies unshare method.");
-	}
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	tsttype = NONESTR;
-	if (strcmp(argv[1], "clone") == 0) {
+	if (!strcmp(str_op, "clone"))
 		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
+	else if (!strcmp(str_op, "unshare"))
 		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
 
 	/* first create the key */
-	id = shmget(TESTKEY, 100, IPC_CREAT);
-	if (id == -1) {
-		perror("shmget");
-		tst_brkm(TFAIL, NULL, "shmget failed");
-	}
+	TEST(shmget(TESTKEY, 100, IPC_CREAT));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "shmget: %s", tst_strerrno(-TST_ERR));
+
+	id = (int)TST_RET;
+
+	tst_res(TINFO, "shmid namespaces test : %s", str_op);
 
-	tst_resm(TINFO, "shmid namespaces test : %s", tsttype);
 	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
-	if (r < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
-	}
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
+
+	SAFE_CLOSE(p1[0]);
+	SAFE_CLOSE(p2[1]);
+
+	SAFE_WRITE(1, p1[1], "go", 3);
+	SAFE_READ(1, p2[0], buf, 7);
 
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-	read(p2[0], buf, 7);
 	if (strcmp(buf, "exists") == 0) {
 		if (use_clone == T_NONE)
-			tst_resm(TPASS, "plain cloned process found shmid");
+			tst_res(TPASS, "plain cloned process found shmid");
 		else
-			tst_resm(TFAIL, "%s: child process found shmid",
-				 tsttype);
+			tst_res(TFAIL, "%s: child process found shmid", str_op);
 	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "plain cloned process didn't find shmid");
-		else
-			tst_resm(TPASS, "%s: child process didn't find shmid",
-				 tsttype);
+		if (use_clone == T_NONE) {
+			tst_res(TFAIL,
+				"plain cloned process didn't find shmid");
+		} else {
+			tst_res(TPASS, "%s: child process didn't find shmid",
+				str_op);
+		}
 	}
 
 	/* destroy the key */
 	shmctl(id, IPC_RMID, NULL);
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
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
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
