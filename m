Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ECEC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:26:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7E13C6AFE
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:26:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 517F93C6AAF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:19 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D2271401235
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641795917; i=@fujitsu.com;
 bh=2hz4oF5bt+tt93lV6YoUIFr+PHyo9gI/ZxOb0JhfbzM=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=i7z5tmgkWgH1Wt9AO6gZJ7Z6OUhlUlWNvj8e7sBVDhSTtRVeAc/v90LWuzv2C4j9f
 ujWYDKkO0Q1Q/lwqjH30HkyfgOhbmuNWZM/C1mFacsdXZ3vRAYQWn26B9RekVPgSbp
 c/a2eB7s3nhWivWzcR6W0wCTfKvAI7zgj949e1wqzyLQhzrFYf00MM14OS51fTHtPm
 78Fy5o8E2bjorpXNSfydVyceeBSedYj+EZR8Mg7Z7v6iDXsxiML4Cm3SFvnDN0NGHT
 sbRvS1avXWzL3HgF2l68o0AqDTVoVPl7LVou1mZGIUB+vpA2W455WL6nKaL4V7ysmT
 0Ql1MlzpKcWRg==
Received: from [100.115.65.216] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id 23/64-06990-C41DBD16;
 Mon, 10 Jan 2022 06:25:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8ORqOtz8Xa
 iwdJJ6hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b97xNYCtYlVLx8Mo2pgbEloIuRi0NI4Cyj
 xK6ONjYIZyeTxNNV15ggnD2MEuubJzB3MXJysAloSjzrXABmiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC5hI7Hr2FGgSBweLgKrEhq0uIGFeAQ+JSduugLVKCChITHn4HszmFPCUuD1vOguILSSQKP
 H2Ry8zRL2gxMmZT1ggxktIHHzxAqpXUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+FpH0
 BI9MqRrukosz0jJLcxMwcXUMDA11DQ1Ndc0NdQ0sDvcQq3US91FLd5NS8kqJEoLReYnmxXmpx
 sV5xZW5yTopeXmrJJkZgMKcUu+/bwfii76feIUZJDiYlUd59528nCvEl5adUZiQWZ8QXleakF
 h9ilOHgUJLg1TsAlBMsSk1PrUjLzAFGFkxagoNHSYQ34hxQmre4IDG3ODMdInWKUZdj5+nFi5
 iFWPLy81KlxHm3XAAqEgApyijNgxsBi/JLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5K0G
 m8GTmlcBtegV0BBPQEckcYEeUJCKkpBqY1jnHrmhlV2+9ckRqGdfFP/MqlxjOjA1/6rXNfF+Z
 R45gf7Buan7Xqh9BJur9vT9Yp5/7nLki5d/8NyoVcVwx3HPWy5yMnFH2jKnjo8uqxM133zZrT
 j2joPGleMqv9D/LTb10NAznTk+tvLSmW6yYnfXTtVkqOS0zL51oYauZvH+NkMKPR5dP5JpdOZ
 yp7v9/zqKD/if2hs71EahnPnloVgp/h5pr2MWKT4eNXFzkDu1V9BR4VpC13m52zlmh/Ys+O7M
 /faOkU/V3tgbXkeU5ipE/V3QeXFCxsang5nkJE1tJvWnXpzcVnF68dsaXvv1c1f0d7w1PRGzr
 cn3RPTX8mccrHQaWG6vV3LUdH700UWIpzkg01GIuKk4EAIgBtBRtAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-545.messagelabs.com!1641795916!148304!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31498 invoked from network); 10 Jan 2022 06:25:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Jan 2022 06:25:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id CA3E01001A6
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B7D8810019B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:25:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 06:09:44 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 10 Jan 2022 09:49:08 +0800
Message-ID: <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
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
 doc/shell-test-api.txt                        | 51 ++++++++++++------
 lib/newlib_tests/runtest.sh                   |  3 +-
 lib/newlib_tests/shell/tst_check_kconfig01.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig02.sh | 15 ++++++
 lib/newlib_tests/shell/tst_check_kconfig03.sh | 16 ++++++
 lib/newlib_tests/shell/tst_check_kconfig04.sh | 25 +++++++++
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  3 +-
 testcases/lib/tst_check_kconfigs.c            | 54 +++++++++++++++++++
 testcases/lib/tst_test.sh                     | 15 ++++++
 10 files changed, 181 insertions(+), 18 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig01.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig02.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig03.sh
 create mode 100644 lib/newlib_tests/shell/tst_check_kconfig04.sh
 create mode 100644 testcases/lib/tst_check_kconfigs.c

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index b993a9e1e..e082808f7 100644
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
+                             default value is comma, it only supports single character.
+| 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
+                             or -1 (special value to disable timeout), default is 300.
+                             Variable is meant be set in tests, not by user.
+                             It's an equivalent of `tst_test.timeout` in C, can be set
+                             via 'tst_set_timeout(timeout)' after test has started.
 |=============================================================================
 
 [options="header"]
@@ -742,3 +745,19 @@ TST_NEEDS_CHECKPOINTS=1
 Since both the implementations are compatible, it's also possible to start
 a child binary process from a shell test and synchronize with it. This process
 must have checkpoints initialized by calling 'tst_reinit()'.
+
+1.7 Parsing kernel .config
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The shell library provides an implementation of the kconfig parsing interface
+compatible with the C version.
+
+It's possible to pass kernel kconfig list for tst_require_kconfigs API with
+'$TST_NEEDS_KCONFIGS'.
+Optional '$TST_NEEDS_KCONFIGS_IFS' is used for splitting, default value is comma.
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
index 000000000..065a20fd2
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
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
diff --git a/lib/newlib_tests/shell/tst_check_kconfig02.sh b/lib/newlib_tests/shell/tst_check_kconfig02.sh
new file mode 100755
index 000000000..3a0f05847
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="tst_check_kconfigs"
+TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TFAIL "invalid kconfig delimter"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig03.sh b/lib/newlib_tests/shell/tst_check_kconfig03.sh
new file mode 100755
index 000000000..c5f046b79
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
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
diff --git a/lib/newlib_tests/shell/tst_check_kconfig04.sh b/lib/newlib_tests/shell/tst_check_kconfig04.sh
new file mode 100644
index 000000000..ad5e8ac21
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
@@ -0,0 +1,25 @@
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
index 000000000..dd0c72768
--- /dev/null
+++ b/testcases/lib/tst_check_kconfigs.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
+
+#include <stdio.h>
+#include <string.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "tst_kconfig.h"
+
+int main(int argc, const char *argv[])
+{
+	char delim[2];
+	char str[PATH_MAX];
+	char *result = NULL;
+	char *next = NULL;
+	int i = 0, j = 0, ret = 0;
+
+	if (argc < 3) {
+		fprintf(stderr, "Please provide kernel kconfig list and delims\n");
+		return 1;
+	}
+
+	if (strlen(argv[2]) != 1) {
+		fprintf(stderr, "The delim must be a single character\n");
+		return 1;
+	}
+
+	strcpy(str, argv[1]);
+	strcpy(delim, argv[2]);
+
+	result = strtok_r(str, delim, &next);
+	for (i = 0; result != NULL; i++)
+		result = strtok_r(NULL, delim, &next);
+
+	strcpy(str, argv[1]);
+	char **kconfigs = (char **)malloc(++i * sizeof(char *));
+
+	result = strtok_r(str, delim, &next);
+	for (i = 0; result != NULL; i++) {
+		kconfigs[i] = (char *)malloc(sizeof(char) * strlen(result));
+		strcpy(kconfigs[i], result);
+		result = strtok_r(NULL, delim, &next);
+	}
+
+	kconfigs[i] = NULL;
+	if (tst_kconfig_check((const char * const*)kconfigs))
+		ret = 1;
+
+	for (j = 0; j <= i; j++)
+		free(kconfigs[i]);
+
+	free(kconfigs);
+	return ret;
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2556b28f5..9c4e4dd3b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -412,6 +412,17 @@ tst_require_drivers()
 	return 0
 }
 
+tst_require_kconfigs()
+{
+	[ $# -ne 2  ] && return 0
+
+	tst_check_kconfigs "$1" $2 > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TCONF "Aborting due to unsuitable kernel config, see above!"
+	fi
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -587,6 +598,7 @@ tst_run()
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
+			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
@@ -627,6 +639,7 @@ tst_run()
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
 	tst_require_cmds $TST_NEEDS_CMDS
+	tst_require_kconfigs "$TST_NEEDS_KCONFIGS" $TST_NEEDS_KCONFIGS_IFS
 	tst_require_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
@@ -748,6 +761,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
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
