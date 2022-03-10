Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98252C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B1A93C0CA6
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:00:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 470023C0CA6
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9D8721001131
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2696A1F381;
 Thu, 10 Mar 2022 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYgmxkY8Cb2Xb5iPH5hI6ebz8v9jOGkhhoeqSoGFmBk=;
 b=i4o2E/Zd03B3E40625JNGJPAVtmAHlX/7SoupqLkZ0pvhiGtl99ZIG2ZhOUUNP6a770Vw7
 uLe82zGh779tBI3VfMT2FLD2f/izD8IKYf1mGcTjdCJKTHvCoDEr4VR81t+CUETz+SoBLL
 HUDohBgz2P8JiZioW5HeXKMavbjpzy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYgmxkY8Cb2Xb5iPH5hI6ebz8v9jOGkhhoeqSoGFmBk=;
 b=3iNbUigf9gv1rVzW54yrBz4XdO2PoSTWvGMyS4+j3K2j2gMNivfs8m9o0XVtb2AkbdJ+/B
 6kMjS60BTI8jeICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0082C13A3D;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CErJOQnaKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:10 +0100
Message-Id: <20220310105916.7960-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/10] Rewrite sem_nstest.c using new LTP API
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
 .../kernel/containers/sysvipc/sem_nstest.c    | 212 +++++++-----------
 1 file changed, 76 insertions(+), 136 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index 72e04fe4f..514af6c4f 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -1,158 +1,98 @@
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
-#include <sys/ipc.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test SysV IPC semaphore usage between namespaces.
+ *
+ * [Algorithm]
+ *
+ * In parent process create a new semaphore with a specific key.
+ * In cloned process, try to access the created semaphore
+ *
+ * Test PASS if the semaphore is readable when flag is None.
+ * Test FAIL if the semaphore is readable when flag is Unshare or Clone.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
 #include <sys/sem.h>
-#include <libclone.h>
-#include "test.h"
-#include "ipcns_helper.h"
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "common.h"
 
-#define MY_KEY     154326L
-#define UNSHARESTR "unshare"
-#define CLONESTR   "clone"
-#define NONESTR    "none"
+#define MY_KEY 154326L
 
-char *TCID = "sem_nstest";
-int TST_TOTAL = 1;
-int p1[2];
-int p2[2];
+static char *str_op = "clone";
+static int use_clone;
+static int ipc_id = -1;
 
-int check_semaphore(void *vtest)
+static int check_semaphore(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[3];
 	int id;
 
-	(void) vtest;
+	id = semget(MY_KEY, 1, 0);
 
-	close(p1[1]);
-	close(p2[0]);
+	if (id < 0) {
+		if (use_clone == T_NONE)
+			tst_res(TFAIL, "Plain cloned process didn't find semaphore");
+		else
+			tst_res(TPASS, "%s: container didn't find semaphore", str_op);
+	} else {
+		tst_res(TINFO, "PID %d: fetched existing semaphore..id = %d", getpid(), id);
 
-	read(p1[0], buf, 3);
-	id = semget(MY_KEY, 1, 0);
-	if (id == -1)
-		write(p2[1], "notfnd", 7);
-	else {
-		write(p2[1], "exists", 7);
-		tst_resm(TINFO, "PID %d: Fetched existing semaphore..id = %d",
-			 getpid(), id);
+		if (use_clone == T_NONE)
+			tst_res(TPASS, "Plain cloned process found semaphore inside container");
+		else
+			tst_res(TFAIL, "%s: Container init process found semaphore", str_op);
 	}
-	tst_exit();
+
+	return 0;
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-	check_newipc();
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore, NULL);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int ret, use_clone = T_NONE, id;
-	char *tsttype = NONESTR;
-	char buf[7];
-
-	setup();
-
-	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone| unshare| none>", argv[0]);
-		tst_brkm(TFAIL, NULL, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-	}
+	use_clone = get_clone_unshare_enum(str_op);
 
-	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	if (strcmp(argv[1], "clone") == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
-		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
+	ipc_id = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
+	if (ipc_id < 0) {
+		tst_res(TINFO, "Semaphore already exists");
+		ipc_id = SAFE_SEMGET(MY_KEY, 1, 0);
 	}
+}
 
-	/* 1. Create (or fetch if existing) the binary semaphore */
-	id = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
-	if (id == -1) {
-		perror("Semaphore create");
-		if (errno != EEXIST) {
-			perror("semget failure");
-			tst_brkm(TBROK, NULL, "Semaphore creation failed");
-		}
-		id = semget(MY_KEY, 1, 0);
-		if (id == -1) {
-			perror("Semaphore create");
-			tst_brkm(TBROK, NULL, "Semaphore operation failed");
-		}
-	}
-
-	tst_resm(TINFO, "Semaphore namespaces Isolation test : %s", tsttype);
-	/* fire off the test */
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore,
-				  NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
-	}
-
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
-	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "Plain cloned process didn't find semaphore");
-		else
-			tst_resm(TPASS, "%s: Container didn't find semaphore",
-				 tsttype);
+static void cleanup(void)
+{
+	if (ipc_id != -1) {
+		tst_res(TINFO, "Delete semaphore");
+		SAFE_SEMCTL(ipc_id, IPC_RMID, 0);
 	}
-
-	/* Delete the semaphore */
-	id = semget(MY_KEY, 1, 0);
-	semctl(id, IPC_RMID, 0);
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
+		{},
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
