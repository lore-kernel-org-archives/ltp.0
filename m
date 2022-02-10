Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD00BC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2050C3C9EF3
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:18:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E061B3C0214
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:18:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 096121A006FF
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:18:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32DD41F399
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644509898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wLOGb+kwHEO6VaUYIw87KQ53cYpbaCLAQ0n4yZqyoS0=;
 b=EX8mFZSjNTqucDG/mUhh2opRupnd6eo8QygRq2+fr7kPlXqe+9+ClQ5hTSYMygkoj3yTRx
 ejkITAfvPZjUp37GD/hD5uqkng9G9l+DEuosJrqKNwq+t4PpLmsMhYVhT7/778pddeu7U+
 44R9jpUM5w3zt/xbGnVDsTHRwwBtFMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644509898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wLOGb+kwHEO6VaUYIw87KQ53cYpbaCLAQ0n4yZqyoS0=;
 b=VmNXLF/PpC9OfK/E5eLt6IqJl/noQLEP/mrNpIjlhsBBn4jsrQeEkAsmVsK84uWYW0Nuyv
 nPeOFkIaQz6rO5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C81313BC1
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ECTEAco6BWJ0LQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:18:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:18:17 +0100
Message-Id: <20220210161817.11555-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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

When the main test process crashes or gets killed e.g. by OOM killer,
the watchdog process currently does not clean up any remaining child
processes. Fix this by sending SIGKILL to the test process group when
the watchdog process gets notified that the main test process has exited
for any reason.

Fixes #892

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/newlib_tests/runtest.sh               |  3 +-
 lib/newlib_tests/test_children_cleanup.c  | 43 +++++++++++++++++++++++
 lib/newlib_tests/test_children_cleanup.sh | 17 +++++++++
 lib/tst_test.c                            |  9 +++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/test_children_cleanup.c
 create mode 100755 lib/newlib_tests/test_children_cleanup.sh

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 92fd3860e..327460e7b 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -4,7 +4,8 @@
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
 tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
-tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh}"
+tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh
+test_children_cleanup.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
 shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
diff --git a/lib/newlib_tests/test_children_cleanup.c b/lib/newlib_tests/test_children_cleanup.c
new file mode 100644
index 000000000..2b1ca5f9c
--- /dev/null
+++ b/lib/newlib_tests/test_children_cleanup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * Test whether the LTP library properly reaps any children left over when
+ * the main test process dies. Run using test_children_cleanup.sh.
+ */
+
+#include <unistd.h>
+#include <signal.h>
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	pid_t child_pid, main_pid = getpid();
+
+	tst_res(TINFO, "Main process %d starting", main_pid);
+
+	/* Check that normal child reaping does not disrupt the test */
+	if (!SAFE_FORK())
+		return;
+
+	SAFE_WAIT(NULL);
+	child_pid = SAFE_FORK();
+
+	/* Start child that will outlive the main test process */
+	if (!child_pid) {
+		sleep(30);
+		return;
+	}
+
+	tst_res(TINFO, "Forked child %d", child_pid);
+	kill(main_pid, SIGKILL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.timeout = 10,
+};
diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/test_children_cleanup.sh
new file mode 100755
index 000000000..d99b9b3a2
--- /dev/null
+++ b/lib/newlib_tests/test_children_cleanup.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 SUSE LLC <mdoucha@suse.cz>
+
+TMPFILE="/tmp/ltp_children_cleanup_$$.log"
+CHILD_PID=`./test_children_cleanup 2>&1 | sed -n 's/^.*Forked child \([0-9]*\)$/\1/p'`
+
+if [ "x$CHILD_PID" = "x" ]; then
+	echo "TFAIL: Child process was not created"
+	exit 1
+elif ! kill -s 0 $CHILD_PID &>/dev/null; then
+	echo "TPASS: Child process was cleaned up"
+	exit 0
+else
+	echo "TFAIL: Child process was left behind"
+	exit 1
+fi
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 191a9deab..09f65ac71 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1399,6 +1399,13 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
+static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	/* If the test process is dead, send SIGKILL to its children */
+	if (kill(test_pid, 0))
+		kill(-test_pid, SIGKILL);
+}
+
 unsigned int tst_timeout_remaining(void)
 {
 	static struct timespec now;
@@ -1481,6 +1488,7 @@ static int fork_testrun(void)
 		tst_disable_oom_protection(0);
 		SAFE_SIGNAL(SIGALRM, SIG_DFL);
 		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
+		SAFE_SIGNAL(SIGCHLD, SIG_DFL);
 		SAFE_SIGNAL(SIGINT, SIG_DFL);
 		SAFE_SETPGID(0, 0);
 		testrun();
@@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
+	SAFE_SIGNAL(SIGCHLD, sigchild_handler);
 
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
