Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D400C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 03:21:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 782913C64A5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 04:21:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 820253C013D
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 04:21:03 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E34FF601AF5
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 04:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639020061; i=@fujitsu.com;
 bh=Wbx1pxVYMghDQxCTrS7d9ym00nvccPvXFEaUkvSfS88=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=EIw9A2R/RNEuzcP1FkkQGMnZMsMoI0hhhLDyK5u5+mqjpgM3SUdPY9GoHhRdz4EaV
 vLfw1Liu6MyMTmPD8Jem3BB/2VfJis4Td2wAfk10/il1HVrYtXOP7VlQ46Rb60h5YD
 KJ+2w6S2xgw/KmdvQ7C+9McxKz513ddNJfvgrStxBKBfEpiZAw9Ix2qzwnFs/3HkJS
 AevJAPkIkMHQS867e/EVlx5GU5q4Kj8hfqp6dq7med6o+q/rnwMfCvrSmTMzfjA66r
 it6y1A1x/dEX8NOhayvR2mUHofs4vfJrZb/XolrbEm0BeAn3HRDtq1mRVog83x9yDH
 qhfCXc47LrkMw==
Received: from [100.115.34.229] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id E5/A9-16537-C1671B16;
 Thu, 09 Dec 2021 03:21:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsViZ8MRoitTtjH
 RoL9LyGLF9x2MDowe+36vYw1gjGLNzEvKr0hgzfh68yhzwY/qijM7EhsYr2d0MXJxCAk0MknM
 enGWCcLZzSix+tAe1i5GTg42AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb+AGjg4hAVcJJqvK
 YKEWQRUJBZ+6GYCsXkFPCRmLDjACGJLCChITHn4HmwMp4CqxOmj79lAbCGg+tYN3xgh6gUlTs
 58wgIxXkLi4IsXzBC9ihKXOr5BzamQmDWrjWkCI/8sJC2zkLQsYGRaxWidVJSZnlGSm5iZo2t
 oYKBraGiqa2ypa2hpqpdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERiSKcXq
 h3cwvrn0Te8QoyQHk5IoLyvnxkQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErwGJUA5waLU9NSKt
 MwcYHzApCU4eJREeEVB0rzFBYm5xZnpEKlTjMYcl6/PW8TM0Txp+XZmIZa8/LxUKXHeFyClAi
 ClGaV5cINgcXuJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvSCnQFJ7MvBK4fa+ATmECOsW
 5ZT3IKSWJCCmpBibHSecmGPTwylivjlTivF3zU+uHpmESQwJ72eQrjpMeLAiccV4p5uuF3yKT
 vrzOPsDYe/pG/A1t5fisX8e2L/3fJT0xx3vazosrJNVneBmtCc6asXta1Zc3lhOCbsceaQ9qW
 zEzfDvL2WMbZvsZvH6491eTzLeIxYESS1/c09eymFS1cXkAy/KND4Trai3yBebebmPy/PS14m
 tio3WP/aS4S8wWjz9u2ZEakboh6kPAs28nmj6a/F0sFCo6V+st/5RrftfrNBWXpm1k15OT/MQ
 069bRTPOgRwVmUfnTWKq/MZ2futvEX61i56e7GRr5/HNchb6l+jCltrfo7ZxbcnrZwrQDMyv5
 Qo4vlZar4+NXYinOSDTUYi4qTgQAPjqzyVYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-548.messagelabs.com!1639020060!57631!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20189 invoked from network); 9 Dec 2021 03:21:00 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-19.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2021 03:21:00 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1B93Kr43025326
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Thu, 9 Dec 2021 03:21:00 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 9 Dec 2021 03:20:50 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 9 Dec 2021 11:21:07 +0800
Message-ID: <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YbDl7YtVZvYXPxwp@pevik>
References: <YbDl7YtVZvYXPxwp@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] library: add cmd check handler in needs_cmds
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

This tst_check_cmd not only check cmd whether exists but also check the cmd
version whether meets test's requirement.

In tst_check_cmd function, use strtok_r to split cmd_token,op_token,version_token.
It only supports six operations '>=' '<=' '>' '<' '==' '!='.

Currently, for the command version check, it only supports mkfs.ext4 command. If you
want to support more commands, just add your own .parser and .table_get methond in
version_parsers structure.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v2-v3:
1. rename check_cmd to tst_check_cmd
2. move code into tst_cmd.c instead of tst_test.c
3. export tst_cmd_check function into tst_private.h
4. add test_needs_cmds cases into runtest.sh
5. fix typo
v1->v2
1. rename tst_version_parser to check_cmd
2. For mkfs_ext4_version_table_get method, use sscanf instead of strtok_r
3. use enum for cmd op
4. fix description
5. add more newlib test for this
 doc/c-test-api.txt                   |  14 +++
 include/tst_private.h                |   9 ++
 lib/newlib_tests/.gitignore          |   8 ++
 lib/newlib_tests/runtest.sh          |   5 +-
 lib/newlib_tests/test_needs_cmds01.c |  25 ++++
 lib/newlib_tests/test_needs_cmds02.c |  24 ++++
 lib/newlib_tests/test_needs_cmds03.c |  24 ++++
 lib/newlib_tests/test_needs_cmds04.c |  24 ++++
 lib/newlib_tests/test_needs_cmds05.c |  24 ++++
 lib/newlib_tests/test_needs_cmds06.c |  24 ++++
 lib/newlib_tests/test_needs_cmds07.c |  24 ++++
 lib/newlib_tests/test_needs_cmds08.c |  27 +++++
 lib/tst_cmd.c                        | 168 +++++++++++++++++++++++++++
 lib/tst_test.c                       |   6 +-
 14 files changed, 400 insertions(+), 6 deletions(-)
 create mode 100644 lib/newlib_tests/test_needs_cmds01.c
 create mode 100644 lib/newlib_tests/test_needs_cmds02.c
 create mode 100644 lib/newlib_tests/test_needs_cmds03.c
 create mode 100644 lib/newlib_tests/test_needs_cmds04.c
 create mode 100644 lib/newlib_tests/test_needs_cmds05.c
 create mode 100644 lib/newlib_tests/test_needs_cmds06.c
 create mode 100644 lib/newlib_tests/test_needs_cmds07.c
 create mode 100644 lib/newlib_tests/test_needs_cmds08.c

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64d0630ce..0555cd614 100644
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
+Currently, we only support mkfs.ext4 command version check.
+If you want to support more commands, please fill your own .parser and .table_get
+method in the version_parsers structure of lib/tst_cmd.c.
+
 1.36 Assert sys or proc file value
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
diff --git a/include/tst_private.h b/include/tst_private.h
index fe0955f3b..b02f91228 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -37,4 +37,13 @@ int tst_get_prefix(const char *ip_str, int is_ipv6);
  */
 char tst_kconfig_get(const char *confname);
 
+/*
+ * If cmd argument is a single command, this function just checks command
+ * whether exists. If not, case skips.
+ * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
+ * function checks command version whether meets this requirement.
+ * If not, case skips.
+ */
+void tst_check_cmd(const char *cmd);
+
 #endif
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
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 05c76228b..da01f36d9 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -2,8 +2,9 @@
 # Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
-tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync03
-test_zero_hugepage.sh}"
+test_needs_cmds01 test_needs_cmds02 test_needs_cmds03 test_needs_cmds06
+test_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
+tst_fuzzy_sync03 test_zero_hugepage.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
 
diff --git a/lib/newlib_tests/test_needs_cmds01.c b/lib/newlib_tests/test_needs_cmds01.c
new file mode 100644
index 000000000..92305ee97
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
+	tst_res(TPASS, "Testing tst_check_cmd() functionality OK.");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4",
+		"mkfs.ext4 >= 1.0.0",
+		"mkfs.ext4 <= 2.0.0",
+		"mkfs.ext4 != 2.0.0",
+		"mkfs.ext4 > 1.0.0",
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
index 000000000..acc28d926
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
+ * at the version_parsers structure in lib/tst_cmd.c.
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
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 7446249f9..229848c28 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -28,10 +28,21 @@
 #include <signal.h>
 #include "test.h"
 #include "tst_cmd.h"
+#include "tst_private.h"
 
 #define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
 #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
 
+enum cmd_op {
+	OP_GE, /* >= */
+	OP_GT, /* >  */
+	OP_LE, /* <= */
+	OP_LT, /* <  */
+	OP_EQ, /* == */
+	OP_NE, /* != */
+};
+
+
 int tst_cmd_fds_(void (cleanup_fn)(void),
 		const char *const argv[],
 		int stdout_fd,
@@ -176,3 +187,160 @@ int tst_system(const char *command)
 	signal(SIGCHLD, old_handler);
 	return ret;
 }
+
+static int mkfs_ext4_version_parser(void)
+{
+	FILE *f;
+	int rc, major, minor, patch;
+
+	f = popen("mkfs.ext4 -V 2>&1", "r");
+	if (!f) {
+		tst_resm(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
+		return -1;
+	}
+
+	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
+	pclose(f);
+	if (rc != 3) {
+		tst_resm(TWARN, "Unable to parse mkfs.ext4 version");
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
+		tst_resm(TWARN, "Illegal version(%s), should use format like 1.43.0", version);
+		return -1;
+	}
+
+	if (len != (int)strlen(version)) {
+		tst_resm(TWARN, "Grabage after version");
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
+void tst_check_cmd(const char *cmd)
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
+		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
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
+		tst_brkm(TCONF, NULL, "Invalid op(%s)", op_token);
+
+	if (!version_token || str) {
+		tst_brkm(TCONF, NULL,
+			"Illegal format(%s), should use format like mkfs.ext4 >= 1.43.0",
+			cmd);
+	}
+
+	for (p = &version_parsers[0]; p->cmd; p++) {
+		if (!strcmp(p->cmd, cmd_token)) {
+			tst_resm(TINFO, "Parsing %s version", p->cmd);
+			break;
+		}
+	}
+
+	if (!p->cmd) {
+		tst_brkm(TBROK, NULL, "No version parser for %s implemented!",
+			cmd_token);
+	}
+
+	ver_parser = p->parser();
+	if (ver_parser < 0)
+		tst_brkm(TBROK, NULL, "Failed to parse %s version", p->cmd);
+
+	ver_get = p->table_get(version_token);
+	if (ver_get < 0)
+		tst_brkm(TBROK, NULL, "Failed to get %s version", p->cmd);
+
+	switch (op_flag) {
+	case OP_GE:
+		if (ver_parser < ver_get) {
+			tst_brkm(TCONF, NULL, "%s required >= %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_GT:
+		if (ver_parser <= ver_get) {
+			tst_brkm(TCONF, NULL, "%s required > %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_LE:
+		if (ver_parser > ver_get) {
+			tst_brkm(TCONF, NULL, "%s required <= %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_LT:
+		if (ver_parser >= ver_get) {
+			tst_brkm(TCONF, NULL, "%s required < %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_EQ:
+		if (ver_parser != ver_get) {
+			tst_brkm(TCONF, NULL, "%s required == %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	case OP_NE:
+		if (ver_parser == ver_get) {
+			tst_brkm(TCONF, NULL, "%s required != %d, but got %d, "
+				"the version is required in order run the test.",
+				cmd, ver_get, ver_parser);
+		}
+		break;
+	}
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..c49e30f5b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -29,7 +29,7 @@
 #include "tst_wallclock.h"
 #include "tst_sys_conf.h"
 #include "tst_kconfig.h"
-
+#include "tst_private.h"
 #include "old_resource.h"
 #include "old_device.h"
 #include "old_tmpdir.h"
@@ -987,12 +987,10 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->needs_cmds) {
 		const char *cmd;
-		char path[PATH_MAX];
 		int i;
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			if (tst_get_path(cmd, path, sizeof(path)))
-				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
+			tst_check_cmd(cmd);
 	}
 
 	if (tst_test->needs_drivers) {
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
