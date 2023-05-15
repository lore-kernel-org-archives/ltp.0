Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D3FC7EE22
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32E583CDD71
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:12:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8783CD4DC
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:48 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 733CC1400330
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:47 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="96161853"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="96161853"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:45 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F498C68E1
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:43 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B9F71D5070
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2A51630C41B;
 Mon, 15 May 2023 16:11:42 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:19 +0800
Message-Id: <1684134680-6190-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--23.226800-10.000000
X-TMASE-MatchedRID: Kkkx1MdXpTzyaWDdlFBzB4HfzWJnn0eo8SkdpG2/n9c6FHRWx2FGsOIj
 0uEwk0o6sThZ10FHnFHfQQLUEQSyKcJLU14K+zeoGYJhRh6sseuZmLDnd2pI33YdkYOuyxVSypt
 8WTCPE+i+RCxnIvo2nV+wX0SqSP+34FG4Cyz4VuYReM8i8p3vgFQQ0EgzIoPRZTDoyKs07HoGMx
 mLVbWqwUx4fB7mBFckfwz9PrG/liIqvhmfWR8SIQrcxrzwsv5uH4pppXAAbjcnyU5/nZpxUBplb
 nRIZ6aE1xUJL0v9L4maiaqz4Y6rSSpe4ofkluPsWTWEh5N2a9EINPeazpADxBMabDrZlAepfdi+
 0/fshTiaIuBZNVsPT4Ay6p60ZV62fJ5/bZ6npdiQZS2ujCtcuA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 5/6] syscalls/statx10: Add basic test for
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
 configure.ac                               |  2 +-
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx10.c  | 93 ++++++++++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)
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
index 000000000..513a8c262
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,93 @@
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
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
+		return;
+	}
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+	if (buf.stx_dio_mem_align != 0)
+		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
+	else
+		tst_res(TFAIL, "stx_dio_mem_align was 0, but DIO should be supported");
+
+	if (buf.stx_dio_offset_align != 0)
+		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
+	else
+		tst_res(TFAIL, "stx_dio_offset_align was 0, but DIO should be supported");
+#else
+	tst_res(TCONF, "glibc statx struct miss stx_dio_mem_align field");
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
