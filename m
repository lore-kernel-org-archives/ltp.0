Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CCCE7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736756256; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kMIbb0+PO11A82zu8NCRQ+rLOeSh1czxQk5ZwUTJyEI=;
 b=rMidX/lwYrg/8UxHlrpK9YiKXdyZzvYKTuiYfJ5mBjNWb21fsnWDQSTVuEWUbJv28QiCy
 uHgQR5KlxjazFodFGoyOEflJPGYRo/IzNP7nXKu9fXQUMkbZr3+W4iWwCal0rM4qhDvzpN7
 2bU4knarv//suNRaWYN7IPqM94NYqBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325B13C770C
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 09:17:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 589D93C770B
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:16:57 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB901235634
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:16:56 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43626213fffso30107335e9.1
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 00:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736756215; x=1737361015; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EKoRJNGsBAUoLGvK2hs25jcWxH0P8D3S8M52/tYMKU=;
 b=DlwzDiRfSsFUkq2St65SN6u6JSXqb8Pl5Di0UKGLBsT/xBMc0jc+Byb6r5BEfytWdY
 rGnyxAM7QqqjHyAtfNW1/JXB+1JoD7Y9SGCaq0QZ9yuR8arvajuGHmWMLSTxA2jH5kCB
 Gad+m+AgEpXJxyw6wPdFM7lGV2IUO2hhNsO/s6Trqs6bNhtjSAI6DYV8gXP3jp4UPX+G
 EQIDoHUk7y4SfyoxdfRRtQr9eMyNc5BSeDC+7isBxd/Svls3m5pEQb/8RIVfaVHat0J1
 P7pDlf0BbhJ/SsnnLaQW3bj+5ytRXq4uF9IE7nMizmBspYjeXdz8wGp1hBdQbwdjxaRY
 ANJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736756215; x=1737361015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EKoRJNGsBAUoLGvK2hs25jcWxH0P8D3S8M52/tYMKU=;
 b=u+RKvTAaS9U7zCiunQD3NgrdcFjHk5lH21nF/9oyhXOvfiPIXFlMiBIvjYVlQH3oP3
 BKIhNOGF3KmEGqiAf08XMqM3RAt31i+cYtKJdQiJFchQxIN4H1NLKU5xnhDNv2S+50xl
 U4gUv+KixKsOl2y+so/OKFdWP3Vh5zce7AxSKzktKdzhNZ5MgnNEl5yh5ODkXH/tgDrZ
 4GQRQrtQyl4zj0R5crtXFk8dfnEh6vZgndchAUYjQkHpb1Hgt4DgbFYJCszwXSb4LL3B
 jodaWeMF+VYLwTYZK5KzIc5pr+nKJZ/uaThNyUlVJvehaZPcODGy0I1gfyaUb6NupZ6r
 UfnA==
X-Gm-Message-State: AOJu0YwY5+2ZQlwPZv3q+6Pd1Gq4kTPEEbUBSQkYgbFuL4gyvmIquI+B
 E4nHQJf9oOMP6z57gV1Uor57iwix4rwGxa3FRtFZ7wzMLRT/rkmyZcY4ljITAh8229zL4f3oE16
 18g==
X-Gm-Gg: ASbGnctR5LV/9J8qmoxsROhLVzH2jIAQwmWcvtrLsBZzSAy1q7DL0vLvlyKvpseYQKK
 uSElavci7MWjVfZmYucj4a8cbJBERqoyFpro5kaFMpczo7GTc4uMdaAw75iydX4AmWMJuHID9wu
 cXz0YJwTj/W98t+r3JjHs7Wct8iLbktC2dDn6mvbey81ZjG1s8qfYMmZvcjH0dm9FOKRndHR1eD
 LEXWi/j2b/yROkMQarjwj59TVdTc5Jx20JvNkM3/0c0Qg==
X-Google-Smtp-Source: AGHT+IE734UbCxolrFjComDaDTQC/QwB11oIL6npuwquuUUtwIp1Ftgc89pw1qzGQ4KDbDIEXYQTbg==
X-Received: by 2002:a05:600c:1d02:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-436e9d6ff89mr112950825e9.5.1736756215389; 
 Mon, 13 Jan 2025 00:16:55 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436f04df606sm102833535e9.12.2025.01.13.00.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 00:16:55 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 13 Jan 2025 03:16:21 -0500
Message-Id: <20250113081622.28942-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250113081622.28942-1-wegao@suse.com>
References: <20241217061636.16366-1-wegao@suse.com>
 <20250113081622.28942-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] ptrace05: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace05.c | 223 ++++++--------------
 1 file changed, 70 insertions(+), 153 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..160dfe651 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,95 @@
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
+	if (strstr(strsig, "???"))
+		tst_res(TDEBUG, "[child] Sending kill(.., %d)", signum);
+	else
+		tst_res(TDEBUG, "[child] Sending kill(.., %s)", strsig);
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
