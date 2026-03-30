Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F90FF494B
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:16:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACA123E4F0E
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:16:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9581E3E1558
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:16:13 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C6825200B6D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1774854967;
 bh=hPV9UA//PTuZtIKX2LD1UfHEvP3ldmk9UyRgVWO+Rxs=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=KuV+XJZD1UQJkSD6K9x4TVk3hysXTfeYV907RPEN01+CPNvyX6cRAmmFMR0JBPEXr
 ioITKz6Bx2orPdlVJG0RiJUV0Z4WP4rNxQyA0ZDRP2cxE8GAbnkW6xoGCECSlNb0kz
 PGIynLwoiW9axCVbzzKSlKAxl1eCX+Y1o7TqkOwA=
X-QQ-mid: zesmtpgz5t1774854964tc4964100
X-QQ-Originating-IP: 6T6q+XOd0chWiYDyiWGPymducZ5UVXZEtptogcbsEAs=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Mar 2026 15:16:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12799103325790913714
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 15:15:54 +0800
Message-Id: <20260330071554.49304-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260304080538.1793-1-lufei@uniontech.com>
References: <20260304080538.1793-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MrFsN+rSFYwlXU5MnaDwwJr6/0xEL76sJhu1dJ53pGFsiWjg2SYXrnf6
 aOxVpE3YEY1+h1Cfd34knDIcBleaj7XOqV3O7lJkA7bnXjRPlgir82qT/5kxtyrEGheAclt
 ukCsZvA3L79FXnafiIjSOzhLwubyI198vdKKl5xbGcCizkWeTAKZ8m6JYPJ4iWBSBgeWtyd
 vLFW0V5Rx7ZpShIFh/t5xJ317EYTpvRQ0p7ckp2npswJtLN7DgzGTN9mej/cmZzeMQZ5Gd0
 nzPRRFzW87F9SmvqLeJRN213OMzVUNB1jbQGMkVOc0a8iuTikf7x4CHCeS0QnQjU6/9F8MX
 REh69RJv5gRNEnyW4nI/yEXgffcFJP5cOBVF8UvO4NA8TxVYO/Kc5typI565FamBX8dfZIZ
 6MAO70XwNEoFlkaU5lT37AradRESw5ndawzSUNyyD7z+kMD/Rv75RW2TSz3yG3QUTb7kpDL
 vvPLMjqnH8F5Jz23mP+03ie2KV63hC6GCyPZqlSbAFFKtApFxjzXv4ws5eNuG7VtPHqY7Dz
 tSAw/T5thAtttGrANM0zZdezrbkJh/B6N8DiBoIl1vZ8+fBzcLSnL4qZ/Ipk8Iu98zPzF8u
 ILz90ViWhIH4PqDaygCyEtRkh/BjKNKcEPy52qpySMqHQ9saCY2Ksq5hs1ZUVkCRFOyvF5n
 nkmGLOzO1ORv53kzcoTw8MwIUaS0dlIyUqrygET1ZKMycTVPbPVP0oKSMHVzOqIMh8ayw5J
 gOvXPSYddJl1LVM9nfKUxVVmuvJPPCUKYfrCHBTHYAJNEGDtm5DifgjKkRCOFYjRNpK/9R4
 GFCxBocj2y5A4nIU+0bxDUw3UJj5Bmf1/e7WDWgNSy8aeXOcrefBkXpIyxga/RxB7yEjlUe
 JLgYeAtDPv0lWY8p7fNOAUheJaRMGJePVBgA39ZR3HFDT+CZBghKU8z9FcHSR2yAnCzlVdi
 kgSkK6LPKp6gsTFfaqo/BWGXfMv78cdSIOVTs1NBxWN4bLK/eefteKCFR7gZhLzZtQ2da9C
 /fuOl+ojRCDFHgOGsuCOuIr1ZaEp8=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Rewrite ftrace_regression tests with new C API
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
 testcases/kernel/tracing/ftrace_test/Makefile |  3 +-
 .../tracing/ftrace_test/ftrace_regression.h   | 65 +++++++++++++++
 .../tracing/ftrace_test/ftrace_regression01.c | 83 +++++++++++++++++++
 .../ftrace_test/ftrace_regression01.sh        | 83 -------------------
 .../tracing/ftrace_test/ftrace_regression02.c | 70 ++++++++++++++++
 .../ftrace_test/ftrace_regression02.sh        | 63 --------------
 7 files changed, 222 insertions(+), 149 deletions(-)
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
index 000000000..710276202
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
@@ -0,0 +1,65 @@
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
+
+#define FTRACE_FILE_BUF_SIZE (1024*1024)
+#define FTRACE_LINE_BUF_SIZE 1024
+
+/**
+ * file_contains - Check if a file contains the given string
+ * path: Path to the file
+ * str: String to search for
+ *
+ * Returns: 1 if file contains str, 0 otherwise
+ */
+static inline int file_contains(const char *path, const char *str)
+{
+	char *buf = SAFE_MALLOC(FTRACE_FILE_BUF_SIZE);
+	bool found = false;
+
+	buf[0] = '\0';
+	SAFE_FILE_SCANF(path, "%1048575[^\x01]", buf);
+	found = strstr(buf, str) != NULL;
+	free(buf);
+
+	return found;
+}
+
+/**
+ * file_contains_line - Check if a file ocntains specific line, strictly
+ *
+ */
+static inline int file_contains_line(const char *path, const char *str)
+{
+	char *buf = SAFE_MALLOC(FTRACE_LINE_BUF_SIZE);
+	bool found = false;
+	FILE *fp = SAFE_FOPEN(path, "r");
+
+	while (fgets(buf, FTRACE_LINE_BUF_SIZE, fp)) {
+		buf[strcspn(buf, "\r\n")] = 0;
+		if (strcmp(buf, str) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(fp);
+	free(buf);
+
+	return found;
+}
+
+#endif /* FTRACE_REGRESSION_H */
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
new file mode 100644
index 000000000..a67d07fd1
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
@@ -0,0 +1,83 @@
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
+		if (!file_contains_line(TRACE_OPTIONS, "userstacktrace"))
+			tst_brk(TBROK, "Failed to set userstacktrace");
+
+		SAFE_FILE_PRINTF(page_fault_path, "1");
+	}
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
index 000000000..97dbaf371
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2026 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ *
+ * Check signal:signal_generate gives 2 more fields: grp res
+ *
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
+	if (file_contains(TRACE_FILE, "grp=") && file_contains(TRACE_FILE, "res="))
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
