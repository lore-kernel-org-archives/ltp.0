Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9C7C7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 05:41:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E123CCFCD
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 07:41:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6A293CC73A
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:40:45 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D4C001A0011C
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680759643; i=@fujitsu.com;
 bh=YySCXM2t9brf/a+txxca03p69QXDLX0yfQpuMiHlTHw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=MpmKtLwQe0SX4gmANCBnyE+74s9IgT+FOy3NCGk0a+I7o5E8v89FTleARElSB+3UH
 kyPbqL5dd0sINCnjaTgGLsbcldvdfaBD3gr58ogNmSwbIwFbgJqsMRIVTWJ3dIDzTY
 MGK9q2p0oRC8XoLYSh6cKGZE1udx05fLa5leeBKMVe+AJRm42el3145lMVSmrVKvGH
 iKA7sJKV5z4et6k2XOg8DLOBFQkeHPTc8/iEUX06IOQ3pf5BiQzDwFs7llDIruSijv
 JItmdtWtLtc17K+OuZLB9tuqvBMzpMlFs2Fssr11Zm+nvrt0x4GFDj2BJZTSt5U6ni
 y3pDs9lIA3DFg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8ORpBsdrZd
 isKaB32Ltnj/MFiu+72B0YPLYtKqTzWPf73WsAUxRrJl5SfkVCawZh968YCv4olJxeOZ89gbG
 i/JdjFwcQgIbGSVaPm1ng3CWMEl0froJ5HACOXsYJd5sKASx2QQ0JZ51LmAGsUUEJCQ6Gt6yg
 9jMAnYSdxY3gcWFBaIlmn6tYwKxWQRUJL5t2QBWwyvgIbHyyUawGgkBBYkpD98D2RwcnAKeEt
 /elkOsKpR4teMRM0S5oMTJmU9YIMZLSBx88QKqVUmirfUKK4RdIdE4/RAThK0mcfXcJuYJjIK
 zkLTPQtK+gJFpFaNpcWpRWWqRrqleUlFmekZJbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGx
 XnFlbnJOil5easkmRmAwpxSzmO1gbO/7q3eIUZKDSUmUd66KTooQX1J+SmVGYnFGfFFpTmrxI
 UYZDg4lCd5dUXopQoJFqempFWmZOcDIgklLcPAoifAu9ANK8xYXJOYWZ6ZDpE4xKkqJ814G6R
 MASWSU5sG1waL5EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3mqQKTyZeSVw018BLWYCWmz
 rrwOyuCQRISXVwMQqo/6vynzn5SW39Is3qlWnfenKfDhj4Tqv22xPTrNLcBkIsqj/yviaLbN0
 am7ZXeYf+kd3s1451BC94zS77NINVSty3Jw/qnlavg3VlvgaPH3+mqi5K/KeGjZMuXM3wdv2y
 o3rUmoRzAZzpUr0l557NU3istjvMrlcnd75Nx+sMPrc/sqx4JXDukLW/VJs6xPvv/ZyLHPZ7M
 TxRWKbrumz6pUrbMQ1u/Wyi7ujo/cyq9kJGHZtecdpb14szy2b7nLjtdZnHedNOQrcpmXFi64
 H/HrOZ2N9ys1BYG7d41ezXI5O7NIKf7B6XrOHRNYvnRmf90XVHnxgc9uFSdCWv+C0veJc14OX
 FG3e89ybrsRSnJFoqMVcVJwIAC9Pc3phAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-585.messagelabs.com!1680759643!122478!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20451 invoked from network); 6 Apr 2023 05:40:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-13.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Apr 2023 05:40:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id CFFE11C1;
 Thu,  6 Apr 2023 06:40:42 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C47561BF;
 Thu,  6 Apr 2023 06:40:42 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 6 Apr 2023 06:40:40 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Apr 2023 13:40:20 +0800
Message-ID: <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
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

On ext4, files that use certain filesystem features (data journalling,
encryption, and verity) fall back to buffered I/O. But ltp doesn't use
these features by default, So I think dio should not fall back to
buffered I/O.

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
index 000000000..59e0c06e4
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
+ * Check these two values are nonzero under dio situation when STATX_DIOALIGN
+ * in the request mask.
+ *
+ * On ext4, files that use certain filesystem features (data journaling,
+ * encryption, and verity) fall back to buffered I/O. But ltp doesn't use these
+ * features by default, So I think dio should not fall back to buffered I/O.
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
+#define MNTPOINT "mnt_point"
+#define TESTFILE MNTPOINT"/testfile"
+
+static void verify_statx(void)
+{
+	struct statx buf;
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
+		return;
+	}
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+	if (buf.stx_dio_mem_align != 0)
+		tst_res(TPASS, "stx_dio_mem_align: %u", buf.stx_dio_mem_align);
+	else
+		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
+
+	if (buf.stx_dio_offset_align != 0)
+		tst_res(TPASS, "stx_dio_offset_align: %u", buf.stx_dio_offset_align);
+	else
+		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
+#endif
+}
+
+static void setup(void)
+{
+	int fd = -1;
+
+	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
+		tst_brk(TCONF, "This test only supports ext4 and xfs");
+
+	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
+	fd = open(TESTFILE, O_RDWR | O_DIRECT);
+	if (fd == -1 && errno == EINVAL) {
+		SAFE_CLOSE(fd);
+		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
