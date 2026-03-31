Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012A21061B2C
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 01:56:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20FE33E1F0E
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 03:56:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0B9A3CB8BA
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 03:55:52 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1ADA1600713
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 03:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1774922147;
 bh=Q3RBl+AbVRYnyg6S05wrshviCgjpmi0MWAoZdRxMh1Q=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=TmSjqdzSCS5wf4Urj6Z3KIkfxH32HptrBsX51UZOOgB99P0DMAF7v7/FWjRUqVjNq
 OIpYyddNVpm1oW75qMAImSSFgDCnVfSojIqmM2dqCn3/Rm0hNxt1fArDbfIEoRcvS4
 hDa2aGqd4MEO7SFihqNo/IC63/7OPe7cFp7CJuLY=
X-QQ-mid: esmtpsz11t1774922144t84c96df7
X-QQ-Originating-IP: riXMWeUfoh5Mrr7xt3gl+Jle89vzGoBe3+RFjNhiJdI=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 31 Mar 2026 09:55:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6793847804531186962
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 31 Mar 2026 09:55:38 +0800
Message-Id: <20260331015538.53326-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260330071554.49304-1-lufei@uniontech.com>
References: <20260330071554.49304-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NBhX117m75pMI85oE4Uc9WJpnVfJnYWi6iDzu34BCkc/43cl55BT+VIX
 Foe+LA0ke5R9L0Ed7/mmhZQNaRFg99e4W5/KA+Lekagj5HbHHI7Y2wc6E8AUvM90vmIKZuq
 GAwC+9ul7fU1ETvSn6Istgnb63EuYXKYse7qn+gRPzDi+rk/lb1JFUpe6lnSjGg0d18UtGM
 ZMsKmULoZ7h6Qrc8Rqt1/9ADmif30eOgrytn+TK9DfSpIyePtEtkQbf0v6Z+eZrhe5tWr5K
 MuzC9irZ5HPCSFndrU2MUF03xYj98VsUll02b+RnsahTFMqZqyytULkdcamrtA2HqFuCvwb
 qC8AO/sffBbAA/S0IQBZMRjqdJADmIWkb1bs4UlxJuxofpkCi3IXxOvrj0Li2NW7Q/HZU+S
 p979OMVnL7S1ZKJdiiObaNg7LJQGmFETIrSq7lap33z+17Hu1YsBcaAuMG99vVh83X0gNCM
 mlenuC/LEb3eU6d5PLY6F3iW+O3Wjx1NMsNSRYgnPgJPmV1k4M6GnbZodnjiJrwIMC/7Rtj
 QYlIwqqwyZ/5Wsn3zDJ9/zpOm6dJ9Z/YINHcgpoTgxbc2yGdiaZANPecozA9HgoqPckrw6A
 yDdGFRl0YBJ9TcQPBN5K3IFCBMSBaRJ4INmDihGsrdzMhxE+LjCy2jQkNhwcd36zQ40ZpD8
 2/1Yaiz/DFcpSHgiKhhP1bCxEbbC3OJ7JaU2hfpVxVs79QVxuuFScpa7U1AEvRaQZCMBMo/
 UBBraAgRY0xcEuqtjJvTchJdC6IN8zJJgyR9Jhcl3u13b1Rm0OQk4Lpi9LVtthhT/8abAfQ
 Ea0KYAYQSa/doXUT2FJYdVltN9TmbQ1ExkqDeqo4xpDlgK2UE1MYAY/QCdrb24NGVv9dKsB
 riXUo5D+evxUFSKqYJDhVXCuxXfqqCTwlm4HGfXvZPhSOFiNL9sj2r1JWGNR3UaRr2trjRN
 ZOBD44gmpQdQ4tsOvaePNJHHZ4jby/DjqOU2yVkuheGku75moVc5wU21wxpH7IAqGJsROMB
 Ytxt8fbw4tIj7FTdU78GEKUhlN0VA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Rewrite ftrace_regression tests with new C API
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
 testcases/kernel/tracing/ftrace_test/Makefile |  3 +-
 .../tracing/ftrace_test/ftrace_regression.h   | 49 +++++++++++
 .../tracing/ftrace_test/ftrace_regression01.c | 88 +++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        | 83 -----------------
 .../tracing/ftrace_test/ftrace_regression02.c | 68 ++++++++++++++
 .../ftrace_test/ftrace_regression02.sh        | 63 -------------
 8 files changed, 211 insertions(+), 149 deletions(-)
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
diff --git a/testcases/kernel/tracing/ftrace_test/Makefile b/testcases/kernel/tracing/ftrace_test/Makefile
index e4a913a56..618cce7e1 100644
--- a/testcases/kernel/tracing/ftrace_test/Makefile
+++ b/testcases/kernel/tracing/ftrace_test/Makefile
@@ -2,6 +2,7 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS         := *.sh ftrace_stress/*
+INSTALL_TARGETS         := *.sh ftrace_stress/* ftrace_regression01 \
+				ftrace_regression02
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression.h b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
new file mode 100644
index 000000000..82687089b
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
@@ -0,0 +1,49 @@
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
+#include <string.h>
+#include <regex.h>
+
+#define FTRACE_LINE_BUF_SIZE 1024
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
+#endif /* FTRACE_REGRESSION_H */
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..b76d5bf7e
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,88 @@
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
+#include <stdio.h>
+#include "ftrace_regression.h"
+
+#define DEBUGFS_DIR "debugfs"
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
+	SAFE_MKDIR(DEBUGFS_DIR, 0755);
+	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
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
+	tst_res(TPASS, "Finished running the test");
+}
+
+static void cleanup(void)
+{
+	SAFE_UMOUNT(DEBUGFS_DIR);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.save_restore = (const struct tst_path_val[]) {
+		{STACK_TRACER_PATH, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1dbd195"},
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
index 000000000..498db29e5
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,68 @@
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
+#include <unistd.h>
+#include <stdio.h>
+#include "ftrace_regression.h"
+
+#define DEBUGFS_DIR "debugfs"
+#define SET_EVENT DEBUGFS_DIR "/tracing/set_event"
+#define TRACING_ON DEBUGFS_DIR "/tracing/tracing_on"
+#define TRACE_FILE DEBUGFS_DIR "/tracing/trace"
+
+#define LOOP 100
+
+static void setup(void)
+{
+	SAFE_MKDIR(DEBUGFS_DIR, 0755);
+	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
+}
+
+static void run(void)
+{
+	int i;
+
+	SAFE_FILE_PRINTF(SET_EVENT, "signal:signal_generate");
+	SAFE_FILE_PRINTF(TRACING_ON, "1");
+	SAFE_FILE_PRINTF(TRACE_FILE, "\n");
+
+	for (i = 0; i < LOOP; i++)
+		tst_cmd((const char *[]){"ls", "-l", "/proc", NULL},
+			"/dev/null", "/dev/null", 0);
+
+	if (file_contains(TRACE_FILE, "grp=[0-9]") && file_contains(TRACE_FILE, "res=[0-9]"))
+		tst_res(TPASS, "Finished running the test");
+	else
+		tst_res(TFAIL, "Pattern grp=[0-9] res=[0-9] not found in trace");
+}
+
+static void cleanup(void)
+{
+	SAFE_UMOUNT(DEBUGFS_DIR);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "ls"},
+		{}
+	},
+	.min_kver = "3.2",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6c303d3"},
+		{"linux-git", "163566f"},
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
