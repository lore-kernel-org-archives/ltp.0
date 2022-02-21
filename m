Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FFBC433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 15:57:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07B7A3CA1A4
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 16:57:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A7853C1041
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 16:57:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 320E91001172
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 16:57:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F5FE2111A
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645459043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oSqABBDVs3kuwaviC45dQSOC4n1OZzCAjEwmLJI7aVA=;
 b=aTFVyUNJqoq36mFGVDjHYj7pT2YOGtMmCyZkFMQ8rvOj4EsE2T+GMw+DN/f2K8MvXk+v/i
 6dFaZymDdO0jfC36XCA2Dl0UD10xXvsABGCuPyRbpdaOJSYF8jrhOFto8fEIBaK24OjyDL
 J2VNseW0X9yVzTJKoS+/2aLj+klooqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645459043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oSqABBDVs3kuwaviC45dQSOC4n1OZzCAjEwmLJI7aVA=;
 b=yDQcJtQrB5cxVp2h9hmmouxTWwxjjkuso9nVRRcqpNz/yCZ50Ebhyc+k913rPYgq4E7+6v
 gLZH/qgfKStwQ0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E988113B2F
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 15:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V8h1N2K2E2IxVwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 15:57:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 21 Feb 2022 16:59:33 +0100
Message-Id: <20220221155933.20824-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] syscalls/waitid: Guarded buf + result
 assertions
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

- make use of guarded buffers for the infop
- add assertion for the values reported in the infop
- Add a few more assertions for pid and gid filter tests

+ adjustements to the docparse comments

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitid/waitid02.c | 17 +++++------
 testcases/kernel/syscalls/waitid/waitid03.c | 18 +++++------
 testcases/kernel/syscalls/waitid/waitid04.c | 19 +++++++-----
 testcases/kernel/syscalls/waitid/waitid05.c | 33 ++++++++++++++-------
 testcases/kernel/syscalls/waitid/waitid06.c | 28 +++++++++++------
 testcases/kernel/syscalls/waitid/waitid07.c | 22 ++++++++------
 testcases/kernel/syscalls/waitid/waitid08.c | 30 ++++++++++++-------
 testcases/kernel/syscalls/waitid/waitid09.c | 33 ++++++++-------------
 8 files changed, 115 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index 15b807476..f13a4ed00 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -8,24 +8,23 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall returns EINVAL when passing
- * invalid set of input values.
+ * Tests if waitid() returns EINVAL when passed invalid options flag value.
  */
 
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
-
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_FAIL(waitid(P_ALL, 0, &infop, WNOHANG), EINVAL);
-
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_FAIL(waitid(P_ALL, 0, infop, WNOHANG), EINVAL);
 }
 
 static struct tst_test test = {
 	.test_all = run,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid03.c b/testcases/kernel/syscalls/waitid/waitid03.c
index 1dbb578da..ef3fd7376 100644
--- a/testcases/kernel/syscalls/waitid/waitid03.c
+++ b/testcases/kernel/syscalls/waitid/waitid03.c
@@ -8,24 +8,24 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall returns ECHILD when the calling
- * process has no existing unwaited-for child processes.
+ * Tests if waitid() syscall returns ECHILD when the calling process has no
+ * child processes.
  */
 
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
-
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_FAIL(waitid(P_ALL, 0, &infop, WNOHANG | WEXITED), ECHILD);
-
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_FAIL(waitid(P_ALL, 0, infop, WNOHANG | WEXITED), ECHILD);
 }
 
 static struct tst_test test = {
 	.test_all = run,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid04.c b/testcases/kernel/syscalls/waitid/waitid04.c
index 32c652dba..96c1cf8b1 100644
--- a/testcases/kernel/syscalls/waitid/waitid04.c
+++ b/testcases/kernel/syscalls/waitid/waitid04.c
@@ -8,15 +8,17 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall filters a child in WNOHANG status.
+ * This test if waitid() syscall leaves the si_pid set to 0 with WNOHANG flag
+ * when no child was waited for.
  */
 
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
 	pid_t pid_child;
 
 	pid_child = SAFE_FORK();
@@ -25,13 +27,10 @@ static void run(void)
 		return;
 	}
 
-	tst_res(TINFO, "filter all children by WNOHANG | WEXITED");
-
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_PASS(waitid(P_ALL, pid_child, &infop, WNOHANG | WEXITED));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_ALL, pid_child, infop, WNOHANG | WEXITED));
 
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_EQ_LI(infop->si_pid, 0);
 
 	TST_CHECKPOINT_WAKE(0);
 }
@@ -40,4 +39,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid05.c b/testcases/kernel/syscalls/waitid/waitid05.c
index 3c0a80cc1..1b9186dc1 100644
--- a/testcases/kernel/syscalls/waitid/waitid05.c
+++ b/testcases/kernel/syscalls/waitid/waitid05.c
@@ -8,34 +8,45 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall filters children which exited from
- * the same group ID.
+ * Tests if waitid() filters children correctly by the group ID.
+ *
+ * - waitid() with GID + 1 returns ECHILD
+ * - waitid() with GID returns correct data
  */
 
+#include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
 	pid_t pid_group;
+	pid_t pid_child;
 
-	/* dummy fork to spawn child in the same group ID */
-	if (!SAFE_FORK())
-		return;
+	pid_child = SAFE_FORK();
+	if (!pid_child)
+		exit(0);
 
 	pid_group = getpgid(0);
 
-	tst_res(TINFO, "filter child by group ID and WEXITED");
+	TST_EXP_FAIL(waitid(P_PGID, pid_group+1, infop, WEXITED), ECHILD);
 
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_PASS(waitid(P_PGID, pid_group, &infop, WEXITED));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_PGID, pid_group, infop, WEXITED));
 
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_EQ_LI(infop->si_pid, pid_child);
+	TST_EXP_EQ_LI(infop->si_status, 0);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_EXITED);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid06.c b/testcases/kernel/syscalls/waitid/waitid06.c
index 886c9b2fd..5f51c81c8 100644
--- a/testcases/kernel/syscalls/waitid/waitid06.c
+++ b/testcases/kernel/syscalls/waitid/waitid06.c
@@ -8,32 +8,42 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall filters children which exited.
+ * Tests if waitid() filters children correctly by the PID.
+ *
+ * - waitid() with PID + 1 returns ECHILD
+ * - waitid() with PID returns correct data
  */
 
+#include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
 	pid_t pid_child;
 
-	/* dummy fork */
 	pid_child = SAFE_FORK();
 	if (!pid_child)
-		return;
+		exit(0);
 
-	tst_res(TINFO, "filter child by WEXITED");
+	TST_EXP_FAIL(waitid(P_PID, pid_child+1, infop, WEXITED), ECHILD);
 
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_PASS(waitid(P_PID, pid_child, &infop, WEXITED));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_PID, pid_child, infop, WEXITED));
 
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_EQ_LI(infop->si_pid, pid_child);
+	TST_EXP_EQ_LI(infop->si_status, 0);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_EXITED);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid07.c b/testcases/kernel/syscalls/waitid/waitid07.c
index 23ae24f35..d607dbd8f 100644
--- a/testcases/kernel/syscalls/waitid/waitid07.c
+++ b/testcases/kernel/syscalls/waitid/waitid07.c
@@ -8,16 +8,16 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall filters children killed with
- * SIGSTOP.
+ * Test if waitid() filters children killed with SIGSTOP.
  */
 
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
 	pid_t pid_child;
 
 	pid_child = SAFE_FORK();
@@ -27,13 +27,13 @@ static void run(void)
 		return;
 	}
 
-	tst_res(TINFO, "filter child by WSTOPPED | WNOWAIT");
-
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_PASS(waitid(P_PID, pid_child, &infop, WSTOPPED | WNOWAIT));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_PID, pid_child, infop, WSTOPPED | WNOWAIT));
 
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
+	TST_EXP_EQ_LI(infop->si_pid, pid_child);
+	TST_EXP_EQ_LI(infop->si_status, SIGSTOP);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_STOPPED);
 
 	SAFE_KILL(pid_child, SIGCONT);
 
@@ -44,4 +44,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid08.c b/testcases/kernel/syscalls/waitid/waitid08.c
index 86a134d99..2da680e64 100644
--- a/testcases/kernel/syscalls/waitid/waitid08.c
+++ b/testcases/kernel/syscalls/waitid/waitid08.c
@@ -8,16 +8,16 @@
 /*\
  * [Description]
  *
- * This test is checking if waitid() syscall filters children killed with
- * SIGCONT.
+ * Test if waitid() filters children killed with SIGCONT.
  */
 
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
 	pid_t pid_child;
 
 	pid_child = SAFE_FORK();
@@ -29,19 +29,25 @@ static void run(void)
 
 	tst_res(TINFO, "send SIGCONT to child");
 
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_PASS(waitid(P_PID, pid_child, &infop, WSTOPPED));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_PID, pid_child, infop, WSTOPPED));
+
+	TST_EXP_EQ_LI(infop->si_pid, pid_child);
+	TST_EXP_EQ_LI(infop->si_status, SIGSTOP);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_STOPPED);
 
 	SAFE_KILL(pid_child, SIGCONT);
 
 	tst_res(TINFO, "filter child by WCONTINUED");
 
-	TST_EXP_PASS(waitid(P_PID, pid_child, &infop, WCONTINUED));
+	memset(infop, 0, sizeof(*infop));
+	TST_EXP_PASS(waitid(P_PID, pid_child, infop, WCONTINUED));
 
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
-
-	SAFE_KILL(pid_child, SIGCONT);
+	TST_EXP_EQ_LI(infop->si_pid, pid_child);
+	TST_EXP_EQ_LI(infop->si_status, SIGCONT);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_CONTINUED);
 
 	TST_CHECKPOINT_WAKE(0);
 }
@@ -50,4 +56,8 @@ static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/waitid/waitid09.c b/testcases/kernel/syscalls/waitid/waitid09.c
index 3ee443831..115c2e672 100644
--- a/testcases/kernel/syscalls/waitid/waitid09.c
+++ b/testcases/kernel/syscalls/waitid/waitid09.c
@@ -8,37 +8,30 @@
 /*\
  * [Description]
  *
- * This test is checking that waitid() syscall filters not a child of the
- * current process.
+ * Test that waitid() fails with ECHILD with process that is not child of the
+ * current process. We fork() one child just to be sure that there are unwaited
+ * for children available while the test runs.
  */
 
+#include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 
+static siginfo_t *infop;
+
 static void run(void)
 {
-	siginfo_t infop;
-	pid_t pid_child;
-
-	pid_child = SAFE_FORK();
-	if (!pid_child) {
-		TST_CHECKPOINT_WAIT(0);
-		return;
-	}
-
-	tst_res(TINFO, "filter not a child of the current process by WEXITED");
+	if (!SAFE_FORK())
+		exit(0);
 
-	memset(&infop, 0, sizeof(infop));
-	TST_EXP_FAIL(waitid(P_PID, 1, &infop, WEXITED), ECHILD);
-
-	tst_res(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
-		infop.si_pid, infop.si_code, infop.si_status);
-
-	TST_CHECKPOINT_WAKE(0);
+	TST_EXP_FAIL(waitid(P_PID, 1, infop, WEXITED), ECHILD);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers[]) {
+		{&infop, .size = sizeof(*infop)},
+		{}
+	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
