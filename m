Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B563C25B75
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 02:33:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12B183D0700
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 04:33:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52A0A3C60BA
 for <ltp@lists.linux.it>; Thu, 30 May 2024 04:33:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=18.169.211.239; helo=smtpbg151.qq.com;
 envelope-from=mataotao@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 82C176024AF
 for <ltp@lists.linux.it>; Thu, 30 May 2024 04:33:21 +0200 (CEST)
X-QQ-mid: bizesmtp78t1717036394ts76e9i2
X-QQ-Originating-IP: meT2uoyEfgfUvz5DWoEDyrRMKjrezfMVcVAgeAW6CNg=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 30 May 2024 10:33:12 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: jXjag1m6xl4+lBoL7NB5lT47tt1RG0byyAXuhWGeeG9wKWgRa83sCzMGfodaS
 yQiVCXZtAA1GOZPgGNA7TZMUOSHw+x8JZhE9+zqEA8hJ1Kzn14xFM/cGPofS3Mm+6p7BZiw
 p0Df0tUG/zCNCNX6pdtfVoLi9FC/gyokndEug2DLCI57WO6kUTyRtEARUKQZBXFSXutEB4A
 v31I9vx7nUnz7xlBAjA+zTEq1YJZe+KB+Ru7fS4qVjsqdw1nKxJIsO6fjycRuXBGYqzrm5n
 6tEIR537gbgH3QKhkTUOlt7yrm9RNavTNMgobylV8xasIrjhpZd55UhAFvdUrAB2AHWi6Gp
 GVn+c3V0c0PcuMBvKgHQ37XQ7l0Rg/khteHqM6H5bML+d7WRlloEQ/hEoQZhQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12521841084230576013
From: mataotao <mataotao@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 30 May 2024 10:33:10 +0800
Message-Id: <20240530023310.4058-1-mataotao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shell: add chmod command check
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

---
 runtest/commands                        |  1 +
 testcases/commands/chmod/Makefile       | 11 ++++
 testcases/commands/chmod/chmod_tests.sh | 83 +++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 testcases/commands/chmod/Makefile
 create mode 100644 testcases/commands/chmod/chmod_tests.sh

diff --git a/runtest/commands b/runtest/commands
index 570b81262..6066d3289 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -13,6 +13,7 @@ cp01_sh cp_tests.sh
 ln01_sh ln_tests.sh
 mkdir01_sh mkdir_tests.sh
 echo_tests_sh echo_tests.sh
+chmod_tests_sh chmod_tests.sh
 mv01_sh mv_tests.sh
 du01_sh du01.sh
 df01_sh df01.sh
diff --git a/testcases/commands/chmod/Makefile b/testcases/commands/chmod/Makefile
new file mode 100644
index 000000000..da8115d71
--- /dev/null
+++ b/testcases/commands/chmod/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 UnionTech Ltd.
+# Author: Taotao Ma <mataotao@uniontech.com>
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= chmod_tests.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/chmod/chmod_tests.sh b/testcases/commands/chmod/chmod_tests.sh
new file mode 100644
index 000000000..469ba70d4
--- /dev/null
+++ b/testcases/commands/chmod/chmod_tests.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2024
+# Copyright (c) 2024 UnionTech Ltd.
+# Author: Taotao Ma <mataotao@uniontech.com>
+#
+# Test basic functionality of chmod command.
+
+TST_CNT=7
+TST_TESTFUNC=do_test
+TST_SETUP=setup
+TST_NEEDS_TMPDIR=1
+
+create_tree()
+{
+  local dirname=$1
+  local dircnt=$2
+  local filecnt=$3
+
+  tst_res TINFO "Creating $dircnt directories."
+  tst_res TINFO "Filling each dir with $filecnt files".
+  while [ $dircnt -gt 0 ]; do
+      dirname=$dirname/dir$dircnt
+          ROD mkdir -p $dirname
+
+      local fcnt=0
+          while [ $fcnt -lt $filecnt ]; do
+          ROD touch $dirname/file$fcnt
+          fcnt=$((fcnt+1))
+      done
+      dircnt=$((dircnt-1))
+  done
+}
+
+setup()
+{
+  create_tree "dir" 3 3
+  ROD echo LTP > file
+}
+
+compare()
+{
+  local act_auth="$1"
+  local exp_auth="$2"
+
+  act="$(stat -c "%a" "$act_auth")"
+  tst_res TINFO "$act"
+  if [ "$act" = "$exp_auth" ]; then
+      tst_res TPASS "Files $act_auth  authority Modified successfully"
+  else
+      tst_res TFAIL "Files $act_auth  authority Modified failed"
+  fi
+}
+
+chmod_test()
+{
+  local args="$1"
+  local auth="$2"
+  local src="$3"
+  local check="$4"
+  if [[ -n $auth ]]; then
+    EXPECT_PASS chmod $args $auth $src
+    compare "$src" "$check"
+  else
+    compare "$src" "$check"
+  fi
+}
+
+do_test()
+{
+  case $1 in
+  1) chmod_test "-R" "775" "dir/dir3/dir2/dir1" "775";;
+  2) chmod_test ""  "" "dir/dir3/dir2/dir1/file0" "775";;
+  3) chmod_test ""  "" "dir/dir3/dir2/dir1/file1" "775";;
+  4) chmod_test "" "go+rwx" "dir/dir3/file0" "677";;
+  5) chmod_test "" "777" "dir/dir3/file1" "777";;
+  6) chmod_test "" "g-r" "dir/dir3/dir2/file0" "604";;
+  7) chmod_test "" "g-r" "dir/dir3/file0" "637";;
+  esac
+}
+
+. tst_test.sh
+tst_run
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
