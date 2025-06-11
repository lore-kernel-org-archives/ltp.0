Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091CC678DC
	for <ltp@archiver.kernel.org>; Wed, 11 Jun 2025 13:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3943A3CB1AA
	for <ltp@archiver.kernel.org>; Wed, 11 Jun 2025 15:25:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08A633C8A7F
 for <ltp@lists.linux.it>; Wed, 11 Jun 2025 15:24:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A5CE100075F
 for <ltp@lists.linux.it>; Wed, 11 Jun 2025 15:24:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92CBD219FC;
 Wed, 11 Jun 2025 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749648279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=suV2hZ84X8xao51hs4aXHbio6498gg+IJiFdYdP9Dog=;
 b=iML0lw5OGYpZmCSf1bBkKNSt/sIaMqoZy3VIpU+fvG8+TxzwtDFLbi26Z9I42T0s9q8Kbk
 DiORCeG411r3j3Boe6aEVtbc8IOonekob4m6wCH5aZJokp9EXHcjOcXMw6y6G2F0e1A0Kt
 WwZqKdCtb3vSPaPgJsqYtYzeh/SiADE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749648279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=suV2hZ84X8xao51hs4aXHbio6498gg+IJiFdYdP9Dog=;
 b=TqPnJ9AhtsT1Uicv0h9eopgDxh1M24eip9cwdDJE2wZXKK5nJ4W7vUmodje2N3NNvHVycs
 sLs/xawRAh+JH6CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iML0lw5O;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TqPnJ9Ah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749648279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=suV2hZ84X8xao51hs4aXHbio6498gg+IJiFdYdP9Dog=;
 b=iML0lw5OGYpZmCSf1bBkKNSt/sIaMqoZy3VIpU+fvG8+TxzwtDFLbi26Z9I42T0s9q8Kbk
 DiORCeG411r3j3Boe6aEVtbc8IOonekob4m6wCH5aZJokp9EXHcjOcXMw6y6G2F0e1A0Kt
 WwZqKdCtb3vSPaPgJsqYtYzeh/SiADE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749648279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=suV2hZ84X8xao51hs4aXHbio6498gg+IJiFdYdP9Dog=;
 b=TqPnJ9AhtsT1Uicv0h9eopgDxh1M24eip9cwdDJE2wZXKK5nJ4W7vUmodje2N3NNvHVycs
 sLs/xawRAh+JH6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7062B139CE;
 Wed, 11 Jun 2025 13:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CqqdGZeDSWiATgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 11 Jun 2025 13:24:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Jun 2025 15:24:38 +0200
MIME-Version: 1.0
Message-Id: <20250611-crash02_rewrite-v1-1-1becd9dc163d@suse.com>
X-B4-Tracking: v=1; b=H4sIAJWDSWgC/x3MTQqAIBBA4avErBN0+iG6SkSYTjUbizEqCO+et
 PwW770QSZgi9MULQhdH3kOGKQtwmw0rKfbZgBob3RqjnNi4aZyEbuGT1NzV5CqvPaKFXB1CCz/
 /cRhT+gB8r6kXYQAAAA==
X-Change-ID: 20250611-crash02_rewrite-b84ec3d0d22a
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749648279; l=15590;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=8C25LosrZvFSnT6igemlGD2h+yBPSAFzkBpuIRgMRec=;
 b=gj2tlKJi+Sf7bBT5zaB4M7MQcNY/sOX2xC0vwi5e6tWsqh2Mp0xVJ/QI0ixzv2p3RPghm4bzV
 nbhVybq3pK4AxaVm97pJiAbxuL4xHJgRyQucspZF2yYgNDgE8ukCDGg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 92CBD219FC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] misc: rewrite crash02 test
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

Rewrite the crash02 test, introducing new API but maintaining the logic
behind it. The test generates random syscall executions with random data
and it verifies that system didn't crash.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/misc/crash/crash02.c | 577 +++++++++--------------------------------
 1 file changed, 123 insertions(+), 454 deletions(-)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index c68f580ef62ad3b3c644093f72646a8908e55076..417c2aa2b8e4facf9ddcde358fe59a7f4419e859 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -1,497 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * crash02.c - Test OS robustness by executing syscalls with random args.
- *
- * Copyright (C) 2001 Stephane Fillod <f4cfe@free.fr>
- *
- * This test program was inspired from crashme, by GEORGE J. CARRETT.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA	02111-1307, USA.
+ * Copyright (C) 2025 SUSE LLC <andrea.cervesato@suse.com>
  */
 
-/*
-A signal handler is set up so that in most cases the machine exception
-generated by the illegal syscall, bad operands, etc in the procedure
-made up of random data are caught; and another round of randomness may
-be tried. Eventually a random syscall may corrupt the program or
-the machine state in such a way that the program must halt. This is
-a test of the robustness of the hardware/software for instruction
-fault handling.
-
-Note: Running this program just a few times, using total CPU time of
-less than a few seconds SHOULD NOT GIVE YOU ANY CONFIDENCE in system
-robustness. Having it run for hours, with tens of thousands of cases
-would be a different thing. It would also make sense to run this
-stress test at the same time you run other tests, like a multi-user
-benchmark.
-
-CAUTION: running this program may crash your system, your disk and all
-	your data along! DO NOT RUN IT ON PRODUCTION SYSTEMS!
-	CONSIDER YOUR DISK FRIED.
-	REMEMBER THE DISCLAIMER PART OF THE LICENSE.
-
-	Running as user nobody and with all your filesystems
-	remounted to readonly may be wise..
-
-TODO:
-	* in rand_long(), stuff in some real pointers to random data
-	* Does a syscall is supposed to send SIGSEGV?
-*/
-
-#define _GNU_SOURCE
-#include <sys/syscall.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <signal.h>
-#include <setjmp.h>
-#include <time.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-#include "test.h"
-
-char *TCID = "crash02";
-int TST_TOTAL = 1;
-
-static int x_opt = 0;
-static int v_opt = 0;
-static char *v_copt;
-static int s_opt = 0;
-static char *s_copt;
-static int l_opt = 0;
-static char *l_copt;
-static int n_opt = 0;
-static char *n_copt;
-
-int verbose_level = 2;
-
-/* depends on architecture.. */
-unsigned int sysno_max = 127;
-
-int nseed;
-int ntries = 100;
-
-/* max time allowed per try, in seconds */
-#define MAX_TRY_TIME 5
-
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-
-void setup(void)
-{
-	/*
-	 * setup a default signal hander and a
-	 * temporary working directory.
-	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+/*\
+ * Test the robustness of the system generating random syscalls execution
+ * with random data and expecting that the current system is not crashing.
+ */
 
-	TEST_PAUSE;
+#include <limits.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/getrandom.h"
 
-	tst_tmpdir();
-}
+#define MAX_SYSCALLS 465
 
-void help(void)
-{
-	printf
-	    ("	-x		dry run, hexdump random code instead\n");
-	printf("	-l x		max syscall no\n");
-	printf("	-v x		verbose level\n");
-	printf("	-s x		random seed\n");
-	printf("	-n x		ntries\n");
-}
+static int *num_errors;
+static char *str_num_tries;
+static int num_tries = 1000;
 
-/*
- */
-option_t options[] = {
-	{"v:", &v_opt, &v_copt},
-	{"l:", &l_opt, &l_copt},
-	{"s:", &s_opt, &s_copt},
-	{"n:", &n_opt, &n_copt},
-	{"x", &x_opt, NULL},
-
-	{NULL, NULL, NULL}
+static int blacklist[] = {
+#if defined(__ia64__)
+	__NR_clone2,	/* IA-64 uses clone2 instead of fork/vfork */
+#else
+# if defined(__NR_vfork)
+	__NR_vfork,
+# endif
+# if defined(__NR_fork)
+	__NR_fork,
+# endif
+#endif /* __ia64__ */
+#if defined(__NR_clone)
+	__NR_clone,
+#endif
+#if defined(__NR_clone3)
+	__NR_clone3,
+#endif
+#if defined(__NR_vhangup)
+	__NR_vhangup,	/* terminal logout */
+#endif
+#if defined(__NR_pause)
+	__NR_pause,	/* sleep indefinitely */
+#endif
+#if defined(__NR_read)
+	__NR_read,	/* sleep indefinitely if the first argument is 0 */
+#endif
+	__LTP__NR_INVALID_SYSCALL,
 };
 
-void badboy_fork();
-void badboy_loop();
-
-void summarize_errno();
-void record_errno(unsigned int n);
-
-int main(int argc, char *argv[])
+static inline long rand_number(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, help);
-
-	if (v_opt)
-		verbose_level = atoi(v_copt);
+	int64_t num = 0;
+	char buff[4];
 
-	if (n_opt)
-		ntries = atoi(n_copt);
+	if (getrandom(buff, 4, 0) == -1)
+		tst_brk(TBROK | TERRNO, "getrandom error");
 
-	if (l_opt)
-		sysno_max = atoi(l_copt);
+	num = (buff[0] << 24) | (buff[1] << 16) | (buff[2] << 8) | buff[3];
+	if (num < 0)
+		num *= -1;
+	num = (num % MAX_SYSCALLS) - 1;
 
-	if (s_opt)
-		nseed = atoi(s_copt);
-	else
-		nseed = time(NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		tst_resm(TINFO, "crashme02 %d %d %d", sysno_max, nseed, ntries);
-
-		srand(nseed);
-		badboy_fork();
-
-		/* still there? */
-		tst_resm(TPASS, "we're still here, OS seems to be robust");
-
-		nseed++;
-	}
-	cleanup();
-	tst_exit();
+	return (long)num;
 }
 
-/* ************************* */
-int badboy_pid;
-
-void my_signal(int sig, void (*func) ());
-
-void monitor_fcn(int sig)
-{
-	int status;
-
-	if (verbose_level >= 3)
-		printf("time limit reached on pid. using kill.\n");
-
-	status = kill(badboy_pid, SIGKILL);
-	if (status < 0) {
-		if (verbose_level >= 3)
-			printf("failed to kill process\n");
-	}
-}
-
-void badboy_fork(void)
+static void try_crash(const int num)
 {
-	int status, pid;
-	pid_t child = fork();
+	long sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6;
+	int invalid;
+	int ret;
 
-	switch (child) {
-	case -1:
-		perror("fork");
-	case 0:
-#ifdef DEBUG_LATE_BADBOY
-		sleep(ntries * MAX_TRY_TIME + 10);
-#else
-		badboy_loop();
-#endif
-		exit(0);
-	default:
-		badboy_pid = child;
-		if (verbose_level > 3)
-			printf("badboy pid = %d\n", badboy_pid);
-
-		/* don't trust the child to return at night */
-		my_signal(SIGALRM, monitor_fcn);
-		alarm(ntries * MAX_TRY_TIME);
-
-		pid = waitpid(-1, &status, WUNTRACED);
-		if (pid <= 0)
-			perror("wait");
-		else {
-			if (verbose_level > 3)
-				printf("pid %d exited with status %d\n",
-				       pid, status);
-#if 0
-			record_status(status);
-#endif
+	do {
+		invalid = 0;
+		sysno = rand_number() % MAX_SYSCALLS;
+
+		for (size_t i = 0; i < ARRAY_SIZE(blacklist); i++) {
+			if (blacklist[i] == sysno) {
+				invalid = 1;
+				break;
+			}
 		}
-	}
-	alarm(0);
-}
-
-/* *************** status recording ************************* */
 
-/* errno status table (max is actually around 127) */
-#define STATUS_MAX 256
-static int errno_table[STATUS_MAX];
-
-void record_errno(unsigned int n)
-{
-	if (n >= STATUS_MAX)
-		return;
+		if (!invalid)
+			break;
+	} while (1);
 
-	errno_table[n]++;
-}
+	arg0 = rand_number();
+	arg1 = rand_number();
+	arg2 = rand_number();
+	arg3 = rand_number();
+	arg4 = rand_number();
+	arg5 = rand_number();
+	arg6 = rand_number();
 
-/* may not work with -c option */
-void summarize_errno(void)
-{
-	int i;
+	tst_res(TDEBUG,
+		"%d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, %#lx, %#lx, %#lx)",
+		num, sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
 
-	if (x_opt || verbose_level < 2)
-		return;
+	ret = syscall(sysno, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
+	if (ret == -1) {
+		(*num_errors)++;
 
-	printf("errno status ... number of cases\n");
-	for (i = 0; i < STATUS_MAX; i++) {
-		if (errno_table[i])
-			printf("%12d ... %5d\n", i, errno_table[i]);
+		tst_res(TDEBUG, "syscall error: %s", strerror(errno));
 	}
 }
 
-/* ************* badboy ******************************************* */
-
-jmp_buf again_buff;
-
-unsigned char *bad_malloc(int n);
-void my_signal(int sig, void (*func) ());
-void again_handler(int sig);
-void try_one_crash(int try_num);
-void set_up_signals();
-int in_blacklist(int sysno);
-
-/* badboy "entry" point */
-
-/*
- * Unlike crashme, faulty syscalls are not supposed to barf
- */
-void badboy_loop(void)
+static void run(void)
 {
-	int i;
-
-	for (i = 0; i < ntries; ++i) {
-		/* level 5 */
+	pid_t pid;
+	int status;
+	int num_signals = 0;
 
-		if (!x_opt && verbose_level >= 5) {
-			printf("try %d\n", i);
+	for (int i = 0; i < num_tries; i++) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			try_crash(i);
+			exit(0);
 		}
 
-		if (setjmp(again_buff) == 3) {
-			if (verbose_level >= 5)
-				printf("Barfed\n");
-		} else {
-			set_up_signals();
-			alarm(MAX_TRY_TIME);
-			try_one_crash(i);
-		}
-	}
-	summarize_errno();
-}
+		SAFE_WAITPID(pid, &status, 0);
 
-void again_handler(int sig)
-{
-	char *ss;
+		if (WIFSIGNALED(status)) {
+			num_signals++;
 
-	switch (sig) {
-	case SIGILL:
-		ss = " illegal instruction";
-		break;
-#ifdef SIGTRAP
-	case SIGTRAP:
-		ss = " trace trap";
-		break;
-#endif
-	case SIGFPE:
-		ss = " arithmetic exception";
-		break;
-#ifdef SIGBUS
-	case SIGBUS:
-		ss = " bus error";
-		break;
-#endif
-	case SIGSEGV:
-		ss = " segmentation violation";
-		break;
-#ifdef SIGIOT
-	case SIGIOT:
-		ss = " IOT instruction";
-		break;
-#endif
-#ifdef SIGEMT
-	case SIGEMT:
-		ss = " EMT instruction";
-		break;
-#endif
-#ifdef SIGALRM
-	case SIGALRM:
-		ss = " alarm clock";
-		break;
-#endif
-	case SIGINT:
-		ss = " interrupt";
-		break;
-	default:
-		ss = "";
+			tst_res(TDEBUG, "syscall signaled: %s",
+				strsignal(WTERMSIG(status)));
+		}
 	}
-	if (verbose_level >= 5)
-		printf("Got signal %d%s\n", sig, ss);
 
-	longjmp(again_buff, 3);
-}
-
-void my_signal(int sig, void (*func) ())
-{
-	struct sigaction act;
+	tst_res(TINFO, "Detected errors: %d", *num_errors);
+	tst_res(TINFO, "Detected signals: %d", num_signals);
 
-	act.sa_handler = func;
-	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
-	act.sa_flags = SA_NOMASK | SA_RESTART;
-	sigaction(sig, &act, 0);
-}
-
-void set_up_signals(void)
-{
-	my_signal(SIGILL, again_handler);
-#ifdef SIGTRAP
-	my_signal(SIGTRAP, again_handler);
-#endif
-	my_signal(SIGFPE, again_handler);
-#ifdef SIGBUS
-	my_signal(SIGBUS, again_handler);
-#endif
-	my_signal(SIGSEGV, again_handler);
-#ifdef SIGIOT
-	my_signal(SIGIOT, again_handler);
-#endif
-#ifdef SIGEMT
-	my_signal(SIGEMT, again_handler);
-#endif
-#ifdef SIGALRM
-	my_signal(SIGALRM, again_handler);
-#endif
-	my_signal(SIGINT, again_handler);
+	tst_res(TPASS, "System is still up and running");
 }
 
-/*
- * NB: rand() (ie. RAND_MAX) might be on 31bits only!
- *
- * FIXME: 64-bit systems
- *
- * TODO: improve arg mixing (16bits and 8bits values, NULLs, etc.).
- *	big values as returned by rand() are no so interresting
- *	(except when used as pointers) because they may fall too
- *	quickly in the invalid parameter sieve. Smaller values,
- *	will be more insidious because they may refer to existing
- *	objects (pids, fd, etc.).
- */
-long int rand_long(void)
+static void setup(void)
 {
-	int r1, r2;
-
-	r1 = rand();
-	r2 = rand();
-
-	if (r1 & 0x10000L)
-		r1 = 0;
-	if (!r1 && (r2 & 0x50000L))
-		r2 = 0;
-	else if (!r1 && (r2 & 0x20000L))
-		r2 &= 0x00ffL;
-
-	return (long int)((r1 & 0xffffL) << 16) | (r2 & 0xffffL);
+	num_errors = SAFE_MMAP(
+		NULL, sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+
+	if (tst_parse_int(str_num_tries, &num_tries, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of entries '%s'", str_num_tries);
 }
 
-void try_one_crash(int try_num)
+static void cleanup(void)
 {
-	long int sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7;
-
-	do {
-		sysno = rand() % sysno_max;
-	} while (in_blacklist(sysno));
-
-	arg1 = rand_long();
-	arg2 = rand_long();
-	arg3 = rand_long();
-	arg4 = rand_long();
-	arg5 = rand_long();
-	arg6 = rand_long();
-	arg7 = rand_long();
-
-	if (x_opt || verbose_level >= 1)
-		printf("%04d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, %#lx, "
-		       "%#lx, %#lx)\n", try_num, sysno, arg1, arg2, arg3,
-		       arg4, arg5, arg6, arg7);
-
-	if (!x_opt) {
-		syscall(sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
-		record_errno(errno);
-	}
+	if (num_errors)
+		SAFE_MUNMAP(num_errors, sizeof(int));
 }
 
-/* The following syscalls create new processes which may cause the test
-	 unable to finish. */
-int in_blacklist(int sysno)
-{
-	int i;
-	const int list[] = {
-#if defined(__ia64__)
-		SYS_clone2,
-#else
-		/*
-		 * No SYS_fork(vfork) on IA-64. Instead, it uses,
-		 * clone(child_stack=0, flags=CLONE_VM|CLONE_VFORK|SIGCHLD)
-		 * clone2()
-		 */
-
-		/*
-		 * NOTE (garrcoop):
-		 * Could not find reference to SYS_fork(vfork) on mips32
-		 * with the Montavista / Octeon toolchain. Need to develop an
-		 * autoconf check for this item.
-		 */
-#if defined(__NR_vfork) && __NR_vfork
-		SYS_vfork,
-#endif
-#if defined(__NR_fork) && __NR_fork
-		SYS_fork,
-#endif
-#endif /* __ia64__ */
-#if defined(__NR_clone) && __NR_clone
-		SYS_clone,
-#endif
-#if defined(__NR_vhangup) && __NR_vhangup
-		__NR_vhangup,	/* int vhangup(void); - terminal logout */
-#endif
-#if defined(__NR_pause) && __NR_pause
-		__NR_pause,	/* int pause(void); - sleep indefinitely */
-#endif
-#if defined(__NR_read) && __NR_read
-		/*
-		 * ssize_t read(int fd, void *buf, size_t count); - will sleep
-		 * indefinitely if the first argument is 0
-		 */
-		__NR_read,
-#endif
-		-1
-	};
-
-	for (i = 0; list[i] != -1; i++) {
-		if (sysno == list[i])
-			return 1;
-	}
-
-	return 0;
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.runtime = 40,
+	.options = (struct tst_option []) {
+		{"n:", &str_num_tries, "Number of retries (default: 1000)"},
+		{}
+	},
+};

---
base-commit: bf9589d5bdeef15b3dbb03f896793306552d0d0f
change-id: 20250611-crash02_rewrite-b84ec3d0d22a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
