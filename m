Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B8EC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:00:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 134623C6AD5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:00:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09E223C0CA6
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 507CC140115C
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8EC521122;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWbs9lt+RNy65eXtssiadU2xVSSsu2HGJ1LiTjSRK3o=;
 b=YCoQYPHUdDgx7Ur6ztwdrfIK9n4bKlYLfpv+0niFA8+N8son8SwVWXnkjzgnL294web/Vw
 SpICREJ8CdnSgUnwSWMxurBRfwgOajimFH7V73VwCBM9uK8L6PH7tAUiudvIyoFPpzCsAH
 wOOvSq1l/6Nn7oU/6s3qGZByfKI67ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWbs9lt+RNy65eXtssiadU2xVSSsu2HGJ1LiTjSRK3o=;
 b=u82AcrdTB2H5/jP8Hdj9NnpqDyB9MW2eQpjBdwRYqXVJ2Bq8gd9npml123LKYKrAM8XfYg
 dHu20AjvngUO//Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C49D613A3D;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHMBLgnaKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:09 +0100
Message-Id: <20220310105916.7960-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/10] Rewrite sem_comm.c using new LTP API
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
 .../kernel/containers/sysvipc/sem_comm.c      | 180 ++++++------------
 1 file changed, 56 insertions(+), 124 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index a2c354a08..a57a1fd1a 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -1,20 +1,16 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Test SysV IPC semaphore usage between cloned processes.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: sem_comm.c
+ * [Algorithm]
  *
- * Description:
  * 1. Clones two child processes with CLONE_NEWIPC flag, each child
  *    creates System V semaphore (sem) with the _identical_ key.
  * 2. Child1 locks the semaphore.
@@ -26,166 +22,102 @@
  */
 
 #define _GNU_SOURCE
-#include <sys/ipc.h>
-#include <sys/types.h>
+
 #include <sys/wait.h>
-#include <stdio.h>
-#include <errno.h>
-#include "ipcns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
 #include "lapi/sem.h"
+#include "common.h"
 
 #define TESTKEY 124426L
-char *TCID	= "sem_comm";
-int TST_TOTAL	= 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(tst_rmdir);
-}
 
-int chld1_sem(void *arg)
+static int chld1_sem(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int id;
 	union semun su;
 	struct sembuf sm;
 
-	id = semget(TESTKEY, 1, IPC_CREAT);
-	if (id == -1) {
-		perror("semget");
-		return 2;
-	}
+	id = SAFE_SEMGET(TESTKEY, 1, IPC_CREAT);
 
 	su.val = 1;
-	if (semctl(id, 0, SETVAL, su) == -1) {
-		perror("semctl");
-		semctl(id, 0, IPC_RMID);
-		return 2;
-	}
+	SAFE_SEMCTL(id, 0, SETVAL, su);
 
 	/* tell child2 to continue and wait for it to create the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	sm.sem_num = 0;
 	sm.sem_op = -1;
 	sm.sem_flg = IPC_NOWAIT;
-	if (semop(id, &sm, 1) == -1) {
-		perror("semop");
-		semctl(id, 0, IPC_RMID);
-		return 2;
-	}
+	SAFE_SEMOP(id, &sm, 1);
 
 	/* tell child2 to continue and wait for it to lock the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	sm.sem_op = 1;
-	semop(id, &sm, 1);
+	SAFE_SEMOP(id, &sm, 1);
+
+	SAFE_SEMCTL(id, 0, IPC_RMID);
 
-	semctl(id, 0, IPC_RMID);
 	return 0;
 }
 
-int chld2_sem(void *arg)
+static int chld2_sem(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	int id, rval = 0;
+	int id;
 	struct sembuf sm;
 	union semun su;
 
 	/* wait for child1 to create the semaphore */
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	id = semget(TESTKEY, 1, IPC_CREAT);
-	if (id == -1) {
-		perror("semget");
-		return 2;
-	}
+	id = SAFE_SEMGET(TESTKEY, 1, IPC_CREAT);
 
 	su.val = 1;
-	if (semctl(id, 0, SETVAL, su) == -1) {
-		perror("semctl");
-		semctl(id, 0, IPC_RMID);
-		return 2;
-	}
+	SAFE_SEMCTL(id, 0, SETVAL, su);
 
 	/* tell child1 to continue and wait for it to lock the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	sm.sem_num = 0;
 	sm.sem_op = -1;
 	sm.sem_flg = IPC_NOWAIT;
-	if (semop(id, &sm, 1) == -1) {
-		if (errno == EAGAIN) {
-			rval = 1;
-		} else {
-			perror("semop");
-			semctl(id, 0, IPC_RMID);
-			return 2;
-		}
+	TEST(semop(id, &sm, 1));
+	if (TST_RET < 0) {
+		if (TST_ERR != EAGAIN)
+			tst_brk(TBROK | TERRNO, "semop error");
+
+		tst_res(TFAIL, "SysV sem: communication with identical keys between namespaces");
+	} else {
+		tst_res(TPASS, "SysV sem: communication with identical keys between namespaces");
 	}
 
 	/* tell child1 to continue */
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_CHECKPOINT_WAKE(0);
 
 	sm.sem_op = 1;
-	semop(id, &sm, 1);
+	SAFE_SEMOP(id, &sm, 1);
+
+	SAFE_SEMCTL(id, 0, IPC_RMID);
 
-	semctl(id, 0, IPC_RMID);
-	return rval;
+	return 0;
 }
 
-static void test(void)
+static void run(void)
 {
-	int status, ret = 0;
-
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_sem, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_sem, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-
-	while (wait(&status) > 0) {
-		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
-			ret = 1;
-		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
-			tst_brkm(TBROK | TERRNO, cleanup, "error in child");
-		if (WIFSIGNALED(status)) {
-			tst_resm(TFAIL, "child was killed with signal %s",
-					tst_strsig(WTERMSIG(status)));
-			return;
-		}
-	}
-
-	if (ret)
-		tst_resm(TFAIL, "SysV sem: communication with identical keys"
-				" between namespaces");
-	else
-		tst_resm(TPASS, "SysV sem: communication with identical keys"
-				" between namespaces");
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_sem, NULL);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_sem, NULL);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
-
-	cleanup();
-	tst_exit();
+	check_newipc();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
