Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5DEC7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:16:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42C23CD715
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:16:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0D03C0238
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:16:41 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9EA0200768
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623799; i=@fujitsu.com;
 bh=lvW+ahfLpJlb1FsXs26kAP7T5H1shlwLpyMO3UAOX1o=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=G8bGPZetKciFU9Kjtug4ox3TdlD5kgLVdBnnOyOqBW47vSxYnDfyzje0eG5YP/dt8
 4Gcam/+DanTq+u6juCTnLIllsrS1cW+lXuHScYHw5jui7LfV0Mttq7wS0MQ/uPqMc3
 rKxyjTXUTwV6BIKSNNT09Cq50WheL8Md5/VaGmwtzhipEp0baso6SCSKSmkwHH1rp7
 epZfyJ3DhBgUWW4tRauvct2YWKOac8EWNJzBy7XGOocfTeBLa5TYg6xVG69GlBhIFf
 3GJY3oegxcmz9k6XwQcwEcwYvxHj5nzaorN8zMzTa4l6DpVpMaOeN0cVbh4id+zP/m
 30rl8IYD+cTNw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRWlGSWpSXmKPExsViZ8ORpFvOH5V
 i0P9C0GLtnj/MFiu+72B0YPLYtKqTzWPf73WsAUxRrJl5SfkVCawZe9f8YClYrVPx9W47ewPj
 J9UuRi4OIYGNjBLr9h9h6WLkBHKmM0lsvWQMYrMJaEo861zADGKLCIhJXN/wihXEZhawlXh5f
 CsjiC0sEC1xY8ZhsBoWAVWJplf/webwCnhKTH64GMyWEFCQmPLwPVgNp4CXxNy2F8wQuzwl3n
 RNYoWoUZO4em4T8wRGngWMDKsYzYpTi8pSi3QNLfWSijLTM0pyEzNz9BKrdBP1Ukt1y1OLS3Q
 N9RLLi/VSi4v1iitzk3NS9PJSSzYxAsMkpZj5xg7Gzzv/6h1ilORgUhLl7doXmSLEl5SfUpmR
 WJwRX1Sak1p8iFGGg0NJgvcBT1SKkGBRanpqRVpmDjBkYdISHDxKIrwnWIDSvMUFibnFmekQq
 VOMilLivF18QAkBkERGaR5cGyxOLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p3ICzSFJz
 OvBG76K6DFTECL/S+HgywuSURISTUwrYk95zA3eFWbx6WVb3dqXNxzUO19DvuuDaK/DBpczm7
 iNylPOnjArStlEocY394PB07+XTSNyTRzyoLpMbzaJ4RC1i20bsn74KjWm/l/Tmpa0Cc5rckC
 Ar/t3y9/tubkuoZXEx7duHPgut13pQrxJRypZxluWbS9PvK6SfbjrY8/amq9dgic4V98ylz9V
 dTx+h/HFjlPF4tPzbgXNv1c6LrF/N9s190rXdFvGZjJ8cRhyVPW7Rb7r3ytvFolLGPjfL6E1/
 +wQRDDmVNH726LNtXZXPBDllviwHOpP4dDKrsk8y5nn0ua2WJ1IGl1zLG5U/Z7GYsftuRUX2v
 0uD9d8vHzrYLfWm/ccvt+hu116VUlluKMREMt5qLiRAB1oulQDgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1683623799!416744!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20504 invoked from network); 9 May 2023 09:16:39 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:16:39 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id DD5731B1;
 Tue,  9 May 2023 10:16:38 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E27A11BB;
 Tue,  9 May 2023 10:16:37 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:07 +0800
Message-Id: <1683623648-22778-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 6/7] syscalls/statx10: Add basic test for
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

STATX_DIOALIGN is used to get stx_dio_mem_align and stx_dio_offset_align
for files on fs that support direct io. We just check whether these
value are nonzero on ext4 and xfs.

On ext4, files that use certain filesystem features (data journalling,
encryption, and verity) fall back to buffered I/O. But ltp creates own
filesystem by enabling mount_device in tst_test struct. If we set block
device to LTP_DEV environment, we use this block device to mount by using
default mount option. Otherwise, use loop device to simuate it. So it can
avoid these above situations and don't fall back to buffered I/O.

For struct statx member check, we only check stx_dio_mem_align because
these two member is introduced together in separate commit in kernel, so it
is safe.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                               |   2 +-
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx10.c  | 103 +++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)
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
index 9c23a4248..e2548dae5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1765,6 +1765,7 @@ statx06 statx06
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
index 000000000..d52add9ed
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,103 @@
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
+ * encryption, and verity) fall back to buffered I/O. But ltp creates own
+ * filesystem by enabling mount_device in tst_test struct. If we set block
+ * device to LTP_DEV environment, we use this block device to mount by using
+ * default mount option. Otherwise, use loop device to simuate it. So it can
+ * avoid these above situations and don't fall back to buffered I/O.
+ *
+ * Minimum Linux version required is v6.1.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mnt_point"
+#define TESTFILE "testfile"
+
+static void verify_statx(void)
+{
+	struct statx buf;
+	uint32_t stx_dio_mem_align, stx_dio_offset_align;
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
+		return;
+	}
+
+#if defined(HAVE_STRUCT_STATX) && !defined(HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN)
+  #if defined(HAVE_STRUCT_STATX_STX_MNT_ID)
+	stx_dio_mem_align = buf.__spare2 >> 32;
+	stx_dio_offset_align = buf.__spare2 & 0xffff;
+  #else
+	stx_dio_mem_align = buf.__spare2[1] >> 32;
+	stx_dio_offset_align = buf.__spare2[1] & 0xffff;
+  #endif
+#else
+	stx_dio_mem_align = buf.stx_dio_mem_align;
+	stx_dio_offset_align = buf.stx_dio_offset_align;
+#endif
+
+	if (stx_dio_mem_align != 0)
+		tst_res(TPASS, "stx_dio_mem_align:%u", stx_dio_mem_align);
+	else
+		tst_res(TFAIL, "stx_dio_mem_align was 0, but DIO should be supported");
+
+	if (stx_dio_offset_align != 0)
+		tst_res(TPASS, "stx_dio_offset_align:%u", stx_dio_offset_align);
+	else
+		tst_res(TFAIL, "stx_dio_offset_align was 0, but DIO should be supported");
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
+	if (fd == -1) {
+		if (errno == EINVAL)
+			tst_brk(TCONF,
+				"The regular file is not on a filesystem that support DIO");
+		else
+			tst_brk(TBROK | TERRNO,
+				"The regular file is open with O_RDWR | O_DIRECT failed");
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
