Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE72C6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 13:45:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF3653CD4EE
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 14:45:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 284FE3CAE69
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:44:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1735C10009CB
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:44:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05E291F897;
 Tue, 14 Mar 2023 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678801491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hYwIVy1tSnNIV8pCs1zzlrufrC9dE4NRlLW+3hVQw/c=;
 b=YDqDFA5FUZI6TLh/HgxdWU7fmIO9f4GjzOzyP5yH6M7jrb1tiaL4OFGf1I6RHvuQqs8sBp
 ACfZINoPAyIXdtbBpPodWCd0frKuVZQVQQus7wPR10jSh0+UG6+a7V9d15Dq2Y0Bw8gFJZ
 k1IIdVrkqFwWNmmtBe3gwD1RjDeqWr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678801491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hYwIVy1tSnNIV8pCs1zzlrufrC9dE4NRlLW+3hVQw/c=;
 b=bTanGjnRFJi8mUnXZx94Z5uFAFhIIU/yUv8rSaqEKFquo435uNxIVCdN+nDGJK7eYsVGp7
 oqPR+l+96EC2faAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC68413A1B;
 Tue, 14 Mar 2023 13:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8oI7NFJ6EGSABAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Mar 2023 13:44:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 14 Mar 2023 14:42:42 +0100
Message-Id: <20230314134242.9203-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Remove ltp_clone_quick usage from pidns suite
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

Replaced ltp_clone_quick with SAFE_CLONE inside the pidns testing
suite. Fixed also errors in pidns0[12] where in previous patches we
used CLONE_NEWNS instead of CLONE_NEWPID.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/pidns/pidns01.c | 24 ++++++++++--------
 testcases/kernel/containers/pidns/pidns02.c | 26 +++++++++++--------
 testcases/kernel/containers/pidns/pidns03.c | 18 +++++++------
 testcases/kernel/containers/pidns/pidns12.c | 22 ++++++++++------
 testcases/kernel/containers/pidns/pidns20.c | 28 +++++++++++++--------
 5 files changed, 72 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 5080b6fad..6b5ec48ac 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -8,7 +8,7 @@
 /*\
  * [Description]
  *
- * Clone a process with CLONE_NEWNS flag and check:
+ * Clone a process with CLONE_NEWPID flag and check:
  *
  * - child process ID must be 1
  * - parent process ID must be 0
@@ -17,29 +17,33 @@
 #include "tst_test.h"
 #include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	pid_t cpid, ppid;
 
 	cpid = getpid();
 	ppid = getppid();
 
-	TST_EXP_PASS(cpid == 1);
-	TST_EXP_PASS(ppid == 0);
-
-	return 0;
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index b8913d3f6..5372aeef9 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -7,7 +7,7 @@
 /*\
  * [Description]
  *
- * Clone a process with CLONE_NEWNS flag and check:
+ * Clone a process with CLONE_NEWPID flag and check:
  *
  * - child session ID must be 1
  * - parent process group ID must be 1
@@ -16,29 +16,35 @@
 #include "tst_test.h"
 #include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	pid_t sid, pgid;
 
+	SAFE_SETSID();
+
 	sid = getsid(0);
 	pgid = getpgid(0);
 
-	TST_EXP_PASS(sid == 1);
-	TST_EXP_PASS(pgid == 1);
-
-	return 0;
+	TST_EXP_EQ_LI(sid, 1);
+	TST_EXP_EQ_LI(pgid, 1);
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index 122ba7891..d0d26c8a5 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -17,7 +17,7 @@
 
 #define PROCDIR "proc"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	char proc_self[10];
 
@@ -28,8 +28,6 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 	SAFE_UMOUNT(PROCDIR);
 
 	TST_EXP_PASS(strcmp(proc_self, "1"), PROCDIR"/self contains 1:");
-
-	return 0;
 }
 
 static void setup(void)
@@ -45,11 +43,12 @@ static void cleanup(void)
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
-	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 }
 
 static struct tst_test test = {
@@ -57,5 +56,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index fb1ec90ca..ab035f33d 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -25,7 +25,7 @@ static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LT
 	sig_pid = si->si_pid;
 }
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	struct sigaction sa;
 
@@ -41,21 +41,22 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	TST_EXP_EQ_LI(sig_pid, 0);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	int pid;
 
-	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	pid = SAFE_CLONE(&args);
+	if (!pid) {
+		child_func();
+		return;
+	}
 
 	TST_CHECKPOINT_WAIT(0);
 
-	SAFE_KILL(ret, SIGUSR1);
+	SAFE_KILL(pid, SIGUSR1);
 
 	TST_CHECKPOINT_WAKE(0);
 }
@@ -63,5 +64,10 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 9f369699a..4d0924c4e 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -26,7 +26,7 @@ static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LT
 	signals++;
 }
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	struct sigaction sa;
 	sigset_t newset;
@@ -37,7 +37,7 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	if (cpid != 1 || ppid != 0) {
 		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
-		return 0;
+		return;
 	}
 
 	SAFE_SIGEMPTYSET(&newset);
@@ -56,30 +56,31 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	if (signals != 1) {
 		tst_res(TFAIL, "Received %d signals", signals);
-		return 0;
+		return;
 	}
 
 	if (last_signo != SIGUSR1) {
 		tst_res(TFAIL, "Received %s signal", tst_strsig(last_signo));
-		return 0;
+		return;
 	}
 
 	tst_res(TPASS, "Received SIGUSR1 signal after unblock");
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	int pid;
 
-	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	pid = SAFE_CLONE(&args);
+	if (!pid) {
+		child_func();
+		return;
+	}
 
 	TST_CHECKPOINT_WAIT(0);
 
-	SAFE_KILL(ret, SIGUSR1);
+	SAFE_KILL(pid, SIGUSR1);
 
 	TST_CHECKPOINT_WAKE(0);
 }
@@ -87,5 +88,10 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
