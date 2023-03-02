Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A129BC678D4
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 07:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B64B33CB9E2
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 08:16:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B4B33CDCEE
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:16:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FE7B600C63
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:16:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B17EF1FE67;
 Thu,  2 Mar 2023 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677741383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBfe9AT36+SA6gQbOFlqYB84ShaSHFqjJUMspwQnLrc=;
 b=beONGKjY4hgyDl7pptCkrl0Fc4Jj+MuV4Am8L2WbOSpmCU3bGFnmFKP8+25/ox9ypfbMfn
 1JSeBDmCZIFStK4yHhQwjM8PfNdzECsacT/540LRLBu8WI/glpwPQ5FnW3PYXZdfngvT/w
 iBrNtviO35DAVu+B9Nv2bCghuPsL0F8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12C0013A5C;
 Thu,  2 Mar 2023 07:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OO2ANkZNAGRxeQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 02 Mar 2023 07:16:22 +0000
To: ltp@lists.linux.it
Date: Thu,  2 Mar 2023 02:15:55 -0500
Message-Id: <20230302071555.18420-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230302071555.18420-1-wegao@suse.com>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] semop04:Refactor with new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ipc/semop/semop04.c | 163 ++++++++----------
 1 file changed, 68 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index 582624d60..dab34075c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -1,36 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (C) 2023 Linux Test Project, Inc.
  */
 
-/*
- *  FILE        : sem01.c
- *  DESCRIPTION : Creates a semaphore and two processes.  The processes
- *                each go through a loop where they semdown, delay for a
- *                random amount of time, and semup, so they will almost
- *                always be fighting for control of the semaphore.
- *  HISTORY:
- *    01/15/2001 Paul Larson (plars@us.ibm.com)
- *      -written
- *    11/09/2001 Manoj Iyer (manjo@ausin.ibm.com)
- *    Modified.
- *    - Removed compiler warnings.
- *      added exit to the end of function main()
+/*\
+ * [Description]
  *
+ * Creates a semaphore and two processes.  The processes
+ * each go through a loop where they semdown, delay for a
+ * random amount of time, and semup, so they will almost
+ * always be fighting for control of the semaphore.
  */
 
 #include <unistd.h>
@@ -41,103 +21,85 @@
 #include <sys/wait.h>
 #include <sys/ipc.h>
 #include "lapi/sem.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 
-int verbose = 0;
-int loops = 100;
-int errors = 0;
+static char *verbose;
+static int loops = 100;
+static char *opt_loops_str;
 
-int semup(int semid)
+static void semup(int semid)
 {
 	struct sembuf semops;
+
 	semops.sem_num = 0;
+
 	semops.sem_op = 1;
+
 	semops.sem_flg = SEM_UNDO;
-	if (semop(semid, &semops, 1) == -1) {
-		perror("semup");
-		errors++;
-		return 1;
-	}
-	return 0;
+
+	SAFE_SEMOP(semid, &semops, 1);
 }
 
-int semdown(int semid)
+static void semdown(int semid)
 {
 	struct sembuf semops;
+
 	semops.sem_num = 0;
+
 	semops.sem_op = -1;
+
 	semops.sem_flg = SEM_UNDO;
-	if (semop(semid, &semops, 1) == -1) {
-		perror("semdown");
-		errors++;
-		return 1;
-	}
-	return 0;
+
+	SAFE_SEMOP(semid, &semops, 1);
 }
 
-void delayloop()
+static void delayloop(void)
 {
 	int delay;
+
 	delay = 1 + ((100.0 * rand()) / RAND_MAX);
+
 	if (verbose)
-		printf("in delay function for %d microseconds\n", delay);
+		tst_res(TINFO, "in delay function for %d microseconds", delay);
 	usleep(delay);
 }
 
 void mainloop(int semid)
 {
 	int i;
+
 	for (i = 0; i < loops; i++) {
-		if (semdown(semid)) {
-			printf("semdown failed\n");
-		}
+		semdown(semid);
 		if (verbose)
-			printf("sem is down\n");
+			tst_res(TINFO, "Sem is down");
 		delayloop();
-		if (semup(semid)) {
-			printf("semup failed\n");
-		}
+		semup(semid);
 		if (verbose)
-			printf("sem is up\n");
+			tst_res(TINFO, "Sem is up");
 	}
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int semid, opt;
+	int semid;
 	union semun semunion;
-	extern char *optarg;
 	pid_t pid;
 	int chstat;
 
-	while ((opt = getopt(argc, argv, "l:vh")) != EOF) {
-		switch ((char)opt) {
-		case 'l':
-			loops = atoi(optarg);
-			break;
-		case 'v':
-			verbose = 1;
-			break;
-		case 'h':
-		default:
-			printf("Usage: -l loops [-v]\n");
-			exit(1);
-		}
-	}
-
 	/* set up the semaphore */
-	if ((semid = semget((key_t) 9142, 1, 0666 | IPC_CREAT)) < 0) {
-		printf("error in semget()\n");
-		exit(-1);
-	}
+	semid = SAFE_SEMGET((key_t) 9142, 1, 0666 | IPC_CREAT);
+	if (semid < 0)
+		tst_brk(TBROK, "Error in semget id=%i", semid);
+
 	semunion.val = 1;
-	if (semctl(semid, 0, SETVAL, semunion) == -1) {
-		printf("error in semctl\n");
-	}
 
-	if ((pid = fork()) < 0) {
-		printf("fork error\n");
-		exit(-1);
-	}
+	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
+
+	pid = SAFE_FORK();
+	if (pid < 0)
+		tst_brk(TBROK, "Fork failed pid %i", pid);
+
 	if (pid) {
 		/* parent */
 		srand(pid);
@@ -147,18 +109,29 @@ int main(int argc, char *argv[])
 			printf("child exited with status\n");
 			exit(-1);
 		}
-		if (semctl(semid, 0, IPC_RMID, semunion) == -1) {
-			printf("error in semctl\n");
-		}
-		if (errors) {
-			printf("FAIL: there were %d errors\n", errors);
-		} else {
-			printf("PASS: error count is 0\n");
-		}
-		exit(errors);
+		SAFE_SEMCTL(semid, 0, IPC_RMID, semunion);
+		tst_res(TPASS, "Semaphore up/down check success");
 	} else {
 		/* child */
 		mainloop(semid);
 	}
-	exit(0);
 }
+
+static void setup(void)
+{
+	if (opt_loops_str)
+		loops = SAFE_STRTOL(opt_loops_str, 1, INT_MAX);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"l:", &opt_loops_str, "Internal loops for semup/down"},
+		{"v", &verbose,
+			"Print information about successful semop."},
+		{}
+	},
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
