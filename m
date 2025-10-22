Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B4CCD1A5
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 01:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94643CF09D
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 03:45:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7A6D3CEE33
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 03:45:41 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20BEA600800
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 03:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1761097531;
 bh=4bBYNikTkjV4KFmuEQj3gmNx4oo+EF+3TNaawefPp/M=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=TaTRFAvekXTAlVSdCz5IEZYK+Jc+Rfl3gCKY0gDPMRci9NK9IHaRdA1BmH5s6SKfH
 jz0Qk98dc2aFrSVPL7oZ/OdnIHAxzSwRFEJTB/H5EiptGckgxlig1kXcJb56w94zdM
 O3yWVdtOPFZaRRsSb2LK8W4bmMs5K6uLmsPGKANU=
X-QQ-mid: zesmtpsz7t1761097525t31d85f88
X-QQ-Originating-IP: Uz6sEGL1vH9/TWoC288rwEZ9CeknzJqIgqqB8uDGcLM=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 22 Oct 2025 09:45:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3738287270365878050
EX-QQ-RecipientCnt: 2
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 22 Oct 2025 09:45:18 +0800
Message-Id: <20251022014518.14549-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NpfbsqbTlzxU9hg0/JMd1APYwO+QhcgZux6EtTigWSQ0Lgoci0oTJoXk
 TkO8dUlV3SSzOFNeXa6t+5vTSY2KUss40D73a2AfhZBtbTDjgNrppine3oidmVIMBIzaCKI
 cz0OknN5auZpbXJa8g01pVxu7WHMx5C5MCaTLNOHAH8tRiCsPPntbpRO7HaXFRwAomSSwB4
 Zb/ciHxehQy9sNgL85Hcz30TJ33z6sp8inUTdbgKohEQWEXguy0wvQ/y/NPeSfrfrMPFShN
 nsx5xoGZZEePJviES37h7iNCDZer3YoOussvHrXEe6wdQlokjmmZjtXIqNsCbdqmpQrk3vB
 6OGpCGjWIMiVKe6pbBtHNaXvCQ/gMaVoOru/KD8Fhw/i46alFTm+xBN6dSo0FV3s+2xS722
 Ja9taEbX5N/61RtVk0qYuOsXxl6YQezAjODhAqsDqu71wAVffMuH/iv9VNtwicgrj1JMQ14
 arVqFcOhsxkqXpK3elqEbMSeSeef+/lIyjHRF2XHtDHP4nGW3egc7y8g6hxPWNLMgRSGe2J
 HkyDX9s8Rao7zvBzw0AEwRZYybFfhNSf+VXnFPhJk8DbXkT0yEY2bRvxl6RyrrbXNP+p2NB
 l0COIb5J6xqSLW4p4qQKTnw4WcClWbCOu3bNat5slt5wrJWiewGaMh77pLDTYLFJWabjutr
 f2geRt09UKBqfPPgtzthf9xAukRP0fLwGuRVN6Yx1OjKPlv1fBjD1TAC/oikmQDviugvY9B
 0DlWYrIND+JOQjhKE6U8ehkcHSeFxQ02HoiehNpwhCszl4HVS+jew8P4J+RmyMx/MoPu+sH
 PrmpDrMIm+rT96uIpNEihi7w0CCyABfAyRD/G4xnFrD7uQkcAORPGXPxU/PMO6AzIpw0bYE
 2kvnf36/hQW/hMepA7gXUoM+aQci5d9+nk3qECnEwhMYwf8/WgZ8zbppyoA8OToDhRfij1W
 C9rsGGWX75fgXUK/+QwsVUvFvDJj5mZqvzYLqcegteqyOu4VS6BMX7TPviWk9sApdv2U=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite sigrelse01.c with new APIs
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update sigrelse01.c with new APIs (using tst_test.h), fix the make
check errors and warnings, keep the test steps/phases as possible.

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/sigrelse/sigrelse.h |  78 ++
 .../kernel/syscalls/sigrelse/sigrelse01.c     | 824 +++---------------
 2 files changed, 210 insertions(+), 692 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sigrelse/sigrelse.h

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse.h b/testcases/kernel/syscalls/sigrelse/sigrelse.h
new file mode 100644
index 000000000..a3ba6a773
--- /dev/null
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2025 lufei <lufei@uniontech.com>
+ */
+
+
+
+/* Needed for NPTL */
+#define SIGCANCEL 32
+#define SIGTIMER 33
+
+/* child exit values */
+#define EXIT_OK    0
+#define SIG_CAUGHT 8
+#define HANDLE_ERR 32
+
+/* ensure that NUMSIGS is defined. */
+#ifndef NUMSIGS
+#define NUMSIGS NSIG
+#endif
+
+
+#ifdef __linux__
+/* glibc2.2 definition needs -D_XOPEN_SOURCE, which breaks other things. */
+extern int sighold(int __sig);
+extern int sigrelse(int __sig);
+#endif
+
+static int choose_sig(int sig)
+{
+	switch (sig) {
+	case SIGKILL:
+	case SIGSTOP:
+	case SIGTSTP:
+	case SIGCONT:
+	case SIGALRM:
+	case SIGUSR1:
+	case SIGTERM:
+	case SIGINT:
+	case SIGCANCEL:
+	case SIGTIMER:
+#ifdef SIGNOBDM
+	case SIGNOBDM:
+#endif
+#ifdef SIGTTIN
+	case SIGTTIN:
+#endif
+#ifdef SIGTTOU
+	case SIGTTOU:
+#endif
+#ifdef SIGPTINTR
+	case SIGPTINTR:
+#endif
+#ifdef SIGSWAP
+	case SIGSWAP:
+#endif
+		return 0;
+	}
+
+	if (sig < 32)
+		return 1;
+
+	return sig >= SIGRTMIN && sig <= SIGRTMAX;
+}
+
+static char *read_pipe(int fd)
+{
+	static char buf[4096];	/* buffer for pipe read */
+	int ret;
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret <= 0)
+		return NULL;
+
+	return buf;
+}
+
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 23c675826..d9029ceec 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -1,784 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * Copyright (c) 2025 lufei <lufei@uniontech.com>
  */
-/* $Id: sigrelse01.c,v 1.14 2009/08/28 14:10:16 vapier Exp $ */
-/*****************************************************************************
- * OS Test - Silicon Graphics, Inc.  Eagan, Minnesota
- *
- * TEST IDENTIFIER : sigrelse01 Releasing held signals.
- *
- * PARENT DOCUMENT : sgrtds01  sigrelse system call
- *
- * AUTHOR          : Bob Clark
- *		   : Rewrote 12/92 by Richard Logan
- *
- * CO-PILOT        : Dave Baumgartner
- *
- * DATE STARTED    : 10/08/86
- *
- * TEST ITEMS
- *
- * 	1. sigrelse turns on the receipt of signals held by sighold.
- *
- * SPECIAL PROCEDURAL REQUIRMENTS
- * 	None
- *
- * DETAILED DESCRIPTION
- * 	set up pipe for parent/child communications
- * 	fork off a child process
- *
- * 	parent():
- * 		set up for unexpected signals
- * 		wait for child to send ready message over pipe
- * 		send all catchable signals to child process
- *		send alarm signal to speed up timeout
- * 		wait for child to terminate and check exit value
- *
- * 		if exit value is EXIT_OK
- * 		  get message from pipe (contains array of signal counters)
- * 		  loop through array of signal counters and record any
- * 			signals which were not caught once.
- * 		  record PASS or FAIL depending on what was found in the array.
- *
- * 		else if exit is SIG_CAUGHT then BROK (signal caught
- *		  before released)
- * 		else if exit is WRITE_BROK then BROK (write() to pipe failed)
- * 		else if exit is HANDLE_ERR then BROK (error in child's
- *		  signal handler)
- * 		else unexpected exit value - BROK
- *
- * 	child():
- * 	  phase 1:
- * 		set up to catch all catchable signals (exit SIG_CAUGHT
- *		  if caught)
- * 		hold each signal with sighold()
- * 		send parent ready message if setup went ok.
- * 		wait for signals to arrive - timeout if they don't
- *
- * 	  phase 2:
- * 		release each signal and wait a second for the handler to
- *		  catch it.
- * 		(the handler will record each signal it catches in an array
- * 		and exit HANDLE_ERR if an error occurs)
+
+/*\
+ * [Description]
  *
- * 		send array of counters back to parent for processing.
- * 		exit EXIT_OK
- * NOTES
- *	since child is executing system calls under test, no
- *	system call times are printed.
+ * Test sigrelse() system call - releasing held signals.
  *
-***************************************************************************/
-
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-#ifdef __linux__
-/* glibc2.2 definition needs -D_XOPEN_SOURCE, which breaks other things. */
-extern int sighold(int __sig);
-extern int sigrelse(int __sig);
-#endif
-
-/* Needed for NPTL */
-#define SIGCANCEL 32
-#define SIGTIMER 33
-
-void setup(void);
-void cleanup(void);
-static void parent(void);
-static void child(void);
-static void timeout(int sig);
-static int setup_sigs(void);
-static void handler(int sig);
-static void wait_a_while(void);
-static char *read_pipe(int fd);
-static int write_pipe(int fd, char *msg);
-static int set_timeout(void);
-static void clear_timeout(void);
-static void getout(void);
-int choose_sig(int sig);
-
-#define TRUE  1
-#define FALSE 0
-
-#ifndef DEBUG
-#define DEBUG 0
-#endif
-
-#define CHILD_EXIT(VAL) ((VAL >> 8) & 0377)	/* exit value of child process */
-#define CHILD_SIG(VAL)   (VAL & 0377)	/* signal value of child proc */
-
-#define MAXMESG 512		/* the size of the message string */
-
-#define READY "ready"		/* signal to parent that child is set up */
-
-#define TIMEOUT 30		/* time (sec) used in the alarm calls */
-
-/* child exit values */
-#define EXIT_OK    0
-#define SIG_CAUGHT 8
-#define WRITE_BROK 16
-#define HANDLE_ERR 32
-
-int TST_TOTAL = 1;		/* number of test items */
+ * This test verifies that sigrelse() turns on the receipt of signals held by sighold().
+ * The test uses a parent-child process model where:
+ * - Child holds all catchable signals using sighold()
+ * - Parent sends signals to child (which should be held)
+ * - Child releases signals using sigrelse() one by one
+ * - Child catches the released signals and reports results to parent
+ * - Parent verifies that each signal was caught exactly once
+ */
 
-char *TCID = "sigrelse01";	/* test case identifier */
-static char mesg[MAXMESG];	/* message buffer for tst_res */
-static int pid;			/* process id of child */
-static int pipe_fd[2];		/* file descriptors for pipe parent read */
-static int pipe_fd2[2];		/* file descriptors for pipe child read */
-static int phase;		/* flag for phase1 or phase2 of */
-				/* signal handler */
-static int sig_caught;		/* flag TRUE if signal caught */
-				/* (see wait_a_while ()) */
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+#include "sigrelse.h"
 
-/* ensure that NUMSIGS is defined. */
-#ifndef NUMSIGS
-#define NUMSIGS NSIG
-#endif
+static int pipe_fd[2];         /* file descriptors for pipe parent read */
+static int phase;              /* flag for phase1 or phase2 of signal handler */
+static int sig_caught;         /* flag TRUE if signal caught */
 
 /* array of counters for signals caught by handler() */
 static int sig_array[NUMSIGS];
 
-/***********************************************************************
- *   M A I N
- ***********************************************************************/
-int main(int argc, char **argv)
-{
-	int lc;
-
-	/* gcc -Wall complains about sig_caught not being ref'd because of the
-	   external declarations. */
-	sig_caught = FALSE;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(argc, argv, NULL, NULL);
+static void child(void);
+static int setup_sigs(void);
+static void handler(int sig);
+static void wait_a_while(void);
+static int choose_sig(int sig);
+static char *read_pipe(int fd);
 
-	/*
-	 * perform global setup for test
-	 */
-	setup();
+static void run(void)
+{
+	pid_t pid;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	/* fork off a child process */
+	pid = SAFE_FORK();
+	if (pid > 0) {
+		/* Parent process */
+		int sig;
+		int term_stat;
+		int rv;
 
-		tst_count = 0;
+		/* wait for child to be ready */
+		TST_CHECKPOINT_WAIT(0);
 
-		/*
-		 * fork off a child process
-		 */
-		if ((pid = tst_fork()) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		else if (pid > 0)
-			parent();
-		else
-			child();
+		/* send signals to child and see if it holds them */
+		for (sig = 1; sig < NUMSIGS; sig++) {
+			if (choose_sig(sig))
+				SAFE_KILL(pid, sig);
+		}
 
-	}
+		/* tell child to start releasing signals */
+		TST_CHECKPOINT_WAKE(0);
 
-	cleanup();
-	tst_exit();
+		/* child is now releasing signals, wait and check exit value */
+		SAFE_WAIT(&term_stat);
 
-}				/* end main */
+		/* check child's signal exit value */
+		if (WIFSIGNALED(term_stat))
+			tst_brk(TBROK, "Unexpected signal %d killed child", WTERMSIG(term_stat));
 
-/****************************************************************************
- * parent() : wait for "ready" from child, send signals to child, wait for
- *    child to exit and report what happened.
- ***************************************************************************/
-static void parent(void)
-{
-	int term_stat;		/* child return status */
-	int rv;			/* function return value */
-	int sig;		/* current signal number */
-	char *str;		/* string returned from read_pipe() */
-	int *array;		/* pointer to sig_array returned from child */
-	int fail = FALSE;	/* flag indicating test item failure */
-	char big_mesg[MAXMESG * 6];	/* storage for big failure message */
-	int caught_sigs;
-
-	/* wait for "ready" message from child */
-	if ((str = read_pipe(pipe_fd[0])) == NULL) {
-		/* read_pipe() failed. */
-		tst_brkm(TBROK, getout, "%s", mesg);
-	}
+		/* get child exit value */
+		rv = WEXITSTATUS(term_stat);
 
-	if (strcmp(str, READY) != 0) {
-		/* child setup did not go well */
-		tst_brkm(TBROK, getout, "%s", str);
-	}
+		switch (rv) {
+		case EXIT_OK: {
+			/* Read results from pipe */
+			int *array = (int *)read_pipe(pipe_fd[0]);
 
-	/*
-	 * send signals to child and see if it holds them
-	 */
+			if (!array) {
+				tst_brk(TBROK, "Could not read results from pipe");
+				break;
+			}
 
-	for (sig = 1; sig < NUMSIGS; sig++) {
-		if (choose_sig(sig)) {
-			if (kill(pid, sig) < 0) {
-				if (errno == ESRCH) {
-					if (kill(pid, SIGTERM) < 0)
-						tst_brkm(TBROK | TERRNO, getout,
-							 "kill(%d, %d) and kill(%d, SIGTERM) failed",
-							 pid, sig, pid);
+			for (sig = 1; sig < NUMSIGS; sig++) {
+				if (choose_sig(sig)) {
+					if (array[sig] != 1)
+						tst_res(TFAIL, "signal %d caught %d times (expected 1).", sig, array[sig]);
 					else
-						tst_brkm(TBROK | TERRNO, getout,
-							 "kill(%d, %d) failed, but kill(%d, SIGTERM) worked",
-							 pid, sig, pid);
-				} else
-					tst_brkm(TBROK | TERRNO, getout,
-						 "kill(%d, %d) failed", pid,
-						 sig);
+						tst_res(TPASS, "signal %d caught once as expected.", sig);
+				}
 			}
-		}
-	}
-
-	if (write_pipe(pipe_fd2[1], READY) < 0) {
-		tst_brkm(TBROK | TERRNO, getout,
-			 "Unable to tell child to go, write to pipe failed");
-	}
-
-	/*
-	 * child is now releasing signals, wait and check exit value
-	 */
-	SAFE_WAIT(getout, &term_stat);
-
-	/* check child's signal exit value */
-	if ((sig = CHILD_SIG(term_stat)) != 0)
-		/* the child was zapped by a signal */
-		tst_brkm(TBROK, cleanup, "Unexpected signal %d killed child",
-			 sig);
-
-	/* get child exit value */
-
-	rv = CHILD_EXIT(term_stat);
+			break;
 
-	switch (rv) {
-	case EXIT_OK:
-		/* sig_array sent back on pipe, check it out */
-		if ((array = (int *)read_pipe(pipe_fd[0])) == NULL) {
-			/* read_pipe() failed. */
-			tst_resm(TBROK, "%s", mesg);
+		case SIG_CAUGHT:
+			tst_brk(TBROK, "A signal was caught before being released.");
 			break;
-		}
-#if DEBUG > 1
-		for (sig = 1; sig < NUMSIGS; sig++) {
-			printf("array[%d] = %d\n", sig, array[sig]);
-		}
-#endif
-		caught_sigs = 0;
-		for (sig = 1; sig < NUMSIGS; sig++) {
-			if (choose_sig(sig)) {
-				if (array[sig] != 1) {
-					/* sig was not caught or caught too many times */
-					(void)sprintf(mesg,
-						      "\tsignal %d caught %d times (expected 1).\n",
-						      sig, array[sig]);
-					(void)strcat(big_mesg, mesg);
-					fail = TRUE;
-				} else {
-					caught_sigs++;
-				}
-			}
-		}		/* endfor */
-
-		if (fail == TRUE)
-			tst_resm(TFAIL, "%s", big_mesg);
-		else
-			tst_resm(TPASS,
-				 "sigrelse() released all %d signals under test.",
-				 caught_sigs);
-		break;
-
-	case TBROK:
-		/* get BROK message from pipe */
-		if ((str = read_pipe(pipe_fd[0])) == NULL) {
-			/* read_pipe() failed. */
-			tst_resm(TBROK, "%s", mesg);
+		case HANDLE_ERR:
+			tst_brk(TBROK, "Error occurred in signal handler.");
+			break;
+		default:
+			tst_brk(TBROK, "Unexpected exit code %d from child", rv);
 			break;
 		}
+		}
+	} else
+		child();
+}
 
-		/* call tst_res: str contains the message */
-		tst_resm(TBROK, "%s", str);
-		break;
-	case SIG_CAUGHT:
-		/* a signal was caught before it was released */
-		tst_resm(TBROK, "A signal was caught before being released.");
-		break;
-	case WRITE_BROK:
-		/* the write() call failed in child's write_pipe */
-		tst_resm(TBROK, "write() pipe failed for child.");
-		break;
-	case HANDLE_ERR:
-		/* more than one signal tried to be handled at the same time */
-		tst_resm(TBROK, "Error occured in signal handler.");
-		break;
-	default:
-		tst_resm(TBROK, "Unexpected exit code %d from child", rv);
-		break;
-	}
-
-}				/* end of parent */
-
-/****************************************************************************
- * child() : hold signals, notify parent and wait for parent to send signals.
- *   If none were caught (sighold worked), release the signals one at a time
- *   and wait for them to be caught.  Send results back to parent
- *   for processing.
- ***************************************************************************/
 static void child(void)
 {
-	int rv;			/* return value from sighold() and sigrelse() */
-	int sig;		/* signal value */
-	int exit_val;		/* exit value to send to parent */
-	char note[MAXMESG];	/* message buffer for pipe */
-	char *str;
-
-	phase = 1;		/* tell handler that we do not want to catch signals */
-
-	/* set note to READY and if an error occurs, overwrite it */
-	(void)strcpy(note, READY);
-
-	/* set alarm in case something hangs */
-	if (set_timeout() < 0) {
-		/* an error occured - put mesg in note and send it back to parent */
-		(void)strcpy(note, mesg);
+	int sig;                /* signal value */
+	int exit_val;           /* exit value to send to parent */
 
-	} else if (setup_sigs() < 0) {
-		/* an error occured - put mesg in note and send it back to parent */
-		(void)strcpy(note, mesg);
+	phase = 1;
+	/* set up to catch all catchable signals, now hold them */
+	if (setup_sigs() < 0)
+		tst_brk(TBROK, "setup_sigs() failed");
 
-	} else {
-		/* all set up to catch signals, now hold them */
-
-		for (sig = 1; sig < NUMSIGS; sig++) {
-			if (choose_sig(sig)) {
-				if ((rv = sighold(sig)) != 0) {
-					/* THEY say sighold ALWAYS returns 0 */
-					(void)sprintf(note,
-						      "sighold did not return 0. rv:%d",
-						      rv);
-					break;
-				}
-			}
+	for (sig = 1; sig < NUMSIGS; sig++)
+		if (choose_sig(sig)) {
+			TEST(sighold(sig));
+			if (TST_RET != 0)
+				tst_brk(TBROK, "sighold did not return 0 but %ld", TST_RET);
 		}
 
-	}
+	/* tell parent we're ready */
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	/*
-	 * send note to parent (if not READY, parent will BROK) and
-	 * wait for parent to send signals.  The timeout clock is set so
-	 * that we will not wait forever - if sighold() did its job, we
-	 * will not receive the signals.  If sighold() blew it we will
-	 * catch a signal and the interrupt handler will exit with a
-	 * value of SIG_CAUGHT.
-	 */
-	if (write_pipe(pipe_fd[1], note) < 0) {
-		/*
-		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
-		 * parent know what happened
-		 */
-		clear_timeout();
-		exit(WRITE_BROK);
-	}
 
 	/*
 	 * if we get to this point, all signals have been held and the
-	 * timer has expired.  Now what we want to do is release each
+	 * parent has sent signals.  Now what we want to do is release each
 	 * signal and see if we catch it.  If we catch all signals,
 	 * sigrelse passed, else it failed.
 	 */
 
-	phase = 2;		/* let handler know we are now expecting signals */
-
-#if DEBUG > 0
-	printf("child: PHASE II\n");
-#endif
+	phase = 2;
 
 	/* assume success and overwrite exit_val if an error occurs */
 	exit_val = EXIT_OK;
 
-#if DEBUG > 0
-	printf("child: pid=%d waiting for parent's ready...\n", getpid());
-#endif
-
-	/*
-	 * wait for parent to tell us that sigals were all sent
-	 */
-
-	/* wait for "ready" message from parent */
-	if ((str = read_pipe(pipe_fd2[0])) == NULL) {
-		/* read_pipe() failed. */
-		printf(" child: read_pipe failed\n");
-		exit(TBROK);
-	}
-
-	if (strcmp(str, READY) != 0) {
-		/* parent/pipe problem */
-		printf("child: didn't proper ready message\n");
-		exit(TBROK);
-	}
-
 	for (sig = 1; sig < NUMSIGS; sig++) {
 		if (choose_sig(sig)) {
-
 			/* all set up, release and catch a signal */
-
-			sig_caught = FALSE;	/* handler sets it to TRUE when caught */
-#if DEBUG > 1
-			printf("child: releasing sig %d...\n", sig);
-#endif
-			if ((rv = sigrelse(sig)) != 0) {
-				/* THEY say sigrelse ALWAYS returns 0 */
-				(void)sprintf(note,
-					      "sigrelse did not return 0. rv:%d",
-					      rv);
-				exit_val = TBROK;
-				break;
-			}
+			sig_caught = 0; /* handler sets it to 1 when caught */
+			TEST(sigrelse(sig));
+			if (TST_RET != 0)
+				tst_brk(TBROK, "sigrelse did not return 0 but %ld.", TST_RET);
 
 			/* give signal handler some time to process signal */
 			wait_a_while();
 		}
-
-	}			/* endfor */
+	}
 
 	/*
 	 * If we are error free so far...
-	 * check the sig_array array for one occurence of
-	 * each of the catchable signals.  If this is true,
-	 * then PASS, otherwise FAIL.
+	 * write the sig_array results to pipe for parent to read
 	 */
 
-	/* send note to parent and exit */
 	if (exit_val == EXIT_OK) {
-		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0) {
-			tst_resm(TBROK | TERRNO, "write() pipe failed");
-			exit(WRITE_BROK);
-		}
-	} else if (write_pipe(pipe_fd[1], note) < 0) {
-		/*
-		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
-		 * parent know what happened
-		 */
-		exit(WRITE_BROK);
+		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0)
+			tst_brk(TBROK | TERRNO, "write() pipe failed");
 	}
 
 	exit(exit_val);
+}
 
-}				/* end of child */
-
-/*****************************************************************************
- *  setup_sigs() : set child up to catch all signals.  If there is
- *       trouble, write message in mesg and return -1, else return 0.
- *       The signal handler has two functions depending on which phase
- *       of the test we are in.  The first section is executed after the
- *       signals have been held (should not ever be used).  The second
- *       section is executed after the signals have been released (should
- *       be executed for each signal).
- ****************************************************************************/
 static int setup_sigs(void)
 {
 	int sig;
 
 	/* set up signal handler routine */
-	for (sig = 1; sig < NUMSIGS; sig++) {
-		if (choose_sig(sig)) {
-			if (signal(sig, handler) == SIG_ERR) {
-				/* set up mesg to send back to parent */
-				(void)sprintf(mesg,
-					      "signal() failed for signal %d. error:%d %s.",
-					      sig, errno, strerror(errno));
-				return (-1);
-			}
-		}
-	}
+	for (sig = 1; sig < NUMSIGS; sig++)
+		if (choose_sig(sig))
+			if (signal(sig, handler) == SIG_ERR)
+				/* set up message to send back to parent */
+				tst_brk(TBROK | TERRNO,
+						"signal() failed for signal %d", sig);
 	return 0;
+}
+
+static void wait_a_while(void)
+{
+	long btime;
+
+	btime = time(NULL);
+	while (time(NULL) - btime < 1)  /* wait up to 1 second */
+		if (sig_caught == 1)
+			break;
+}
 
-}				/* end of setup_sigs  */
-
-/*****************************************************************************
- *  handler() : child's interrupt handler for all signals.  The phase variable
- *      is set in the child process indicating what action is to be taken.
- *    The phase 1 section will be run if the child process catches a signal
- *      after the signal has been held resulting in a test item BROK.
- *      The parent detects this situation by a child exit value of SIG_CAUGHT.
- *    The phase 2 section will be run if the child process catches a
- *      signal after the signal has been released.  All signals must be
- *      caught in order for a PASS.
- ****************************************************************************/
 static void handler(int sig)
 {
-	static int s = 0;	/* semaphore so that we don't handle 2 */
-	/* sigs at once */
-#if DEBUG > 1
-	printf("child: handler phase%d: caught signal %d.\n", phase, sig);
-#endif
+	static int s;       /* semaphore so that we don't handle 2 sigs at once */
 
-	if (phase == 1) {
+	if (phase == 1)
 		/* exit the child process with a value of -1 */
 		exit(SIG_CAUGHT);
-
-	} else {
+	else {
 		/* phase 2 (error if s gets incremented twice) */
 		++s;
 
-		if (s > 1) {
+		if (s > 1)
 			exit(HANDLE_ERR);
-		}
 
 		/* increment the array element for this signal */
 		++sig_array[sig];
-		sig_caught = TRUE;	/* flag for wait_a_while () */
+		sig_caught = 1; /* flag for wait_a_while () */
 		--s;
 	}
-
-	return;
-
-}				/* end of handler */
-
-/*****************************************************************************
- *  read_pipe() : read data from pipe and return in buf.  If an error occurs
- *      put message in mesg and return NULL.  Note: this routine sets a
- *      timeout signal in case the pipe is blocked.
- ****************************************************************************/
-static char *read_pipe(int fd)
-{
-	static char buf[MAXMESG];	/* buffer for pipe read */
-	int ret;
-
-#if DEBUG > 0
-	printf("read_pipe: pid=%d waiting...\n", getpid());
-#endif
-
-	/* set timeout alarm in case the pipe is blocked */
-	if (set_timeout() < 0) {
-		/* an error occured, message in mesg */
-		return NULL;
-	}
-
-	ret = -1;
-	while (ret == -1) {	/* while empty reads */
-		if ((ret = read(fd, buf, MAXMESG)) == 0) {
-			(void)sprintf(mesg, "read() pipe failed. error:%d %s.",
-				      errno, strerror(errno));
-
-			clear_timeout();
-			return NULL;
-		}
-	}
-	clear_timeout();
-
-#if DEBUG > 0
-	printf("read_pipe: pid=%d received: %s.\n", getpid(), buf);
-#endif
-	return (buf);
-
-}				/* end of read_pipe */
-
-/*****************************************************************************
- *  write_pipe(msg) : write msg to pipe.  If it fails, put message in
- *       mesg and return -1, else return 0.
- ****************************************************************************/
-static int write_pipe(int fd, char *msg)
-{
-
-#if DEBUG > 0
-	printf("write_pipe: pid=%d, sending %s.\n", getpid(), msg);
-#endif
-
-	if (write(fd, msg, strlen(msg) + 1) < 0) {
-		(void)sprintf(mesg, "write() pipe failed. error:%d %s.",
-			      errno, strerror(errno));
-
-		return (-1);
-	}
-	return 0;
-
-}				/* end of write_pipe */
-
-/*****************************************************************************
- *  set_timeout() : set alarm to signal process after the period of time
- *       indicated by TIMEOUT.  If the signal occurs, the routine timeout()
- *       will be executed.  If all goes ok, return 0, else load message
- *       into mesg and return -1.
- ****************************************************************************/
-static int set_timeout(void)
-{
-	if (signal(SIGALRM, timeout) == SIG_ERR) {
-		(void)sprintf(mesg,
-			      "signal() failed for signal %d. error:%d %s.",
-			      SIGALRM, errno, strerror(errno));
-		return (-1);
-	}
-
-	(void)alarm(TIMEOUT);
-	return 0;
-
-}				/* end of set_timeout */
-
-/*****************************************************************************
- *  clear_timeout() : turn off the alarm so that SIGALRM will not get sent.
- ****************************************************************************/
-static void clear_timeout(void)
-{
-	(void)alarm(0);
-
-}				/* end of clear_timeout */
-
-/*****************************************************************************
- *  timeout() : this routine is executed when the SIGALRM signal is
- *      caught.  It does nothing but return - the read() on the pipe
- *      will fail.
- ****************************************************************************/
-static void timeout(int sig)
-{
-#if DEBUG > 0
-	printf("timeout: pid=%d sigalrm caught.\n", getpid());
-#endif
-}
-
-/*****************************************************************************
- *  wait_a_while () : wait a while before returning.
- ****************************************************************************/
-static void wait_a_while(void)
-{
-	long btime;
-
-	btime = time(NULL);
-	while (time(NULL) - btime < TIMEOUT) {
-		if (sig_caught == TRUE)
-			break;
-	}
-}				/* end of wait_a_while */
-
-static void getout(void)
-{
-	if (pid > 0 && kill(pid, SIGKILL) < 0)
-		tst_resm(TWARN, "kill(%d, SIGKILL) failed", pid);
-	cleanup();
-
-}				/* end of getout */
-
-#ifdef VAX
-static int sighold(int signo)
-{
-	return 0;
 }
 
-static int sigrelse(signo)
-int signo;
+static void setup(void)
 {
-	return 0;
-}
-#endif
-
-int choose_sig(int sig)
-{
-	switch (sig) {
-
-	case SIGKILL:
-	case SIGSTOP:
-	case SIGTSTP:
-	case SIGCONT:
-	case SIGALRM:
-	case SIGCANCEL:
-	case SIGTIMER:
-#ifdef SIGNOBDM
-	case SIGNOBDM:
-#endif
-#ifdef SIGTTIN
-	case SIGTTIN:
-#endif
-#ifdef SIGTTOU
-	case SIGTTOU:
-#endif
-#ifdef  SIGPTINTR
-	case SIGPTINTR:
-#endif
-#ifdef  SIGSWAP
-	case SIGSWAP:
-#endif
-		return 0;
-
-	}
-
-	if (sig < 32)
-		return 1;
-
-	return sig >= SIGRTMIN && sig <= SIGRTMAX;
-}
-
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* set up pipe for parent/child communications */
-	SAFE_PIPE(cleanup, pipe_fd);
-
-	/*
-	 * Cause the read to return 0 once EOF is encountered and the
-	 * read to return -1 if pipe is empty.
-	 */
-	if (fcntl(pipe_fd[0], F_SETFL, O_NONBLOCK) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "fcntl(Fds[0], F_SETFL, O_NONBLOCK) failed");
-
 	/* set up pipe for parent/child communications */
-	SAFE_PIPE(cleanup, pipe_fd2);
-
-	/*
-	 * Cause the read to return 0 once EOF is encountered and the
-	 * read to return -1 if pipe is empty.
-	 */
-	if (fcntl(pipe_fd2[0], F_SETFL, O_NONBLOCK) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "fcntl(Fds[0], F_SETFL, O_NONBLOCK) failed");
+	SAFE_PIPE(pipe_fd);
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
 
-}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
