Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A808C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 08:47:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7B03CE97E
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 09:47:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC1ED3CC841
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 09:47:20 +0100 (CET)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E79E91000C68
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 09:47:19 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="126400639"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; d="scan'208";a="126400639"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 17:47:16 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D4CDBD9DA6
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 17:47:14 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C33AF953
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 17:47:14 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id ADA9770B2C
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 17:47:13 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 60CC31A0072;
 Thu,  2 Nov 2023 16:47:13 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu,  2 Nov 2023 04:05:35 -0400
Message-Id: <20231102080535.63847-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.006
X-TMASE-Result: 10--16.858600-10.000000
X-TMASE-MatchedRID: kREspPIIG7SPo+6vQMop+jYTypjB3iDVMVVFhl7NwvNM+b8yxBqvA48G
 DEpogLcwmzzMF21UDfkSuJRtSU84o1o8LOaXS5gWTuctSpiuWyU2ZWOmuJUS2VgLks93sG9t09D
 6Rw2zIrO+c1YW/zYo9lM67ebhB/uCoDlDgS6jzLSnOYknDZ/QoR5KThfB7m1yycmFNidOeD2lzb
 GAkBjour3SKCxDfa5NEo4+Y44Pf0GVMViPmIQzhf9XRIMLUOjQuoYFb0nRiqNHpEd1UrzmFdn/o
 cIR7L314vM1YF6AJbairWjTJ+o3GQtuKBGekqUpPjKoPgsq7cA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add error tests for pathconf() system call
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

A series of tests were added to test the negative results of pathconf()

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/pathconf/.gitignore |  1 +
 .../kernel/syscalls/pathconf/pathconf02.c     | 97 +++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pathconf/pathconf02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1851752cf..e20f0c49e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -971,6 +971,7 @@ madvise11 madvise11
 newuname01 newuname01
 
 pathconf01 pathconf01
+pathconf02 pathconf02
 
 pause01 pause01
 pause02 pause02
diff --git a/testcases/kernel/syscalls/pathconf/.gitignore b/testcases/kernel/syscalls/pathconf/.gitignore
index 31abe8a28..82e38b253 100644
--- a/testcases/kernel/syscalls/pathconf/.gitignore
+++ b/testcases/kernel/syscalls/pathconf/.gitignore
@@ -1 +1,2 @@
 /pathconf01
+/pathconf02
diff --git a/testcases/kernel/syscalls/pathconf/pathconf02.c b/testcases/kernel/syscalls/pathconf/pathconf02.c
new file mode 100644
index 000000000..8d7996190
--- /dev/null
+++ b/testcases/kernel/syscalls/pathconf/pathconf02.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that,
+ *
+ * - pathconf() fails with ENOTDIR if A component used as a directory
+ *   in path is not in fact a directory.
+ * - pathconf() fails with ENOENT if path is an empty string.
+ * - pathconf() fails with ENAMETOOLONG if path is too long.
+ * - pathconf() fails with EINVA if name is invalid.
+ * - pathconf() fails with EACCES if search permission is denied for
+ *   one of the directories in the path prefix of path.
+ * - pathconf() fails with ELOOP if too many symbolic links were
+ *   encountered while resolving path.
+ */
+
+#define FILEPATH "testfile/testfile_1"
+#define TESTELOOP "test_eloop1"
+
+#include <stdlib.h>
+#include <pwd.h>
+#include "tst_test.h"
+
+static char *fpath;
+static char *emptypath;
+static char path[PATH_MAX + 2];
+static char *long_path = path;
+static char *abs_path;
+static char *testeloop;
+static struct passwd *user;
+
+static struct tcase {
+	char **path;
+	int name;
+	int exp_errno;
+	char *desc;
+} tcases[] = {
+	{&fpath, 0, ENOTDIR, "path prefix is not a directory"},
+	{&emptypath, 0, ENOENT, "path is an empty string"},
+	{&long_path, 0, ENAMETOOLONG, "path is too long"},
+	{&abs_path, -1, EINVAL, "name is invalid"},
+	{&abs_path, 0, EACCES, "without full permissions of the path prefix"},
+	{&testeloop, 0, ELOOP, "too many symbolic links"},
+};
+
+static void verify_fpathconf(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (tc->exp_errno == EACCES)
+		SAFE_SETEUID(user->pw_uid);
+
+	TST_EXP_FAIL(pathconf(*tc->path, tc->name), tc->exp_errno,
+		     "pathconf() fail with %s", tc->desc);
+
+	if (tc->exp_errno == EACCES)
+		SAFE_SETEUID(0);
+}
+
+static void setup(void)
+{
+	user = SAFE_GETPWNAM("nobody");
+
+	SAFE_TOUCH("testfile", 0777, NULL);
+
+	char *tmpdir =  tst_get_tmpdir();
+
+	abs_path = tst_aprintf("%s/%s", tmpdir, FILEPATH);
+
+	SAFE_CHMOD(tmpdir, 0);
+	free(tmpdir);
+
+	memset(path, 'a', PATH_MAX + 2);
+
+	SAFE_SYMLINK("test_eloop1", "test_eloop2");
+	SAFE_SYMLINK("test_eloop2", "test_eloop1");
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_fpathconf,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&fpath, .str = FILEPATH},
+		{&emptypath, .str = ""},
+		{&testeloop, .str = TESTELOOP},
+		{},
+	},
+	.needs_root = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
