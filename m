Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D8FC2BD05
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 07:17:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D91BA3D0F7E
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 09:17:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA493CD84E
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 09:17:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.204.34.130;
 helo=smtpbguseast2.qq.com; envelope-from=mataotao@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 128BA6000E0
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 09:17:35 +0200 (CEST)
X-QQ-mid: bizesmtpsz1t1719213448twzr50n
X-QQ-Originating-IP: UXFks4mOrIPGaoSOCp4UuyUxygVkuy562fg+/3/XixE=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Jun 2024 15:17:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11295617643818501788
From: mataotao <mataotao@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 24 Jun 2024 15:17:23 +0800
Message-Id: <20240624071723.23480-1-mataotao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shell: add echo command check
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
Cc: mataotao <mataotao@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: mataotao <mataotao@uniontech.com>
---
 runtest/commands                      |  1 +
 testcases/commands/echo/Makefile      | 11 +++++
 testcases/commands/echo/echo_tests.sh | 62 +++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/commands/echo/Makefile
 create mode 100644 testcases/commands/echo/echo_tests.sh

diff --git a/runtest/commands b/runtest/commands
index 5ec2c3b69..570b81262 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -12,6 +12,7 @@ gzip01_sh gzip_tests.sh
 cp01_sh cp_tests.sh
 ln01_sh ln_tests.sh
 mkdir01_sh mkdir_tests.sh
+echo_tests_sh echo_tests.sh
 mv01_sh mv_tests.sh
 du01_sh du01.sh
 df01_sh df01.sh
diff --git a/testcases/commands/echo/Makefile b/testcases/commands/echo/Makefile
new file mode 100644
index 000000000..20fbab421
--- /dev/null
+++ b/testcases/commands/echo/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 UnionTech Ltd.
+# Author: Taotao Ma <mataotao@uniontech.com>
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= echo_tests.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/echo/echo_tests.sh b/testcases/commands/echo/echo_tests.sh
new file mode 100644
index 000000000..0223cbf5b
--- /dev/null
+++ b/testcases/commands/echo/echo_tests.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2024
+# Copyright (c) 2024 UnionTech Ltd.
+# Author: Taotao Ma <mataotao@uniontech.com>
+#
+# Test basic functionality of lsmod command.
+
+TST_CNT=4
+TST_TESTFUNC=do_test
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="echo"
+. tst_test.sh
+
+echo_test()
+{
+    local echo_opt=$1
+    local echo_content=$2
+
+    local echo_cmd="echo $echo_opt $echo_content"
+
+    $echo_cmd > temp 2>&1
+    if [ $? -ne 0 ]; then
+        grep -q -E "unknown option|invalid option" temp
+        if [ $? -eq 0 ]; then
+            tst_res TCONF "$echo_cmd not supported."
+        else
+            tst_res TFAIL "$echo_cmd failed."
+        fi
+        return
+    fi
+
+    line=$(wc -l temp | awk '{print $1}')
+
+    if [ -z "$echo_opt" ];then
+        if [ "$line" -ne 1 ];then
+            tst_res TFAIL "$echo_cmd failed."
+            return
+        fi
+    else
+        if [ "$echo_opt" = "-e" ];then
+            if [ "$line" -ne 2 ];then
+                tst_res TFAIL "$echo_cmd failed."
+                return
+            fi
+        fi
+    fi
+
+    tst_res TPASS "echo passed with $echo_opt option."
+}
+
+do_test()
+{
+    case $1 in
+        1) echo_test "" "hello\nworld";;
+        2) echo_test "-e" "hello\nworld";;
+        3) echo_test "--help";;
+        4) echo_test "--version";;
+    esac
+}
+
+tst_run
\ No newline at end of file
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
