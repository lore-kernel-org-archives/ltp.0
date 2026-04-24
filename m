Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E0DFDEE5C
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 02:09:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD1A53DDAD6
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 04:09:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9BF3CD9FD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 04:09:21 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D639A600A1A
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 04:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1776996551;
 bh=dzdjekys48PG3nI5Nn7tfGj3Q5O8LgNN18quKWd/M8U=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=VmeYFAYC8x5jHTwROV4VZ1JlfsX88+Ml13eZ7rALrcBUoR0l+12bJuPF1jTaOyyLT
 srhlKKKrTL7wbeswFD8vZN/eR+pjRL/AFAaHA9gA+SgGhJufyZKnKjfRLPd+Ulpilk
 gAGA4+PgI0/dwhTzK+hif/AKVr/bGsKItH01TLRI=
X-QQ-mid: esmtpsz21t1776996545t593c4173
X-QQ-Originating-IP: NfmcJAtRmL0jNwKOcAEvgWK1AsL/gegF2pLA35oL0f8=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Apr 2026 10:09:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10708680566075025503
EX-QQ-RecipientCnt: 4
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 10:08:54 +0800
Message-Id: <20260424020854.96845-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260331100138.58202-1-lufei@uniontech.com>
References: <20260331100138.58202-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NAeO0+xU6W76/M7gmSZfq5JPj4hRuyAFrhubU8hidvVI/2U07LzkzCyK
 5Ze94mEdyxyWEiSERU+QQ83TKGavX0s7ZKD12WK89rrgXeA0MQJzpGYpy8F2PR8+i/z4qvv
 s6yrNQ2QOJsxxjOFpMmeXtHv1DksCrfMsp76v0XhNYUCch1JrhPz776Nq558SDT7IH2w+Eo
 0FAnyyClQ+W5fZQ1lXiHzQga7IzieOHYS4NdYk1M47iDwC+Z8onNE65x4mkozw9/hv18cKQ
 v28MDxPQr2UDHLhiD3yd6cKgnNGmax5LIsZQLduhxDHR2R7M4blEDv5nw8F0df60RR9Ht+j
 i7Bu4by9eM/yP85FvKZ6741YTRsyr/acSPWSwIJVL1RarV6Iwol+u/OJt8AnCqXOGMCG6HN
 VGk03R5ea/1pf4HYvho/e3f5JrCmRYsX5tuxCfEAAvWHm/C1ZX0wDMoDNGKrP/n4Z/zc2IC
 wSiXXIWx5NJiZjXj59JagK3zfA9FSja/MiDxs+g8IecLtFhijcSz+EHCgh3e8BTWwD8BB/3
 xQ0QDRdyo8j1skPxDBTUGNmMgDOWRjofNDH56qbKMgTCdCJoMm9QotSCQkymR1wMXUC6UEG
 WYitzWoGA6TJLSnC2SwrXlg/4229YvV1TEuq9QjV5eVUhIQZYur3hHohKP9womJU53i7Bbd
 zXz8A+oRDgUrOfKAROjnqUZQAYpmmsYpfziCbSovCskRGcpeakkL1nGTvyaFtEcWLqkB0HF
 KLjEcxxZfwmEAjA1FJEUO5zqsYc/vJmMAZpKxnauLrxeFaL60StGkJhrcXmIR8pd8MSCrU4
 NTGSYHouUr2sR1eKUTSRXdCex43uaLXcqaWa2XD0733avt4RTvj5qeC6z4psxmpLBvNzgTT
 IWU8Ag+1ENwefPAe4gfCJoxTCdJUZXHeuJPR2eBrLfVHx4axoWC73p+UAjYNMC2aCqf0cOw
 qz7AzghmXh26C3mvumv5lgMWdYJX835iv+sSDTK8qc/YmlEukwOTx7IEyhfYO3yuwCEbNUK
 vuqxhmOLQyUaRpIgPUv1++WEXBpUGfGRH90JjoOg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Rewrite ftrace_regression tests with new C API
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rewritten from old shell scripts.

ftrace_regression01: regression test for panic bug while using
userstacktrace, set userstacktrace in loop and check if success.

ftrace_regression02: for checking signal:signal_generate gives
2 more fields: grp res.

Signed-off-by: lufei <lufei@uniontech.com>
---
 runtest/tracing                               |  4 +-
 .../kernel/tracing/ftrace_test/.gitignore     |  2 +
 .../tracing/ftrace_test/ftrace_regression.h   | 62 ++++++++++++++
 .../tracing/ftrace_test/ftrace_regression01.c | 82 ++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        | 83 -------------------
 .../tracing/ftrace_test/ftrace_regression02.c | 56 +++++++++++++
 .../ftrace_test/ftrace_regression02.sh        | 63 --------------
 7 files changed, 204 insertions(+), 148 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression.h
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh

diff --git a/runtest/tracing b/runtest/tracing
index 674e2ad97..2a4a92c5f 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -1,6 +1,6 @@
 #DESCRIPTION:Tracing testing
-ftrace_regression01	ftrace_regression01.sh
-ftrace_regression02	ftrace_regression02.sh
+ftrace_regression01	ftrace_regression01
+ftrace_regression02	ftrace_regression02
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
 fanotify25 fanotify25
diff --git a/testcases/kernel/tracing/ftrace_test/.gitignore b/testcases/kernel/tracing/ftrace_test/.gitignore
new file mode 100644
index 000000000..b0153e9fa
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/.gitignore
@@ -0,0 +1,2 @@
+ftrace_regression01
+ftrace_regression02
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression.h b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
new file mode 100644
index 000000000..ab18e3768
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ *
+ * Shared header for ftrace regression tests.
+ */
+
+#ifndef FTRACE_REGRESSION_H
+#define FTRACE_REGRESSION_H
+
+#include "tst_test.h"
+#include "tst_safe_file_ops.h"
+#include "tst_safe_stdio.h"
+
+#include <regex.h>
+#include <stdio.h>
+
+#define FTRACE_LINE_BUF_SIZE 1024
+#define DEBUGFS_DIR "debugfs"
+
+/**
+ * file_contains - Check if a file contains specific regex pattern.
+ */
+static inline int file_contains(const char *path, const char *pattern)
+{
+	FILE *fp = SAFE_FOPEN(path, "r");
+	char *buf = SAFE_MALLOC(FTRACE_LINE_BUF_SIZE);
+	bool found = false;
+
+	regex_t re;
+
+	if (regcomp(&re, pattern, REG_EXTENDED | REG_NOSUB) != 0) {
+		SAFE_FCLOSE(fp);
+		free(buf);
+		return found;
+	}
+
+	while (fgets(buf, FTRACE_LINE_BUF_SIZE, fp)) {
+		if (regexec(&re, buf, 0, NULL, 0) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	regfree(&re);
+	SAFE_FCLOSE(fp);
+	free(buf);
+	return found;
+}
+
+static inline void mount_debugfs(void)
+{
+	SAFE_MKDIR(DEBUGFS_DIR, 0755);
+	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
+}
+
+static inline void umount_debugfs(void)
+{
+	SAFE_UMOUNT(DEBUGFS_DIR);
+}
+
+#endif /* FTRACE_REGRESSION_H */
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..be2327582
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * Regression test for panic while using userstacktrace.
+ *
+ * BUG: unable to handle kernel paging request at 00000000417683c0
+ *      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0
+ *      Thread overran stack, or stack corrupted
+ *      Oops: 0000 [#1] SMP
+ *      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map
+ *
+ * The bug was fixed by:
+ *      1dbd195 (tracing: Fix preempt count leak)
+ */
+
+#include <unistd.h>
+#include "ftrace_regression.h"
+
+#define STACK_TRACER_PATH "/proc/sys/kernel/stack_tracer_enabled"
+#define TRACE_OPTIONS DEBUGFS_DIR "/tracing/trace_options"
+#define EXC_PAGE_FAULT DEBUGFS_DIR "/tracing/events/exceptions/page_fault_kernel/enable"
+#define MM_PAGE_FAULT DEBUGFS_DIR "/tracing/events/kmem/mm_kernel_pagefault/enable"
+
+#define LOOP 10
+
+static const char *page_fault_path;
+static int page_fault_origin;
+
+static void setup(void)
+{
+	mount_debugfs();
+
+	if (access(EXC_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = EXC_PAGE_FAULT;
+	else if (access(MM_PAGE_FAULT, F_OK) == 0)
+		page_fault_path = MM_PAGE_FAULT;
+	else
+		tst_brk(TCONF, "Page fault event not available");
+
+	SAFE_FILE_SCANF(page_fault_path, "%d", &page_fault_origin);
+}
+
+static void run(void)
+{
+	int i;
+
+	for (i = 0; i < LOOP; i++) {
+		SAFE_FILE_PRINTF(STACK_TRACER_PATH, "1");
+		SAFE_FILE_PRINTF(TRACE_OPTIONS, "userstacktrace");
+
+		if (!file_contains(TRACE_OPTIONS, "^userstacktrace"))
+			tst_brk(TBROK, "Failed to set userstacktrace");
+
+		SAFE_FILE_PRINTF(page_fault_path, "1");
+	}
+
+	SAFE_FILE_PRINTF(page_fault_path, "%d", page_fault_origin);
+
+	tst_res(TPASS, "Test passed for setting userstacktrace "
+			"bug(preempt count leak) not reproduced"
+			);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = umount_debugfs,
+	.save_restore = (const struct tst_path_val[]) {
+		{STACK_TRACER_PATH, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd1951f39e"},
+		{}
+	},
+};
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
deleted file mode 100755
index d6969cfc6..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ /dev/null
@@ -1,83 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary:  panic while using userstacktrace                            ##
-##                                                                       ##
-## BUG: unable to handle kernel paging request at 00000000417683c0       ##
-##      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0                 ##
-##      PGD 41a796067 PUD 0                                              ##
-##      Thread overran stack, or stack corrupted                         ##
-##      Oops: 0000 [#1] SMP                                              ##
-##      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map ##
-##                                                                       ##
-## The bug was fixed by:                                                 ##
-##      1dbd195 (tracing: Fix preempt count leak)                        ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression01"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-LOOP=10
-
-TSTACK_TRACE_PATH="/proc/sys/kernel/stack_tracer_enabled"
-EXC_PAGE_FAULT_ENABLE="$TRACING_PATH/events/exceptions/page_fault_kernel/enable"
-MM_PAGE_FAULT_ENABLE="$TRACING_PATH/events/kmem/mm_kernel_pagefault/enable"
-
-ftrace_userstacktrace_test()
-{
-	if [ ! -e "$TSTACK_TRACE_PATH" ]; then
-		tst_brkm TCONF "Stack Tracer is not cofigured in This kernel"
-	fi
-
-	for i in $(seq $LOOP); do
-		echo 1 >  $TSTACK_TRACE_PATH
-		echo userstacktrace > $TRACING_PATH/trace_options
-		grep -q "^userstacktrace"  $TRACING_PATH/trace_options
-		if [ $? -ne 0 ]; then
-			tst_brkm TBROK "Failed to set userstacktrace"
-		fi
-
-		if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
-			echo 1 > $EXC_PAGE_FAULT_ENABLE
-		else
-			mm_page_fault_enable=`cat $MM_PAGE_FAULT_ENABLE`
-			echo 1 > $MM_PAGE_FAULT_ENABLE
-		fi
-	done
-
-	if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-		echo "$exc_page_fault_enable" > $EXC_PAGE_FAULT_ENABLE
-	else
-		echo "$mm_page_fault_enable" > $MM_PAGE_FAULT_ENABLE
-	fi
-
-	tst_resm TPASS "Finished running the test"
-}
-
-ftrace_userstacktrace_test
-
-tst_exit
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
new file mode 100644
index 000000000..b4aac7ad0
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * Check signal:signal_generate gives 2 more fields: grp=[0-9] res=[0-9]
+ */
+
+#include "ftrace_regression.h"
+
+#define SET_EVENT DEBUGFS_DIR "/tracing/set_event"
+#define TRACING_ON DEBUGFS_DIR "/tracing/tracing_on"
+#define TRACE_FILE DEBUGFS_DIR "/tracing/trace"
+
+#define LOOP 100
+
+static void run(void)
+{
+	int i;
+	const char *const cmd_ls[] = {"ls", "-l", "/proc", NULL};
+
+	SAFE_FILE_PRINTF(SET_EVENT, "signal:signal_generate");
+	SAFE_FILE_PRINTF(TRACING_ON, "1");
+	SAFE_FILE_PRINTF(TRACE_FILE, "\n");
+
+	// to generate trace
+	for (i = 0; i < LOOP; i++)
+		SAFE_CMD(cmd_ls, "/dev/null", "/dev/null");
+
+	if (file_contains(TRACE_FILE, "grp=[0-9]") &&
+			file_contains(TRACE_FILE, "res=[0-9]"))
+		tst_res(TPASS, "Pattern grp=[0-9] res=[0-9] reported after "
+			       "setting signal:signal_generate");
+	else
+		tst_res(TFAIL, "Pattern grp=[0-9] res=[0-9] not found in trace");
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = mount_debugfs,
+	.test_all = run,
+	.cleanup = umount_debugfs,
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "ls"},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3ab39f"},
+		{"linux-git", "163566f60bfe"},
+		{}
+	},
+};
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
deleted file mode 100755
index 3c32f219e..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary: check signal:signal_generate gives 2 more fields: grp res    ##
-##                                                                       ##
-## This testcase is writing for signal events change:                    ##
-##       6c303d3 tracing: let trace_signal_generate() report more info...##
-##       163566f tracing: send_sigqueue() needs trace_signal_generate()  ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression02"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-ftrace_signal_test()
-{
-	# Set envent
-	echo 'signal:signal_generate' > $TRACING_PATH/set_event
-	echo 1 > $TRACING_PATH/tracing_on
-	echo > $TRACING_PATH/trace
-
-	# just to generate trace
-	for i in $(seq 100); do
-		ls -l /proc > /dev/null 2>&1
-	done
-
-	grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "finished running the test."
-	else
-		tst_resm TFAIL "running the test failed, please check log message."
-	fi
-}
-
-if tst_kvcmp -lt "3.2"; then
-	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
-fi
-
-ftrace_signal_test
-
-tst_exit
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
