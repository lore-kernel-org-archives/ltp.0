Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CDEC6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 13:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B57A03CCE09
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 14:33:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB9683CBAAA
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 14:33:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A96A7600723
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 14:33:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF5ED21DFF;
 Thu,  2 Mar 2023 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677763979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zJYDVZ1e5dx13GmorhWKT8QpHFFofG2F4XlO5ErAwUg=;
 b=ep5R5jor3vGk/Q6ny3OnEWMHDdHB0/gopPbhIiazZD488ZtOnDkPQDX/RhYb9EHCzWQc/8
 YaXF9ZMMyKvQtJ+IL7KI4fmNGpVAc8XWUKeqlYt3EzW1MSqOkquIKft24LSikqpZYgWj0I
 gKCKdmSbANTliQhJjWL3hn4qCZPjI7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6B5F13A63;
 Thu,  2 Mar 2023 13:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0jmWKoulAGQ1RgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 02 Mar 2023 13:32:59 +0000
To: ltp@lists.linux.it
Date: Thu,  2 Mar 2023 14:30:55 +0100
Message-Id: <20230302133055.7860-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove ltp_clone_quick from sysvipc testing suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Replaced ltp_clone_quick with SAFE_CLONE
Removed check_newipc because CLONE_NEWIPC is supported from 2.6.x

 testcases/kernel/containers/sysvipc/common.h  | 47 +++++++------------
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 13 ++---
 .../kernel/containers/sysvipc/msg_comm.c      | 19 ++------
 .../kernel/containers/sysvipc/sem_comm.c      | 19 ++------
 .../kernel/containers/sysvipc/sem_nstest.c    | 12 ++---
 .../kernel/containers/sysvipc/semtest_2ns.c   | 15 ++----
 .../kernel/containers/sysvipc/shm_comm.c      | 19 ++------
 .../kernel/containers/sysvipc/shmem_2nstest.c | 15 ++----
 .../kernel/containers/sysvipc/shmnstest.c     | 10 +---
 9 files changed, 48 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
index 9b0fc16e9..c43d947d5 100644
--- a/testcases/kernel/containers/sysvipc/common.h
+++ b/testcases/kernel/containers/sysvipc/common.h
@@ -19,24 +19,7 @@ enum {
 	T_NONE,
 };
 
-static int dummy_child(void *v)
-{
-	(void)v;
-	return 0;
-}
-
-static void check_newipc(void)
-{
-	int pid, status;
-
-	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child, NULL);
-	if (pid < 0)
-		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
-
-	SAFE_WAITPID(pid, &status, 0);
-}
-
-static inline int get_clone_unshare_enum(const char* str_op)
+static inline int get_clone_unshare_enum(const char *str_op)
 {
 	int use_clone;
 
@@ -54,16 +37,19 @@ static inline int get_clone_unshare_enum(const char* str_op)
 	return use_clone;
 }
 
-static void clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+static void clone_test(unsigned long clone_flags, void (*fn1)())
 {
+	const struct tst_clone_args clone_args = { clone_flags, SIGCHLD };
 	int pid;
 
-	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
-	if (pid < 0)
-		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
+	pid = SAFE_CLONE(&clone_args);
+	if (!pid) {
+		fn1();
+		exit(0);
+	}
 }
 
-static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+static void unshare_test(unsigned long clone_flags, void (*fn1)())
 {
 	int pid;
 
@@ -71,34 +57,33 @@ static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void
 	if (!pid) {
 		SAFE_UNSHARE(clone_flags);
 
-		fn1(arg1);
+		fn1();
 		exit(0);
 	}
 }
 
-static void plain_test(int (*fn1)(void *arg), void *arg1)
+static void plain_test(void (*fn1)())
 {
 	int pid;
 
 	pid = SAFE_FORK();
 	if (!pid) {
-		fn1(arg1);
+		fn1();
 		exit(0);
 	}
 }
 
-static void clone_unshare_test(int use_clone, unsigned long clone_flags,
-			       int (*fn1)(void *arg), void *arg1)
+static void clone_unshare_test(int use_clone, unsigned long clone_flags, void (*fn1)())
 {
 	switch (use_clone) {
 	case T_NONE:
-		plain_test(fn1, arg1);
+		plain_test(fn1);
 	break;
 	case T_CLONE:
-		clone_test(clone_flags, fn1, arg1);
+		clone_test(clone_flags, fn1);
 	break;
 	case T_UNSHARE:
-		unshare_test(clone_flags, fn1, arg1);
+		unshare_test(clone_flags, fn1);
 	break;
 	default:
 		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__, use_clone);
diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index 056b5d086..4b12c1ce1 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -42,7 +42,7 @@ struct msg_buf {
 	char mtext[80];
 };
 
-static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_mesgq(void)
 {
 	int id, n;
 	struct msg_buf msg = {};
@@ -55,7 +55,7 @@ static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
 		else
 			tst_res(TPASS, "%s: container didn't find mesgq", str_op);
 
-		return 0;
+		return;
 	}
 
 	if (use_clone == T_NONE) {
@@ -68,11 +68,10 @@ static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
 		if (strcmp(msg.mtext, MSG_TEXT))
 			tst_res(TFAIL, "Received the wrong text message");
 
-		return 0;
+		return;
 	}
 
 	tst_res(TFAIL, "%s: container init process found mesgq", str_op);
-	return 0;
 }
 
 static void run(void)
@@ -87,16 +86,12 @@ static void run(void)
 
 	tst_res(TINFO, "mesgq namespaces test: %s", str_op);
 
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq);
 }
 
 static void setup(void)
 {
 	use_clone = get_clone_unshare_enum(str_op);
-
-	if (use_clone != T_NONE)
-		check_newipc();
-
 	ipc_id = SAFE_MSGGET(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
 }
 
diff --git a/testcases/kernel/containers/sysvipc/msg_comm.c b/testcases/kernel/containers/sysvipc/msg_comm.c
index 238863d9c..3762adb02 100644
--- a/testcases/kernel/containers/sysvipc/msg_comm.c
+++ b/testcases/kernel/containers/sysvipc/msg_comm.c
@@ -38,7 +38,7 @@ struct sysv_msg {
 	char mtext[1];
 };
 
-static int chld1_msg(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld1_msg(void)
 {
 	int id;
 	struct sysv_msg m = {
@@ -66,11 +66,9 @@ static int chld1_msg(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE(0);
 
 	SAFE_MSGCTL(id, IPC_RMID, NULL);
-
-	return 0;
 }
 
-static int chld2_msg(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld2_msg(void)
 {
 	int id;
 	struct sysv_msg m = {
@@ -85,24 +83,17 @@ static int chld2_msg(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_MSGCTL(id, IPC_RMID, NULL);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_msg, NULL);
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_msg, NULL);
-}
-
-static void setup(void)
-{
-	check_newipc();
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_msg);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_msg);
 }
 
 static struct tst_test test = {
 	.test_all = run,
-	.setup = setup,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index 3323ec09f..d8f0956a7 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -33,7 +33,7 @@
 
 #define TESTKEY 124426L
 
-static int chld1_sem(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld1_sem(void)
 {
 	int id;
 	struct sembuf sm = {
@@ -56,11 +56,9 @@ static int chld1_sem(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_SEMCTL(id, 0, IPC_RMID);
-
-	return 0;
 }
 
-static int chld2_sem(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld2_sem(void)
 {
 	int id;
 	struct sembuf sm = {
@@ -93,24 +91,17 @@ static int chld2_sem(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE(0);
 
 	SAFE_SEMCTL(id, 0, IPC_RMID);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_sem, NULL);
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_sem, NULL);
-}
-
-static void setup(void)
-{
-	check_newipc();
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_sem);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_sem);
 }
 
 static struct tst_test test = {
 	.test_all = run,
-	.setup = setup,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index ac1dae443..35d55cbac 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -35,7 +35,7 @@ static char *str_op;
 static int use_clone;
 static int ipc_id = -1;
 
-static int check_semaphore(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_semaphore(void)
 {
 	int id;
 
@@ -47,7 +47,7 @@ static int check_semaphore(LTP_ATTRIBUTE_UNUSED void *vtest)
 		else
 			tst_res(TPASS, "%s: container didn't find semaphore", str_op);
 
-		return 0;
+		return;
 	}
 
 	tst_res(TINFO, "PID %d: fetched existing semaphore..id = %d", getpid(), id);
@@ -56,22 +56,16 @@ static int check_semaphore(LTP_ATTRIBUTE_UNUSED void *vtest)
 		tst_res(TPASS, "Plain cloned process found semaphore inside container");
 	else
 		tst_res(TFAIL, "%s: Container init process found semaphore", str_op);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore);
 }
 
 static void setup(void)
 {
 	use_clone = get_clone_unshare_enum(str_op);
-
-	if (use_clone != T_NONE)
-		check_newipc();
-
 	ipc_id = SAFE_SEMGET(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
 }
 
diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index edff3f522..f03b18f72 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -40,7 +40,7 @@
 static char *str_op;
 static int use_clone;
 
-static int check_sem1(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_sem1(void)
 {
 	int id;
 	struct sembuf sm = {
@@ -62,11 +62,9 @@ static int check_sem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_SEMCTL(id, IPC_RMID, 0);
-
-	return 0;
 }
 
-static int check_sem2(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_sem2(void)
 {
 	int id;
 	struct sembuf sm = {
@@ -112,22 +110,17 @@ static int check_sem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 	}
 
 	TST_CHECKPOINT_WAKE(0);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2);
 }
 
 static void setup(void)
 {
 	use_clone = get_clone_unshare_enum(str_op);
-
-	if (use_clone != T_NONE)
-		check_newipc();
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/containers/sysvipc/shm_comm.c b/testcases/kernel/containers/sysvipc/shm_comm.c
index 12ad49110..e7ba8c8de 100644
--- a/testcases/kernel/containers/sysvipc/shm_comm.c
+++ b/testcases/kernel/containers/sysvipc/shm_comm.c
@@ -35,7 +35,7 @@
 #define TESTKEY 124426L
 #define SHMSIZE 50
 
-static int chld1_shm(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld1_shm(void)
 {
 	int id;
 	char *shmem;
@@ -56,11 +56,9 @@ static int chld1_shm(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	SAFE_SHMDT(shmem);
 	SAFE_SHMCTL(id, IPC_RMID, NULL);
-
-	return 0;
 }
 
-static int chld2_shm(LTP_ATTRIBUTE_UNUSED void *arg)
+static void chld2_shm(void)
 {
 	int id;
 	char *shmem;
@@ -77,24 +75,17 @@ static int chld2_shm(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	SAFE_SHMDT(shmem);
 	SAFE_SHMCTL(id, IPC_RMID, NULL);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm, NULL);
-	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm, NULL);
-}
-
-static void setup(void)
-{
-	check_newipc();
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm);
 }
 
 static struct tst_test test = {
 	.test_all = run,
-	.setup = setup,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index ea3de94bd..a184cfcb4 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -40,7 +40,7 @@
 static char *str_op;
 static int use_clone;
 
-static int check_shmem1(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_shmem1(void)
 {
 	int id;
 
@@ -51,11 +51,9 @@ static int check_shmem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_SHMCTL(id, IPC_RMID, NULL);
-
-	return 0;
 }
 
-static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_shmem2(void)
 {
 	TST_CHECKPOINT_WAIT(0);
 
@@ -74,22 +72,17 @@ static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 	}
 
 	TST_CHECKPOINT_WAKE(0);
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2);
 }
 
 static void setup(void)
 {
 	use_clone = get_clone_unshare_enum(str_op);
-
-	if (use_clone != T_NONE)
-		check_newipc();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index d8ace723e..63ae62aa6 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -27,7 +27,7 @@ static char *str_op;
 static int use_clone;
 static int ipc_id = -1;
 
-static int check_shmid(LTP_ATTRIBUTE_UNUSED void *vtest)
+static void check_shmid(void)
 {
 	TEST(shmget(TESTKEY, 100, 0));
 	if (TST_RET < 0) {
@@ -41,22 +41,16 @@ static int check_shmid(LTP_ATTRIBUTE_UNUSED void *vtest)
 		else
 			tst_res(TFAIL, "%s: child process found shmid", str_op);
 	}
-
-	return 0;
 }
 
 static void run(void)
 {
-	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid);
 }
 
 static void setup(void)
 {
 	use_clone = get_clone_unshare_enum(str_op);
-
-	if (use_clone != T_NONE)
-		check_newipc();
-
 	ipc_id = shmget(TESTKEY, 100, IPC_CREAT);
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
