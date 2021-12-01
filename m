Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E8AC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 07:54:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 057C53C8F07
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02A833C8D11
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:53:37 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3022910011D8
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638345215; i=@fujitsu.com;
 bh=iRsWLLzVTXtAl4kLjgaqNc0qW52y17Wigv1zDm08l6M=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=sdXXq+nZkEqA4/Vmxm9fmgIJd3yOxAys2gDt983/b7JubW+6A3o4H0LLqZv6PJhqm
 WmZpbih6irdoZiTxjZoK3SeoDEqhYCO8NIJpwzs/HAwRX0OaP/MYX5mZ4keJnRYyoK
 lbJ7s14LltWBzZA/vjMivc8vVGewXq4kQdgZMM1Cf8KxHuyB8ef/Lr811ws/1nT+Bv
 2cK1LXKsTgvEVqpLuGZDqtKZ4pg1aSPZmQ3mt8+5jw+L24XYHZkC4enXWaJyvDSv7F
 ioIxLmRkEuCm9fiUs9zWf9BE0BaeSw8KC8MI3jIDS3y0pbF/MRiA9t4dB3BwqI8p+Q
 qyPf8sKJfiDcA==
Received: from [100.113.0.112] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.symcld.net id E2/D7-15394-FF927A16;
 Wed, 01 Dec 2021 07:53:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRWlGSWpSXmKPExsViZ8MRovtPc3m
 iwZ9pZhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aWjneMBVtiKp5t/sLYwHjUr4uRi0NIoJFJ
 4vOHL8wQzm5GibY5X1m6GDk52AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9YgKxhQVsJPbO+
 QVWwyKgItF88xJQnIODV8BD4vKkCpCwhICCxJSH78FKeAUEJU7OfMICMUZC4uCLF8wQNYoSlz
 q+MULYFRKzZrUxTWDknYWkZRaSlgWMTKsYLZOKMtMzSnITM3N0DQ0MdA0NjXWNdQ0tTfQSq3Q
 T9VJLdZNT80qKEoGyeonlxXrFlbnJOSl6eaklmxiBAZZSyHxoB+OT1x/0DjFKcjApifI+Yl6e
 KMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC10ENKCdYlJqeWpGWmQMMdpi0BAePkggvHzDghXiLC
 xJzizPTIVKnGHU5mict384sxJKXn5cqJc4rC1IkAFKUUZoHNwIWeZcYZaWEeRkZGBiEeApSi3
 IzS1DlXzGKczAqCfPagkzhycwrgdv0CugIJqAj3i5dDHJESSJCSqqBiV+udsOVvTzrVmRvVzU
 788m2ns23lT3I2+729CRFs08MOYsi772U/OyovCPGZe4br8QNjsX/ds9w+MCu+t36xpN5XHeC
 OT7YvOGSiLmkInNMzWOKPfMx+8gfsmGPHjImhXecqu/ZNkepukNgI0fgUSYn0+YXaeWWt05O9
 tAW/RtWv+p0yzQneaXVifrzc64EL6n8cXdp5KmLW25+5rjRdDEkcEP/ISnxTRu5xf228H8TcE
 /ZfdXdY/rbleGvNN03b7g5g7dimde9jzaaWQ+dTl4SfSPocjvlY5aQeUqlWu2F9KhUc5MO0dk
 nY+rf1OdZbHm65TRni92+W1deVn2TfJy957+fod238JD1M1halViKMxINtZiLihMBXr+mZjcD
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-232.messagelabs.com!1638345214!237714!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30932 invoked from network); 1 Dec 2021 07:53:34 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-9.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 1 Dec 2021 07:53:34 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1B17rLbT024965
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 1 Dec 2021 07:53:34 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 1 Dec 2021 07:53:19 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 1 Dec 2021 15:53:27 +0800
Message-ID: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: add cmd parse handler in needs_cmd
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

Testcase ie statx05 needs mkfs.ext4 >= 1.43.0 because of encrypt feature.

As Cyril suggested, add cmd parser handler in needs_cmd.

The difference logic about from before, we don't report not-found error and think it is
cmd version string(need to use tst_version_parser) if tst_get_path fails in tst_test.c.

In tst_version_parser function, use strtok_r to split cmd_token,op_token,version_token.
It only supports six operations '>=' '<=' '>' '<' '==' '!='.

Currently, this tst_version_parser only supports mkfs.ext4 command. If you want to support
more commands, just add your own .parser and .table_get methond in version_parsers structure.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt                       |  14 +++
 include/tst_test.h                       |   1 +
 include/tst_version_parser.h             |  15 +++
 lib/newlib_tests/.gitignore              |   5 +
 lib/newlib_tests/test_version_parser01.c |  25 ++++
 lib/newlib_tests/test_version_parser02.c |  24 ++++
 lib/newlib_tests/test_version_parser03.c |  24 ++++
 lib/newlib_tests/test_version_parser04.c |  24 ++++
 lib/newlib_tests/test_version_parser05.c |  24 ++++
 lib/tst_test.c                           |   2 +-
 lib/tst_version_parser.c                 | 148 +++++++++++++++++++++++
 11 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 include/tst_version_parser.h
 create mode 100644 lib/newlib_tests/test_version_parser01.c
 create mode 100644 lib/newlib_tests/test_version_parser02.c
 create mode 100644 lib/newlib_tests/test_version_parser03.c
 create mode 100644 lib/newlib_tests/test_version_parser04.c
 create mode 100644 lib/newlib_tests/test_version_parser05.c
 create mode 100644 lib/tst_version_parser.c

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64d0630ce..fde6dce0c 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2013,6 +2013,20 @@ terminated array of strings such as:
 },
 -------------------------------------------------------------------------------
 
+Also can check required commands version whether is satisfied by using 'needs_cmds',
+
+[source,c]
+-------------------------------------------------------------------------------
+.needs_cmds = (const char *const []) {
+	"mkfs.ext4 >= 1.43.0",
+	NULL
+},
++-------------------------------------------------------------------------------
+
+Currently, we only support mkfs.ext4 command. If you want to support more commands,
+please fill your own .parser and .table_get method in the version_parsers structure
+of lib/tst_version_parser.c.
+
 1.36 Assert sys or proc file value
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
diff --git a/include/tst_test.h b/include/tst_test.h
index c06a4729b..fd3d4cfee 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -44,6 +44,7 @@
 #include "tst_taint.h"
 #include "tst_memutils.h"
 #include "tst_arch.h"
+#include "tst_version_parser.h"
 
 /*
  * Reports testcase result.
diff --git a/include/tst_version_parser.h b/include/tst_version_parser.h
new file mode 100644
index 000000000..145043929
--- /dev/null
+++ b/include/tst_version_parser.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef TST_VERSION_PARSER_H__
+#define TST_VERSION_PARSER_H__
+
+/*
+ * Parse the cmd version requirement in needs_cmds member of tst_test
+ * structure whether is satisfied.
+ */
+void tst_version_parser(const char *cmd);
+
+#endif /* TST_VERSION_PARSER_H__ */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index cf467b5a0..ef8694d08 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -46,4 +46,9 @@ test_macros06
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
+test_version_parser01
+test_version_parser02
+test_version_parser03
+test_version_parser04
+test_version_parser05
 test_zero_hugepage
diff --git a/lib/newlib_tests/test_version_parser01.c b/lib/newlib_tests/test_version_parser01.c
new file mode 100644
index 000000000..9e1bd3962
--- /dev/null
+++ b/lib/newlib_tests/test_version_parser01.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Tesing tst_version_parser() functionality OK.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4",
+		"mkfs.ext4 >= 1.43.0",
+		"mkfs.ext4 <= 2.0.0",
+		"mkfs.ext4 != 2.0.0",
+		"mkfs.ext4 > 1.43.0",
+		"mkfs.ext4 < 2.0.0",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_version_parser02.c b/lib/newlib_tests/test_version_parser02.c
new file mode 100644
index 000000000..5aedaa28f
--- /dev/null
+++ b/lib/newlib_tests/test_version_parser02.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using Illegal cmd.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext45 >= 1.43.0",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_version_parser03.c b/lib/newlib_tests/test_version_parser03.c
new file mode 100644
index 000000000..8f96e68d2
--- /dev/null
+++ b/lib/newlib_tests/test_version_parser03.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using Illegal operation.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 ! 1.43.0",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_version_parser04.c b/lib/newlib_tests/test_version_parser04.c
new file mode 100644
index 000000000..461f673df
--- /dev/null
+++ b/lib/newlib_tests/test_version_parser04.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using Illegal version.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 > 1.43",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_version_parser05.c b/lib/newlib_tests/test_version_parser05.c
new file mode 100644
index 000000000..1bfe24f73
--- /dev/null
+++ b/lib/newlib_tests/test_version_parser05.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test non-existed cmd whether still can be detected.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext45",
+		NULL
+	}
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..a9e95a3d7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -992,7 +992,7 @@ static void do_setup(int argc, char *argv[])
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
 			if (tst_get_path(cmd, path, sizeof(path)))
-				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
+				tst_version_parser(cmd);
 	}
 
 	if (tst_test->needs_drivers) {
diff --git a/lib/tst_version_parser.c b/lib/tst_version_parser.c
new file mode 100644
index 000000000..296e25ea2
--- /dev/null
+++ b/lib/tst_version_parser.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_version_parser.h"
+#include "tst_test.h"
+
+static int mkfs_ext4_version_parser(void)
+{
+	FILE *f;
+	int rc, major, minor, patch;
+
+	f = popen("mkfs.ext4 -V 2>&1", "r");
+	if (!f) {
+		tst_res(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
+		return -1;
+	}
+	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
+	pclose(f);
+	if (rc != 3) {
+		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
+		return -1;
+	}
+
+	return major * 10000 +  minor * 100 + patch;
+}
+
+static int mkfs_ext4_version_table_get(char *version)
+{
+	char *major, *minor, *patch, *next, *str;
+	char table_version[100];
+
+	strcpy(table_version, version);
+
+	major = strtok_r(table_version, ".", &next);
+	minor = strtok_r(NULL, ".", &next);
+	patch = strtok_r(NULL, ".", &next);
+	str = strtok_r(NULL, ".", &next);
+	if (!major || !minor || !patch || str) {
+		tst_res(TWARN, "Illegal version(%s), should use format like 1.43.0", version);
+		return -1;
+	}
+
+	return atoi(major) * 10000 + atoi(minor) * 100 + atoi(patch);
+}
+
+static struct version_parser {
+	const char *cmd;
+	int (*parser)(void);
+	int (*table_get)(char *version);
+} version_parsers[] = {
+	{.cmd = "mkfs.ext4", .parser = mkfs_ext4_version_parser, .table_get = mkfs_ext4_version_table_get},
+	{},
+};
+
+void tst_version_parser(const char *cmd)
+{
+	struct version_parser *p;
+	char *cmd_token, *op, *version, *next, *str;
+	char path[PATH_MAX];
+	char parser_cmd[100];
+	int ver_parser, ver_get;
+	int op_flag = 0;
+
+	strcpy(parser_cmd, cmd);
+
+	cmd_token = strtok_r(parser_cmd, " ", &next);
+	op = strtok_r(NULL, " ", &next);
+	version = strtok_r(NULL, " ", &next);
+	str = strtok_r(NULL, " ", &next);
+	if (!cmd_token || !op || !version || str)
+		tst_brk(TCONF,
+			"Illegal fomart(%s), should use format like mkfs.ext4 >= 1.43.0", cmd);
+
+	if (tst_get_path(cmd_token, path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
+
+	if (!strcmp(op, ">="))
+		op_flag = 1;
+
+	if (!strcmp(op, ">"))
+		op_flag = 2;
+
+	if (!strcmp(op, "<="))
+		op_flag = 3;
+
+	if (!strcmp(op, "<"))
+		op_flag = 4;
+
+	if (!strcmp(op, "=="))
+		op_flag = 5;
+
+	if (!strcmp(op, "!="))
+		op_flag = 6;
+
+	if (!op_flag)
+		tst_brk(TCONF, "Invalid op(%s)", op);
+
+	for (p = &version_parsers[0]; p; p++) {
+		if (!strcmp(p->cmd, cmd_token))
+			tst_res(TINFO, "Parsing %s version", p->cmd);
+			break;
+	}
+
+	if (!p->cmd)
+		tst_brk(TBROK, "No version parser for %s implemented!", cmd_token);
+
+	ver_parser = p->parser();
+	if (ver_parser < 0)
+		tst_brk(TBROK, "Failed to parse %s version", p->cmd);
+
+	ver_get = p->table_get(version);
+	if (ver_get < 0)
+		tst_brk(TBROK, "Failed to get %s version", p->cmd);
+
+	switch (op_flag) {
+	case 1:
+		if (ver_parser < ver_get)
+			tst_brk(TCONF, "cmd(%s) expected >= %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	case 2:
+		if (ver_parser <= ver_get)
+			tst_brk(TCONF, "cmd(%s) expected > %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	case 3:
+		if (ver_parser > ver_get)
+			tst_brk(TCONF, "cmd(%s) expected <= %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	case 4:
+		if (ver_parser >= ver_get)
+			tst_brk(TCONF, "cmd(%s) expected < %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	case 5:
+		if (ver_parser != ver_get)
+			tst_brk(TCONF, "cmd(%s) expected == %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	case 6:
+		if (ver_parser == ver_get)
+			tst_brk(TCONF, "cmd(%s) expected != %d, but got %d", cmd, ver_get, ver_parser);
+		break;
+	}
+}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
