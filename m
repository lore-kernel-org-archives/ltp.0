Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A64C636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 09:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 406E03CC14A
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:13:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AE283CB0FC
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:13:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E8D01A01019
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:13:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38CC1207C0;
 Wed,  8 Feb 2023 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675847600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5GSl97AcWHnXRiuxHz5hsSu9yEzvfxkUQSSP5cubx/s=;
 b=nrkOo2N13r8HtwbVd1dcoGDAXajaJwchWefUND5UVmHOrsIlhAIVKocJkN2RU2YkpT9jHB
 OFBRDHUy51TuKq+zyodPoLlFgImT/NtrgiSvbadxnD9Ypq/TWUXw8p4ii6fJ4oczDs4y2E
 CE/lbw3Fb/+M0JS6PY8/yXTCdn2GtXc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1062E13A1F;
 Wed,  8 Feb 2023 09:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SPr6AbBn42NyEgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 08 Feb 2023 09:13:20 +0000
To: ltp@lists.linux.it
Date: Wed,  8 Feb 2023 10:11:20 +0100
Message-Id: <20230208091120.9994-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Refactor pidns30 test using new LTP API
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
Usage of TST_* macros
Usage of SAFE_CLONE
Moved signal check out of signal handler
Better TINFO message

 testcases/kernel/containers/pidns/pidns30.c | 322 +++++---------------
 1 file changed, 72 insertions(+), 250 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index c8b0806c0..c408484dd 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -1,296 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) Bull S.A.S. 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************
-* File: pidns30.c
-*
-*   Description:
-*    This testcase checks if the si_pid is correctly set when a process
-*    that has registered for notification on a posix mqueue is in a
-*    descendant namespace wrt the process that sends a message to that posix
-*    mqueue.
-*
-*   Test Assertion & Strategy:
-*    Parent                                   Child
-*    --------------------------------------------------------------------------
-*    Create a POSIX mqueue.
-*    Create a PID namespace container.
-*                                             Open that mqueue for reading
-*                                             Register for notification when a
-*                                                message arrives in that mqueue
-*                                             Install a handler for SIGUSR1.
-*    Write something to the mqueue.
-*                                             Inside the handler, check that
-*                                                si_pid is set to 0
-*
-*   Usage: <for command-line>
-*    pidns30
-*
-*   History:
-*    DATE      NAME                             DESCRIPTION
-*    01/12/08  Nadia Derbey               Creation of this test.
-*              <Nadia.Derbey@bull.net>
-*
-******************************************************************************/
-#define _GNU_SOURCE 1
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <mqueue.h>
-#include "lapi/syscalls.h"
-#include "pidns_helper.h"
-#include "test.h"
-
-char *TCID = "pidns30";
-int TST_TOTAL = 1;
-
-char *mqname = "mq1";
-int result = TFAIL;
-
-int father_to_child[2];
-int child_to_father[2];
-
-#define CHILD_PID       1
-#define PARENT_PID      0
+ * Copyright (c) Bull S.A.S. 2008
+ *               01/12/08  Nadia Derbey <Nadia.Derbey@bull.net>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-#define MSG      "HOW ARE YOU"
-#define MSG_PRIO 1
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag, register notification on a posix
+ * mqueue and send a mqueue message from the parent. Then check if signal
+ * notification contains si_pid of the parent.
+ */
 
-#define NO_STEP	-1
-#define F_STEP_0 0x00
-#define F_STEP_1 0x01
-#define F_STEP_2 0x02
-#define F_STEP_3 0x03
-#define C_STEP_0 0x10
-#define C_STEP_1 0x11
-#define C_STEP_2 0x12
+#define _GNU_SOURCE
+#include <signal.h>
+#include <mqueue.h>
+#include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
+#include "lapi/sched.h"
 
-mqd_t rc = -1;
-mqd_t mqd = -1;
+#define MQNAME "/LTP_PIDNS30_MQ"
 
-static void remove_pipe(int *fd)
-{
-	close(fd[0]);
-	close(fd[1]);
-}
+static mqd_t mqd = -1;
+static siginfo_t info;
+static volatile int received;
 
 static void remove_mqueue(mqd_t mqd)
 {
-	mq_close(mqd);
-	tst_syscall(__NR_mq_unlink, mqname);
-}
+	if (mqd != -1)
+		SAFE_MQ_CLOSE(mqd);
 
-static void cleanup(void)
-{
-	if (mqd != -1) {
-		remove_mqueue(mqd);
-	}
-	if (rc != -1) {
-		remove_mqueue(rc);
-	}
-	remove_pipe(father_to_child);
-	remove_pipe(child_to_father);
+	mq_unlink(MQNAME);
 }
 
-static void cleanup_child(void)
+static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
 {
-	if (mqd != -1) {
-		tst_syscall(__NR_mq_notify, mqd, NULL);
-	}
-	cleanup();
+	received = 1;
+	memcpy(&info, si, sizeof(info));
 }
 
-/*
- * child_signal_handler() - to handle SIGUSR1
- *
- * XXX (garrcoop): add calls to cleanup_child() -- or should this be handled
- * from the libltp signal handler?
- */
-static void child_signal_handler(int sig, siginfo_t * si, void *unused)
+static void child_func(void)
 {
-	char buf[256];
-	struct mq_attr attr;
-
-	if (si->si_signo != SIGUSR1) {
-		printf("received signal = %d unexpectedly\n", si->si_signo);
-		return;
-	}
-
-	if (si->si_code != SI_MESGQ) {
-		printf("expected signal code SI_MESGQ; got %d instead\n",
-		       si->si_code);
-		return;
-	}
-
-	if (si->si_pid) {
-		printf("expected signal originator PID = 0; got %d instead\n",
-		       si->si_pid);
-		return;
-	} else {
-		printf("signal originator PID = 0\n");
-		result = TPASS;
-	}
-
-	/*
-	 * Now read the message - Be silent on errors since this is not the
-	 * test purpose.
-	 */
-	rc = mq_getattr(si->si_int, &attr);
-	if (rc != -1)
-		mq_receive(si->si_int, buf, attr.mq_msgsize, NULL);
-}
-
-/*
- * child_fn() - Inside container
- *
- * XXX (garrcoop): add more calls to cleanup_child()?
- */
-int child_fn(void *arg)
-{
-	pid_t pid, ppid;
+	pid_t cpid, ppid;
 	struct sigaction sa;
 	struct sigevent notif;
-	char buf[5];
+	mqd_t mqd_child;
 
-	/* Set process id and parent pid */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
 
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		printf("pidns was not created\n");
-		return 1;
-	}
-
-	/* Close the appropriate end of each pipe */
-	close(child_to_father[0]);
-	close(father_to_child[1]);
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
 
-	while (read(father_to_child[0], buf, 1) != 1)
-		sleep(1);
+	TST_CHECKPOINT_WAIT(0);
 
-	mqd = tst_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
-	if (mqd == -1) {
-		perror("mq_open failed");
-		return 1;
-	} else
-		printf("mq_open succeeded\n");
+	tst_res(TINFO, "Register notification on posix mqueue");
 
-	/* Register for notification on message arrival */
+	mqd_child = SAFE_MQ_OPEN(MQNAME, O_RDONLY, 0, NULL);
 	notif.sigev_notify = SIGEV_SIGNAL;
 	notif.sigev_signo = SIGUSR1;
-	notif.sigev_value.sival_int = mqd;
-	if (tst_syscall(__NR_mq_notify, mqd, &notif) == -1) {
-		perror("mq_notify failed");
-		return 1;
-	} else
-		printf("successfully registered for notification\n");
+	notif.sigev_value.sival_int = mqd_child;
+
+	SAFE_MQ_NOTIFY(mqd_child, &notif);
 
-	/* Define handler for SIGUSR1 */
 	sa.sa_flags = SA_SIGINFO;
-	sigemptyset(&sa.sa_mask);
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
 	sa.sa_sigaction = child_signal_handler;
-	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
-		perror("sigaction failed");
-		return 1;
-	} else
-		printf("successfully registered handler for SIGUSR1\n");
-
-	/* Ask parent to send a message to the mqueue */
-	if (write(child_to_father[1], "c:ok", 5) != 5) {
-		perror("write failed");
-		return 1;
-	}
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
 
-	sleep(3);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	/* Has parent sent a message? */
-	read(father_to_child[0], buf, 5);
-	if (strcmp(buf, "f:ok") != 0) {
-		printf("parent did not send the message!\n");
-		return 1;
-	}
-	printf("parent is done - cleaning up\n");
-
-	cleanup_child();
+	if (received)
+		tst_res(TPASS, "Signal notification has been received");
+	else
+		tst_res(TFAIL, "Signal notification has not been received");
 
-	exit(0);
+	TST_EXP_EQ_LI(info.si_signo, SIGUSR1);
+	TST_EXP_EQ_LI(info.si_code, SI_MESGQ);
+	TST_EXP_EQ_LI(info.si_pid, 0);
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	tst_require_root();
-	check_newpid();
+	remove_mqueue(mqd);
 }
 
-int main(void)
+static void run(void)
 {
-	int status;
-	char buf[5];
-	pid_t cpid;
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
-	setup();
+	remove_mqueue(mqd);
+	received = 0;
 
-	if (pipe(child_to_father) == -1 || pipe(father_to_child) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
 	}
 
-	tst_syscall(__NR_mq_unlink, mqname);
-
-	/* container creation on PID namespace */
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
-	if (cpid == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	mqd =
-	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
-		    NULL);
-	if (mqd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
-	else
-		tst_resm(TINFO, "successfully created posix mqueue");
-
-	if (write(father_to_child[1], buf, 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
+	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, 0);
 
-	/* Close the appropriate end of each pipe */
-	close(child_to_father[1]);
-	close(father_to_child[0]);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	/* Is container ready */
-	read(child_to_father[0], buf, 5);
-	if (strcmp(buf, "c:ok") != 0)
-		tst_brkm(TBROK, cleanup,
-			 "container did not respond as expected!");
-
-	rc = mq_send(mqd, MSG, strlen(MSG), MSG_PRIO);
-	if (rc == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mq_send failed");
-	else
-		tst_resm(TINFO, "mq_send succeeded");
+	tst_res(TINFO, "Send mqueue message");
 
-	/* Tell the child the message has been sent */
-	if (write(father_to_child[1], "f:ok", 5) != 5)
-		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
+	SAFE_MQ_SEND(mqd, "pippo", 5, 1);
 
-	/* Wait for child to finish */
-	if (wait(&status) == -1)
-		tst_resm(TBROK | TERRNO, "wait failed");
-
-	cleanup();
-
-	tst_exit();
+	TST_CHECKPOINT_WAKE(0);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
