Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2596C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 11:44:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A22773C9F07
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 12:44:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D78F03C1351
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:44:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35D781A0154B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:44:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6249D21138
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644579842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=81sanNuPXk3qeH6lJa4xoVHj3rOx6NaTx468GirdFKM=;
 b=KseRc/LwBWoz0W1Yiaqm+IUjqLEDp0oWNyBVugHDbw8C1vF/asrqJjWvCRdV/Chk/oW8+Q
 Csk0dSmGWvrilaakOZ7lk8rvu6m3mSXBHZRDNUjxhuai4IfF3BtSEm6gBd4AOaJm6YHPmS
 9MgQ83gznfC0KuA5RTgbrELJU0KoneI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644579842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=81sanNuPXk3qeH6lJa4xoVHj3rOx6NaTx468GirdFKM=;
 b=FFEhSHjKfWak/lwX5OQardLCJNmypQQO0OpaIqV8Okr9C6vzIxJzW0G8wCmSArnyComim8
 QOsWdQzX37gesbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5004413C03
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 11:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z4tiEgJMBmJvVwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 11:44:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 12:44:01 +0100
Message-Id: <20220211114401.24663-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Terminate leftover subprocesses when main test
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

Changes since v1:
- The SIGKILL can be sent after SAFE_WAITPID() returns, removed
  the unnecessary SIGCHLD handler
- Fixed libtest shell script, calling test_children_cleanup inside backticks
  would block the shell script until any leftover child exits, which renders
  the test useless. Temp file must be used for passing child PID.

 lib/newlib_tests/runtest.sh               |  3 +-
 lib/newlib_tests/test_children_cleanup.c  | 43 +++++++++++++++++++++++
 lib/newlib_tests/test_children_cleanup.sh | 19 ++++++++++
 lib/tst_test.c                            |  3 ++
 4 files changed, 67 insertions(+), 1 deletion(-)
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
index 000000000..2a84c3d85
--- /dev/null
+++ b/lib/newlib_tests/test_children_cleanup.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 SUSE LLC <mdoucha@suse.cz>
+
+TMPFILE="/tmp/ltp_children_cleanup_$$.log"
+./test_children_cleanup &>"$TMPFILE"
+CHILD_PID=`sed -n 's/^.*Forked child \([0-9]*\)$/\1/p' "$TMPFILE"`
+rm "$TMPFILE"
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
index 191a9deab..a84d72d53 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1495,6 +1495,9 @@ static int fork_testrun(void)
 		return TFAIL;
 	}
 
+	if (tst_test->forks_child)
+		kill(-test_pid, SIGKILL);
+
 	if (WIFEXITED(status) && WEXITSTATUS(status))
 		return WEXITSTATUS(status);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
