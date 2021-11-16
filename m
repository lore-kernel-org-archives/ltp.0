Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596FC433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:56:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B4461BF9
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60B4461BF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2802E3C8763
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:56:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 445963C12D4
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:46 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A398120097B
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637049343; i=@fujitsu.com;
 bh=CX6AWI6/71f+SHBgO1k7ySnRUbJwgI7QDRDiyAThwxo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mCz9+ue4qYRZHALhT7ivyO4kSAWxzJSH19XDoqK/JUfnJtGGQHFhK1UxNnerX7Beh
 MPjJ4LNIuLYvwki+6a/b3F346v/zkQfUEaLZRKR6DkAV18U6xRm0G5ORxDnkhtDCE+
 GdMWCEKGbW2eirNvUaebsLQTKJ7W0QPRj5W4eBt2W8rYNd6DBqaAY9Il4fvBibt/97
 WS9x0NevCY/t8430FcpDn44HUpDLF/sclTcMtDDh6e2YD8O3aLIMLHS2eJfWWPwjz1
 t7kHQwEndBsblaYjX6OmuOI/UhJ53w9r4kz2g3IJCSDBPnm7PRzJ0xsnyxz7rpY9U3
 Pldw2/gnWxyAg==
Received: from [100.115.36.91] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id BA/29-16121-FF363916;
 Tue, 16 Nov 2021 07:55:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8MxSfd/8uR
 Egxk7OCxWfN/B6MDose/3OtYAxijWzLyk/IoE1ozdH0+zFTwxqrjz/hdrA+MKrS5GLg4hgbOM
 EruPLWOBcHYySWz6vIkZwtnDKPHowlvGLkZODjYBTYlnnQuYQWwRAQmJjoa37CA2s4C6xPJJv
 5hAbGEBM4nPx/aAxVkEVCXOfWxkBbF5BTwllk7ZDlYjIaAgMeXhe7A5nAJeEgf3fgGbLwRU03
 PoCjtEvaDEyZlPWCDmS0gcfPGCGaJXUeJSxzdGCLtCYtasNqiZahJXz21insAoOAtJ+ywk7Qs
 YmVYxWicVZaZnlOQmZuboGhoY6BoamuoaW+oaWprqJVbpJuqlluqWpxaX6BrpJZYX66UWF+sV
 V+Ym56To5aWWbGIEBnJKsfrhHYxvLn3TO8QoycGkJMp7TXtyohBfUn5KZUZicUZ8UWlOavEhR
 hkODiUJ3txAoJxgUWp6akVaZg4wqmDSEhw8SiK8S5OA0rzFBYm5xZnpEKlTjLoczZOWb2cWYs
 nLz0uVEufNBCkSACnKKM2DGwGL8EuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHlDEoGm8GT
 mlcBtegV0BBPQEfb3+kGOKElESEk1MGWXzLXoSJik4HRk292OP0o9HFLW6ueDFh4Pa3/V+CXj
 i9y5ORkLslh33e5Z434yKm516HHt7+dunz8h55jF/kLWsiVN841U2JJXP8/5iJ3Pe79FbV7JV
 RU+oYuqV195283a8Z75drPcJEnXyc69SxZv73iw6JhyYSkPF++2kEyW1o9fi+tSvBfNfBtgPe
 OJHN/DsLN+v0UXRC8V/G7F0b9g2XHpo82PFe8VcxbuEY8wvL6+NEP1kN+ZvxOPqej6yqV5xLJ
 LGLFy7Ds0oT74KY9jgLn6y9MbD/tnLl26kKt5TvhzU/EbTif7GPgCpBOqAsVmNFxQecAj5ZSZ
 LmiUYr5Jb2rsr/07Xose6I0NVWIpzkg01GIuKk4EAIg1aOBrAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-565.messagelabs.com!1637049342!914869!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2293 invoked from network); 16 Nov 2021 07:55:43 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-21.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Nov 2021 07:55:43 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B031D100471
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A397C100467
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 16 Nov 2021 07:55:26 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 16 Nov 2021 15:55:52 +0800
Message-ID: <1637049352-25731-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] syscalls/statx08: Add new test
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

Like statx04.c, but use stx_attributes_mask before test so we only test
flag which has been implemented by the underlying filesystem.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx08.c  | 196 +++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d57c73e39..bcd6ac1ab 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1741,6 +1741,7 @@ statx04 statx04
 statx05 statx05
 statx06 statx06
 statx07 statx07
+statx08 statx08
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 2f5457e48..4db060dbb 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -5,3 +5,4 @@
 /statx05
 /statx06
 /statx07
+/statx08
diff --git a/testcases/kernel/syscalls/statx/statx08.c b/testcases/kernel/syscalls/statx/statx08.c
new file mode 100644
index 000000000..dc869d6b6
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx08.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This case tests whether the attributes field of statx received expected value
+ * by using flags in the stx_attributes_mask field of statx.
+ * File set with following flags by using SAFE_IOCTL:
+ *
+ * - STATX_ATTR_COMPRESSED: The file is compressed by the filesystem.
+ * - STATX_ATTR_IMMUTABLE: The file cannot be modified.
+ * - STATX_ATTR_APPEND: The file can only be opened in append mode for writing.
+ * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
+ *                        program such as dump(8) is run.
+ *
+ * Two directories are tested.
+ * First directory has all flags set. Second directory has no flags set.
+ *
+ * Minimum kernel version required is 4.11.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include <stdlib.h>
+#include "lapi/stat.h"
+
+#define MOUNT_POINT "mntpoint"
+#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
+#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
+
+static int fd, clear_flags;
+static int supp_compr = 1, supp_append = 1, supp_immutable = 1, supp_nodump = 1;
+
+static void test_flag(int flag)
+{
+	struct statx buf;
+
+	TEST(statx(AT_FDCWD, flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED, 0, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
+
+	if (supp_compr) {
+		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_COMPRESSED flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_COMPRESSED flag is not set");
+	}
+	if (supp_append) {
+		if (buf.stx_attributes & STATX_ATTR_APPEND)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_APPEND flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_APPEND flag is not set");
+	}
+	if (supp_immutable) {
+		if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_IMMUTABLE flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_IMMUTABLE flag is not set");
+	}
+	if (supp_nodump) {
+		if (buf.stx_attributes & STATX_ATTR_NODUMP)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_NODUMP flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_NODUMP flag is not set");
+	}
+}
+
+struct test_cases {
+	void (*tfunc)(int);
+	int set_flag;
+} tcases[] = {
+	{&test_flag, 1},
+	{&test_flag, 0},
+};
+
+static void run(unsigned int i)
+{
+	tcases[i].tfunc(tcases[i].set_flag);
+}
+
+static void caid_flags_setup(void)
+{
+	int attr, ret;
+
+	fd = SAFE_OPEN(TESTDIR_FLAGGED, O_RDONLY | O_DIRECTORY);
+
+	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+	if (ret < 0) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
+
+		/* ntfs3g fuse fs returns wrong errno for unimplemented ioctls */
+		if (!strcmp(tst_device->fs_type, "ntfs")) {
+			tst_brk(TCONF | TERRNO,
+				"ntfs3g does not support FS_IOC_GETFLAGS");
+		}
+
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
+	}
+
+	if (supp_compr)
+		attr |= FS_COMPR_FL;
+	if (supp_append)
+		attr |= FS_APPEND_FL;
+	if (supp_immutable)
+		attr |= FS_IMMUTABLE_FL;
+	if (supp_nodump)
+		attr |= FS_NODUMP_FL;
+
+	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
+	}
+
+	clear_flags = 1;
+}
+
+static void setup(void)
+{
+	struct statx buf;
+
+	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
+	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
+
+	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+
+	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0) {
+		supp_compr = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_COMPR_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0) {
+		supp_append = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_APPEND_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0) {
+		supp_immutable = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0) {
+		supp_nodump = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_NODUMP_FL");
+	}
+	if (!(supp_compr || supp_append || supp_immutable || supp_nodump))
+		tst_brk(TCONF,
+			"filesystem doesn't support the above any attr, skip it");
+
+	caid_flags_setup();
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	if (clear_flags) {
+		SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+		attr &= ~(FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL);
+		SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+	}
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_POINT,
+	.min_kver = "4.11",
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
