Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3AAC433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:11:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E053B3C9B62
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:11:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 779BC3C9B23
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B14861400F4B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5414A210F0;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5BCPXPj1tEwISrtLA+ycmMvyqa75tdpRnUOYuYLtXFY=;
 b=N9r9vyrTofwFfy1+k4bpiELJItXEq3rFeBnoW2WDhoHtN5MQ5IRYKUilMsgmEe7nQ2UtgX
 0EuEJ96G2ZjfX5knCSaLdPSbut8HRs1UBK+L578RHeTCDjxKZljA913oYr0gzdb3WQXHZh
 g3dvrB63G6JKTv04ryXL2Iig9X7rITk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5BCPXPj1tEwISrtLA+ycmMvyqa75tdpRnUOYuYLtXFY=;
 b=mj2i8mryOYF6b5Ypmy5aZ/jbotvfcJRREcmDBUd/gJi6/uSl8HcXkgLN6cz4BVXJYnbym8
 zuIhDgKlGHMQj+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21C9013BF9;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gEwtBnFBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:45 +0100
Message-Id: <20220208100948.22913-7-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 6/9] Rewrite semtest_2ns.c using new LTP API
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
 .../kernel/containers/sysvipc/semtest_2ns.c   | 318 ++++++++----------
 1 file changed, 149 insertions(+), 169 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index c3483b675..9b0d83879 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -1,230 +1,210 @@
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
+ * Create 2 'containers' with the below flag value
+ *   Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+ * In Cont1, create semaphore with key 124326L
+ * In Cont2, try to access the semaphore created in Cont1.
+ * PASS :
+ *		If flag = None and the semaphore is accessible in Cont2.
+ *		If flag = unshare/clone and the semaphore is not accessible in
+ *Cont2. If semaphore is not accessible in Cont2, creates new semaphore with the
+ *same key to double check isloation in IPCNS.
+ *
+ * FAIL :
+ *		If flag = none and the semaphore is not accessible.
+ *		If flag = unshare/clone and semaphore is accessible in Cont2.
+ *		If the new semaphore creation Fails.
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
+#include "tst_test.h"
+#include "common.h"
+
+#define MY_KEY 124326L
+
+static char *str_op = "clone";
+
+static int p1[2];
+static int p2[2];
+
 static struct sembuf semop_lock[2] = {
 	/* sem_num, sem_op, flag */
-	{0, 0, 0},		/* wait for sem#0 to become 0 */
-	{0, 1, SEM_UNDO}	/* then increment sem#0 by 1 */
+	{ 0, 0, 0 }, /* wait for sem#0 to become 0 */
+	{ 0, 1, SEM_UNDO } /* then increment sem#0 by 1 */
 };
 
 static struct sembuf semop_unlock[1] = {
 	/* sem_num, sem_op, flag */
-	{0, -1, (IPC_NOWAIT | SEM_UNDO)}	/* decrement sem#0 by 1 (sets it to 0) */
+	{ 0, -1,
+	  (IPC_NOWAIT | SEM_UNDO) } /* decrement sem#0 by 1 (sets it to 0) */
 };
 
 /*
  * sem_lock() - Locks the semaphore for crit-sec updation, and unlocks it later
  */
-void sem_lock(int id)
+static void sem_lock(int id)
 {
+	int ret;
+
 	/* Checking the semlock and simulating as if the crit-sec is updated */
-	if (semop(id, &semop_lock[0], 2) < 0) {
-		perror("sem lock error");
-		tst_brkm(TBROK, NULL, "semop failed");
-	}
-	tst_resm(TINFO, "Sem1: File locked, Critical section is updated...");
+	ret = semop(id, &semop_lock[0], 2);
+	if (ret < 0)
+		tst_brk(TBROK, "semop: %s", tst_strerrno(-ret));
+
+	tst_res(TINFO, "Sem1: File locked, Critical section is updated...");
+
 	sleep(2);
-	if (semop(id, &semop_unlock[0], 1) < 0) {
-		perror("sem unlock error");
-		tst_brkm(TBROK, NULL, "semop failed");
-	}
+
+	ret = semop(id, &semop_unlock[0], 1);
+	if (ret < 0)
+		tst_brk(TBROK, "semop: %s", tst_strerrno(-ret));
 }
 
 /*
  * check_sem1 -  does not read -- it writes to check_sem2() when it's done.
  */
-int check_sem1(void *vtest)
+static int check_sem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int id1;
+	SAFE_CLOSE(p1[0]);
 
-	(void) vtest;
-
-	close(p1[0]);
 	/* 1. Create (or fetch if existing) the binary semaphore */
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
+	TEST(semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666));
+	if (TST_RET < 0) {
+		tst_res(TINFO, "semget failure. Checking existing semaphore");
+
+		if (TST_ERR != EEXIST)
+			tst_brk(TBROK, "Semaphore creation failed");
+
+		TEST(semget(MY_KEY, 1, 0));
+		if (TST_RET < 0)
+			tst_brk(TBROK, "Semaphore operation failed");
 	}
 
-	write(p1[1], "go", 3);
-	tst_resm(TINFO, "Cont1: Able to create semaphore");
-	tst_exit();
+	SAFE_WRITE(1, p1[1], "go", 3);
+
+	tst_res(TINFO, "Cont1: Able to create semaphore");
+
+	return 0;
 }
 
 /*
  * check_sem2() reads from check_sem1() and writes to main() when it's done.
  */
-
-int check_sem2(void *vtest)
+static int check_sem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
 	char buf[3];
 	int id2;
 
-	(void) vtest;
-
-	close(p1[1]);
-	close(p2[0]);
-	read(p1[0], buf, 3);
+	SAFE_CLOSE(p1[1]);
+	SAFE_CLOSE(p2[0]);
+	SAFE_READ(1, p1[0], buf, 3);
 
 	id2 = semget(MY_KEY, 1, 0);
-	if (id2 != -1) {
+	if (id2 >= 0) {
 		sem_lock(id2);
-		write(p2[1], "exists", 7);
+		SAFE_WRITE(1, p2[1], "exists", 7);
 	} else {
-		/* Trying to create a new semaphore, if semaphore is not existing */
-		id2 = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
-		if (id2 == -1) {
-			perror("Semaphore create");
-			if (errno != EEXIST) {
-				perror("semget failure");
-				tst_resm(TBROK, "semget failure");
+		/* Trying to create a new semaphore, if semaphore is not
+		 * existing
+		 */
+		TEST(semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666));
+		if (TST_RET < 0) {
+			if (TST_ERR != EEXIST) {
+				tst_brk(TBROK, "semget: %s",
+					tst_strerrno(-TST_RET));
 			}
-		} else
-			tst_resm(TINFO,
-				 "Cont2: Able to create semaphore with sameKey");
+		} else {
+			tst_res(TINFO,
+				"Cont2: Able to create semaphore with sameKey");
+		}
+
 		/* Passing the pipe Not-found mesg */
-		write(p2[1], "notfnd", 7);
+		SAFE_WRITE(1, p2[1], "notfnd", 7);
 	}
 
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int ret, id, use_clone = T_NONE;
-	char *tsttype = NONESTR;
+	int id, use_clone = T_NONE;
 	char buf[7];
 
-	setup();
-
-	if (argc != 2) {
-		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
-		tst_resm(TINFO, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-		tst_exit();
-	}
-
 	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror("pipe1");
-		tst_exit();
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe2");
-		tst_exit();
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
 
-	tst_resm(TINFO, "Semaphore Namespaces Test : %s", tsttype);
+	tst_res(TINFO, "Semaphore Namespaces Test : %s", str_op);
 
 	/* Create 2 containers */
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
-	}
-
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
+
+	SAFE_CLOSE(p2[1]);
+	SAFE_READ(1, p2[0], buf, 7);
+
+	if (!strcmp(buf, "exists"))
+		if (use_clone == T_NONE) {
+			tst_res(TPASS, "Plain cloned process able to access "
+				       "the semaphore "
+				       "created");
+		} else {
+			tst_res(TFAIL,
+				"%s : In namespace2 found the semaphore "
+				"created in Namespace1",
+				str_op);
+		}
+	else if (use_clone == T_NONE) {
+		tst_res(TFAIL, "Plain cloned process didn't find semaphore");
+	} else {
+		tst_res(TPASS,
+			"%s : In namespace2 unable to access the semaphore "
+			"created in Namespace1",
+			str_op);
 	}
-	close(p2[1]);
-	read(p2[0], buf, 7);
-
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
 
 	/* Delete the semaphore */
 	id = semget(MY_KEY, 1, 0);
 	semctl(id, IPC_RMID, 0);
-	tst_exit();
 }
+
+static void setup(void)
+{
+	check_newipc();
+
+	if (strcmp(str_op, "clone") && strcmp(str_op, "unshare") &&
+	    strcmp(str_op, "none"))
+		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
+}
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
