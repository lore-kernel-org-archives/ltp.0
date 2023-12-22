Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2199DC41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 09:45:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C1A3CF232
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 10:45:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35523CB2A8
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 10:45:07 +0100 (CET)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC81B2202F0
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 10:45:05 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="123086686"
X-IronPort-AV: E=Sophos;i="6.04,296,1695654000"; d="scan'208";a="123086686"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 18:45:04 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 30DC7DCC16
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 52C2DD601A
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E715522DD1B
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 96D051A0075;
 Fri, 22 Dec 2023 17:45:00 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 04:44:55 -0500
Message-Id: <20231222094455.3878-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
References: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.006
X-TMASE-Result: 10--14.612100-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb2Po+6vQMop+jYTypjB3iDVMVVFhl7NwvNM+b8yxBqvA48G
 DEpogLcwmzzMF21UDfkSuJRtSU84o1o8LOaXS5gWTuctSpiuWyU2ZWOmuJUS2QMFD5cGHhglDMo
 0XQZly2hsXqCizdUSQ+i9kuvczI15vlICZ4RQ8+7X3j/lf1V8LBokPBiBBj9/34IWA8b/pV1bVE
 WYN/4Idg4/GEQ2nzo2FLNoOUSLINYXHLPN9+q8ed9JA2lmQRNUHhysWPN3OzibKItl61J/yZ+in
 TK0bC9eKrauXd3MZDUMuCG+fAyq2oI+wcnBm2uAAPQjJAMaakhpwmvd4oDckKYK4DiiMuuW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] fchownat03: Add error tests for fchownat()
 system call
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

A series of tests were added to test the negative results of fchownat()

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fchownat/.gitignore |   1 +
 .../kernel/syscalls/fchownat/fchownat03.c     | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b7ceb25d3..589c2c9a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -275,6 +275,7 @@ fchown05_16 fchown05_16
 #fchownat test case
 fchownat01 fchownat01
 fchownat02 fchownat02
+fchownat03 fchownat03
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
index 35c00345b..60fac7e69 100644
--- a/testcases/kernel/syscalls/fchownat/.gitignore
+++ b/testcases/kernel/syscalls/fchownat/.gitignore
@@ -1,2 +1,3 @@
 /fchownat01
 /fchownat02
+/fchownat03
diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
new file mode 100644
index 000000000..85591dd93
--- /dev/null
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2006-2023
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * - fchownat() fails with ENOTDIR  if dir_fd is file descriptor to the file
+ *   and pathname is relative path of the file.
+ * - fchownat() fails with EBADF if dir_fd is invalid.
+ * - fchownat() fails with EINVAL if flag is invalid.
+ * - fchownat() fails with ENAMETOOLONG if pathname is too long.
+ * - fchownat() fails with ELOOP if too many symbolic links were
+ *   encountered while resolving path.
+ * - fchownat() fails with ENOENT if the file does not exist.
+ * - fchownat() fails with EFAULT if pathname points outside accessible
+ *   address space.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define TESTFILE  "testfile"
+#define TESTELOOP "test_eloop1"
+#define PATH_LEN (PATH_MAX + 2)
+
+static int dir_fd, fd;
+static int invalid_fd = -1;
+static char *testfile;
+static char path[PATH_LEN];
+static char *long_path = path;
+static char *testeloop;
+static char *emptypath;
+static char *bad_path;
+
+static struct tcase {
+	int *fds;
+	char **filenames;
+	int flag;
+	int exp_errno;
+	char *desc;
+} tcases[] = {
+	{&fd, &testfile, 0, ENOTDIR, "path prefix is not a directory"},
+	{&invalid_fd, &testfile, 0, EBADF, "invalid fd"},
+	{&dir_fd, &testfile, -1, EINVAL, "invalid flag"},
+	{&dir_fd, &long_path, 0, ENAMETOOLONG, "pathname is too long"},
+	{&dir_fd, &testeloop, 0, ELOOP, "too many symbolic links"},
+	{&dir_fd, &emptypath, 0, ENOENT, "the file does not exist"},
+	{&dir_fd, &bad_path, 0, EFAULT, "inaccessible address space"},
+};
+
+static void setup(void)
+{
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+
+	fd = SAFE_OPEN("testfile2", O_CREAT | O_RDWR, 0600);
+
+	memset(path, 'a', PATH_LEN);
+
+	SAFE_SYMLINK("test_eloop1", "test_eloop2");
+	SAFE_SYMLINK("test_eloop2", "test_eloop1");
+
+	bad_path = tst_get_bad_addr(NULL);
+}
+
+static void fchownat_verify(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
+		     tc->flag), tc->exp_errno, "fchownat() fails with %s",
+		     tc->desc);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = fchownat_verify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&testfile, .str = TESTFILE},
+		{&testeloop, .str = TESTELOOP},
+		{&emptypath, .str = ""},
+		{},
+	},
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
