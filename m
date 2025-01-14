Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75557E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736865193; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+SEVA4l1I2gLYVU31z6/zcbpREjgAAbVKHKVsswVKEA=;
 b=i3rwgoR73fqw7jDyMthbiUeZnMONEjdrinDv6X9CgEWXlriaObFfCI0+meaiOhxkWulxU
 Q+WM5VC4BeF4JH0rvz8KTKE7FyxDct2xPoZX/k5kXIe1uLoM/zJo1n/6nFNSVJ5BOTKQG5u
 xwtnG29agJ9OKBEY82eQk58M8K+HHdE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC7083C7B07
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:33:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1213C7AEB
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:32:33 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F30A911F5F37
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:32:32 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso40017675e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 06:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736865152; x=1737469952; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZ2k++PQ0jgh9OAnDJgyXaaMe2bH7uxOZOcrXCmtmZY=;
 b=gxY+iejLc8cx6GQMuszP4LD0mWIMehySzex+/nOQBbqQm3KmywMKXa+a4FqdqqiTdZ
 NT7Brie5dkcugs+8g6J8VKyEPsGetkeWpolP3MjhQIPlFY9i5EHcTOmvx7OvJi8fk+zl
 un2JAPtUALlSuVp3PQk2bnqfJsnqKEhQPO0zXicIn6/GSUTk/wy2rXZ5JtvdRxrGQGaL
 2H2LLqFdZG2qk/QN92e1PT/lFDy5My9qLXjQ5+UFjhtWCg17qVJx62Gzc9bDO+ncAJwa
 w3EdHEmpu/Kji8Rptg07vWAcNZogdZjvwr22GfVi5k+g/DRIJftoujXhZIqLDRaxxnDO
 NHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865152; x=1737469952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZ2k++PQ0jgh9OAnDJgyXaaMe2bH7uxOZOcrXCmtmZY=;
 b=YLpjwRdiI4fY43O8udzDis/aIrikh27xv1at70MH2h49pM3nEb6xWtlamIeCQnSrQE
 ILqZ19f6dZyGtTFy7DMlFkxH8ETxlTEn/U0EqWqO+5PND4s7TlmPNYNU9IBDy4kRXRZw
 4FctMxI0V2lI4B6wHzG4rJUufLE1dm3xCSAtZEPuCoLaOCtgwp/4yAUuRy4Cdj9do52i
 tZThbRuuaEEy2RWzFJ250cGNWUQvc+DVpVhf8CAk6V+lvQ9T1aWZGWF8TkLLGcrqEU+z
 aKA8RUMy8A/z3F0P4zmvuDMbgdj3Hpsr82mseFVETMcGt46Xdn6jWouHNd3i4J7ibyxX
 8SCA==
X-Gm-Message-State: AOJu0YxKWR4xv7hdnr2Fq92CXZvjBXxNRmcElpx+i4Sf20CLHQ/dxY67
 1/5ITS1LaxTmYKceS/VpxDt05jxf+6SMrz15eoLCqetCu7oGj4lF+5SlgQW16h/HWS06Qnt0WVA
 =
X-Gm-Gg: ASbGncuf6xrTHNTaYLPk1Ga2SjBuO+4++DCt2xTaUaj/rbAzWCS0hA0Tgkgug3XjeUl
 RsDQAdMaK/b5xOqaOAjHqqlWUQYwT9ZuFs2ecFzsg++CWKoaSwvxvZsOLHdpTSvzxUCs2faoysr
 T3dfLhEv7QB18qevtcYDc4aOEsnT/JTQ7tHzv7Tivk4AUaT/OaFUFW8pmDnjfIsf/Z4k85tdPvQ
 YgZtI+GN6J9lKq0HinOkqr+3tIBvRCSSu6ShRy6LC4Y8Q==
X-Google-Smtp-Source: AGHT+IFL+ac3T01/4tAcQgqkO+3tJF+ZbLV1oYth9dHzceawhdejNvp+s0TFAFZgxA5RNPuDM4jbEA==
X-Received: by 2002:a05:600c:5486:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-436e2696d20mr3625905e9.9.1736865152157; 
 Tue, 14 Jan 2025 06:32:32 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0bb7sm209387135e9.16.2025.01.14.06.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 06:32:31 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 09:32:16 -0500
Message-Id: <20250114143217.21018-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250114143217.21018-1-wegao@suse.com>
References: <20250114124023.4702-1-wegao@suse.com>
 <20250114143217.21018-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] ptrace05: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace05.c | 218 ++++++--------------
 1 file changed, 62 insertions(+), 156 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..276faa77b 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,84 @@
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
+static void test_signal(int signum)
 {
-	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
-	return 1;
-}
-
-int main(int argc, char **argv)
-{
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
+		tst_res(TDEBUG, "[child] Sending kill(.., %s)", tst_strsig(signum));
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
