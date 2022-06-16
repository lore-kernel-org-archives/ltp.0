Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BD7C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 13:47:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F002E3C60BC
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 15:47:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 900D63C0277
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:47:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 814AF1000F4F
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:47:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D35C1F7AB
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655387230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B3H8+9MiOIVHCAe1c9esZ1xj3ugCO/UezNhC9qr0Gjg=;
 b=V8pIBZGblKN6WKV2GUOMBeFR1v6Nsc+biHtQy2UBKFSXgcGVVkohB5fI5y4Cx38UdpbEaD
 LXz7Q+tqbqkmNbDx4yEcEulbcPofm/+Z7rQD3F4Ps9Ym+F/Mrh1j63lp9uEknmNkB5cu4m
 Baj/22V7T+4DvgYQ28ze/FlTHCe3w54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655387230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B3H8+9MiOIVHCAe1c9esZ1xj3ugCO/UezNhC9qr0Gjg=;
 b=A9fl3xAHrdjlZ+Y2JMoaO4Nr8NfoKQwB408fJmivU141e6wIY9GGiOXth0RKNVog7cEzgi
 iwDjFCvebwEMdHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85C6E13A70
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 13:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tfWfH140q2LiHwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 13:47:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 15:49:19 +0200
Message-Id: <20220616134919.8248-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fork13: Rewrite to new API + add .max_runtime
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

This fixes a problem we had for years, the test can run for more than
half an hour on slow systems and it used to timeout quite often.

This commit introduces a max_runtime with a 10 minute limit which is
more than enough for the test to complete on a modern hardware but at
the same time it limits the runtime to a sensible value on older
hardware and embedded.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 README.md                               |   2 +-
 runtest/syscalls                        |   2 +-
 testcases/kernel/syscalls/fork/fork13.c | 168 ++++++++++--------------
 3 files changed, 71 insertions(+), 101 deletions(-)

diff --git a/README.md b/README.md
index 7764eb81a..3a0fd7f96 100644
--- a/README.md
+++ b/README.md
@@ -150,7 +150,7 @@ $ testcases/bin/abort01
 Some have arguments
 
 ```
-$ testcases/bin/fork13 -i 37
+$ testcases/bin/mesgq\_nstest -m none
 ```
 
 The vast majority of test cases accept the -h (help) switch
diff --git a/runtest/syscalls b/runtest/syscalls
index 88c31db06..36fc50aeb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -372,7 +372,7 @@ fork08 fork08
 fork09 fork09
 fork10 fork10
 fork11 fork11
-fork13 fork13 -i 1000000
+fork13 fork13
 fork14 fork14
 
 fpathconf01 fpathconf01
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 583c8bd4d..1714beff3 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -1,5 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * a race in pid generation that causes pids to be reused immediately
+ * Copyright (C) 2010  Red Hat, Inc.
+ * Copyright (C) 2022 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * A race in pid generation that causes pids to be reused immediately
  *
  * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
  *
@@ -9,6 +17,7 @@
  * implementation.  Furthermore, many shell scripts assume that pid
  * numbers will not be used for some length of time.
  *
+ * ---------------------------------------------------------------------
  * Race Description:
  *
  * A                                B
@@ -23,27 +32,7 @@
  *                                  // Next fork()...
  *                                  last = pid_ns->last_pid; // == n
  *                                  pid = last + 1;
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * ---------------------------------------------------------------------
  */
 
 #include <sys/types.h>
@@ -54,101 +43,82 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include "test.h"
-
-char *TCID = "fork13";
-int TST_TOTAL = 1;
 
-static unsigned long pid_max;
+#include "tst_test.h"
 
-#define PID_MAX_PATH "/proc/sys/kernel/pid_max"
 #define PID_MAX 32768
+#define PID_MAX_STR "32768"
 #define RETURN 256
+#define MAX_ITERATIONS 1000000
 
-static void setup(void);
-static int pid_distance(pid_t first, pid_t second);
-static void cleanup(void);
-static void check(void);
-
-int main(int argc, char *argv[])
+/* The distance mod PIDMAX between two pids, where the first pid is
+   expected to be smaller than the second. */
+static int pid_distance(pid_t first, pid_t second)
 {
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
-	check();
-	cleanup();
-	tst_exit();
+	return (second + PID_MAX - first) % PID_MAX;
 }
 
 static void check(void)
 {
-	long lc;
-	pid_t last_pid = 0;
+	pid_t prev_pid = 0;
 	pid_t pid;
-	int child_exit_code, distance, reaped, status;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		child_exit_code = lc % RETURN;
-		switch (pid = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		case 0:
-			exit(child_exit_code);
-		default:
-			if (lc > 0) {
-				distance = pid_distance(last_pid, pid);
-				if (distance == 0) {
-					tst_resm(TFAIL,
-						 "Unexpected pid sequence: "
-						 "previous fork: pid=%d, "
-						 "current fork: pid=%d for "
-						 "iteration=%ld.", last_pid,
-						 pid, lc);
-					return;
-				}
-			}
-			last_pid = pid;
-
-			reaped = waitpid(pid, &status, 0);
-			if (reaped != pid) {
-				tst_resm(TFAIL,
-					 "Wait return value: expected pid=%d, "
-					 "got %d, iteration %ld.", pid, reaped,
-					 lc);
-				return;
-			} else if (WEXITSTATUS(status) != child_exit_code) {
-				tst_resm(TFAIL, "Unexpected exit status %x, "
-					 "iteration %ld.", WEXITSTATUS(status),
-					 lc);
+	int i, distance, reaped, status, retval;
+
+	for (i = 0; i < MAX_ITERATIONS; i++) {
+		retval = i % RETURN;
+
+		pid = SAFE_FORK();
+		if (!pid)
+			exit(retval);
+
+		if (prev_pid) {
+			distance = pid_distance(prev_pid, pid);
+			if (distance == 0) {
+				tst_res(TFAIL,
+					"Unexpected pid sequence: prev_pid=%i, pid=%i for iteration=%i",
+					prev_pid, pid, i);
 				return;
 			}
 		}
-	}
-	tst_resm(TPASS, "%ld pids forked, all passed", lc);
-}
 
-static void setup(void)
-{
-	tst_require_root();
+		prev_pid = pid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+		reaped = SAFE_WAITPID(pid, &status, 0);
 
-	/* Backup pid_max value. */
-	SAFE_FILE_SCANF(NULL, PID_MAX_PATH, "%lu", &pid_max);
+		if (reaped != pid) {
+			tst_res(TFAIL,
+				"Wrong pid %i returned from waitpid() expected %i",
+				reaped, pid);
+			return;
+		}
 
-	SAFE_FILE_PRINTF(NULL, PID_MAX_PATH, "%d", PID_MAX);
-}
+		if (WEXITSTATUS(status) != retval) {
+			tst_res(TFAIL,
+				"Wrong process exit value %i expected %i",
+				WEXITSTATUS(status), retval);
+			return;
+		}
 
-static void cleanup(void)
-{
-	/* Restore pid_max value. */
-	FILE_PRINTF(PID_MAX_PATH, "%lu", pid_max);
-}
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Runtime exhausted, exiting...");
+			break;
+		}
+	}
 
-/* The distance mod PIDMAX between two pids, where the first pid is
-   expected to be smaller than the second. */
-static int pid_distance(pid_t first, pid_t second)
-{
-	return (second + PID_MAX - first) % PID_MAX;
+	tst_res(TPASS, "%i pids forked, all passed", i);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.max_runtime = 600,
+	.test_all = check,
+	.save_restore = (const struct tst_path_val[]) {
+		{"!/proc/sys/kernel/pid_max", PID_MAX_STR},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5fdee8c4a5e1"},
+		{}
+	}
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
