Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5590E7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734416252; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QWVko+ozTj6JrJPV/TEGurltLMLAnYc44dE60pRpvjs=;
 b=k6mv8zX9+8Uf1Em+V6pObKjDzsDXUGtufc3hvGqjsRF8zZxwzT5XOv3PMwzmgK5ThsMEA
 Gm5thx5qfRwrgFuPTXe0EET+Ne06dgjJLxJfbAt3LBU3DH1qMj+mXbESMT0mKFhNYRKAt+W
 8Op8+cU4eSTJeB/eTUGaRWk9CMwumew=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35483E29AF
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 07:17:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C96023E29B1
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:16:54 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 448761BD108C
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 07:16:54 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso8220541a12.0
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 22:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734416213; x=1735021013; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN0Xhe8n8fCyZtS+jfFPFgaUmrpsROB6BrnCXpjJsxM=;
 b=OQGjeAy3JbUS6V5Cl/VtrFsYQGa0+woi0ZE6vcNkReYAKEfnOnCHWafLRxa6eyD1hX
 nsmhfisBLWL1C6rNm5ItyctMQsoc/TsQzXyP7At9Q4d6DfBhJHaZKiiWJk9nhxORgwbE
 JNIFcecuBEXcy2f+N1HYPQ8p3cISc1ksxVO81USWOdRNrUjjwSmP67LKlDejYLYGKOKW
 ZCbghJlxCfrki/fWjVa29VWz560xYB9Eg9YneJ0LttekwuM2oS+8A++IhmzYQpWEmdgz
 rISTDml3B6S1hgbu5LaxqJdQYVzgkdl3hU799Hj5D8MZ22VQAhvhfaieAtedMRBDnN3n
 2/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416213; x=1735021013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sN0Xhe8n8fCyZtS+jfFPFgaUmrpsROB6BrnCXpjJsxM=;
 b=uGxoDibhZiY3xsL8aMr3x3JDJ5DgtJK0VlUv4/FM2DMIXUDCLx4Q6WrZdQ6hPYHW+f
 tC0cuwZe/VyRrezBZ9GRjKcEGO0APVh/LsfLw9AdP5oglMLWaWjvBWUtTmBOPJWsTjCI
 tT4l6f1LV+yWiumHyuJtO5KUZlAc5KmOlGnoljv9h62TX+4Md7mCaacm5ZLaQNxUIQh1
 StVG4Rw6iKEDO8Tw27QPtZtqao2X7Ubq6+Nvy2DmM5fxcI5q+ECRwiTYundx9NWpx8XX
 M9cmDlu2RrhiyVEeLQUsQhi/GeMykpEIgAhyk2lB+M6yaGfci+VK/R0VlrhCjeNs/rFK
 Q/Nw==
X-Gm-Message-State: AOJu0Yx5RqM5yBZT24w/Hj43XOpSsAcSJHwWew/5wZsYO7kUU4fZw3qe
 u607QlDrgtZSSsRMQ/jTXw4rQn/JVpNH1mJdOf8fx3k0+lgrHTHzgVDdt59QpOiGSqqOfCyrCE0
 =
X-Gm-Gg: ASbGnctAq2q2JmXV9Bl9pGUjcx4HG7lKPh5oPFw8O9DQi6CbyacaOx0j/ptTuQRHBub
 1UJWrsKJlSagfvmyXRwoW1WYQ+Eo5ThuIHoRBpoVcw5beFcBRcD8f+6W4fj6KpP20FDf6bEjiEK
 oRK9H1DG+YDWNfC8EZZzsdYM2+ZqI6EdW2E87tm7rgq7n5Z6RhWu1ba/5rLGdfV0eQWa/6s9ZQQ
 TVZUBHAzxSuKXNIvIz9dciUXy2yE1Zk2ZM4ZVN/GoZNjQ==
X-Google-Smtp-Source: AGHT+IELwUYDH3YZPO8bnWG8+teSk7k26Ym2cXMWtbN+wt9rF1rwtomEhcGE2NMcm+9yoMXivi2uKw==
X-Received: by 2002:a17:907:7da8:b0:aa6:912f:7ec1 with SMTP id
 a640c23a62f3a-aab77e9e80emr1600819266b.39.1734416213046; 
 Mon, 16 Dec 2024 22:16:53 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9606b540sm405249766b.80.2024.12.16.22.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:16:52 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 01:16:35 -0500
Message-Id: <20241217061636.16366-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217061636.16366-1-wegao@suse.com>
References: <20240603103553.8318-1-wegao@suse.com>
 <20241217061636.16366-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] ptrace05: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace05.c | 228 +++++++-------------
 1 file changed, 78 insertions(+), 150 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..90c167ab3 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * Copyright (c) Linux Test Project, 2009-2019
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
+ * This test ptraces itself as per arbitrarily specified signals,
+ * over 0 to SIGRTMAX range.
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
 #include <sys/ptrace.h>
-
-#include "test.h"
 #include "lapi/signal.h"
+#include "tst_test.h"
 
-char *TCID = "ptrace05";
-int TST_TOTAL = 0;
+static int expect_stop;
 
-int usage(const char *);
-
-int usage(const char *argv0)
+static void print_dbg_sig(int signum)
 {
-	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
-	return 1;
+
+	char const *strsig = tst_strsig(signum);
+
+	if (strstr(strsig, "???")) {
+		tst_res(TDEBUG, "[child] Sending kill(.., %d)",
+				signum);
+	} else {
+		tst_res(TDEBUG, "[child] Sending kill(.., %s)",
+				strsig);
+	}
 }
 
-int main(int argc, char **argv)
+static void test_signal(int signum)
 {
 
-	int end_signum = -1;
-	int signum;
-	int start_signum = -1;
 	int status;
-
 	pid_t child;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	child = SAFE_FORK();
+
+	if (!child) {
+		TST_EXP_PASS_SILENT(ptrace(PTRACE_TRACEME, 0, NULL, NULL));
 
-	if (start_signum == -1) {
-		start_signum = 0;
+		print_dbg_sig(signum);
+		SAFE_KILL(getpid(), signum);
+		exit(0);
 	}
-	if (end_signum == -1) {
-		end_signum = SIGRTMAX;
+
+	SAFE_WAITPID(child, &status, 0);
+
+	switch (signum) {
+	case 0:
+		if (WIFEXITED(status)
+				&& WEXITSTATUS(status) == 0) {
+			tst_res(TPASS,
+					"kill(.., 0) exited with 0, as expected.");
+		} else {
+			tst_res(TFAIL,
+					"kill(.., 0) exited with unexpected %s.", tst_strstatus(status));
+		}
+		break;
+	case SIGKILL:
+		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
+			tst_res(TPASS, "Child killed by SIGKILL");
+		else
+			tst_res(TFAIL, "Child %s", tst_strstatus(status));
+		break;
+		/* All other processes should be stopped. */
+	default:
+		if (WIFSTOPPED(status))
+			tst_res(TDEBUG, "Stopped as expected");
+		else {
+			tst_res(TFAIL, "Didn't stop as expected. Child %s", tst_strstatus(status));
+			expect_stop++;
+		}
+		break;
 	}
 
-	for (signum = start_signum; signum <= end_signum; signum++) {
+	if (signum != 0 && signum != SIGKILL)
+		SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);
+}
+
+static void run(void)
+{
+	int signum = 0;
 
+	for (signum = 0; signum <= SIGRTMAX; signum++) {
 		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
 			continue;
-
-		switch (child = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-		case 0:
-
-			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-				tst_resm(TINFO, "[child] Sending kill(.., %d)",
-					 signum);
-				if (kill(getpid(), signum) < 0) {
-					tst_resm(TINFO | TERRNO,
-						 "[child] kill(.., %d) failed.",
-						 signum);
-				}
-			} else {
-
-				/*
-				 * This won't increment the TST_COUNT var.
-				 * properly, but it'll show up as a failure
-				 * nonetheless.
-				 */
-				tst_resm(TFAIL | TERRNO,
-					 "Failed to ptrace(PTRACE_TRACEME, ...) "
-					 "properly");
-
-			}
-			/* Shouldn't get here if signum == 0. */
-			exit((signum == 0 ? 0 : 2));
-			break;
-
-		default:
-
-			waitpid(child, &status, 0);
-
-			switch (signum) {
-			case 0:
-				if (WIFEXITED(status)
-				    && WEXITSTATUS(status) == 0) {
-					tst_resm(TPASS,
-						 "kill(.., 0) exited "
-						 "with 0, as expected.");
-				} else {
-					tst_resm(TFAIL,
-						 "kill(.., 0) didn't exit "
-						 "with 0.");
-				}
-				break;
-			case SIGKILL:
-				if (WIFSIGNALED(status)) {
-					/* SIGKILL must be uncatchable. */
-					if (WTERMSIG(status) == SIGKILL) {
-						tst_resm(TPASS,
-							 "Killed with SIGKILL, "
-							 "as expected.");
-					} else {
-						tst_resm(TPASS,
-							 "Didn't die with "
-							 "SIGKILL (?!) ");
-					}
-				} else if (WIFEXITED(status)) {
-					tst_resm(TFAIL,
-						 "Exited unexpectedly instead "
-						 "of dying with SIGKILL.");
-				} else if (WIFSTOPPED(status)) {
-					tst_resm(TFAIL,
-						 "Stopped instead of dying "
-						 "with SIGKILL.");
-				}
-				break;
-				/* All other processes should be stopped. */
-			default:
-				if (WIFSTOPPED(status)) {
-					tst_resm(TPASS, "Stopped as expected");
-				} else {
-					tst_resm(TFAIL, "Didn't stop as "
-						 "expected.");
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
-				}
-
-				break;
-
-			}
-
-		}
-		/* Make sure the child dies a quick and painless death ... */
-		kill(child, 9);
-
+		test_signal(signum);
 	}
 
-	tst_exit();
-
+	if (expect_stop == 0)
+		tst_res(TPASS, "Stopped as expected");
+	else
+		tst_res(TFAIL, "Didn't stop as expected, total %d cases failed", expect_stop);
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
