Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27071C64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 12:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51EC73CDDE2
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 13:46:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 497EB3CAFCD
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 13:45:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC1DE600124
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 13:45:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3CAE1FDCA;
 Tue, 28 Feb 2023 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677588352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoLjmwf6cZM3ngO/YzZCYpdICHF8PvTkbZkVjO8e55A=;
 b=h+JdLZi7j7oHF0yAys28XTmBWfoIwv1Duwvh8cP2Lad+B+nKzujb6hW73v8z8MXIde4wHi
 cLyjkGHGRodd/e+ja8GCAlYEhRdP+/gRoP3Wwn83E7R5Sr/82Ih6Lbwk5p94fsOp1ZoRei
 hAJPg2GzOiwH2Nr4ztBnDD8kvCWEqU8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 902AC1333C;
 Tue, 28 Feb 2023 12:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xdprIID3/WPmGQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 28 Feb 2023 12:45:52 +0000
To: ltp@lists.linux.it
Date: Tue, 28 Feb 2023 13:43:48 +0100
Message-Id: <20230228124348.13164-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove ltp_clone_quick usage from pidns suite
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

Replaced ltp_clone_quick with SAFE_CLONE inside the pidns testing
suite.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/pidns/pidns01.c | 14 ++++++------
 testcases/kernel/containers/pidns/pidns02.c | 14 ++++++------
 testcases/kernel/containers/pidns/pidns03.c | 14 ++++++------
 testcases/kernel/containers/pidns/pidns12.c | 18 +++++++++-------
 testcases/kernel/containers/pidns/pidns20.c | 24 +++++++++++----------
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 5080b6fad..998da7d95 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -17,7 +17,7 @@
 #include "tst_test.h"
 #include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	pid_t cpid, ppid;
 
@@ -26,20 +26,20 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	TST_EXP_PASS(cpid == 1);
 	TST_EXP_PASS(ppid == 0);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
 
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
 };
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index b8913d3f6..57102f652 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -16,7 +16,7 @@
 #include "tst_test.h"
 #include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	pid_t sid, pgid;
 
@@ -25,20 +25,20 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	TST_EXP_PASS(sid == 1);
 	TST_EXP_PASS(pgid == 1);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
 
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
 };
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index 122ba7891..50e69a9f3 100644
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
@@ -57,5 +56,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index fb1ec90ca..2631a7451 100644
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
@@ -63,5 +64,6 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 9f369699a..c3d63d125 100644
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
@@ -87,5 +88,6 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
