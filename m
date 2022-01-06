Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE492C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC2553C81A3
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:25:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB84F3C03F6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:37 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0843200BD6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641461135; i=@fujitsu.com;
 bh=aq3xz6/oigVLW7Mq5W9kLh79H4y0p5B6FPayMR09kVk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=iImSCnnp6MlAyYX/XOwLCw3W1RUH7wf/8/1P0os6vGpSpI9XCrg8GI5GVqBeoI7eO
 sY5VE3PnyMhaCiks1JAownMaObtCpTV/NiOtY3MEBn5RvIMYGmGFS33vTbdY7U6ZvM
 iZ/xuEDu0paphItlcVtnpfJpDyF2qacqjQRoGkW8n6X9s2/aygyp2dlj4hqZDuWQF3
 FL5/TmV1m7v4DCS0X3+o081H5iRwj+zAGZjKNx+qUtGNMuO5T37EsOhQcycv8RzEH6
 tMVtuxcms01O4KZC/QcSN0JgNRk8Pj+5KRK+RcLNNC9rup36OCAIR2ROfe4CooVIiA
 /QIdlHhkKEEXQ==
Received: from [100.115.6.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 33/69-10124-F85B6D16;
 Thu, 06 Jan 2022 09:25:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8ORqNu/9Vq
 iwd1PohYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b0F58YC/rSKiZPnsXcwHg9tIuRi0NI4Cyj
 xPQN01i6GDmBnJ1MEvvvCUMkdjNK/Nu5kxUkwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSxgInH+9E8wm0VAReLz2ulgvbwCHhLr5veDxSUEFCSmPHwPNIeDg1PAU2L5KR0QU0ggSe
 LPLXWIakGJkzOfsEBMl5A4+OIFM0SnosSljm+MEHaFxKxZbVAT1SSuntvEPIFRcBaS9llI2hc
 wMq1itEoqykzPKMlNzMzRNTQw0DU0NNU10DUyMdZLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuu
 zE3OSdHLSy3ZxAgM4JRihs87GBf0/dQ7xCjJwaQkytuldS1RiC8pP6UyI7E4I76oNCe1+BCjD
 AeHkgSv/SagnGBRanpqRVpmDjCaYNISHDxKIry/NgKleYsLEnOLM9MhUqcYdTl2nl68iFmIJS
 8/L1VKnHfCFqAiAZCijNI8uBGwyL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg3DmQKT2Z
 eCdymV0BHMAEdcU7uMsgRJYkIKakGJu6jsill+w7YqJf3syilzjt+x7PUlu1hCufcP33uix4m
 J/9/XlzM9FbQ/ZQnn3VeWnxIgHTBnDIjY5+ZXn9eCf+cdJotTMKh8S2b96ztBvXdU8T3ZzrsY
 TwgdvyJ/5YHbzOdz4TM8FqxQ7bTL+a3yuHElX25qRNTmn9sLsz9cvi4xg6tCbL2ZUo+8fe5l2
 o3p7Os6ZK86KHa8zxv3wJ33edLd9+f/OxsV+3MhX+4ODWd3wluv5TS+ftSlnRcys3fCw5yl/7
 1OBtZ/KDn7d3vNszlj+4I/tl3/ujSp8+m6YlnpprZlKgndR1pD/JVuKBn+DhxhlRq1N5lIgGu
 a/SVt+1mr0pr/3fwyav5QgEflFiKMxINtZiLihMBPCyUamcDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-587.messagelabs.com!1641461135!6129!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 419 invoked from network); 6 Jan 2022 09:25:35 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-21.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Jan 2022 09:25:35 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C48D81001A6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B7C0010019C
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 09:25:34 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 09:25:19 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Jan 2022 17:25:20 +0800
Message-ID: <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

Use tst_check_kconfigs command to call tst_kconfig_check function in internal.
It introduces two variables in tst_test.sh
TST_NEEDS_KCONFIGS
TST_NEEDS_KCONFIGS_IFS (default value is comma)

Also, we can use tst_check_kconfigs in your shell case if you want to skip subtest
case instead the whole test.

Fixes:#891
Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt                        | 54 +++++++++++++------
 lib/newlib_tests/runtest.sh                   |  3 +-
 lib/newlib_tests/shell/tst_check_kconfig01.sh | 26 +++++++++
 lib/newlib_tests/shell/tst_check_kconfig02.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig03.sh | 15 ++++++
 lib/newlib_tests/shell/tst_check_kconfig04.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig05.sh | 26 +++++++++
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  3 +-
 testcases/lib/tst_check_kconfigs.c            | 18 +++++++
 testcases/lib/tst_test.sh                     | 35 ++++++++++++
 11 files changed, 195 insertions(+), 18 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig01.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig02.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig03.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig04.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig05.sh
 create mode 100644 testcases/lib/tst_check_kconfigs.c

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index b993a9e1e..a1ec6ba2a 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -193,22 +193,25 @@ simply by setting right '$TST_NEEDS_FOO'.
 
 [options="header"]
 |=============================================================================
-| Variable name      | Action done
-| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root.
-|                    | Alternatively the 'tst_require_root' command can be used.
-| 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
-| 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
-                       device is stored in '$TST_DEVICE' variable.
-                       The option implies 'TST_NEEDS_TMPDIR'.
-| 'TST_NEEDS_CMDS'   | String with command names that has to be present for
-                       the test (see below).
-| 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
-| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
-| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int >= 1,
-                       or -1 (special value to disable timeout), default is 300.
-                       Variable is meant be set in tests, not by user.
-                       It's an equivalent of `tst_test.timeout` in C, can be set
-                       via 'tst_set_timeout(timeout)' after test has started.
+| Variable name            | Action done
+| 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
+|                          | Alternatively the 'tst_require_root' command can be used.
+| 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
+| 'TST_NEEDS_DEVICE'       | Prepare test temporary device, the path to testing
+                             device is stored in '$TST_DEVICE' variable.
+                             The option implies 'TST_NEEDS_TMPDIR'.
+| 'TST_NEEDS_CMDS'         | String with command names that has to be present for
+                             the test (see below).
+| 'TST_NEEDS_MODULE'       | Test module name needed for the test (see below).
+| 'TST_NEEDS_DRIVERS'      | Checks kernel drivers support for the test.
+| 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
+| 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
+                             default value is comma.
+| 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
+                             or -1 (special value to disable timeout), default is 300.
+                             Variable is meant be set in tests, not by user.
+                             It's an equivalent of `tst_test.timeout` in C, can be set
+                             via 'tst_set_timeout(timeout)' after test has started.
 |=============================================================================
 
 [options="header"]
@@ -742,3 +745,22 @@ TST_NEEDS_CHECKPOINTS=1
 Since both the implementations are compatible, it's also possible to start
 a child binary process from a shell test and synchronize with it. This process
 must have checkpoints initialized by calling 'tst_reinit()'.
+
+1.7 Parsing kernel .config
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The shell library provides an implementation of the kconfig parsing interface
+compatible with the C version.
+
+It's possible to pass kernel kconfig list for tst_require_kconfigs API with
+'$TST_NEEDS_KCONFIGS'.
+Optional '$TST_NEEDS_KCONFIGS_IFS' is used for splitting, default value is comma.
+
+Now, we support the length of kconfig list is 10.
+
+-------------------------------------------------------------------------------
+#!/bin/sh
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS, CONFIG_QUOTACTL=y"
+
+. tst_test.sh
+-------------------------------------------------------------------------------
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 8b2fe347a..b34a582b7 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -6,7 +6,8 @@ tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh}"
 
-LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
+LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
+shell/tst_check_kconfig0[1-4].sh shell/net/*.sh}"
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
new file mode 100755
index 000000000..90e76360e
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_GENERIC_IRQ_PROBE=y,
+CONFIG_GENERIC_IRQ_SHOW=y,
+CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y,
+CONFIG_GENERIC_PENDING_IRQ=y,
+CONFIG_GENERIC_IRQ_MIGRATION=y,
+CONFIG_IRQ_DOMAIN=y,
+CONFIG_IRQ_DOMAIN_HIERARCHY=y,
+CONFIG_GENERIC_MSI_IRQ=y,
+CONFIG_GENERIC_MSI_IRQ_DOMAIN=y,
+CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y,
+CONFIG_GENERIC_IRQ_RESERVATION_MODE=y"
+
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "kernel config check functionality only supports 10 kernel kconfigs"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig02.sh b/lib/newlib_tests/shell/tst_check_kconfig02.sh
new file mode 100755
index 000000000..065a20fd2
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4"
+
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "kernel .config doesn't have CONFIG_EXT4"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig03.sh b/lib/newlib_tests/shell/tst_check_kconfig03.sh
new file mode 100755
index 000000000..ebdec70f8
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS: CONFIG_XFS_FS"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "invalid kconfig delimter"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig04.sh b/lib/newlib_tests/shell/tst_check_kconfig04.sh
new file mode 100755
index 000000000..c5f046b79
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
+TST_NEEDS_KCONFIGS_IFS=":"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "valid kconfig delimter"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig05.sh b/lib/newlib_tests/shell/tst_check_kconfig05.sh
new file mode 100755
index 000000000..1a214016a
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+. tst_test.sh
+
+do_test()
+{
+	tst_check_kconfigs "CONFIG_EXT4_FS"
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "kernel .config has CONFIG_EXT4_fs"
+	else
+		tst_res TFAIL "kernel .config doesn't have CONFIG_EXT4_FS"
+	fi
+
+	tst_check_kconfigs "CONFIG_EXT4"
+	if [ $? -eq 0 ]; then
+		tst_res TFAIL "kernel .config has CONFIG_EXT4"
+	else
+		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4"
+	fi
+}
+
+tst_run
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 9625d9043..c0d4dc851 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1,4 +1,5 @@
 /tst_check_drivers
+/tst_check_kconfigs
 /tst_checkpoint
 /tst_device
 /tst_getconf
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index d6b4c7a91..f2de0c832 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -11,6 +11,7 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
+			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
+			   tst_check_kconfigs
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_check_kconfigs.c b/testcases/lib/tst_check_kconfigs.c
new file mode 100644
index 000000000..5c387a62d
--- /dev/null
+++ b/testcases/lib/tst_check_kconfigs.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved. */
+
+#include <stdio.h>
+#include "tst_kconfig.h"
+
+int main(int argc, const char *argv[])
+{
+	if (argc < 2) {
+		fprintf(stderr, "Please provide kernel kconfig list\n");
+		return 1;
+	}
+
+	if (tst_kconfig_check(argv+1))
+		return 1;
+
+	return 0;
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2556b28f5..0097c8d43 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -412,6 +412,37 @@ tst_require_drivers()
 	return 0
 }
 
+tst_require_kconfigs()
+{
+	[ $# -eq 0 ] && return 0
+
+	local kconfigs
+	local kconfig_i
+	local kconfig_max
+
+	kconfigs=$@
+	[ -z "$kconfigs" ] && return 0
+
+	tst_check_cmds cut tr wc
+	kconfig_max=$(( $(echo "$kconfigs" | tr -cd "$TST_NEEDS_KCONFIGS_IFS" | wc -c) +1))
+	if [ $kconfig_max -gt 10 ]; then
+		tst_brk TCONF "The max number of kconfig is 10!"
+	fi
+
+	for kconfig_i in $(seq $kconfig_max); do
+		eval "local kconfig$kconfig_i"
+		eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIGS_IFS" -f$kconfig_i)'"
+	done
+
+	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
+			$kconfig7 $kconfig8 $kconfig9 $kconfig10
+	if [ $? -ne 0 ]; then
+		tst_brk TCONF "Aborting due to unsuitable kernel config, see above!"
+	fi
+
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -587,6 +618,7 @@ tst_run()
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
+			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
@@ -627,6 +659,7 @@ tst_run()
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
 	tst_require_cmds $TST_NEEDS_CMDS
+	tst_require_kconfigs $TST_NEEDS_KCONFIGS
 	tst_require_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
@@ -748,6 +781,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
 	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
 
+	TST_NEEDS_KCONFIGS_IFS="${TST_NEEDS_KCONFIGS_IFS:-,}"
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
