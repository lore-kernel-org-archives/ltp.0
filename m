Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAFCC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 08:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9323C2349
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 09:07:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 823293C21F1
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:07:50 +0100 (CET)
Received: from mail1.bemta32.sdw.messagelabs.com
 (mail1.bemta32.messagelabs.com [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 80D50600D27
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638864468; i=@fujitsu.com;
 bh=PBMvlFsYy2TMDECAaRLMDCOkUTveufExZG/3Iaairj8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=ePDjnK82G0EWGv3yjMvCMh3oQ+Jhg1CFEgZ9Js+ZkrLXTPXE6SM+1WLppDkeiXPvm
 Lfennub9+px+cZtUgtRzl0RakJNxV6DlbMHg//eHCFpg67Cvg31RdhyS8pV0wqDAI5
 GIx9zQEBdFBq+KW4bs8jmy8KfzS/dG+gts3FI2tJJoiJDXEiVuD7MigbSeFlo6ATY4
 1Ugd0ghlnwM+XYZ41Vu9WezU8kL3VRzNauTf1RwPRCnQsxWLfada0fVILtfM7auRR6
 H2cT9+8eTWzl2FJc76/u8GFg5YpEf/92GQYkv+q36qUoFH7e8abOQz8mJEd+eKafg/
 tLZvQZyWQaNbw==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 39/BF-28408-4561FA16;
 Tue, 07 Dec 2021 08:07:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8MxSTdYbH2
 iwbazphYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bK7SIFH7Mq1vyayNbA+Cuyi5GLQ0jgLKPE
 vaffGCGcnUwSjcv3sUE4uxkldu29DuRwcrAJaEo861zADGKLCEhIdDS8ZQexmQXUJZZP+sUEY
 gsLuEj03PzNCGKzCKhI3F6xFCzOK+Ah8WT2ErB6CQEFiSkP34PN4QSqudfWygJiCwkoS7yf+o
 YZol5Q4uTMJywQ8yUkDr54wQzRqyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjIKzkLTPQtK+gJF
 pFaNVUlFmekZJbmJmjq6hgYGuoaGpromukbGlXmKVbqJeaqlueWpxia6hXmJ5sV5qcbFecWVu
 ck6KXl5qySZGYBCnFLO838HY1PdT7xCjJAeTkijvDIH1iUJ8SfkplRmJxRnxRaU5qcWHGGU4O
 JQkeNVFgHKCRanpqRVpmTnAiIJJS3DwKInwngRJ8xYXJOYWZ6ZDpE4xGnNcvj5vETNH86Tl25
 mFWPLy81KlxHkDQUoFQEozSvPgBsEi/RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5dUaA
 pPJl5JXD7XgGdwgR0Skz/apBTShIRUlINTCXHtC6JHzvM4xEeKbSLNWphndCGp9/DbrXb1XzJ
 uOJXVXh7bY3vGvdrtQn6YRe8dxdP9/1Y6uHPPCXpfEfbJRWtmHfBhV4+fkezzh48ocVxXmD9n
 IYPjw5W/640Ve28yvZAcoLkgazeJEWHkpTrEhf/TVNYm8zUet7RMV7+56wr/3OFfyofnXNDc9
 3lMxcmnM7bnPE35ZanwNRZiVfmuH5Ulkr3vvWHl4tz66Wjj5wTdnvt1dywz1c329/lWuuqk19
 0J+5UfHNywXK9F/tWbPq0Zo9uy172b/xO8V7dG9fXVZ20Z1v5eGcVe8n7NV5CswV2hNmVBqnz
 tOY6eYh+nJS0nfXWnIYt5v83pAcsOK/EUpyRaKjFXFScCADdglalbwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-587.messagelabs.com!1638864467!94948!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30946 invoked from network); 7 Dec 2021 08:07:47 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Dec 2021 08:07:47 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 65F91100458
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:07:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5956A100453
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:07:47 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 08:07:45 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 7 Dec 2021 16:08:02 +0800
Message-ID: <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ya4DeVrCa1X8IFjk@yuki>
References: <Ya4DeVrCa1X8IFjk@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] library: add cmd check handler in needs_cmds
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

As Cyril suggested, add cmd check handler in needs_cmd.

We don't use tst_ prefix ie tst_check_cmd since we don't export this api to user.
This check_cmd not only check cmd whether existed but also check the cmd version whether
meet test's requirement.

In check_cmd function, use strtok_r to split cmd_token,op_token,version_token.
It only supports six operations '>=' '<=' '>' '<' '==' '!='.

Currently, for the command version check, it only supports  mkfs.ext4 command. If you
want to support more commands, just add your own .parser and .table_get methond in
version_parsers structure.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1->v2
1. rename tst_version_parser to check_cmd
2. For mkfs_ext4_version_table_get method, use sscanf instead of strtok_r
3. use enum for cmd op
4. fix description
5. add more newlib test for this
 doc/c-test-api.txt                   |  14 +++
 lib/newlib_tests/.gitignore          |   8 ++
 lib/newlib_tests/test_needs_cmds01.c |  25 ++++
 lib/newlib_tests/test_needs_cmds02.c |  24 ++++
 lib/newlib_tests/test_needs_cmds03.c |  24 ++++
 lib/newlib_tests/test_needs_cmds04.c |  24 ++++
 lib/newlib_tests/test_needs_cmds05.c |  24 ++++
 lib/newlib_tests/test_needs_cmds06.c |  24 ++++
 lib/newlib_tests/test_needs_cmds07.c |  24 ++++
 lib/newlib_tests/test_needs_cmds08.c |  27 +++++
 lib/tst_test.c                       | 169 ++++++++++++++++++++++++++-
 11 files changed, 384 insertions(+), 3 deletions(-)
 create mode 100644 lib/newlib_tests/test_needs_cmds01.c
 create mode 100644 lib/newlib_tests/test_needs_cmds02.c
 create mode 100644 lib/newlib_tests/test_needs_cmds03.c
 create mode 100644 lib/newlib_tests/test_needs_cmds04.c
 create mode 100644 lib/newlib_tests/test_needs_cmds05.c
 create mode 100644 lib/newlib_tests/test_needs_cmds06.c
 create mode 100644 lib/newlib_tests/test_needs_cmds07.c
 create mode 100644 lib/newlib_tests/test_needs_cmds08.c

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64d0630ce..d35708516 100644
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
+of lib/tst_test.c.
+
 1.36 Assert sys or proc file value
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index cf467b5a0..a19fa22e8 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -46,4 +46,12 @@ test_macros06
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
+test_needs_cmds01
+test_needs_cmds02
+test_needs_cmds03
+test_needs_cmds04
+test_needs_cmds05
+test_needs_cmds06
+test_needs_cmds07
+test_needs_cmds08
 test_zero_hugepage
diff --git a/lib/newlib_tests/test_needs_cmds01.c b/lib/newlib_tests/test_needs_cmds01.c
new file mode 100644
index 000000000..0ce69d61e
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds01.c
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
+	tst_res(TPASS, "Tesing check_cmd() functionality OK.");
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
diff --git a/lib/newlib_tests/test_needs_cmds02.c b/lib/newlib_tests/test_needs_cmds02.c
new file mode 100644
index 000000000..1eeaf6351
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds02.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using non-existing cmd.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Nonexisting command is present!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext45 >= 1.43.0",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds03.c b/lib/newlib_tests/test_needs_cmds03.c
new file mode 100644
index 000000000..c50077f4e
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds03.c
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
+	tst_res(TFAIL, "Wrong operator was evaluated!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 ! 1.43.0",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds04.c b/lib/newlib_tests/test_needs_cmds04.c
new file mode 100644
index 000000000..5d05ed46d
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds04.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using incomplete version.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Incomplete version was parsed!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 > 1.43",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds05.c b/lib/newlib_tests/test_needs_cmds05.c
new file mode 100644
index 000000000..f4b509b68
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds05.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format by using version that has garbage.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Garbage version was parsed!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 > 1.43.0-1",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds06.c b/lib/newlib_tests/test_needs_cmds06.c
new file mode 100644
index 000000000..f1234820e
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds06.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test Illegal format with garbage.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Garbage format was parsed!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 > 1.43.0 2",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds07.c b/lib/newlib_tests/test_needs_cmds07.c
new file mode 100644
index 000000000..e2d2643f4
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds07.c
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
+	tst_res(TFAIL, "Nonexisting command is present!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext45",
+		NULL
+	}
+};
diff --git a/lib/newlib_tests/test_needs_cmds08.c b/lib/newlib_tests/test_needs_cmds08.c
new file mode 100644
index 000000000..342c3716c
--- /dev/null
+++ b/lib/newlib_tests/test_needs_cmds08.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test mkfs.xfs that it doesn't have own parser and table_get function
+ * at the version_parsers structure in lib/tst_test.c.
+ * So it should report parser function for this cmd is not implemented.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Nonexisting parser function for mkfs.xfs is present!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.xfs",
+		"mkfs.xfs >= 4.20.0",
+		NULL
+	}
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..7cca209ab 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -65,6 +65,15 @@ struct results {
 	unsigned int timeout;
 };
 
+enum cmd_op {
+	OP_GE, /* >= */
+	OP_GT, /* >  */
+	OP_LE, /* <= */
+	OP_LT, /* <  */
+	OP_EQ, /* == */
+	OP_NE, /* != */
+};
+
 static struct results *results;
 
 static int ipc_fd;
@@ -950,6 +959,162 @@ static void prepare_device(void)
 	}
 }
 
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
+	int major, minor, patch;
+	int len;
+
+	if (sscanf(version, "%u.%u.%u %n", &major, &minor, &patch, &len) != 3) {
+		tst_res(TWARN, "Illega version(%s), "
+			"should use format like 1.43.0", version);
+		return -1;
+	}
+
+	if (len != (int)strlen(version)) {
+		tst_res(TWARN, "Grabage after version");
+		return -1;
+	}
+
+	return major * 10000 + minor * 100 + patch;
+}
+
+static struct version_parser {
+	const char *cmd;
+	int (*parser)(void);
+	int (*table_get)(char *version);
+} version_parsers[] = {
+	{"mkfs.ext4", mkfs_ext4_version_parser, mkfs_ext4_version_table_get},
+	{},
+};
+
+static void check_cmd(const char *cmd)
+{
+	struct version_parser *p;
+	char *cmd_token, *op_token, *version_token, *next, *str;
+	char path[PATH_MAX];
+	char parser_cmd[100];
+	int ver_parser, ver_get;
+	int op_flag = 0;
+
+	strcpy(parser_cmd, cmd);
+
+	cmd_token = strtok_r(parser_cmd, " ", &next);
+	op_token = strtok_r(NULL, " ", &next);
+	version_token = strtok_r(NULL, " ", &next);
+	str = strtok_r(NULL, " ", &next);
+
+	if (tst_get_path(cmd_token, path, sizeof(path)))
+		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
+
+	if (!op_token)
+		return;
+
+	if (!strcmp(op_token, ">="))
+		op_flag = OP_GE;
+	else if (!strcmp(op_token, ">"))
+		op_flag = OP_GT;
+	else if (!strcmp(op_token, "<="))
+		op_flag = OP_LE;
+	else if (!strcmp(op_token, "<"))
+		op_flag = OP_LT;
+	else if (!strcmp(op_token, "=="))
+		op_flag = OP_EQ;
+	else if (!strcmp(op_token, "!="))
+		op_flag = OP_NE;
+	else
+		tst_brk(TCONF, "Invalid op(%s)", op_token);
+
+	if (!version_token || str) {
+		tst_brk(TCONF, "Illegal format(%s), should use format like "
+			"mkfs.ext4 >= 1.43.0", cmd);
+	}
+
+	for (p = &version_parsers[0]; p->cmd; p++) {
+		if (!strcmp(p->cmd, cmd_token)) {
+			tst_res(TINFO, "Parsing %s version", p->cmd);
+			break;
+		}
+	}
+
+	if (!p->cmd) {
+		tst_brk(TBROK, "No version parser for %s implemented!",
+			cmd_token);
+	}
+
+	ver_parser = p->parser();
+	if (ver_parser < 0)
+		tst_brk(TBROK, "Failed to parse %s version", p->cmd);
+
+	ver_get = p->table_get(version_token);
+	if (ver_get < 0)
+		tst_brk(TBROK, "Failed to get %s version", p->cmd);
+
+	switch (op_flag) {
+	case OP_GE:
+		if (ver_parser < ver_get) {
+			tst_brk(TCONF, "%s required >= %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_GT:
+		if (ver_parser <= ver_get) {
+			tst_brk(TCONF, "%s required > %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_LE:
+		if (ver_parser > ver_get) {
+			tst_brk(TCONF, "%s required <= %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_LT:
+		if (ver_parser >= ver_get) {
+			tst_brk(TCONF, "%s required < %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_EQ:
+		if (ver_parser != ver_get) {
+			tst_brk(TCONF, "%s required == %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_NE:
+		if (ver_parser == ver_get) {
+			tst_brk(TCONF, "%s required != %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	}
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -987,12 +1152,10 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->needs_cmds) {
 		const char *cmd;
-		char path[PATH_MAX];
 		int i;
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			if (tst_get_path(cmd, path, sizeof(path)))
-				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
+			check_cmd(cmd);
 	}
 
 	if (tst_test->needs_drivers) {
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
