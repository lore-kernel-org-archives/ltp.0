Return-Path: <SRS0=AfES=PH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE130C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 09:48:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E6561057
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 09:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7E6561057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81D703C3235
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 11:48:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24E0F3C009D
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 11:48:08 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB53F140115E
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 11:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634636886; i=@fujitsu.com;
 bh=dHpBearEBpgAuz8438Qcb63IT2AQzfrb+200u2ikTfw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=sYGfM+l7/Yibyy3EZzMnMJgd2MDVnT5WiOnYDamxKlo0YMPZaZFwYeiHWD8w6t6Z1
 4WAinE/HMIVLP5NgqN8BWwMZ62W8T0rLJ6MG8/s8+QYad+CiYNiFi0qGZDsqfos+0O
 srvDyT5jKDWgiff+G2o+9w5sHmoCcRSoc+INEfsKKKeGN/4DRTjVI2ihx2g29zTT7l
 +DBJ4tPbB//zbIeULcRU1D17GN8wtjEyb/4Mt9UB56+F524cq5ofhH9YR08keQ42Q/
 glx1lgeKCzu4JOMOLzRC00TxAq7MqfhmHtxtMXuMMEp9or8kpDIeyap9IgMNDoCGTB
 G3fU9lUEvwnsg==
Received: from [100.113.5.110] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id B1/68-01506-6549E616;
 Tue, 19 Oct 2021 09:48:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8ORqBs6JS/
 RYP8XLYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNaPtyRnGgm1zGCuOXpZuYNxf38XIxSEkcJZR
 4tOS22wQzk4mifub77FAOPsZJV7OngDkcHKwCWhIXHvczgxiiwhISHQ0vGUHsZkF1CR2Xz3GB
 mILC5hKnFj/EKyGRUBV4ubyO2A1vAKuEi9OLAOzJQQUJKY8fM8MEReUODnzCQvEHAmJgy9eME
 PUKErs37uREcKukJgxYxsbhK0mcfXcJuYJjPyzkLTPQtK+gJFpFaNlUlFmekZJbmJmjq6hgYG
 uoaGxrqmukYmhXmKVbpJeaqlucmpeSVEiUFYvsbxYr7gyNzknRS8vtWQTIzAoUwpZP+5gPPT6
 g94hRkkOJiVR3ouueYlCfEn5KZUZicUZ8UWlOanFhxhlODiUJHi9JwLlBItS01Mr0jJzgBECk
 5bg4FES4d09CSjNW1yQmFucmQ6ROsWoy/Hg6r1VzEIsefl5qVLivJyTgYoEQIoySvPgRsCi9R
 KjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd6XIJfwZOaVwG16BXQEE9ARV51zQI4oSURISTU
 wKSqdW5HzavKy/og8s9YbSocZTD7s3j+/682zcyyvrBgflaZ6haXsXrxkm8bc+8eOTrUvrZCz
 E/LNTP3gvZxldthDjRMVySVnHlqcNNLuXeD1ZMH06cxMDtv3TfhaOiG47GS27aTHNiHV2+0cP
 LcWiIk6nHj2KflXSKn4N3W2aQ8mMkUVdHsENP3/+eFo0pu/vuwl821fSW5fu3Trtg7Ng+tWLz
 6i7cCYNzs4c9LPhHXzP+fXvTVhedP45qPqB6eFE8qXya/hb35/afWqTPX8+Ydlpgp/ZpcMUN3
 Ssff4rpZ3nbe+3In+uSGiwPaIfaPA/bwfFetW9S7bkfY1M+SLyO4T5nv3C0hcYZXY+MxtSZAS
 S3FGoqEWc1FxIgA72D+/UQMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-10.tower-245.messagelabs.com!1634636885!99507!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9061 invoked from network); 19 Oct 2021 09:48:05 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-10.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Oct 2021 09:48:05 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 330BD100231
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 10:48:05 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 279EE100227
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 10:48:05 +0100 (BST)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 19 Oct 2021 10:48:01 +0100
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 19 Oct 2021 05:47:52 -0400
Message-ID: <1634636872-2892-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fcntl15: Convert to new API
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

1) use SAFE macro
2) use TST_CHECKPOINT_WAIT and TST_CHECKPOINT_WAKE instead of sleep
3) remove uclinux code

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl15.c | 554 +++++++++---------------------
 1 file changed, 166 insertions(+), 388 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl15.c b/testcases/kernel/syscalls/fcntl/fcntl15.c
index a49ead0..e33c733 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl15.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -1,145 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * Copyright (c) Linux Test Project, 2021
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
+ * MODIFIED: - mridge@us.ibm.com -- changed getpid to syscall(get thread ID)
+ * for unique ID on NPTL threading
  */
 
-/*
- * NAME
- *	fcntl15.c
- *
- * DESCRIPTION
- *	Check that file locks are removed when file closed
- *
- * ALGORITHM
- *	Use three testcases to check removal of locks when a file is closed.
- *
- *	Case 1: Parent opens a file and duplicates it, places locks using
- *	both file descriptors then closes one descriptor, all locks should
- *	be removed.
- *
- *	Case 2: Open same file twice using(open), place locks using both
- *	descriptors then close on descriptor, locks on the file should be
- *	lost
+/*\
+ * [Description]
  *
- *	Case 3: Open file twice, one by each process, set the locks and have
- *	a child check the locks. Remove the first file and have the child
- *	check the locks. Remove the first file and have child check locks
- *	again. Only locks set on first file should have been removed
+ * Check that file locks are removed when file closed.
  *
- * USAGE
- *	fcntl15
+ * 1. Parent opens a file and duplicates it, places locks using
+ * both file descriptors then closes one descriptor, all locks should
+ * be removed.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- * MODIFIED: - mridge@us.ibm.com -- changed getpid to syscall(get thread ID) for unique ID on NPTL threading
+ * 2. Open same file twice using(open), place locks using both
+ * descriptors then close one descriptor, locks on the file should be
+ * lost.
  *
- * RESTRICTIONS
- *	None
+ * 3. Open file twice, one by each process, set the locks and have
+ * a child check the locks. Remove the first file and have the child
+ * check the locks. Remove the first file and have child check locks
+ * again. Only locks set on first file should have been removed.
  */
 
 #include <signal.h>
 #include <fcntl.h>
-#include "test.h"
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/types.h>
 #include <sys/syscall.h>
-#include <linux/unistd.h>
-
-#define	DATA	"ABCDEFGHIJ"
-#define	DUP	0
-#define	OPEN	1
-#define	FORK_	2
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-char *TCID = "fcntl15";
-int TST_TOTAL = 1;
+#define DATA    "ABCDEFGHIJ"
+#define DUP     0
+#define OPEN    1
+#define FORK_   2
 
 static int parent, child1, child2, status;
 static volatile sig_atomic_t parent_flag, child_flag, alarm_flag;
-static char tmpname[40];
+static char tmpname[10] = "testfile";
 struct flock flock;
-
-#ifdef UCLINUX
-static char *argv0;		/* set by main, passed to self_exec */
-#endif
-
-
-void alarm_sig(int sig)
+static int fd[3];
+
+static struct tcase {
+	int dup_flag;
+	int test_num;
+	char *dup_flag_name;
+} tcases[] = {
+	{DUP, 1, "dup"},
+	{OPEN, 2, "open"},
+	{FORK_, 3, "fork"}
+};
+
+static int dochild1(int file_flag, int file_mode)
 {
-	signal(SIGALRM, alarm_sig);
-	alarm_flag = 1;
-	if ((syscall(__NR_gettid)) == parent) {
-		tst_resm(TINFO, "Alarm caught by parent");
-	} else {
-		tst_resm(TINFO, "Alarm caught by child");
-	}
-}
-
-void child_sig(int sig)
-{
-	signal(SIGUSR1, child_sig);
-	child_flag++;
-}
-
-void parent_sig(int sig)
-{
-	signal(SIGUSR2, parent_sig);
-	parent_flag++;
-}
-
-int dochild1(int file_flag, int file_mode)
-{
-	int fd_B;
 	sigset_t newmask, zeromask, oldmask;
 
-	if ((fd_B = open(tmpname, file_flag, file_mode)) < 0) {
-		perror("open on child1 file failed");
-		exit(1);
-	}
+	fd[1] = SAFE_OPEN(tmpname, file_flag, file_mode);
 
-	/* initialize lock structure for second 5 bytes of file */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 5L;
 	flock.l_len = 5L;
 
-	/* set lock on child file descriptor */
-	if ((fcntl(fd_B, F_SETLK, &flock)) < 0) {
-		perror("child lock failed should have succeeded");
-		exit(1);
-	}
+	SAFE_FCNTL(fd[1], F_SETLK, &flock);
 
-	sigemptyset(&zeromask);
-	sigemptyset(&newmask);
-	sigaddset(&newmask, SIGUSR1);
-	sigaddset(&newmask, SIGUSR2);
-	sigaddset(&newmask, SIGALRM);
-	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0) {
-		perror("child1 sigprocmask SIG_BLOCK fail");
-		exit(1);
-	}
-	/*
-	 * send signal to parent here to tell parent we have locked the
-	 * file, thus allowing parent to proceed
-	 */
-	if ((kill(parent, SIGUSR1)) < 0) {
-		perror("child1 signal to parent failed");
-		exit(1);
-	}
+	SAFE_SIGEMPTYSET(&zeromask);
+	SAFE_SIGEMPTYSET(&newmask);
+	SAFE_SIGADDSET(&newmask, SIGUSR1);
+	SAFE_SIGADDSET(&newmask, SIGUSR2);
+	SAFE_SIGADDSET(&newmask, SIGALRM);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &newmask, &oldmask);
+
+	SAFE_KILL(parent, SIGUSR1);
 
 	/*
 	 * set alarm to break pause if parent fails to signal then spin till
@@ -148,73 +86,34 @@ int dochild1(int file_flag, int file_mode)
 	alarm(60);
 	while (parent_flag == 0 && alarm_flag == 0)
 		sigsuspend(&zeromask);
-	alarm((unsigned)0);
+	alarm(0);
 	if (parent_flag != 1) {
-		perror("pause in child1 terminated without "
-		       "SIGUSR2 signal from parent");
+		tst_res(TFAIL, "pause in child1 terminated without SIGUSR2 signal from parent");
 		exit(1);
 	}
 	parent_flag = 0;
 	alarm_flag = 0;
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0) {
-		perror("child1 sigprocmask SIG_SETMASK fail");
-		exit(1);
-	}
+	SAFE_SIGPROCMASK(SIG_SETMASK, &oldmask, NULL);
 
-	/* wait for child2 to complete then cleanup */
-	sleep(10);
-	close(fd_B);
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_CLOSE(fd[1]);
 	exit(0);
 }
 
-#ifdef UCLINUX
-int uc_file_flag, uc_file_mode, uc_dup_flag;
-
-void dochild1_uc(void)
+static int dofork(int file_flag, int file_mode)
 {
-	dochild1(uc_file_flag, uc_file_mode);
-}
-
-void dochild2_uc(void)
-{
-	dochild2(uc_file_flag, uc_dup_flag);
-}
-#endif
+	child1 = SAFE_FORK();
 
-int dofork(int file_flag, int file_mode)
-{
-	/* create child process */
-	if ((child1 = FORK_OR_VFORK()) < 0) {
-		perror("Fork failure");
-		return 1;
-	}
-
-	/* child1 */
 	if (child1 == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv0, "nddds", 1, file_flag, file_mode,
-			      parent, tmpname) < 0) {
-			perror("self_exec failure");
-			return 1;
-		}
-#else
 		dochild1(file_flag, file_mode);
-#endif
 	} else {
-		/*
-		 * need to wait for child1 to open, and lock the area of the
-		 * file prior to continuing on from here
-		 */
 		sigset_t newmask, zeromask, oldmask;
-		sigemptyset(&zeromask);
-		sigemptyset(&newmask);
-		sigaddset(&newmask, SIGUSR1);
-		sigaddset(&newmask, SIGUSR2);
-		sigaddset(&newmask, SIGALRM);
-		if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0) {
-			perror("parent sigprocmask SIG_BLOCK fail");
-			exit(1);
-		}
+		SAFE_SIGEMPTYSET(&zeromask);
+		SAFE_SIGEMPTYSET(&newmask);
+		SAFE_SIGADDSET(&newmask, SIGUSR1);
+		SAFE_SIGADDSET(&newmask, SIGUSR2);
+		SAFE_SIGADDSET(&newmask, SIGALRM);
+		SAFE_SIGPROCMASK(SIG_BLOCK, &newmask, &oldmask);
 
 		/*
 		 * set alarm to break pause if parent fails to signal then spin till
@@ -223,74 +122,51 @@ int dofork(int file_flag, int file_mode)
 		alarm(60);
 		while (child_flag == 0 && alarm_flag == 0)
 			sigsuspend(&zeromask);
-		alarm((unsigned)0);
+		alarm(0);
 		if (child_flag != 1) {
-			perror("parent paused without SIGUSR1 " "from child");
+			tst_res(TFAIL, "parent paused without SIGUSR1 from child");
 			exit(1);
 		}
 		child_flag = 0;
 		alarm_flag = 0;
-		if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0) {
-			perror("parent sigprocmask SIG_SETMASK fail");
-			exit(1);
-		}
+		SAFE_SIGPROCMASK(SIG_SETMASK, &oldmask, NULL);
 	}
 	return 0;
 }
 
-int dochild2(int file_flag, int file_mode, int dup_flag)
+static int dochild2(int file_flag, int file_mode, int dup_flag)
 {
-	int fd_C;
 	sigset_t newmask, zeromask, oldmask;
 
-	if ((fd_C = open(tmpname, file_flag, file_mode)) < 0) {
-		perror("open on child2 file failed");
-		exit(1);
-	}
+	fd[2] = SAFE_OPEN(tmpname, file_flag, file_mode);
 
-	/* initialize lock structure for first 5 bytes of file */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 0L;
 	flock.l_len = 5L;
 
-	/* Set lock on child file descriptor */
-	if ((fcntl(fd_C, F_SETLK, &flock)) >= 0) {
-		tst_resm(TFAIL, "First child2 lock succeeded should "
-			 "have failed");
+	if ((fcntl(fd[2], F_SETLK, &flock)) >= 0) {
+		tst_res(TFAIL, "First child2 lock succeeded should have failed");
 		exit(1);
 	}
 
-	/* initialize lock structure for second 5 bytes of file */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 5L;
 	flock.l_len = 5L;
 
-	/* set lock on child file descriptor */
-	if ((fcntl(fd_C, F_SETLK, &flock)) >= 0) {
-		tst_resm(TFAIL, "second child2 lock succeeded should have "
-			 "failed");
+	if ((fcntl(fd[2], F_SETLK, &flock)) >= 0) {
+		tst_res(TFAIL, "second child2 lock succeeded should have failed");
 		exit(1);
 	}
+	SAFE_SIGEMPTYSET(&zeromask);
+	SAFE_SIGEMPTYSET(&newmask);
+	SAFE_SIGADDSET(&newmask, SIGUSR1);
+	SAFE_SIGADDSET(&newmask, SIGUSR2);
+	SAFE_SIGADDSET(&newmask, SIGALRM);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &newmask, &oldmask);
 
-	sigemptyset(&zeromask);
-	sigemptyset(&newmask);
-	sigaddset(&newmask, SIGUSR1);
-	sigaddset(&newmask, SIGUSR2);
-	sigaddset(&newmask, SIGALRM);
-	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0) {
-		perror("child2 sigprocmask SIG_BLOCK fail");
-		exit(1);
-	}
-	/*
-	 * send signal to parent here to tell parent we have locked the
-	 * file, thus allowing parent to proceed
-	 */
-	if ((kill(parent, SIGUSR1)) < 0) {
-		perror("child2 signal to parent failed");
-		exit(1);
-	}
+	SAFE_KILL(parent, SIGUSR1);
 
 	/*
 	 * set alarm to break pause if parent fails to signal then spin till
@@ -299,178 +175,81 @@ int dochild2(int file_flag, int file_mode, int dup_flag)
 	alarm(60);
 	while (parent_flag == 0 && alarm_flag == 0)
 		sigsuspend(&zeromask);
-	alarm((unsigned)0);
+	alarm(0);
 	if (parent_flag != 1) {
-		perror("pause in child2 terminated without "
-		       "SIGUSR2 signal from parent");
+		tst_res(TFAIL, "pause in child2 terminated without SIGUSR2 signal from parent");
 		exit(1);
 	}
 	parent_flag = 0;
 	alarm_flag = 0;
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0) {
-		perror("child2 sigprocmask SIG_SETMASK fail");
-		exit(1);
-	}
+	SAFE_SIGPROCMASK(SIG_SETMASK, &oldmask, NULL);
 
-	/* initialize lock structure for first 5 bytes of file */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 0L;
 	flock.l_len = 5L;
 
-	/* set lock on child file descriptor */
-	if ((fcntl(fd_C, F_SETLK, &flock)) < 0) {
-		tst_resm(TFAIL, "third child2 lock failed should have "
-			 "succeeded");
-		exit(1);
-	}
+	SAFE_FCNTL(fd[2], F_SETLK, &flock);
 
-	/* Initialize lock structure for second 5 bytes of file */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 5L;
 	flock.l_len = 5L;
 
-	/* set lock on child file descriptor */
 	if (dup_flag == FORK_) {
-		if ((fcntl(fd_C, F_SETLK, &flock)) >= 0) {
-			tst_resm(TFAIL, "fourth child2 lock succeeded "
-				 "should have failed");
+		if ((fcntl(fd[2], F_SETLK, &flock)) >= 0) {
+			tst_res(TFAIL, "fourth child2 lock succeeded should have failed");
 			exit(1);
 		}
-	} else {
-		if ((fcntl(fd_C, F_SETLK, &flock)) < 0) {
-			tst_resm(TFAIL, "fourth child2 lock failed "
-				 "should have succeeded");
-			exit(1);
-		}
-	}
-	close(fd_C);
-	exit(0);
-}
+	} else
+		SAFE_FCNTL(fd[2], F_SETLK, &flock);
 
-void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
+	SAFE_CLOSE(fd[2]);
+	TST_CHECKPOINT_WAIT(0);
+	exit(0);
 }
 
-int run_test(int file_flag, int file_mode, int dup_flag)
+static int run_test(int file_flag, int file_mode, int dup_flag)
 {
-	int fd_A, fd_B;
-	fd_B = -1;
 	sigset_t newmask, zeromask, oldmask;
 
-	/* setup to catch SIGUSR1 signal from child process */
-	if ((signal(SIGUSR1, child_sig)) == SIG_ERR) {
-		perror("Signal setup for SIGUSR1 failed");
-	}
-
-	/* setup to catch SIGUSR2 signal from parent */
-	if ((signal(SIGUSR2, parent_sig)) == SIG_ERR) {
-		perror("Signal setup for SIGUSR1 failed");
-	}
-
-	parent = syscall(__NR_gettid);
-
-	tst_tmpdir();
-	/* setup temporary file name */
-	sprintf(tmpname, "fcntl15.%d", parent);
-
-	/* initialize signal flags */
-	child_flag = parent_flag = alarm_flag = 0;
-
-	if ((fd_A = open(tmpname, file_flag, file_mode)) < 0) {
-		perror("open first parent file failed");
-		tst_rmdir();
-		return 1;
-	}
-
-	/* write some data to the file */
-	(void)write(fd_A, DATA, 10);
+	fd[0] = SAFE_OPEN(tmpname, file_flag, file_mode);
+	SAFE_WRITE(1, fd[0], DATA, 10);
 
 	if (dup_flag) {
 		if (dup_flag == FORK_) {
 			dofork(file_flag, file_mode);
-		} else {
-			if ((fd_B = open(tmpname, file_flag, file_mode)) < 0) {
-				perror("open second parent file failed");
-				tst_rmdir();
-				return 1;
-			}
-		}
-	} else {
-		/* create a second file descriptor from first file */
-		if ((fd_B = fcntl(fd_A, F_DUPFD, 0)) < 0) {
-			perror("dup of second parent file failed");
-			tst_rmdir();
-			return 1;
-		}
-	}
+		} else
+			fd[1] = SAFE_OPEN(tmpname, file_flag, file_mode);
+	} else
+		fd[1] = SAFE_FCNTL(fd[0], F_DUPFD, 0);
 
-	/*
-	 * initialize lock structure for first lock on first
-	 * 5 bytes of file
-	 */
 	flock.l_type = F_WRLCK;
 	flock.l_whence = 0;
 	flock.l_start = 0L;
 	flock.l_len = 5L;
 
-	/* set lock on first file descriptor */
-	if ((fcntl(fd_A, F_SETLK, &flock)) < 0) {
-		perror("Attempt to set first parent lock failed");
-		tst_rmdir();
-		return 1;
-	}
+	SAFE_FCNTL(fd[0], F_SETLK, &flock);
 
 	if (dup_flag != FORK_) {
-		/* initialize lock structure for last 5 bytes of file */
 		flock.l_type = F_WRLCK;
 		flock.l_whence = 0;
 		flock.l_start = 5L;
 		flock.l_len = 5L;
 
-		/* set lock on second file descriptor */
-		if ((fcntl(fd_B, F_SETLK, &flock)) < 0) {
-			perror("Attempt to set second parent lock failed");
-			tst_rmdir();
-			return 1;
-		}
+		SAFE_FCNTL(fd[1], F_SETLK, &flock);
 	}
 
-	/* create child process */
-	if ((child2 = FORK_OR_VFORK()) < 0) {
-		perror("Fork failure");
-		tst_rmdir();
-		return 1;
-	} else if (child2 == 0) {	/* child */
-#ifdef UCLINUX
-		if (self_exec(argv0, "ndddds", 2, file_flag, file_mode,
-			      dup_flag, parent, tmpname) < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "self_exec failed");
-#else
+	child2 = SAFE_FORK();
+	if (child2 == 0)
 		dochild2(file_flag, file_mode, dup_flag);
-#endif
-	}
-
-	/* parent */
 
-	/*
-	 * Set alarm to break pause if child fails to signal then spin till
-	 * child is ready
-	 */
-
-	sigemptyset(&zeromask);
-	sigemptyset(&newmask);
-	sigaddset(&newmask, SIGUSR1);
-	sigaddset(&newmask, SIGUSR2);
-	sigaddset(&newmask, SIGALRM);
-	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0) {
-		perror("parent sigprocmask SIG_BLOCK fail");
-		exit(1);
-	}
+	SAFE_SIGEMPTYSET(&zeromask);
+	SAFE_SIGEMPTYSET(&newmask);
+	SAFE_SIGADDSET(&newmask, SIGUSR1);
+	SAFE_SIGADDSET(&newmask, SIGUSR2);
+	SAFE_SIGADDSET(&newmask, SIGALRM);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &newmask, &oldmask);
 
 	/*
 	 * set alarm to break pause if parent fails to signal then spin till
@@ -479,86 +258,85 @@ int run_test(int file_flag, int file_mode, int dup_flag)
 	alarm(60);
 	while (child_flag == 0 && alarm_flag == 0)
 		sigsuspend(&zeromask);
-	alarm((unsigned)0);
-	if (child_flag != 1) {
-		perror("parent paused without SIGUSR1 " "from child");
-		exit(1);
-	}
+	alarm(0);
 	child_flag = 0;
 	alarm_flag = 0;
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0) {
-		perror("parent sigprocmask SIG_SETMASK fail");
-		exit(1);
-	}
+	SAFE_SIGPROCMASK(SIG_SETMASK, &oldmask, NULL);
 
-	/* close the first file then signal child to test locks */
-	close(fd_A);
-	if ((kill(child2, SIGUSR2)) < 0) {
-		perror("Signal to child2 failed");
-		tst_rmdir();
-		return 1;
-	}
+	SAFE_CLOSE(fd[0]);
+	SAFE_KILL(child2, SIGUSR2);
+
+	if (dup_flag != FORK_) {
+		TST_CHECKPOINT_WAKE(0);
+	} else
+		SAFE_KILL(child1, SIGUSR2);
 
-	if (dup_flag == FORK_) {
-		if ((kill(child1, SIGUSR2)) < 0) {
-			perror("Signal to child1 failed");
-			tst_rmdir();
-			return 1;
-		}
-	}
-	/* wait for child to complete then cleanup */
 	while ((wait(&status)) > 0) {
 		if (status >> 8 != 0) {
-			tst_resm(TFAIL, "Expected 0 got %d", status >> 8);
-			tst_rmdir();
+			tst_res(TFAIL, "Expected 0 got %d", status >> 8);
 			return 1;
 		}
 	}
 	if (dup_flag != FORK_) {
-		close(fd_B);
+		SAFE_CLOSE(fd[1]);
 	}
-	unlink(tmpname);
-	tst_rmdir();
+	SAFE_UNLINK(tmpname);
 	return 0;
 }
 
-int main(int ac, char **av)
+static void verify_fcntl(unsigned int n)
 {
-	int lc;
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&dochild1_uc, "nddds", 1, &uc_file_flag,
-			&uc_file_mode, &parent, tmpname);
-	maybe_run_child(&dochild2_uc, "nddds", 1, &uc_file_flag,
-			&uc_file_mode, &uc_dup_flag, &parent, tmpname);
-	argv0 = av[0];
-#endif
+	if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, tc->dup_flag))
+		tst_res(TFAIL, "Test %d: test with \"%s\" FAILED", tc->test_num, tc->dup_flag_name);
+	else
+		tst_res(TPASS, "Test %d: test with \"%s\" PASSED", tc->test_num, tc->dup_flag_name);
+}
 
-	setup();
+static void alarm_sig(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	alarm_flag = 1;
+	if (tst_syscall(__NR_gettid) == parent)
+		tst_res(TINFO, "Alarm caught by parent");
+	else
+		tst_res(TINFO, "Alarm caught by child");
+}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+static void child_sig(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	child_flag++;
+}
 
-		if ((signal(SIGALRM, alarm_sig)) == SIG_ERR) {
-			perror("SIGALRM signal set up failed");
-			exit(1);
-		}
+static void parent_sig(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	parent_flag++;
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGALRM, alarm_sig);
+	SAFE_SIGNAL(SIGUSR1, child_sig);
+	SAFE_SIGNAL(SIGUSR2, parent_sig);
 
-		if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, DUP))
-			tst_resm(TFAIL, "Test 1: test with \"dup\" FAILED");
-		else
-			tst_resm(TPASS, "Test 1: test with \"dup\" PASSED");
+	parent = tst_syscall(__NR_gettid);
+}
 
-		if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, OPEN))
-			tst_resm(TFAIL, "Test 2: test with \"open\" FAILED");
-		else
-			tst_resm(TPASS, "Test 2: test with \"open\" PASSED");
+static void cleanup(void)
+{
+	int i;
 
-		if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, FORK_))
-			tst_resm(TFAIL, "Test 3: test with \"fork\" FAILED");
-		else
-			tst_resm(TPASS, "Test 3: test with \"fork\" PASSED");
+	for (i = 0; i < 3; i++) {
+		if (fd[i] > 0)
+			SAFE_CLOSE(fd[i]);
 	}
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = verify_fcntl,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
