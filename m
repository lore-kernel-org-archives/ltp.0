Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A19FEE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 09:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3CE3CCD62
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:23:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7F3A3CB65C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:22:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC5AE2009FA
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:22:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C6BC21850;
 Thu,  7 Sep 2023 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694078566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIdtj9g5ZKhRLgkhg+g81fIUc3hBI9hikoNRfkn5Hrk=;
 b=dtCimF3Tl28WDpYRrZpW+hZFs37EHRp8pO9d5xqlrrgZiuACRUO98eaVUl/h4li8tW6iHU
 VQ5lCmaoy4rmkRou59hZYj+JRLyYChm3CeEKBKUtjKKXPuaOhSQKSZ1ipSo7lNPryWW5kc
 HkR8xFkFAwYqaXYDL9g4g6kOzvIwzbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694078566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIdtj9g5ZKhRLgkhg+g81fIUc3hBI9hikoNRfkn5Hrk=;
 b=1duLtA54FyiPc9RkYLJ1dbrP8v8hDR35FepVWjCUeWM3IrLMtkMv435JFkh4DRIbjhMQ4R
 uTAzcVUCiiLUD2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 049B213ADD;
 Thu,  7 Sep 2023 09:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oHgtAGaW+WSINgAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 07 Sep 2023 09:22:46 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 11:22:37 +0200
Message-ID: <20230907092239.15253-2-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092239.15253-1-mkittler@suse.de>
References: <20230907092239.15253-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Refactor ioctl02.c to use the new test API
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

This test code itself has been kept unchanged as much as possible
(although it probably still has room for improvement).

See https://github.com/linux-test-project/ltp/issues/637 for related
discussion.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 280 +++++++---------------
 1 file changed, 90 insertions(+), 190 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index b4d4a3594..77283e510 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -1,31 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
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
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
  */
 
-/*
- * NAME
- *	ioctl02.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
  *	Testcase to test the TCGETA, and TCSETA ioctl implementations for
  *	the tty driver
  *
- * ALGORITHM
  *	In this test, the parent and child open the parentty and the childtty
  *	respectively.  After opening the childtty the child flushes the stream
  *	and sends a SIGUSR1 to the parent (thereby asking it to continue its
@@ -38,22 +23,6 @@
  *	set. The parent does all the testing, the requirement of the child
  *	process is to moniter the testing done by the parent, and hence the
  *	child just waits for the parent.
- *
- * USAGE:  <for command-line>
- *  ioctl02 -D /dev/tty[0-9] [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	test must be run with the -D option
- *	test may have to be run as root depending on the tty permissions
  */
 
 #include <stdio.h>
@@ -64,22 +33,17 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <termios.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/ioctl.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 #define	CNUL	0
 
-char *TCID = "ioctl02";
-int TST_TOTAL = 1;
-
 static struct termio termio, save_io;
 
 static char *parenttty, *childtty;
-static int parentfd, childfd;
+static int parentfd = -1, childfd = -1;
 static int parentpid, childpid;
 static volatile int sigterm, sigusr1, sigusr2;
-static int closed = 1;
 
 static int do_child_setup(void);
 static int do_parent_setup(void);
@@ -88,108 +52,63 @@ static int run_ctest(void);
 static int chk_tty_parms();
 static void setup(void);
 static void cleanup(void);
-static void help(void);
 static void do_child(void);
-void do_child_uclinux(void);
 static void sigterm_handler(void);
 
-static int Devflag;
-static char *devname;
+static char *device;
 
-static option_t options[] = {
-	{"D:", &Devflag, &devname},
-	{NULL, NULL, NULL}
-};
-
-int main(int ac, char **av)
+static void verify_ioctl(void)
 {
-	int lc;
-	int rval;
-
-	tst_parse_opts(ac, av, options, &help);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child_uclinux, "dS", &parentpid, &childtty);
-#endif
-
-	if (!Devflag)
-		tst_brkm(TBROK, NULL, "You must specify a tty device with "
-			 "the -D option.");
-
-	tst_require_root();
-
-	setup();
+	parenttty = device;
+	childtty = device;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	parentpid = getpid();
+	childpid = SAFE_FORK();
+	if (childpid == 0)
+		do_child();
 
-		tst_count = 0;
-
-		parenttty = devname;
-		childtty = devname;
-
-		parentpid = getpid();
-
-		childpid = FORK_OR_VFORK();
-		if (childpid < 0)
-			tst_brkm(TBROK, cleanup, "fork failed");
-
-		if (childpid == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "dS", parentpid, childtty) < 0)
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-#else
-			do_child();
-#endif
-		}
-
-		while (!sigusr1)
-			sleep(1);
-
-		sigusr1 = 0;
-
-		parentfd = do_parent_setup();
-		if (parentfd < 0) {
-			kill(childpid, SIGTERM);
-			waitpid(childpid, NULL, 0);
-			cleanup();
-		}
-
-		/* run the parent test */
-		rval = run_ptest();
-		if (rval == -1) {
-			/*
-			 * Parent cannot set/get ioctl parameters.
-			 * SIGTERM the child and cleanup.
-			 */
-			kill(childpid, SIGTERM);
-			waitpid(childpid, NULL, 0);
-			cleanup();
-		}
+	while (!sigusr1)
+		sleep(1);
 
-		if (rval != 0)
-			tst_resm(TFAIL, "TCGETA/TCSETA tests FAILED with "
-				 "%d %s", rval, rval > 1 ? "errors" : "error");
-		else
-			tst_resm(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
+	sigusr1 = 0;
 
-		/* FIXME: check return codes. */
-		(void)kill(childpid, SIGTERM);
-		(void)waitpid(childpid, NULL, 0);
+	parentfd = do_parent_setup();
+	if (parentfd < 0) {
+		kill(childpid, SIGTERM);
+		waitpid(childpid, NULL, 0);
+		cleanup();
+	}
 
+	/* run the parent test */
+	int rval = run_ptest();
+	if (rval == -1) {
 		/*
-		 * Clean up things from the parent by restoring the
-		 * tty device information that was saved in setup()
-		 * and closing the tty file descriptor.
+		 * Parent cannot set/get ioctl parameters.
+		 * SIGTERM the child and cleanup.
 		 */
-		if (ioctl(parentfd, TCSETA, &save_io) == -1)
-			tst_resm(TINFO, "ioctl restore failed in main");
-		SAFE_CLOSE(cleanup, parentfd);
-
-		closed = 1;
+		kill(childpid, SIGTERM);
+		waitpid(childpid, NULL, 0);
+		cleanup();
 	}
-	cleanup();
 
-	tst_exit();
+	if (rval != 0)
+		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
+				"%d %s", rval, rval > 1 ? "errors" : "error");
+	else
+		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
+
+	/* FIXME: check return codes. */
+	(void)kill(childpid, SIGTERM);
+	(void)waitpid(childpid, NULL, 0);
+
+	/*
+	 * Clean up things from the parent by restoring the
+	 * tty device information that was saved in setup()
+	 * and closing the tty file descriptor.
+	 */
+	if (ioctl(parentfd, TCSETA, &save_io) == -1)
+		tst_res(TINFO, "ioctl restore failed in main");
+	SAFE_CLOSE(parentfd);
 }
 
 static void do_child(void)
@@ -201,28 +120,12 @@ static void do_child(void)
 	_exit(0);
 }
 
-void do_child_uclinux(void)
-{
-	struct sigaction act;
-
-	/* Set up the signal handlers again */
-	act.sa_handler = (void *)sigterm_handler;
-	act.sa_flags = 0;
-	sigemptyset(&act.sa_mask);
-	(void)sigaction(SIGTERM, &act, 0);
-
-	/* Run the normal child */
-	do_child();
-}
-
 /*
  * run_ptest() - setup the various termio structure values and issue
  *		 the TCSETA ioctl call with the TEST macro.
  */
 static int run_ptest(void)
 {
-	int i, rval;
-
 	/* Use "old" line discipline */
 	termio.c_line = 0;
 
@@ -230,7 +133,7 @@ static int run_ptest(void)
 	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
 
 	/* Set control chars. */
-	for (i = 0; i < NCC; i++) {
+	for (int i = 0; i < NCC; i++) {
 		if (i == VEOL2)
 			continue;
 		termio.c_cc[i] = CSTART;
@@ -250,16 +153,10 @@ static int run_ptest(void)
 
 	TEST(ioctl(parentfd, TCSETA, &termio));
 
-	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "ioctl TCSETA failed : "
-			 "errno = %d", TEST_ERRNO);
-		return -1;
-	}
-
 	/* Get termio and see if all parameters actually got set */
-	rval = ioctl(parentfd, TCGETA, &termio);
+	int rval = ioctl(parentfd, TCGETA, &termio);
 	if (rval < 0) {
-		tst_resm(TFAIL, "ioctl TCGETA failed.  Ending test.");
+		tst_res(TFAIL, "ioctl TCGETA failed.  Ending test.");
 		return -1;
 	}
 
@@ -276,10 +173,10 @@ static int run_ctest(void)
 
 	sigterm = 0;
 
-	tst_resm(TINFO, "child: Got SIGTERM from parent.");
+	tst_res(TINFO, "child: Got SIGTERM from parent.");
 
 	if (close(childfd) == -1)
-		tst_resm(TINFO, "close() in run_ctest() failed");
+		tst_res(TINFO, "close() in run_ctest() failed");
 	return 0;
 }
 
@@ -288,7 +185,7 @@ static int chk_tty_parms(void)
 	int i, flag = 0;
 
 	if (termio.c_line != 0) {
-		tst_resm(TINFO, "line discipline has incorrect value %o",
+		tst_res(TINFO, "line discipline has incorrect value %o",
 			 termio.c_line);
 		flag++;
 	}
@@ -301,7 +198,7 @@ static int chk_tty_parms(void)
 	 */
 #if 0
 	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
-		tst_resm(TINFO, "cflag has incorrect value. %o",
+		tst_res(TINFO, "cflag has incorrect value. %o",
 			 termio.c_cflag);
 		flag++;
 	}
@@ -312,7 +209,7 @@ static int chk_tty_parms(void)
 			if (termio.c_cc[VEOL2] == CNUL) {
 				continue;
 			} else {
-				tst_resm(TINFO, "control char %d has "
+				tst_res(TINFO, "control char %d has "
 					 "incorrect value %d %d", i,
 					 termio.c_cc[i], CNUL);
 				flag++;
@@ -321,7 +218,7 @@ static int chk_tty_parms(void)
 		}
 
 		if (termio.c_cc[i] != CSTART) {
-			tst_resm(TINFO, "control char %d has incorrect "
+			tst_res(TINFO, "control char %d has incorrect "
 				 "value %d.", i, termio.c_cc[i]);
 			flag++;
 		}
@@ -330,7 +227,7 @@ static int chk_tty_parms(void)
 	if (!
 	    (termio.c_lflag
 	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
-		tst_resm(TINFO, "lflag has incorrect value. %o",
+		tst_res(TINFO, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
 	}
@@ -339,34 +236,29 @@ static int chk_tty_parms(void)
 	    (termio.c_iflag
 	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
 		 | IXOFF))) {
-		tst_resm(TINFO, "iflag has incorrect value. %o",
+		tst_res(TINFO, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
 	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
-		tst_resm(TINFO, "oflag has incorrect value. %o",
+		tst_res(TINFO, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
 	}
 
 	if (!flag)
-		tst_resm(TINFO, "termio values are set as expected");
+		tst_res(TINFO, "termio values are set as expected");
 
 	return flag;
 }
 
 static int do_parent_setup(void)
 {
-	int pfd;
-
-	pfd = SAFE_OPEN(cleanup, parenttty, O_RDWR, 0777);
-
-	/* unset the closed flag */
-	closed = 0;
+	int pfd = SAFE_OPEN(parenttty, O_RDWR, 0777);
 
 	/* flush tty queues to remove old output */
-	SAFE_IOCTL(cleanup, pfd, TCFLSH, 2);
+	SAFE_IOCTL(pfd, TCFLSH, 2);
 	return pfd;
 }
 
@@ -376,7 +268,7 @@ static int do_child_setup(void)
 
 	cfd = open(childtty, O_RDWR, 0777);
 	if (cfd < 0) {
-		tst_resm(TINFO, "Could not open %s in do_child_setup(), errno "
+		tst_res(TINFO, "Could not open %s in do_child_setup(), errno "
 			 "= %d", childtty, errno);
 		/* signal the parent so we don't hang the test */
 		kill(parentpid, SIGUSR1);
@@ -385,7 +277,7 @@ static int do_child_setup(void)
 
 	/* flush tty queues to remove old output */
 	if (ioctl(cfd, TCFLSH, 2) < 0) {
-		tst_resm(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
+		tst_res(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
 		/* signal the parent so we don't hang the test */
 		kill(parentpid, SIGUSR1);
 		return -1;
@@ -415,24 +307,22 @@ static void sigusr2_handler(void)
 	sigusr2 = 1;
 }
 
-static void help(void)
-{
-	printf("  -D <tty device> : for example, /dev/tty[0-9]\n");
-}
-
 static void setup(void)
 {
+	if (!device)
+		tst_brk(TBROK, "You must specify a tty device with -D option");
+
 	int fd;
 	struct sigaction act;
 
 	/* XXX: TERRNO required all over the place */
-	fd = SAFE_OPEN(NULL, devname, O_RDWR, 0777);
+	fd = SAFE_OPEN(device, O_RDWR, 0777);
 
 	/* Save the current device information - to be restored in cleanup() */
-	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
+	SAFE_IOCTL(fd, TCGETA, &save_io);
 
 	/* Close the device */
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 
 	/* Set up the signal handlers */
 	act.sa_handler = (void *)sigterm_handler;
@@ -453,16 +343,26 @@ static void setup(void)
 	(void)sigaction(SIGTTOU, &act, 0);
 
 	sigterm = sigusr1 = sigusr2 = 0;
-
-	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	if (!closed) {
+	if (parentfd != -1) {
 		if (ioctl(parentfd, TCSETA, &save_io) == -1)
-			tst_resm(TINFO, "ioctl restore failed in cleanup()");
+			tst_res(TINFO, "ioctl restore failed in cleanup()");
 		if (close(parentfd) == -1)
-			tst_resm(TINFO, "close() failed in cleanup()");
+			tst_res(TINFO, "close() failed in cleanup()");
 	}
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl,
+	.options = (struct tst_option[]) {
+		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
+		{}
+	}
+};
\ No newline at end of file
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
