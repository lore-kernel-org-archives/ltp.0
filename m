Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1766E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736858477; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bu5UUsD7q/6InzMzMwHEAr6qHFW2qT2WKSFzSiENF4o=;
 b=gnOgsSSobboEpoD4XWY6kcmc1jkh+jCGJOvea8YnDSv2ixfFK/L6+0XPRW1Os2B+sQl6M
 277Bmg34xzKsI1UHzdwHTJhAyNQK+UNseY/Z1xTC3VoMYSJmEJh8ESMZG6w0ECI9NLZhDiE
 BujvB0ygU817VrqGPoDR8sCEaQB8rAs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 374003C7A2E
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 13:41:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338473C7A46
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:40:41 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 940C71436EDF
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:40:40 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso38125505e9.3
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736858440; x=1737463240; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+//mdtstPt7S6RpNsLfi13YSgJ7RDva+wbVHQ2dEvtc=;
 b=PnEHdnKFwcMlSc3wsZg1M0sfAkvgIkx+f85ex9FhjIkph1jSqzcnQCTAuAUlc+CnC3
 RIxL7LXoYOP+Gi+PDVhDlyqeU31yIin3JhtFbE1FQT/PAIHcJMuZFPnWY+lLTUnuYzPj
 Llnyd9X3plFsuwADDdA24znjvUoCMTEdBK4kuRGXpuJGmEBKiJGXhwgCZoVmkAmuQX14
 q6LLwHzBzA6lFwFwMHsUvosfuhr0TxY2wt9sn/Zzj5Wem7Sf+FEoihfEKCACwNOwS4jC
 YI+iSqLLkqKSghxFm4n78UV8km9GN3yqz1jWNrtNzOg0wHUNxu/KE98qvJqx3x+FZxF7
 Uhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736858440; x=1737463240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+//mdtstPt7S6RpNsLfi13YSgJ7RDva+wbVHQ2dEvtc=;
 b=gqD0eJgRcGeg6KQNF3uoFsrf2m7TodC+HuVgaSTlcYGVmH26C+4JopVUDdvICYVhyS
 0DPzOkmOWVsAj400Pw87gpCgfnfpscdXMRDrhY77s/HGUpQXEduGZRr9KLo/Jca5TqpV
 mIMzqNgd9jHZCYTM79EpVcI3QhIu85Ejf+NWmyXMmzltVUkvxrPetJdCWLuyF/cQMNk4
 78Z+EN7yrUd6Q/Cbskq6+qdi+VXTte1w9ynZlZtGCnPkt7fnTiycElyVyEX1Nz+TRida
 9QggegZ73SKwXXqBGza03fu+/y1DO0W0DNiVgNxbrnqLmEFGQkVOroip5fvbGpEk3nuj
 6jpQ==
X-Gm-Message-State: AOJu0Yz4PjSBEzbgHD6YFEk2bPjKamYCd/odFIZB3YzBDNi6ZY3M8dBO
 M0A53hFLi3jcYewJMQFdZ3dpjWotrYSNQMeJ2l/QCzFg5DIEkSVhX3Ck8Gpfud2eGhFIbmjdyZQ
 =
X-Gm-Gg: ASbGncvbr+uyzKeWOHltSp46iKnVQNCqnYaxu9CkAXZ/BIFb7HwQroNQ2d1ipbgGBxc
 jwii1JceDUzWjAL7y1P8QMCn7eK+0shSZCIl6FbNXRe+bOQrSnrlKm2igsiHrMlBn0rdnH9GqEP
 75LerZDFNmScqC3t1ydx0oZLoY/d/gkYM9qEcppLHmcn/oKbugUqiD8aPGpU1YwveUWANefFziA
 GwADh+taXCwh/KfyxUbDYivmYVLTKEMhn0tj/AIHb3SSg==
X-Google-Smtp-Source: AGHT+IHTAC8K8PmKF7Z5Mvk4j/9CJJbjtcC+C6rgQA6gWkBC+LJxQboVPCxr3MphlhEAIQ3D0LfpaA==
X-Received: by 2002:a05:600c:35c1:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-436e26efb22mr198148725e9.26.1736858439749; 
 Tue, 14 Jan 2025 04:40:39 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9df958dsm173123765e9.17.2025.01.14.04.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 04:40:39 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 07:40:22 -0500
Message-Id: <20250114124023.4702-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250114124023.4702-1-wegao@suse.com>
References: <20250113081622.28942-1-wegao@suse.com>
 <20250114124023.4702-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] ptrace05: Refactor the test using new LTP API
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 220 ++++++--------------
 1 file changed, 67 insertions(+), 153 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..431c5a9d2 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,92 @@
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
- *
- *   You should have received a copy of the GNU General Public License along
- *   with this program; if not, write to the Free Software Foundation, Inc.,
- *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Copyright (c) Linux Test Project, 2009-2019
+ * Copyright (C) 2009, Ngie Cooper
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- ******************************************************************************
+ * This test ptraces itself as per arbitrarily specified signals,
+ * over 0 to SIGRTMAX range.
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
-
-int usage(const char *);
+static int expect_stop;
 
-int usage(const char *argv0)
+static void print_dbg_sig(int signum)
 {
-	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
-	return 1;
+	char const *strsig = tst_strsig(signum);
+
+	tst_res(TDEBUG, "[child] Sending kill(.., %s)", strsig);
 }
 
-int main(int argc, char **argv)
+static void test_signal(int signum)
 {
-
-	int end_signum = -1;
-	int signum;
-	int start_signum = -1;
 	int status;
-
 	pid_t child;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	child = SAFE_FORK();
 
-	if (start_signum == -1) {
-		start_signum = 0;
+	if (!child) {
+		TST_EXP_PASS_SILENT(ptrace(PTRACE_TRACEME, 0, NULL, NULL));
+
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
+		if (WIFSTOPPED(status)) {
+			tst_res(TDEBUG, "Stopped as expected");
+		} else {
+			tst_res(TFAIL, "Didn't stop as expected. Child %s", tst_strstatus(status));
+			expect_stop++;
+		}
+		break;
 	}
 
-	for (signum = start_signum; signum <= end_signum; signum++) {
+	if (signum != 0 && signum != SIGKILL)
+		SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);
+}
 
+static void run(void)
+{
+	int signum = 0;
+
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
-
-	tst_exit();
-
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
