Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0635C7618D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:31:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F0FB3CAC3E
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 09:31:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B043CA9F0
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:30:57 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E51E6008C7
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680593455; i=@fujitsu.com;
 bh=yTiGeaSrT0hNNbS834uP90dlgk9hXtMUDBacZA3zKNQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=P9+hwE8JglXl6Iz9b8XLJqR11wPVgaIpKnPdhBGAlqgnD4qeiG9ka2oSjYOOdB5GG
 +R1539oB2VJBOFIuLB0EKhYNcY3B2pW7/VYXR3cC5d1y0qI4HRv92tdDkTU/ujV7ar
 JT1ROE8R4qsa9Rw2cBZzXNOnJ+rTPgg09pOnHGQldP1wqSDzOQyiiGWysT0/2apVN7
 MPOvnv7pamJ1bcCiOYgRVbyVQ9/uKFSkHCRa83QpiOQGt0sJvL8xsmqLAYxr0Zbnhi
 NJCl/Kk127CLN9y87xEHV2bDW8nAseUGpHBPRm19if1B6ZUlJGosUssJe7AOvuBUg2
 Xu8agj3/aRgAg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8MxSVfvkna
 Kwd9TZhZr9/xhtljxfQejA5PHplWdbB77fq9jDWCKYs3MS8qvSGDNaP3zlangr2bFjlfz2RsY
 e1S6GLk4hAS2MEo82vuCBcJZziSxdeZ8dghnD6PEjZuTgRxODjYBTYlnnQuYQWwRAQmJjoa3Y
 HFmATuJO4ubwOLCAtESZ5adZQWxWQRUJE483wg0lYODV8BTYtpGAZCwhICCxJSH78HKOQW8JP
 bcPgBWLiSQLtF/7hdYnFdAUOLkzCcsEOMlJA6+eMEM0ask0dZ6hRXCrpBonH6ICcJWk7h6bhP
 zBEbBWUjaZyFpX8DItIrRrDi1qCy1SNfQUi+pKDM9oyQ3MTNHL7FKN1EvtVS3PLW4RNdQL7G8
 WC+1uFivuDI3OSdFLy+1ZBMjMKBTilmP72Cc1fdX7xCjJAeTkijvo43aKUJ8SfkplRmJxRnxR
 aU5qcWHGGU4OJQkeDPPA+UEi1LTUyvSMnOA0QWTluDgURLh/XsOKM1bXJCYW5yZDpE6xagoJc
 678QJQQgAkkVGaB9cGi+hLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5Xc4ATeHJzCuBm/4
 KaDET0OLWKA2QxSWJCCmpBiYnnn/PBfK+tgX/53F8s365WNWc55Jdz74ed7e/0PJ3smtzcGJ7
 4Pd9S8oe6saZTI3pL9n/5WNN8ZYmrdZ0n2yeR9sfrPrxc9qsmevZ5C0zms96dKh9Yf/zOEp+a
 1c1s97R9pDlFscKLe2MLFoOp73kNMl61FwW6cYp0OQZ2/mx+ZjC7m/XxcNymesdrroFrpP7lH
 Vvde0CB9P5uyPEA2zzY+apL182O26T2vrCttMfz4XeeOt/LT9ZtMqm5L+N9fof+QyS7bP+bSu
 bWvkqzbhN7MyWuYa8L567MjvymFgzMrBoS1yo6Ti/4POiOZpX9OSuSH6YxHRFg+Evw6GiuyrP
 l+0SPfK7ca5UoQPrDSWW4oxEQy3mouJEAMefgt9jAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-585.messagelabs.com!1680593454!378471!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1060 invoked from network); 4 Apr 2023 07:30:54 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-17.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 07:30:54 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 7604B100467;
 Tue,  4 Apr 2023 08:30:54 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 68B7D1000FC;
 Tue,  4 Apr 2023 08:30:54 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 08:30:52 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 15:30:28 +0800
Message-ID: <1680593430-14728-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] syscalls/statx10: Add basic test for
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

If the caller didn't include STATX_DIOALIGN in the request mask,
direct I/O alignment information isn't returned since statx() isn't
required to return unrequested information.

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
v2->v3:
1. fix testfile path problme
2. also test stx_dio_mem_align and stx_dio_offset_align is not filled
when not request STATX_DIOALIGN
 configure.ac                               |  2 +-
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx10.c  | 98 ++++++++++++++++++++++
 4 files changed, 101 insertions(+), 1 deletion(-)
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
index 000000000..7e5d287d9
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,98 @@
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
+ * These two values are only filled when STATX_DIOALIGN in the request mask.
+ * Also check these two values are nonzero under dio situation when
+ * STATX_DIOALIGN in the request mask
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
+#define TESTFILE MNTPOINT"/testfile"
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
+
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, 0, &buf),
+		"statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE);
+
+	if ((buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TFAIL, "STATX_DIOALIGN mask return even not request");
+		return;
+	}
+	TST_EXP_EQ_LU(buf.stx_dio_mem_align, 0);
+	TST_EXP_EQ_LU(buf.stx_dio_offset_align, 0);
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
