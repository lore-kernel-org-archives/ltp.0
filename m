Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58C8C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 12:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0953C8811
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 13:56:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53CDC3C696C
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3573D1A00E7F
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE471F858;
 Fri, 25 Mar 2022 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648212887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSYSM8SHi4m1OutMTYSSqVuCY8Gjq+EQ9Gq4IlZiP2k=;
 b=nDAgmjA/RVMSbL1tB4lsnAGNbikfTx0YQliwuIMGbetO2Wt/Wb8msDw5Fu4iA8sRudj+lr
 6nsevT6WZk9zQ2dsROJrSCx0jigeWH2QCWmuEmMrFhJlwTS0XpvX8airNoTQoEsqcFER9B
 S+Wbt0RtA934eM4Kp9xCM48golyF5zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648212887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSYSM8SHi4m1OutMTYSSqVuCY8Gjq+EQ9Gq4IlZiP2k=;
 b=WW64C4MeqYTQoVjNigPVTYpLeC5dsefqeKI2sU48Qsxo15nYp3eF+1dnV9epmpygPAQFH+
 11Inl902taxTjTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF8A1332D;
 Fri, 25 Mar 2022 12:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8OowIZe7PWKoZgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 12:54:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 13:54:40 +0100
Message-Id: <20220325125445.11984-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325125445.11984-1-andrea.cervesato@suse.de>
References: <20220325125445.11984-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 05/10] Rewrite semtest_2ns.c using new LTP API
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

Updated containers runtest file to include new semtest_2ns.c options.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/containers                            |   6 +-
 .../kernel/containers/sysvipc/semtest_2ns.c   | 326 +++++++-----------
 2 files changed, 127 insertions(+), 205 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 4f56b1b4d..3130ccfbd 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -57,9 +57,9 @@ msg_comm msg_comm
 sem_nstest_none sem_nstest -m none
 sem_nstest_clone sem_nstest -m clone
 sem_nstest_unshare sem_nstest -m unshare
-semtest_2ns_none semtest_2ns none
-semtest_2ns_clone semtest_2ns clone
-semtest_2ns_unshare semtest_2ns unshare
+semtest_2ns_none semtest_2ns -m none
+semtest_2ns_clone semtest_2ns -m clone
+semtest_2ns_unshare semtest_2ns -m unshare
 sem_comm sem_comm
 
 utstest_unshare_1 utstest unshare 1
diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index c3483b675..1666b1f04 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -1,230 +1,152 @@
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
-* Test Assertion:
-* This testcase verifies the semaphore isoloation in 2 diff containers.
-* It tries to create/access a semaphore created with the same KEY.
-*
-* Description:
-* Create 2 'containers' with the below flag value
-*   Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In Cont1, create semaphore with key 124326L
-* In Cont2, try to access the semaphore created in Cont1.
-* PASS :
-*		If flag = None and the semaphore is accessible in Cont2.
-*		If flag = unshare/clone and the semaphore is not accessible in Cont2.
-*		If semaphore is not accessible in Cont2, creates new semaphore with
-*		the same key to double check isloation in IPCNS.
-*
-* FAIL :
-*		If flag = none and the semaphore is not accessible.
-*		If flag = unshare/clone and semaphore is accessible in Cont2.
-*		If the new semaphore creation Fails.
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <sys/ipc.h>
-#include <sys/sem.h>
-#include <libclone.h>
-#include "test.h"
-#include "ipcns_helper.h"
-
-#define MY_KEY     124326L
-#define UNSHARESTR "unshare"
-#define CLONESTR   "clone"
-#define NONESTR    "none"
-
-char *TCID = "semtest_2ns";
-int TST_TOTAL = 1;
-int p1[2];
-int p2[2];
-static struct sembuf semop_lock[2] = {
-	/* sem_num, sem_op, flag */
-	{0, 0, 0},		/* wait for sem#0 to become 0 */
-	{0, 1, SEM_UNDO}	/* then increment sem#0 by 1 */
-};
-
-static struct sembuf semop_unlock[1] = {
-	/* sem_num, sem_op, flag */
-	{0, -1, (IPC_NOWAIT | SEM_UNDO)}	/* decrement sem#0 by 1 (sets it to 0) */
-};
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * sem_lock() - Locks the semaphore for crit-sec updation, and unlocks it later
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-void sem_lock(int id)
-{
-	/* Checking the semlock and simulating as if the crit-sec is updated */
-	if (semop(id, &semop_lock[0], 2) < 0) {
-		perror("sem lock error");
-		tst_brkm(TBROK, NULL, "semop failed");
-	}
-	tst_resm(TINFO, "Sem1: File locked, Critical section is updated...");
-	sleep(2);
-	if (semop(id, &semop_unlock[0], 1) < 0) {
-		perror("sem unlock error");
-		tst_brkm(TBROK, NULL, "semop failed");
-	}
-}
 
-/*
- * check_sem1 -  does not read -- it writes to check_sem2() when it's done.
+/*\
+ * [Description]
+ *
+ * Test SysV IPC semaphore usage between namespaces and processes.
+ *
+ * [Algorithm]
+ *
+ * Create 2 'containers'
+ * In container1 create semaphore with a specific key and lock it
+ * In container2 try to access the semaphore created in container1 and try to
+ * unlock it.
+ *
+ * If mode = None, test will PASS when semaphore created process1 can be read
+ * and unlocked from process2.
+ * If mode = Clone, test will PASS when semaphore created in container1 can't
+ * be accessed from container2.
+ * If mode = Unshare, test will PASS when semaphore created in container2 can't
+ * be accessed from container2.
  */
-int check_sem1(void *vtest)
-{
-	int id1;
-
-	(void) vtest;
-
-	close(p1[0]);
-	/* 1. Create (or fetch if existing) the binary semaphore */
-	id1 = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
-	if (id1 == -1) {
-		perror("Semaphore create");
-		if (errno != EEXIST) {
-			perror("semget failure");
-			tst_brkm(TBROK, NULL, "semget failure");
-		}
-		id1 = semget(MY_KEY, 1, 0);
-		if (id1 == -1) {
-			perror("Semaphore create");
-			tst_brkm(TBROK, NULL, "semget failure");
-		}
-	}
 
-	write(p1[1], "go", 3);
-	tst_resm(TINFO, "Cont1: Able to create semaphore");
-	tst_exit();
-}
+#define _GNU_SOURCE
 
-/*
- * check_sem2() reads from check_sem1() and writes to main() when it's done.
- */
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include <sys/sem.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "common.h"
 
-int check_sem2(void *vtest)
+#define MY_KEY 124326L
+
+static char *str_op;
+static int use_clone;
+
+static int check_sem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[3];
-	int id2;
+	int id;
+	struct sembuf sm;
 
-	(void) vtest;
+	id = SAFE_SEMGET(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
 
-	close(p1[1]);
-	close(p2[0]);
-	read(p1[0], buf, 3);
+	tst_res(TINFO, "%s: created key in child1", str_op);
 
-	id2 = semget(MY_KEY, 1, 0);
-	if (id2 != -1) {
-		sem_lock(id2);
-		write(p2[1], "exists", 7);
-	} else {
-		/* Trying to create a new semaphore, if semaphore is not existing */
-		id2 = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
-		if (id2 == -1) {
-			perror("Semaphore create");
-			if (errno != EEXIST) {
-				perror("semget failure");
-				tst_resm(TBROK, "semget failure");
-			}
-		} else
-			tst_resm(TINFO,
-				 "Cont2: Able to create semaphore with sameKey");
-		/* Passing the pipe Not-found mesg */
-		write(p2[1], "notfnd", 7);
-	}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	tst_exit();
-}
+	tst_res(TINFO, "Lock semaphore in container1");
+	sm.sem_num = 0;
+	sm.sem_op = 1;
+	sm.sem_flg = SEM_UNDO;
+	SAFE_SEMOP(id, &sm, 1);
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static int check_sem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int ret, id, use_clone = T_NONE;
-	char *tsttype = NONESTR;
-	char buf[7];
+	int id;
+	struct sembuf sm;
 
-	setup();
+	TST_CHECKPOINT_WAIT(0);
 
-	if (argc != 2) {
-		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
-		tst_resm(TINFO, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-		tst_exit();
-	}
+	tst_res(TINFO, "%s: reading key in child2", str_op);
 
-	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror("pipe1");
-		tst_exit();
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe2");
-		tst_exit();
+	id = semget(MY_KEY, 1, 0);
+	if (id >= 0) {
+		if (use_clone == T_NONE)
+			tst_res(TPASS, "Plain cloned process able to access the semaphore created");
+		else
+			tst_res(TFAIL, "%s: In namespace2 found semaphore created in namespace1", str_op);
+	} else {
+		if (use_clone == T_NONE)
+			tst_res(TFAIL, "Plain cloned process didn't find semaphore");
+		else
+			tst_res(TPASS, "%s: In namespace2 unable to access semaphore created in namespace1", str_op);
 	}
 
-	if (strcmp(argv[1], "clone") == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
-		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	if (id >= 0) {
+		tst_res(TINFO, "Trying to unlock semaphore in container2");
+		sm.sem_num = 0;
+		sm.sem_op = -1;
+		sm.sem_flg = IPC_NOWAIT | SEM_UNDO;
+		TEST(semop(id, &sm, 1));
+
+		if (TST_RET >= 0) {
+			if (use_clone == T_NONE)
+				tst_res(TPASS, "Plain cloned process able to unlock semaphore");
+			else
+				tst_res(TFAIL, "%s: In namespace2 able to unlock the semaphore created in an namespace1", str_op);
+		} else {
+			if (use_clone == T_NONE)
+				tst_res(TFAIL, "Plain cloned process unable to unlock semaphore");
+			else
+				tst_res(TPASS, "%s: In namespace2 unable to unlock the semaphore created in an namespace1", str_op);
+		}
+
+		SAFE_SEMCTL(id, IPC_RMID, 0);
 	}
 
-	tst_resm(TINFO, "Semaphore Namespaces Test : %s", tsttype);
+	TST_CHECKPOINT_WAKE(0);
 
-	/* Create 2 containers */
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
-	}
+	return 0;
+}
 
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
-	}
-	close(p2[1]);
-	read(p2[0], buf, 7);
+static void run(void)
+{
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
+}
+
+static void setup(void)
+{
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone != T_NONE)
+		check_newipc();
+}
+
+static void cleanup(void)
+{
+	int id;
 
-	if (strcmp(buf, "exists") == 0)
-		if (use_clone == T_NONE)
-			tst_resm(TPASS,
-				 "Plain cloned process able to access the semaphore "
-				 "created");
-		else
-			tst_resm(TFAIL,
-				 "%s : In namespace2 found the semaphore "
-				 "created in Namespace1", tsttype);
-	else if (use_clone == T_NONE)
-		tst_resm(TFAIL, "Plain cloned process didn't find semaphore");
-	else
-		tst_resm(TPASS,
-			 "%s : In namespace2 unable to access the semaphore "
-			 "created in Namespace1", tsttype);
-
-	/* Delete the semaphore */
 	id = semget(MY_KEY, 1, 0);
-	semctl(id, IPC_RMID, 0);
-	tst_exit();
+	if (id >= 0) {
+		tst_res(TINFO, "Destroy semaphore");
+		SAFE_SEMCTL(id, IPC_RMID, 0);
+	}
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
+		{},
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
