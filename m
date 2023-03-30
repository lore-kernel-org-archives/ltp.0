Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C73C761AF
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 08:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A0243CC9B3
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 10:23:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39473CC9B8
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:20 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 583B91400073
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680164598; i=@fujitsu.com;
 bh=nnGuvGJCH84ORxt37jTiJoBl79rqyxrDw/8OJRhfuJI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=OQkqGHcDCiaGQUcCs4CwotWI7qUk+ElrR469j7d1kA56Yb9wSljA/E71i4kG/YQeQ
 Y+zeUQ9eEJ3WbDdxtdLD3/J+brHwewwbSsd06qAKAiIQLcg7JMxCrBY1SZrSdjQih0
 XgU5gqtQY2OHh8vkYwwWOHCe2lX5Lf5lirSww5qLILJYdwTBsR5f8iIZ/Z3Cr3F4LH
 UE2EoCAii70W2agz8UsyGmGWmqIR3kWccfd1yvAPhfpbr3rmea4Nz0JrdYNH9qS75G
 nomJZHqe3lLY7gHtbdgnB5wJ2+yLMw9DFTKS+MJyiiwSRISIpmaJFDw/yLO/xxusyg
 GBZjT5pMb8iWA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8ORpPvNTTX
 F4PpPJou1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBm3Ht4kbFghmLF6wMHWRoY
 L8h0MXJxCAlsYJRY9fQgG4SzhEni7J7tLBDOXkaJY5unsncxcnKwCWhKPOtcwAxiiwhISHQ0v
 AWLMwvYSdxZ3AQWFxbwkLh9p5UVxGYRUJV41HGVCcTmFfCUePr0GpgtIaAgMeXhe6B6Dg5OAS
 +Jlr2cIGEhoJIF+6+wQpQLSpyc+YQFYryExMEXL5ghWpUk2lohaiQEKiQapx+CGqkmcfXcJuY
 JjIKzkLTPQtK+gJFpFaN5cWpRWWqRrqGlXlJRZnpGSW5iZo5eYpVuol5qqW5eflFJhq6hXmJ5
 sV5qcbFecWVuck6KXl5qySZGYEinFKd93cE4u++v3iFGSQ4mJVHeSk7VFCG+pPyUyozE4oz4o
 tKc1OJDjDIcHEoSvJtcgHKCRanpqRVpmTnA+IJJS3DwKInwqjgBpXmLCxJzizPTIVKnGBWlxH
 n7XYESAiCJjNI8uDZYTF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMxrBLKdJzOvBG76K6D
 FTECLj6WqgCwuSURISTUwCW85n+Z4OML5qXjr85QCM4lHYleLjk+RZp28SuLg5JUfuyIdC1+d
 L81b43fkxswbb/1DqpuFNl+Ks2hYpMP961+SrnPf3/udU332HZs/7WLCtX+3j+rd//ApQFS88
 ezB7Fm/QzemO20Kfizn2pgSMku6QOyxa/THs4nrDZqW9B9atFl9+VdP8dDIzwm/GmxSXFfkn9
 /K6Jc/a8l3+0l+fzg3Gc4JvnKkTXj7qu1qJq6dq0pFg1T3XN2Sv3PXnPoZDS8SHoQ8FDA2X77
 6+YHT9hsvWjzU6Nv5NLg1UXSDmNLN+Uv3/WpvYLu6fZ3btZYOsyCJ+2t85z+Wcugz/pHTu/iq
 VVHoX/5pjgzs6qcP5CmxFGckGmoxFxUnAgCvOHBoZAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-728.messagelabs.com!1680164597!741309!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24146 invoked from network); 30 Mar 2023 08:23:17 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-14.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 30 Mar 2023 08:23:17 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 6F1D17B;
 Thu, 30 Mar 2023 09:23:17 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 63DE61B6;
 Thu, 30 Mar 2023 09:23:17 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 30 Mar 2023 09:23:15 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 30 Mar 2023 16:22:48 +0800
Message-ID: <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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
value are nonzero because we don't know the underflying device details(ie
whether dio faillback to bufferio or whether use loop device).

For struct statx member check, we only check stx_dio_mem_align because
these two member is introduced toger in separate commit in kernel, so it is
safe.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                               |  2 +-
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx10.c  | 81 ++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)
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
index 000000000..7a2c92ad2
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for STATX_DIOALIGN mask.
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
