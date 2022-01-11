Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F0CC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E06643C93E4
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:10:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D16C93C93B8
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:22 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 979C6601C63
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641881420; i=@fujitsu.com;
 bh=+2IhD4bi+FFuAlwaz7iM0Nz7ZPBkiN/O5umnXN7uXwY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lno6/ExgwwZPMSRcptY7JGPZsr1xv6f+cP3QdlMuYY9tNH672IIu1ny0W4N6MZYtM
 LIPK/0Dwq2MZuKh5d+qZZjuClICHBcI54OsFMma4k9OuXQpoaVW0hQWYUpTR0/HmdU
 THBdZd3zIHv5iNNjj2ok5dZujJlt9r6TfkaOt8B2RmZnLTbXKzBGwdGXuGhhv/XfYR
 ubocf8C3plKUUhC5f4nl8/wxZtQYsSl29VjoyGolvqQW4WP8253kf38En5LvxODTYE
 5JYvPeGvNH/E6uxnJIjAgBJ8qUkXTxgtjio8qzUJYvmNuhtgidi6SoRjjxyJARN735
 nDLZDn94JbFPg==
Received: from [100.115.38.11] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-2.aws.ess.symcld.net id 6D/9E-28974-C4F1DD16;
 Tue, 11 Jan 2022 06:10:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8MxSddH/m6
 iwe1ODosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPSmqNsBXvTKy42HmdsYPwZ2sXIxSEkcJZR
 onHBWkYIZyeTxKFzu4AcTiBnD6PEjt5CEJtNQFPiWecCZhBbREBCoqPhLTuIzSygLrF80i8mE
 FtYwERizsdHYL0sAqoSsy5cAovzCnhI/N64jgXElhBQkJjy8D3YHE4BT4neUxPZIHYlSsw/8B
 yqXlDi5MwnLBDzJSQOvnjBDNGrKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmMgrOQtM9C0r6AkWk
 Vo3VSUWZ6RkluYmaOrqGBga6hoamusZGuoZGZXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVu
 ck6KXl5qySZGYBinFCvU7WC8tvKn3iFGSQ4mJVHeWsm7iUJ8SfkplRmJxRnxRaU5qcWHGGU4O
 JQkeGfIAuUEi1LTUyvSMnOAMQWTluDgURLh1ZIGSvMWFyTmFmemQ6ROMepy7Dy9eBGzEEtefl
 6qlDjvZ0GgIgGQoozSPLgRsPi+xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYd6Ic0BSezLw
 SuE2vgI5gAjoimeM2yBEliQgpqQamTXIe01qqpRekbj1S9qA1LzTYbVvxnOS9ZZOUfpz1+rqq
 5/q3Gz+d3y3+lZbzvCTugAtryUErb/YfZVGfj7g93cC/ttni1ozOdd/X9E+57i3DJarZv6VX1
 HXPIjG1L5/cJh8Lf2XIq1xrefmMycatdhPjG8wupDqa9Vd3V3SJdL833rZg0bxtzd8X1l254L
 /i7sOS4l9tZ48u2LEghS98teqK9lPfTE+GqiyeEmLWkSrTc1T11+Ko7PX/F0RZfBMI51qYXfr
 +h8DCkHlL1E6deSDXOXG+wb9HP9tjPkzQeCe85RDPDTW2UwdzFULmT5z47EGQudiz1UvPKR6d
 cZ3hps2Z7Y/lzRzjMpuEdp2uClViKc5INNRiLipOBAAiV+d/agMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-571.messagelabs.com!1641881419!83088!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7626 invoked from network); 11 Jan 2022 06:10:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-15.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 06:10:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id AC503100458
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 67BAC100452
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:19 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 06:10:08 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 14:10:33 +0800
Message-ID: <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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
case instead the whole test. Of course, ltp shell test library can use
tst_require_kconfigs in the future if needs. The delim parameter is optional for
tst_require_kconfigs or tst_check_kconfigs api because they have default value for
themselves.

Fixes:#891
Reviewed-by: Li Wang <liwang@redhat.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt                        | 51 +++++++++++++------
 lib/newlib_tests/runtest.sh                   |  5 +-
 lib/newlib_tests/shell/tst_check_kconfig01.sh | 15 ++++++
 lib/newlib_tests/shell/tst_check_kconfig02.sh | 14 +++++
 lib/newlib_tests/shell/tst_check_kconfig03.sh | 15 ++++++
 lib/newlib_tests/shell/tst_check_kconfig04.sh | 24 +++++++++
 lib/newlib_tests/shell/tst_check_kconfig05.sh | 16 ++++++
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  3 +-
 testcases/lib/tst_check_kconfigs.c            | 46 +++++++++++++++++
 testcases/lib/tst_test.sh                     | 24 +++++++++
 11 files changed, 196 insertions(+), 18 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig01.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig02.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig03.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig04.sh
 create mode 100755 lib/newlib_tests/shell/tst_check_kconfig05.sh
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
index 8b2fe347a..ad213eef6 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -6,7 +6,8 @@ tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
 tst_fuzzy_sync03 test_zero_hugepage.sh}"
 
-LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
+LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
+shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
@@ -179,6 +180,8 @@ if [ -z "$run" -o "$run" = "c" ]; then
 fi
 
 if [ -z "$run" -o "$run" = "s" ]; then
+	export KCONFIG_PATH=config02
+	runtest_res TINFO "KCONFIG_PATH='$KCONFIG_PATH'"
 	run_shell_tests
 	shell_fail=$?
 fi
diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
new file mode 100755
index 000000000..03f86266d
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
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
index 000000000..6a20cfc3d
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
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
index 000000000..361b6bf0b
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
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
new file mode 100755
index 000000000..21cd998dd
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+	tst_check_kconfigs "CONFIG_EXT4_FS"
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "kernel .config has CONFIG_EXT4_FS"
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
diff --git a/lib/newlib_tests/shell/tst_check_kconfig05.sh b/lib/newlib_tests/shell/tst_check_kconfig05.sh
new file mode 100755
index 000000000..f118f27a5
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+	tst_require_kconfigs "CONFIG_EXT4_FS"
+	tst_res TPASS "kernel .config has CONFIG_EXT4_FS"
+
+	tst_require_kconfigs "CONFIG_EXT4"
+	tst_res TFAIL "kernel .config has CONFIG_EXT4"
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
index 000000000..b0f1f201a
--- /dev/null
+++ b/testcases/lib/tst_check_kconfigs.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include "tst_kconfig.h"
+
+int main(int argc, char *argv[])
+{
+	char *str = argv[1];
+	char *delim = argv[2];
+	unsigned int i, cnt = 1;
+	int ret = 0;
+
+	if (argc == 2 || strlen(delim) == 0) {
+		delim = ",";
+	} else if (argc == 3) {
+		if (strlen(delim) > 1) {
+			fprintf(stderr, "The delim must be a single character\n");
+			return 1;
+		}
+	} else {
+		fprintf(stderr, "Please provide kernel kconfig list and delim "
+				"(optinal, default value is ',')\n");
+		return 1;
+	}
+
+	for (i = 0; str[i]; i++) {
+		if (str[i] == delim[0])
+			cnt++;
+	}
+
+	char **kconfigs = malloc(++i * sizeof(char *));
+
+	for (i = 0; i < cnt; i++)
+		kconfigs[i] = strtok_r(str, delim, &str);
+
+	kconfigs[i] = NULL;
+
+	if (tst_kconfig_check((const char * const*)kconfigs))
+		ret = 1;
+
+	free(kconfigs);
+	return ret;
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2556b28f5..30614974c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -412,6 +412,26 @@ tst_require_drivers()
 	return 0
 }
 
+tst_require_kconfigs()
+{
+	local delim
+
+	if [ $# -gt 2 ]; then
+		return 0
+	elif [ $# -eq 1 ]; then
+		delim="$TST_NEEDS_KCONFIGS_IFS"
+	else
+		delim="$2"
+	fi
+
+	[ -z "$1" ] && return 0
+
+	tst_check_kconfigs "$1" "$delim" > /dev/null
+
+	[ $? -ne 0 ] && tst_brk TCONF "Aborting due to unsuitable kernel config, see above!"
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -587,6 +607,7 @@ tst_run()
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
+			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
@@ -627,6 +648,7 @@ tst_run()
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
 	tst_require_cmds $TST_NEEDS_CMDS
+	tst_require_kconfigs "$TST_NEEDS_KCONFIGS"
 	tst_require_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
@@ -748,6 +770,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
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
