Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A105C4345F
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 02:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714269883; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=T/NQTwMULcvwKTwztToocqXQXBZVqXKnnsDQdQBk0hs=;
 b=LSmHC/XG7WF7/dtQVbYnu8V6yNvaNPyBWen1YZVfoWc3MhPmkyd/4h89oHnfE26LYYlu3
 X7WC3QfL5a3uu78zJJRKiokB0DISmqWgMlOivTSmPcMvHPbEaDYmqboA3Bw4h+bj1c0CHvy
 xmMYCL9sEIo9S5F6VmBYy9rQFS+rR+w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38F7A3CFF64
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 04:04:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA6453CBDD0
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 04:04:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71447602BD5
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 04:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1714269859; x=1745805859;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZCadwkSRXYMSdcREJfY+Vss+AbThxGXkqFNMCttn4r0=;
 b=Sq7OqqEtIJIYWeT6HdtcgwcA9XNxJfecFWj4rPauYX+wDkCm7nFtdMK7
 lEHEQb3wPIWppGxdvRHJV2Eee756oeyhClgTK+UIJRwqD1dg6p/lyiXh8
 JhnfJR6XYTuxDMR4f4s4cWF8jzVwPfqxwfJ0SFEVDNRhWuSiXnU6Ztx+J
 fR+ghQ+ycjQh3QR4pktQ6+GLaSX6t9O8C6H+nEwNuUAYcTspV4GRhnpXd
 vdvHK8/kY+CAj6gNEKv0OF1q+4k7b6rD0eBSkfmRIt7pPOX27QiGa/Yho
 TeU0T8TPThXZFHkPJ1tGGA8iZEWROgaJJacTqLAMppPD3X1tmAU/h9ewL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="157243828"
X-IronPort-AV: E=Sophos;i="6.07,236,1708354800"; d="scan'208";a="157243828"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 11:04:15 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id EE2C7C68FD
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 11:04:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D2074D28E
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 11:04:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5EDB20093274
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 11:04:12 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 413E51A0002;
 Sun, 28 Apr 2024 10:04:12 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 01:25:36 -0400
Message-Id: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28348.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28348.004
X-TMASE-Result: 10--18.790600-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb1SuJfEWZSQfDyjd/AizytB2FA7wK9mP9dgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDjpOcMxD4/Db2L0urcUf+APkKCFOKwAEzEi8rgutezVpS7NxD4SLUR24kR
 SZ1g8ZJaH3E3UlyJO9hBax1yAmf0oXHLPN9+q8ed9JA2lmQRNUHhysWPN3OzibKItl61J/yZ+in
 TK0bC9eKrauXd3MZDUD/dHyT/Xh7Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lseek: Add negative tests for lseek
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative tests for lseek(), when errno is ENXIO

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/lseek/.gitignore |  1 +
 testcases/kernel/syscalls/lseek/lseek12.c  | 80 ++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lseek/lseek12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 62eb4c1cd..7575b27b1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -726,6 +726,7 @@ lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
+lseek12 lseek12
 
 lstat01A symlink01 -T lstat01
 lstat01A_64 symlink01 -T lstat01_64
diff --git a/testcases/kernel/syscalls/lseek/.gitignore b/testcases/kernel/syscalls/lseek/.gitignore
index 1dc1465ee..c49728607 100644
--- a/testcases/kernel/syscalls/lseek/.gitignore
+++ b/testcases/kernel/syscalls/lseek/.gitignore
@@ -2,3 +2,4 @@
 /lseek02
 /lseek07
 /lseek11
+/lseek12
diff --git a/testcases/kernel/syscalls/lseek/lseek12.c b/testcases/kernel/syscalls/lseek/lseek12.c
new file mode 100644
index 000000000..9d80e632b
--- /dev/null
+++ b/testcases/kernel/syscalls/lseek/lseek12.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that lseek(2) fails with
+ *
+ * - ENXIO when whence is SEEK_DATA, file offset is beyond the end of the file
+ * - ENXIO when whence is SEEK_HOLE, file offset is beyond the end of the file
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include "tst_test.h"
+#include "lapi/seek.h"
+
+#define TEST_ENXIO "test_enxio"
+
+static int fd_enxio;
+
+static struct test_case_t {
+	int *fd;
+	off_t offset;
+	int whence;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{&fd_enxio, 10, SEEK_DATA, ENXIO,
+		"whence is SEEK_DATA, "
+		"file offset is beyond the end of the file"},
+	{&fd_enxio, 10, SEEK_HOLE, ENXIO,
+		"whence is SEEK_HOLE, "
+		"file offset is beyond the end of the file"},
+};
+
+static void setup(void)
+{
+	SAFE_TOUCH(TEST_ENXIO, 0777, NULL);
+	fd_enxio = SAFE_OPEN(TEST_ENXIO, O_RDWR, 0777);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd_enxio);
+}
+
+static void verify_lseek(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	off_t offset;
+
+	offset = lseek(*(tc->fd), tc->offset, tc->whence);
+	if (offset == -1) {
+		if (errno == EINVAL) {
+			tst_res(TCONF, "SEEK_DATA/SEEK_HOLE are not supported");
+		} else {
+			if (errno == tc->expected_errno) {
+				tst_res(TPASS | TERRNO, tc->desc);
+			} else {
+				tst_res(TFAIL | TERRNO,
+					"lseek() failed unexpectedly");
+			}
+		}
+	} else {
+		tst_res(TFAIL, "lseek() succeeded unexpectedly");
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_lseek,
+	.needs_tmpdir = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
