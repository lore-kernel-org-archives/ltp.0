Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19283C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 06:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 386BD3C1D3C
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 07:57:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DCDA3C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:19 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B31F653A57
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 07:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641279438; i=@fujitsu.com;
 bh=CceJcMUa/+lo1xon+FKVml9EEcfEBKFdfDu6/J5ldr8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=y6ZshrRYNpm5sZoDIGsxs7rvxyDuV6wtkjDcIhreTdFIjl/8tFCQB6qA/5AcEFtl/
 /6ykLh4F4cZtiagiefkyGqCP43+8FT7eCgzYN0vRQepPBz1wWi1tIE6hoTkSov8iI9
 XnFhL2p+IB/o3HF5eeLczhQgwmOyCuINRa8MsPJzhXOMwdGnyoK5nHHBrjwpIJIDCs
 cFKADHCM9qH2BB88fi0Ll0k7e7qgHJVSnbAcy5vFutC911xMlBssP1b38P3JmAz9m4
 CwEgy3QMxz2YjecQLY46Q0NhpEJ+YCy3ZK+RfkDwmRD1BxgXdnPbB1DCx2erEitznh
 V9iECCULcl0eA==
Received: from [100.115.6.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id CE/C2-13695-ECFE3D16;
 Tue, 04 Jan 2022 06:57:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRWlGSWpSXmKPExsViZ8MxSffs+8u
 JBp/Xy1is+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBnfDk5iLejNq7ixYwJLA+Px2C5GTg4hgbOM
 Enu7vSDsnUwS0/5pdzFyAdm7GSXur3/PDJJgE9CUeNa5AMwWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYWMJGYuv8qmM0ioCKxeMppoBoODl4BD4mtV7JBwhICChJTHoKM5ODgFPCUOLdVDGKth0TPlu
 lsIDavgKDEyZlPWCCmS0gcfPGCGaJVUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+FpH0
 BI9MqRsukosz0jJLcxMwcXUMDA11DQ1NdY10LM73EKt1EvdRS3fLU4hJdQ73E8mK91OJiveLK
 3OScFL281JJNjMDgTSlmDtvB+Kf3p94hRkkOJiVR3oyTlxOF+JLyUyozEosz4otKc1KLDzHKc
 HAoSfBWvAbKCRalpqdWpGXmACMJJi3BwaMkwvvzHVCat7ggMbc4Mx0idYpRl2Pn6cWLmIVY8v
 LzUqXEeetAigRAijJK8+BGwKL6EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3n6QKTyZeSV
 wm14BHcEEdMQ5ObAjShIRUlINTBbd5/OCnhztEGnhWNzavHLJbMF254K2htBLBbwr3jo/tbjC
 c0L7vkq388Eq0x2rbgj/3Lve5cD/Xz7RMkelgl7LPvj35trL0qZ5By6/XVsdbj2fsyxKT7TMb
 tPBO60TapqcXt+f/nXXWXOWZPP03R4eOmzSiXP/27FMEvH8tnTZIgHp99qH+g/6l+x+ZbJxZ8
 fVZXfO/Jhi3JlhIWkmKfhw+qtKY8GVXRXB+osZZsvbfK/TswzwUuUPqfKqnrpA3j4jaNb867M
 fbjuz4uPSH89ypjLMcln34t1yxXmCsysZL/zkvCHVULTqiALXoe9bbH+Wb24/Kll7jKlY7fkZ
 3aVBBtuXzDm/4uA0BcHZ29iUWIozEg21mIuKEwEr1xv3ZQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-587.messagelabs.com!1641279437!57453!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28805 invoked from network); 4 Jan 2022 06:57:17 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-21.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Jan 2022 06:57:17 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 04A9E100354
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:17 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id EBE1C100331
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 06:57:16 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 06:57:04 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Jan 2022 14:57:18 +0800
Message-ID: <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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
It introduces three variables in tst_test.sh
TST_NEEDS_KCONFIGS
TST_NEEDS_KCONFIG_IFS (default value is comma)
TST_TCONF_IF_KCONFIG (default value is 1, 0 means to use TWRAN and case continue)

Also, we can use tst_check_kconfigs in your shell case if you want to skip subtest
case instead the whole test.

ps:Don't use array in tst_require_kconfigs because dash doesn't support shell array.

Fixes:#891
Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt                        | 57 +++++++++++++------
 lib/newlib_tests/runtest.sh                   |  4 +-
 lib/newlib_tests/shell/tst_check_kconfig01.sh | 26 +++++++++
 lib/newlib_tests/shell/tst_check_kconfig02.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig03.sh | 15 +++++
 lib/newlib_tests/shell/tst_check_kconfig04.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig05.sh | 26 +++++++++
 lib/newlib_tests/shell/tst_check_kconfig06.sh | 17 ++++++
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  4 +-
 testcases/lib/tst_check_kconfigs.c            | 17 ++++++
 testcases/lib/tst_test.sh                     | 41 +++++++++++++
 12 files changed, 221 insertions(+), 19 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig01.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig02.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig03.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig04.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig05.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig06.sh
 create mode 100644 testcases/lib/tst_check_kconfigs.c

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index b993a9e1e..c742fff39 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -193,22 +193,23 @@ simply by setting right '$TST_NEEDS_FOO'.
 
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
+| Variable name       | Action done
+| 'TST_NEEDS_ROOT'    | Exit the test with 'TCONF' unless executed under root.
+|                     | Alternatively the 'tst_require_root' command can be used.
+| 'TST_NEEDS_TMPDIR'  | Create test temporary directory and cd into it.
+| 'TST_NEEDS_DEVICE'  | Prepare test temporary device, the path to testing
+                        device is stored in '$TST_DEVICE' variable.
+                        The option implies 'TST_NEEDS_TMPDIR'.
+| 'TST_NEEDS_CMDS'    | String with command names that has to be present for
+                        the test (see below).
+| 'TST_NEEDS_MODULE'  | Test module name needed for the test (see below).
+| 'TST_NEEDS_DRIVERS' | Checks kernel drivers support for the test.
+| 'TST_NEEDS_KCONFIGS'| Checks kernel kconfigs support for the test (see below).
+| 'TST_TIMEOUT'       | Maximum timeout set for the test in sec. Must be int >= 1,
+                        or -1 (special value to disable timeout), default is 300.
+                        Variable is meant be set in tests, not by user.
+                        It's an equivalent of `tst_test.timeout` in C, can be set
+                        via 'tst_set_timeout(timeout)' after test has started.
 |=============================================================================
 
 [options="header"]
@@ -742,3 +743,27 @@ TST_NEEDS_CHECKPOINTS=1
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
+It's possible to pass kernel kconfig list for tst_require_kconfigs api with
+'$TST_NEEDS_KCONFIGS'.
+Optional '$TST_NEEDS_KCONFIG_IFS' is used for splitting, default value is comma.
+Optional '$TST_TCONF_IF_KCONFIG' is used for deciding how to exit the test if kernel
+.config doesn't meet test's requirement, default value is 1(TCONF). Otherwise, just
+use TWRAN and continue to run test.
+
+Now, we support the length of kconfig list is 10.
+
+-------------------------------------------------------------------------------
+#!/bin/sh
+TST_NEEDS_KCONFIGS="CONFIG_FS_EXT4 , CONFIG_QUOTACTL=y"
+TST_NEEDS_KCONFIG_IFS=","
+TST_TCONF_IF_KCONFIG=1
+
+. tst_test.sh
+-------------------------------------------------------------------------------
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 8b2fe347a..1fb9e7f21 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -6,7 +6,9 @@ tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh}"
 
-LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
+LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
+shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
+
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
new file mode 100755
index 000000000..dc09b6092
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
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
+	tst_res TFAIL "Kconfig api only supports 10 kernel kconfigs!"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig02.sh b/lib/newlib_tests/shell/tst_check_kconfig02.sh
new file mode 100755
index 000000000..d79f96ff2
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4"
+
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "Kernel .config doesn't have CONFIG_EXT4!"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig03.sh b/lib/newlib_tests/shell/tst_check_kconfig03.sh
new file mode 100755
index 000000000..c70f378f8
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS: CONFIG_XFS_FS"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "Invalid kconfig delimter!"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig04.sh b/lib/newlib_tests/shell/tst_check_kconfig04.sh
new file mode 100755
index 000000000..42b07d287
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
+TST_NEEDS_KCONFIG_IFS=":"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Valid kconfig delimter!"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig05.sh b/lib/newlib_tests/shell/tst_check_kconfig05.sh
new file mode 100755
index 000000000..6e5d5368b
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+. tst_test.sh
+
+do_test()
+{
+	tst_check_kconfigs "CONFIG_EXT4_FS"
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "kernel .config has CONFIG_EXT4_fs."
+	else
+		tst_res TFAIL "kerenl .config doesn't have CONFIG_EXT4_FS."
+	fi
+
+	tst_check_kconfigs "CONFIG_EXT4"
+	if [ $? -eq 0 ]; then
+		tst_res TFAIL "kernel .config has CONFIG_EXT4."
+	else
+		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4."
+	fi
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig06.sh b/lib/newlib_tests/shell/tst_check_kconfig06.sh
new file mode 100755
index 000000000..6a6d68fd7
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig06.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4"
+TST_TCONF_IF_KCONFIG=0
+
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Kernel .config doesn't have CONFIG_EXT4!"
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
index d6b4c7a91..0e40cc7e3 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
-
+			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
+			   tst_check_kconfigs
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_check_kconfigs.c b/testcases/lib/tst_check_kconfigs.c
new file mode 100644
index 000000000..fda322746
--- /dev/null
+++ b/testcases/lib/tst_check_kconfigs.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/
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
+	return 0;
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2556b28f5..c8134692e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -412,6 +412,41 @@ tst_require_drivers()
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
+	kconfig_max=$(( $(echo "$kconfigs" | tr -cd "$TST_NEEDS_KCONFIG_IFS" | wc -c) +1))
+	if [ $kconfig_max -gt 10 ]; then
+		tst_brk TCONF "The max number of kconfig is 10!"
+	fi
+
+	for kconfig_i in $(seq $kconfig_max); do
+		eval "local kconfig$kconfig_i"
+		eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIG_IFS" -f$kconfig_i)'"
+	done
+
+	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
+			$kconfig7 $kconfig8 $kconfig9 $kconfig10
+	if [ $? -ne 0 ]; then
+		if [ $TST_TCONF_IF_KCONFIG -eq 1 ]; then
+			tst_brk TCONF "kconfig not available"
+		else
+			tst_res TWARN "kconfig not available"
+		fi
+	fi
+
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -586,6 +621,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			NEEDS_KCONFIGS|NEEDS_KCONFIG_IFS|TCONF_IF_KCONFIG);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
@@ -626,6 +662,7 @@ tst_run()
 	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
+	tst_require_kconfigs $TST_NEEDS_KCONFIGS
 	tst_require_cmds $TST_NEEDS_CMDS
 	tst_require_drivers $TST_NEEDS_DRIVERS
 
@@ -748,6 +785,10 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
 	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
 
+	TST_NEEDS_KCONFIG_IFS="${TST_NEEDS_KCONFIG_IFS:-,}"
+
+	TST_TCONF_IF_KCONFIG="${TST_TCONF_IF_KCONFIG:-1}"
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
