Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A03CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:11:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2D893CDCE8
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE31C3CDCEC
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:11:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9479460091B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:11:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88F5A1F45F;
 Mon, 25 Sep 2023 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695640283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjhZ6jdtVQ4O37Y2XgCpV+mukFj7F36OlxRxkefoeX4=;
 b=sKJ2haHtCB3LqErKqjcT0whP+Pf2loKbU6q1PnkslfzVtWxspHIJaBi6/ekGgx2bM0rmof
 g+DKp9H5qWoz0tEfJXwEdnOKJEVFBntRIdSnKdGIIDsI9hHma5jGfIrp/r8l+jtEPCkgNx
 JPCfySQzo42AWfRUr/Sps2BoPEjmZlE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D0EC1358F;
 Mon, 25 Sep 2023 11:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0DVRDdpqEWVPOwAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 25 Sep 2023 11:11:22 +0000
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Mon, 25 Sep 2023 07:04:22 -0400
Message-Id: <20230925110422.19167-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230925110422.19167-1-wegao@suse.com>
References: <20230925110422.19167-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] d
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
 testcases/kernel/syscalls/ptrace/ptrace05.c | 147 +++-------
 testcases/kernel/syscalls/ptrace/ptrace06.c | 306 +++++++++++---------
 2 files changed, 214 insertions(+), 239 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 54cfa4d7b..4904b959c 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,122 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- ******************************************************************************
- *
- *   ptrace05 - an app which ptraces itself as per arbitrarily specified signals,
- *   over a user specified range.
- *
- *   Copyright (C) 2009, Ngie Cooper
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
+ * Copyright (C) 2009, Ngie Cooper
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- *   You should have received a copy of the GNU General Public License along
- *   with this program; if not, write to the Free Software Foundation, Inc.,
- *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  ptrace05 - an app which ptraces itself as per arbitrarily specified signals
  *
- ******************************************************************************
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <errno.h>
-#include <libgen.h>
-#include <math.h>
 #include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-
 #include <config.h>
 #include "ptrace.h"
 
-#include "test.h"
 #include "lapi/signal.h"
+#include "tst_test.h"
 
-char *TCID = "ptrace05";
-int TST_TOTAL = 0;
-
-int usage(const char *);
-
-int usage(const char *argv0)
-{
-	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
-	return 1;
-}
-
-int main(int argc, char **argv)
+static void run(void)
 {
 
-	int end_signum = -1;
-	int signum;
-	int start_signum = -1;
+	int end_signum = SIGRTMAX;
+	int signum = 0;
+	int start_signum = 0;
 	int status;
 
 	pid_t child;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	if (start_signum == -1) {
-		start_signum = 0;
-	}
-	if (end_signum == -1) {
-		end_signum = SIGRTMAX;
-	}
-
 	for (signum = start_signum; signum <= end_signum; signum++) {
 
-		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
-			continue;
-
-		switch (child = fork()) {
+		switch (child = SAFE_FORK()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
+			tst_brk(TBROK | TERRNO, "fork() failed");
 		case 0:
 
-			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-				tst_resm(TINFO, "[child] Sending kill(.., %d)",
-					 signum);
-				if (kill(getpid(), signum) < 0) {
-					tst_resm(TINFO | TERRNO,
-						 "[child] kill(.., %d) failed.",
-						 signum);
-				}
+			TEST(ptrace(PTRACE_TRACEME, 0, NULL, NULL));
+			if (TST_RET != -1) {
+				tst_res(TINFO, "[child] Sending kill(.., %d)",
+						signum);
+				SAFE_KILL(getpid(), signum);
 			} else {
-
-				/*
-				 * This won't increment the TST_COUNT var.
-				 * properly, but it'll show up as a failure
-				 * nonetheless.
-				 */
-				tst_resm(TFAIL | TERRNO,
+				tst_brk(TFAIL | TERRNO,
 					 "Failed to ptrace(PTRACE_TRACEME, ...) "
 					 "properly");
-
 			}
-			/* Shouldn't get here if signum == 0. */
-			exit((signum == 0 ? 0 : 2));
+
+			exit(0);
 			break;
 
 		default:
 
-			waitpid(child, &status, 0);
+			SAFE_WAITPID(child, &status, 0);
 
 			switch (signum) {
 			case 0:
 				if (WIFEXITED(status)
 				    && WEXITSTATUS(status) == 0) {
-					tst_resm(TPASS,
+					tst_res(TPASS,
 						 "kill(.., 0) exited "
 						 "with 0, as expected.");
 				} else {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "kill(.., 0) didn't exit "
 						 "with 0.");
 				}
@@ -125,20 +70,20 @@ int main(int argc, char **argv)
 				if (WIFSIGNALED(status)) {
 					/* SIGKILL must be uncatchable. */
 					if (WTERMSIG(status) == SIGKILL) {
-						tst_resm(TPASS,
+						tst_res(TPASS,
 							 "Killed with SIGKILL, "
 							 "as expected.");
 					} else {
-						tst_resm(TPASS,
+						tst_brk(TFAIL | TERRNO,
 							 "Didn't die with "
 							 "SIGKILL (?!) ");
 					}
 				} else if (WIFEXITED(status)) {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "Exited unexpectedly instead "
 						 "of dying with SIGKILL.");
 				} else if (WIFSTOPPED(status)) {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "Stopped instead of dying "
 						 "with SIGKILL.");
 				}
@@ -146,35 +91,21 @@ int main(int argc, char **argv)
 				/* All other processes should be stopped. */
 			default:
 				if (WIFSTOPPED(status)) {
-					tst_resm(TPASS, "Stopped as expected");
+					tst_res(TPASS, "Stopped as expected");
 				} else {
-					tst_resm(TFAIL, "Didn't stop as "
+					tst_brk(TFAIL | TERRNO, "Didn't stop as "
 						 "expected.");
-					if (kill(child, 0)) {
-						tst_resm(TINFO,
-							 "Is still alive!?");
-					} else if (WIFEXITED(status)) {
-						tst_resm(TINFO,
-							 "Exited normally");
-					} else if (WIFSIGNALED(status)) {
-						tst_resm(TINFO,
-							 "Was signaled with "
-							 "signum=%d",
-							 WTERMSIG(status));
-					}
-
 				}
-
 				break;
-
 			}
-
 		}
-		/* Make sure the child dies a quick and painless death ... */
-		kill(child, 9);
 
+		if (signum != 0 && signum != 9)
+			SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);
 	}
-
-	tst_exit();
-
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index c0cb3b9bd..5829faea4 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -1,32 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Copyright (c) 2008 Analog Devices Inc.
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
  * check out-of-bound/unaligned addresses given to
  *  - {PEEK,POKE}{DATA,TEXT,USER}
  *  - {GET,SET}{,FG}REGS
  *  - {GET,SET}SIGINFO
  *
- * Copyright (c) 2008 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later
  */
 
 #define _GNU_SOURCE
 
-#include <errno.h>
-#include <stdbool.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-
 #include <config.h>
-#include "ptrace.h"
 
-#include "test.h"
-#include "spawn_ptrace_child.h"
-#include "config.h"
+#include "ptrace.h"
+#include "tst_test.h"
 
 /* this should be sizeof(struct user), but that info is only found
  * in the kernel asm/user.h which is not exported to userspace.
  */
+
 #if defined(__i386__)
 #define SIZEOF_USER 284
 #elif defined(__x86_64__)
@@ -35,168 +34,213 @@
 #define SIZEOF_USER 0x1000	/* just pick a big number */
 #endif
 
-char *TCID = "ptrace06";
-
 struct test_case_t {
 	int request;
 	long addr;
 	long data;
 } test_cases[] = {
 	{
-	PTRACE_PEEKDATA,.addr = 0}, {
-	PTRACE_PEEKDATA,.addr = 1}, {
-	PTRACE_PEEKDATA,.addr = 2}, {
-	PTRACE_PEEKDATA,.addr = 3}, {
-	PTRACE_PEEKDATA,.addr = -1}, {
-	PTRACE_PEEKDATA,.addr = -2}, {
-	PTRACE_PEEKDATA,.addr = -3}, {
-	PTRACE_PEEKDATA,.addr = -4}, {
-	PTRACE_PEEKTEXT,.addr = 0}, {
-	PTRACE_PEEKTEXT,.addr = 1}, {
-	PTRACE_PEEKTEXT,.addr = 2}, {
-	PTRACE_PEEKTEXT,.addr = 3}, {
-	PTRACE_PEEKTEXT,.addr = -1}, {
-	PTRACE_PEEKTEXT,.addr = -2}, {
-	PTRACE_PEEKTEXT,.addr = -3}, {
-	PTRACE_PEEKTEXT,.addr = -4}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_PEEKUSER,.addr = -1}, {
-	PTRACE_PEEKUSER,.addr = -2}, {
-	PTRACE_PEEKUSER,.addr = -3}, {
-	PTRACE_PEEKUSER,.addr = -4}, {
-	PTRACE_POKEDATA,.addr = 0}, {
-	PTRACE_POKEDATA,.addr = 1}, {
-	PTRACE_POKEDATA,.addr = 2}, {
-	PTRACE_POKEDATA,.addr = 3}, {
-	PTRACE_POKEDATA,.addr = -1}, {
-	PTRACE_POKEDATA,.addr = -2}, {
-	PTRACE_POKEDATA,.addr = -3}, {
-	PTRACE_POKEDATA,.addr = -4}, {
-	PTRACE_POKETEXT,.addr = 0}, {
-	PTRACE_POKETEXT,.addr = 1}, {
-	PTRACE_POKETEXT,.addr = 2}, {
-	PTRACE_POKETEXT,.addr = 3}, {
-	PTRACE_POKETEXT,.addr = -1}, {
-	PTRACE_POKETEXT,.addr = -2}, {
-	PTRACE_POKETEXT,.addr = -3}, {
-	PTRACE_POKETEXT,.addr = -4}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_POKEUSER,.addr = -1}, {
-	PTRACE_POKEUSER,.addr = -2}, {
-	PTRACE_POKEUSER,.addr = -3}, {
-	PTRACE_POKEUSER,.addr = -4},
+	PTRACE_PEEKDATA, .addr = 0}, {
+	PTRACE_PEEKDATA, .addr = 1}, {
+	PTRACE_PEEKDATA, .addr = 2}, {
+	PTRACE_PEEKDATA, .addr = 3}, {
+	PTRACE_PEEKDATA, .addr = -1}, {
+	PTRACE_PEEKDATA, .addr = -2}, {
+	PTRACE_PEEKDATA, .addr = -3}, {
+	PTRACE_PEEKDATA, .addr = -4}, {
+	PTRACE_PEEKTEXT, .addr = 0}, {
+	PTRACE_PEEKTEXT, .addr = 1}, {
+	PTRACE_PEEKTEXT, .addr = 2}, {
+	PTRACE_PEEKTEXT, .addr = 3}, {
+	PTRACE_PEEKTEXT, .addr = -1}, {
+	PTRACE_PEEKTEXT, .addr = -2}, {
+	PTRACE_PEEKTEXT, .addr = -3}, {
+	PTRACE_PEEKTEXT, .addr = -4}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4}, {
+	PTRACE_PEEKUSER, .addr = -1}, {
+	PTRACE_PEEKUSER, .addr = -2}, {
+	PTRACE_PEEKUSER, .addr = -3}, {
+	PTRACE_PEEKUSER, .addr = -4}, {
+	PTRACE_POKEDATA, .addr = 0}, {
+	PTRACE_POKEDATA, .addr = 1}, {
+	PTRACE_POKEDATA, .addr = 2}, {
+	PTRACE_POKEDATA, .addr = 3}, {
+	PTRACE_POKEDATA, .addr = -1}, {
+	PTRACE_POKEDATA, .addr = -2}, {
+	PTRACE_POKEDATA, .addr = -3}, {
+	PTRACE_POKEDATA, .addr = -4}, {
+	PTRACE_POKETEXT, .addr = 0}, {
+	PTRACE_POKETEXT, .addr = 1}, {
+	PTRACE_POKETEXT, .addr = 2}, {
+	PTRACE_POKETEXT, .addr = 3}, {
+	PTRACE_POKETEXT, .addr = -1}, {
+	PTRACE_POKETEXT, .addr = -2}, {
+	PTRACE_POKETEXT, .addr = -3}, {
+	PTRACE_POKETEXT, .addr = -4}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 1}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 2}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 3}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 4}, {
+	PTRACE_POKEUSER, .addr = -1}, {
+	PTRACE_POKEUSER, .addr = -2}, {
+	PTRACE_POKEUSER, .addr = -3}, {
+	PTRACE_POKEUSER, .addr = -4},
 #ifdef PTRACE_GETREGS
 	{
-	PTRACE_GETREGS,.data = 0}, {
-	PTRACE_GETREGS,.data = 1}, {
-	PTRACE_GETREGS,.data = 2}, {
-	PTRACE_GETREGS,.data = 3}, {
-	PTRACE_GETREGS,.data = -1}, {
-	PTRACE_GETREGS,.data = -2}, {
-	PTRACE_GETREGS,.data = -3}, {
-	PTRACE_GETREGS,.data = -4},
+	PTRACE_GETREGS, .data = 0}, {
+	PTRACE_GETREGS, .data = 1}, {
+	PTRACE_GETREGS, .data = 2}, {
+	PTRACE_GETREGS, .data = 3}, {
+	PTRACE_GETREGS, .data = -1}, {
+	PTRACE_GETREGS, .data = -2}, {
+	PTRACE_GETREGS, .data = -3}, {
+	PTRACE_GETREGS, .data = -4},
 #endif
 #ifdef PTRACE_GETFGREGS
 	{
-	PTRACE_GETFGREGS,.data = 0}, {
-	PTRACE_GETFGREGS,.data = 1}, {
-	PTRACE_GETFGREGS,.data = 2}, {
-	PTRACE_GETFGREGS,.data = 3}, {
-	PTRACE_GETFGREGS,.data = -1}, {
-	PTRACE_GETFGREGS,.data = -2}, {
-	PTRACE_GETFGREGS,.data = -3}, {
-	PTRACE_GETFGREGS,.data = -4},
+	PTRACE_GETFGREGS, .data = 0}, {
+	PTRACE_GETFGREGS, .data = 1}, {
+	PTRACE_GETFGREGS, .data = 2}, {
+	PTRACE_GETFGREGS, .data = 3}, {
+	PTRACE_GETFGREGS, .data = -1}, {
+	PTRACE_GETFGREGS, .data = -2}, {
+	PTRACE_GETFGREGS, .data = -3}, {
+	PTRACE_GETFGREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETREGS
 	{
-	PTRACE_SETREGS,.data = 0}, {
-	PTRACE_SETREGS,.data = 1}, {
-	PTRACE_SETREGS,.data = 2}, {
-	PTRACE_SETREGS,.data = 3}, {
-	PTRACE_SETREGS,.data = -1}, {
-	PTRACE_SETREGS,.data = -2}, {
-	PTRACE_SETREGS,.data = -3}, {
-	PTRACE_SETREGS,.data = -4},
+	PTRACE_SETREGS, .data = 0}, {
+	PTRACE_SETREGS, .data = 1}, {
+	PTRACE_SETREGS, .data = 2}, {
+	PTRACE_SETREGS, .data = 3}, {
+	PTRACE_SETREGS, .data = -1}, {
+	PTRACE_SETREGS, .data = -2}, {
+	PTRACE_SETREGS, .data = -3}, {
+	PTRACE_SETREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETFGREGS
 	{
-	PTRACE_SETFGREGS,.data = 0}, {
-	PTRACE_SETFGREGS,.data = 1}, {
-	PTRACE_SETFGREGS,.data = 2}, {
-	PTRACE_SETFGREGS,.data = 3}, {
-	PTRACE_SETFGREGS,.data = -1}, {
-	PTRACE_SETFGREGS,.data = -2}, {
-	PTRACE_SETFGREGS,.data = -3}, {
-	PTRACE_SETFGREGS,.data = -4},
+	PTRACE_SETFGREGS, .data = 0}, {
+	PTRACE_SETFGREGS, .data = 1}, {
+	PTRACE_SETFGREGS, .data = 2}, {
+	PTRACE_SETFGREGS, .data = 3}, {
+	PTRACE_SETFGREGS, .data = -1}, {
+	PTRACE_SETFGREGS, .data = -2}, {
+	PTRACE_SETFGREGS, .data = -3}, {
+	PTRACE_SETFGREGS, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_GETSIGINFO
 	{
-	PTRACE_GETSIGINFO,.data = 0}, {
-	PTRACE_GETSIGINFO,.data = 1}, {
-	PTRACE_GETSIGINFO,.data = 2}, {
-	PTRACE_GETSIGINFO,.data = 3}, {
-	PTRACE_GETSIGINFO,.data = -1}, {
-	PTRACE_GETSIGINFO,.data = -2}, {
-	PTRACE_GETSIGINFO,.data = -3}, {
-	PTRACE_GETSIGINFO,.data = -4},
+	PTRACE_GETSIGINFO, .data = 0}, {
+	PTRACE_GETSIGINFO, .data = 1}, {
+	PTRACE_GETSIGINFO, .data = 2}, {
+	PTRACE_GETSIGINFO, .data = 3}, {
+	PTRACE_GETSIGINFO, .data = -1}, {
+	PTRACE_GETSIGINFO, .data = -2}, {
+	PTRACE_GETSIGINFO, .data = -3}, {
+	PTRACE_GETSIGINFO, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_SETSIGINFO
 	{
-	PTRACE_SETSIGINFO,.data = 0}, {
-	PTRACE_SETSIGINFO,.data = 1}, {
-	PTRACE_SETSIGINFO,.data = 2}, {
-	PTRACE_SETSIGINFO,.data = 3}, {
-	PTRACE_SETSIGINFO,.data = -1}, {
-	PTRACE_SETSIGINFO,.data = -2}, {
-	PTRACE_SETSIGINFO,.data = -3}, {
-	PTRACE_SETSIGINFO,.data = -4},
+	PTRACE_SETSIGINFO, .data = 0}, {
+	PTRACE_SETSIGINFO, .data = 1}, {
+	PTRACE_SETSIGINFO, .data = 2}, {
+	PTRACE_SETSIGINFO, .data = 3}, {
+	PTRACE_SETSIGINFO, .data = -1}, {
+	PTRACE_SETSIGINFO, .data = -2}, {
+	PTRACE_SETSIGINFO, .data = -3}, {
+	PTRACE_SETSIGINFO, .data = -4},
+#endif
+};
+
+#define SPT(x) [PTRACE_##x] = #x,
+static char *strings[] = {
+	SPT(TRACEME)
+	SPT(PEEKTEXT)
+	SPT(PEEKDATA)
+	SPT(PEEKUSER)
+	SPT(POKETEXT)
+	SPT(POKEDATA)
+	SPT(POKEUSER)
+#ifdef PTRACE_GETREGS
+	SPT(GETREGS)
+#endif
+#ifdef PTRACE_SETREGS
+	SPT(SETREGS)
+#endif
+#ifdef PTRACE_GETSIGINFO
+	SPT(GETSIGINFO)
+#endif
+#ifdef PTRACE_SETSIGINFO
+	SPT(SETSIGINFO)
+#endif
+#ifdef PTRACE_GETFGREGS
+	SPT(GETFGREGS)
+#endif
+#ifdef PTRACE_SETFGREGS
+	SPT(SETFGREGS)
 #endif
+	SPT(KILL)
+	SPT(SINGLESTEP)
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+static inline char *strptrace(int request)
+{
+	return strings[request];
+}
+
+static void child(void)
+{
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+	execl("/bin/echo", "/bin/echo", NULL);
+	exit(0);
+}
 
-int main(int argc, char *argv[])
+static void run(void)
 {
 	size_t i;
-	long ret;
-	int saved_errno;
+	int pid;
+	int status;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid = SAFE_FORK();
 
-	make_a_baby(argc, argv);
+	if (!pid)
+		child();
+
+	SAFE_WAIT(&status);
+
+	if (!WIFSTOPPED(status))
+		tst_brk(TBROK, "child %d was not stopped", pid);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
 		struct test_case_t *tc = &test_cases[i];
 
-		errno = 0;
-		ret =
-		    ptrace(tc->request, pid, (void *)tc->addr,
-			   (void *)tc->data);
-		saved_errno = errno;
-		if (ret != -1)
-			tst_resm(TFAIL,
+		TEST(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data));
+		if (TST_RET != -1)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 ret);
-		else if (saved_errno != EIO && saved_errno != EFAULT)
-			tst_resm(TFAIL,
+				 TST_RET);
+		else if (TST_ERR != EIO && TST_ERR != EFAULT)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 saved_errno, strerror(saved_errno));
+				 TST_ERR, strerror(TST_ERR));
 		else
-			tst_resm(TPASS,
+			tst_res(TPASS,
 				 "ptrace(%s, ..., %li, %li) failed as expected",
 				 strptrace(tc->request), tc->addr, tc->data);
 	}
 
-	/* hopefully this worked */
-	ptrace(PTRACE_KILL, pid, NULL, NULL);
+	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);
 
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
