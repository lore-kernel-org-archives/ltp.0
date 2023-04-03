Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6EEC76196
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 10:45:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3643CD05E
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 12:45:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DD5A3CC883
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:05 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8055B600074
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680518703; i=@fujitsu.com;
 bh=qv75hWqiQAL904mGVBqZvEeItTE77nJDt9D55DtHCL4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=igXcCz3/BS3KpFkYvWetxQKfcNwM2Ye1TDfHLRCNV3ltQcRcaS7c8I0YLhEZGugak
 eqbifGRP8ES9vo3ZYAxvlL+tywgEWfoYlTW1MPrbpvBikgyxf6iIINBbiYTagw1Epf
 WfpmMchdHFF+l9L04uS3UO+6gW6og4yE2hkMCb3zZn4UismmsDqxMkoaHWPcHZrGqZ
 W+iHeKSA81JkI4NFv0HIRiCTUKWa47i1w3C9+r4UfldDiRTTd+Tnw5VBiVFC0D8LGk
 9tf33aGayOVafaubmmx6RVUMo9FTcEwqs19H6RZff+6CkEdn9Z3IfLYgPTEt1DJucO
 AQoMxvSJPCDsg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8MxSVd/nVa
 KwdcbzBZr9/xhtljxfQejA5PHplWdbB77fq9jDWCKYs3MS8qvSGDNmPV+MXPBbcWKVxu2sDcw
 dsl2MXJxCAlsYZT4s+sJE4SznEli4fytUM4eRomr678wdzFycrAJaEo861wAZosISEh0NLxlB
 7GZBewk7ixuAosLC0RLXP+5jAnEZhFQkbg9ZSEjiM0r4CGxcu83sLiEgILElIfvweo5BTwlDk
 08DRTnAFpWI3H9rh9EuaDEyZlPWCDGS0gcfPGCGaJVSaKt9QorhF0h0Tj9ENRINYmr5zYxT2A
 UnIWkfRaS9gWMTKsYzYpTi8pSi3QNLfSSijLTM0pyEzNz9BKrdBP1Ukt1y1OLS3SN9BLLi/VS
 i4v1iitzk3NS9PJSSzYxAgM6pVj5ww7GpX1/9Q4xSnIwKYnyrl2jlSLEl5SfUpmRWJwRX1Sak
 1p8iFGGg0NJgtcSJCdYlJqeWpGWmQOMLpi0BAePkgjvpSVAad7igsTc4sx0iNQpRkUpcd7jIH
 0CIImM0jy4NlhEX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzLsHZApPZl4J3PRXQIuZgBa
 3RmmALC5JREhJNTAtuGjdK/T67NyNZzItvVOW55Rxv4pWO+++akWPwzbXmxq/w+csM/oa/llZ
 1vnoTfP9U5w7TW4tmxS+VV+Tde9UUQVF350F5mLvZm9/qNbxQ3v1jptTLZZpFPT//qq9ctZRt
 7kbEsS0V3nqu3KcTSmN/6nzdMqJnmPfdXfYL9WR3rlq3R+j6LPib+59U7zcss3ohmZjvl/gvu
 pjGSY3lvrtVeiN36z44Ke6eYaXHvv0lGjFbbO/1Ty5qN5eXL8ows57959gtU3rfkWVbeNXzX1
 001BPP7cm42taScT0+LqNMrcndn7fzLLPZXWwZe1alU6pXiXeZIdIhe3aV6Q6lpv8DzxS8v8z
 /8Xq2qPvdt9WYinOSDTUYi4qTgQAXIpc4GMDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-548.messagelabs.com!1680518702!204032!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 897 invoked from network); 3 Apr 2023 10:45:03 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-6.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Apr 2023 10:45:03 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id BB0F41009B3;
 Mon,  3 Apr 2023 11:45:02 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id AE0091009B2;
 Mon,  3 Apr 2023 11:45:02 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 3 Apr 2023 11:45:00 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 3 Apr 2023 18:44:34 +0800
Message-ID: <1680518676-2863-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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

STATX_DIOALIGN is used to get stx_dio_mem_align and stx_dio_offset_align
for files on fs that support direct io. We just check whether these
value are nonzero on ext4 and xfs.

For struct statx member check, we only check stx_dio_mem_align because
these two member is introduced toger in separate commit in kernel, so it is
safe.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                               |  2 +-
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx10.c  | 84 ++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx10.c

diff --git a/configure.ac b/configure.ac
index 4c8763376..548288310 100644
--- a/configure.ac
+++ b/configure.ac
@@ -158,7 +158,7 @@ AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
-AC_CHECK_MEMBERS([struct statx.stx_mnt_id],,,[
+AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
 #define _GNU_SOURCE
 #include <sys/stat.h>
 ])
diff --git a/runtest/syscalls b/runtest/syscalls
index 8b002e989..92123772c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1769,6 +1769,7 @@ statx06 statx06
 statx07 statx07
 statx08 statx08
 statx09 statx09
+statx10 statx10
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 1cea43c0d..67341ff2d 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -7,3 +7,4 @@
 /statx07
 /statx08
 /statx09
+/statx10
diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
new file mode 100644
index 000000000..4307ada16
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for STATX_DIOALIGN mask on ext4 and xfs filesystem.
+ *
+ * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
+ *
+ * Minimum Linux version required is v6.1.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+#define MNTPOINT "mnt_point"
+#define TESTFILE "testfile"
+
+static int fd = -1;
+
+static void verify_statx(void)
+{
+	struct statx buf;
+
+	memset(&buf, 0, sizeof(buf));
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
+		return;
+	}
+
+	if (buf.stx_dio_mem_align != 0)
+		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
+	else
+		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
+
+	if (buf.stx_dio_offset_align != 0)
+		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
+	else
+		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
+}
+
+static void setup(void)
+{
+	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
+		tst_brk(TCONF, "This test only supports ext4 and xfs");
+
+	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
+	fd = open(TESTFILE, O_RDWR | O_DIRECT);
+	if (fd == -1 && errno == EINVAL)
+		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct statx to have the stx_dio_mem_align fields");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
