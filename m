Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70CFC25B76
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717411012; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5/qU2FzrqPBaRtHArKeE7SUHA1mvY76izCW/ODUkYC0=;
 b=RYcs1WzaIAgmOkXT1ikZg1fEeULdE4I6m+P64t7+0TFELy0Mqj8hRiFTCV+MnahsCXcgT
 31GHVNkFkNk8hiBjnq7DhIM0t6bTvguiADfpid+sTgWKfwSL4yQaETeujziIiVHHfjCMZzC
 h0EbAB1ny5sbs/hAH0sow+Cuo170++g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 427B13D08E7
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:36:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B0ED3D08D0
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:16 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E483100126A
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:15 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eaa794eb9fso20775941fa.2
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717410974; x=1718015774; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdgDwgylJwfk4x3jafz3408ZhIuZycTJPgNfNwlQTSI=;
 b=aYVF5maGBRue6/gj0P/tnkSGJKd4ChbIoSYr2vaTy3yb7oHImiv7I1CvRFPtpgdSyR
 8jbLKvKeKZOdvAKAcWDt1IXsMGgbCxu/vBKmpVHkhC7meWfjj2HVIQOiVjfK6PjO3cub
 s2DacD+GFlbHr1+REwfIjXFaM9hIs4K3wi8WCB0yJD3Og4uRH6F4TpItiBlBXQ++GNGz
 zh7NmAc3EJJE/C32qTQ4zMenhOB11AWAA98wv/VBQf5r3vlZGeXgFCnu0ciAF3UVex1L
 bFOBbhjk0Gmf2byVJq5oZXAdB4dae0puvdgL4UT1HddcUP+uOPemFBKB6FyZkz1buOXR
 1OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717410974; x=1718015774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdgDwgylJwfk4x3jafz3408ZhIuZycTJPgNfNwlQTSI=;
 b=g9XWa7KVULz9cdU2ZPfnQL9tTexgXSBGixaUqzsb28wTURxi4zAB1qowdxcyRGbUZo
 Q2HI4PY89UVza0hc39OHl7SJyUa3yGITVvbR+rJp+W2Vju3vfkDk7I8ycDh8Gtw5O/Mh
 o9SLp2TAb11IZs9YctYHfXSG2xsMg2zsEb3+KTP/lkakBE3+xuEgeb+UAoV2dIOXQ84U
 pwvnbChYUJBth+s+628yt4w0s/Y7lNzEoRS+dwJleUBrm/IoW9D2s5BnFKmIWYazQzU/
 iJAC1N8UFbJSwgtcsq2Nfzse6YVhInkLTeWhiiRGSaImE94R81GPfuzJgBCGl/agJesW
 lScA==
X-Gm-Message-State: AOJu0Yw1lrkqGKG7XgZwtD972TjsIK+vvSSB1rkE7pM/X91zsCX2cyGq
 qtr9Cd8uuSgn4W8Q2ESOQlz85Bv9yGkxPFdEhrBnXazyS0/rCyGUjvdEBn450g8h5IYvjffsKvk
 =
X-Google-Smtp-Source: AGHT+IFSe30Vy3Tdes83oAOaC/22vWSG4H7ZszAWRrtpOhkmcTd5jRnpD+JbiGu3/yP9UENTqNxJxg==
X-Received: by 2002:a2e:870d:0:b0:2e9:8a16:fe31 with SMTP id
 38308e7fff4ca-2ea950aee36mr64560801fa.2.1717410974225; 
 Mon, 03 Jun 2024 03:36:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35937a4c5sm4253262a12.68.2024.06.03.03.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 03:36:13 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 06:35:52 -0400
Message-Id: <20240603103553.8318-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240603103553.8318-1-wegao@suse.com>
References: <20231201005902.15630-1-wegao@suse.com>
 <20240603103553.8318-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] ptrace05: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/ptrace/ptrace05.c | 215 ++++++--------------
 1 file changed, 67 insertions(+), 148 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..33432f186 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,97 @@
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
-
-	int end_signum = -1;
-	int signum;
-	int start_signum = -1;
+	int signum = 0;
 	int status;
-
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
-	for (signum = start_signum; signum <= end_signum; signum++) {
-
+	for (signum = 0; signum <= SIGRTMAX; signum++) {
 		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
 			continue;
 
-		switch (child = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-		case 0:
+		child = SAFE_FORK();
 
-			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-				tst_resm(TINFO, "[child] Sending kill(.., %d)",
-					 signum);
-				if (kill(getpid(), signum) < 0) {
-					tst_resm(TINFO | TERRNO,
-						 "[child] kill(.., %d) failed.",
-						 signum);
-				}
+		if (child == 0) {
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
-					 "Failed to ptrace(PTRACE_TRACEME, ...) "
-					 "properly");
-
+				tst_brk(TFAIL | TERRNO,
+						"Failed to ptrace(PTRACE_TRACEME, ...) "
+						"properly");
 			}
+
 			/* Shouldn't get here if signum == 0. */
 			exit((signum == 0 ? 0 : 2));
-			break;
-
-		default:
+		}
 
-			waitpid(child, &status, 0);
+		SAFE_WAITPID(child, &status, 0);
 
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
+		switch (signum) {
+		case 0:
+			if (WIFEXITED(status)
+					&& WEXITSTATUS(status) == 0) {
+				tst_res(TPASS,
+						"kill(.., 0) exited with 0, as expected.");
+			} else {
+				tst_brk(TFAIL | TERRNO,
+						"kill(.., 0) didn't exit with 0.");
+			}
+			break;
+		case SIGKILL:
+			if (WIFSIGNALED(status)) {
+				/* SIGKILL must be uncatchable. */
+				if (WTERMSIG(status) == SIGKILL) {
+					tst_res(TPASS,
+							"Killed with SIGKILL, as expected.");
 				} else {
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
+					tst_brk(TFAIL | TERRNO,
+							"Didn't die with SIGKILL (?!) ");
 				}
-
-				break;
-
+			} else if (WIFEXITED(status)) {
+				tst_res(TFAIL | TERRNO,
+						"Exited unexpectedly instead of dying with SIGKILL.");
+			} else if (WIFSTOPPED(status)) {
+				tst_res(TFAIL | TERRNO,
+						"Stopped instead of dying with SIGKILL.");
 			}
-
+			break;
+			/* All other processes should be stopped. */
+		default:
+			if (WIFSTOPPED(status))
+				tst_res(TPASS, "Stopped as expected");
+			else
+				tst_res(TFAIL | TERRNO, "Didn't stop as expected.");
+			break;
 		}
-		/* Make sure the child dies a quick and painless death ... */
-		kill(child, 9);
 
+		if (signum != 0 && signum != SIGKILL)
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
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
