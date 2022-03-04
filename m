Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32507C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 06:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 176A73CA38A
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 07:41:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387903CA1EC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 07:41:24 +0100 (CET)
Received: from cxsh.intel-email.com (cxsh.intel-email.com [121.46.250.151])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60E311400977
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 07:41:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by cxsh.intel-email.com (Postfix) with ESMTP id 39486DDA785
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 14:41:15 +0800 (CST)
Received: from cxsh.intel-email.com (localhost [127.0.0.1])
 by cxsh.intel-email.com (Postfix) with ESMTP id E867ADDA7B8
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 14:41:14 +0800 (CST)
Authentication-Results: cxsh.intel-email.com; none
Received: from FZEX4.ruijie.com.cn (unknown [120.35.11.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by cxsh.intel-email.com (Postfix) with ESMTPS id 51829DDA785
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 14:41:11 +0800 (CST)
Received: from localhost.localdomain (172.29.46.186) by FZEX4.ruijie.com.cn
 (192.168.58.89) with Microsoft SMTP Server id 14.3.123.3; Fri, 4 Mar 2022
 14:41:11 +0800
From: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
To: <ltp@lists.linux.it>
Date: Fri, 4 Mar 2022 01:40:26 -0500
Message-ID: <20220304064026.82070-1-xiaoshoukui@ruijie.com.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [172.29.46.186]
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Add pty07 test for use-after-free in vt_ioctl()
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
Cc: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/Makefile   |  4 +-
 testcases/kernel/pty/pty07.c    | 99 +++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/pty/pty07.c

diff --git a/runtest/pty b/runtest/pty
index 9e5754fab..df2074153 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -5,6 +5,7 @@ pty03 pty03
 pty04 pty04
 pty05 pty05
 pty06 pty06
+pty07 pty07
 ptem01 ptem01
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 9b6058cf9..acca3db9a 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -6,3 +6,4 @@
 /pty04
 /pty05
 /pty06
+/pty07
diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index 51b7356c2..ca698de59 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -6,7 +6,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-pty03 pty05 pty06: CFLAGS += -pthread
-pty03 pty05 pty06: LDLIBS += -lrt
+pty03 pty05 pty06 pty07: CFLAGS += -pthread
+pty03 pty05 pty06 pty07: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
new file mode 100644
index 000000000..7b9d24f6b
--- /dev/null
+++ b/testcases/kernel/pty/pty07.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 xiaoshoukui <xiaoshoukui@ruijie.com.cn>
+ */
+
+/*\
+ * [Description]
+ *
+ * The VT_DISALLOCATE ioctl can free a virtual console while VT_RESIZEX ioctl is
+ * still running, causing a use-after-free in vt_ioctl(). Because VT_RESIZEX ioctl
+ * have not make sure vc_cons[i].d is not NULL after grabbing console_lock().
+ *
+ * Fixed by commit:
+ *
+ *  commit 6cd1ed50efd88261298577cd92a14f2768eddeeb
+ *  Author: Eric Dumazet <edumazet@google.com>
+ *  Date:   Mon Feb 10 11:07:21 2020 -0800
+ *
+ *    vt: vt_ioctl: fix race in VT_RESIZEX
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <termios.h>
+#include <linux/vt.h>
+#include "lapi/ioctl.h"
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_fuzzy_sync.h"
+
+#define BUF_SIZE 256
+#define MAX_NR_CONSOLES 63
+
+static char tty_path[BUF_SIZE];
+static int test_tty_port = 8;
+static int fd = -1;
+static struct tst_fzsync_pair fzp;
+
+static void *open_close(void *unused)
+{
+	while (tst_fzsync_run_b(&fzp)) {
+		tst_fzsync_start_race_b(&fzp);
+		for (int i = test_tty_port; i < MAX_NR_CONSOLES; i++) {
+			ioctl(fd, VT_ACTIVATE, i);
+			ioctl(fd, VT_DISALLOCATE, i);
+		}
+		tst_fzsync_end_race_b(&fzp);
+	}
+
+	return unused;
+}
+
+static void do_test(void)
+{
+	struct vt_consize sz = { 0x1, 0x1, 0x1, 0x1, 0x1, 0x1 };
+
+	tst_fzsync_pair_reset(&fzp, open_close);
+
+	while (tst_fzsync_run_a(&fzp)) {
+		tst_fzsync_start_race_a(&fzp);
+		ioctl(fd, VT_RESIZEX, &sz);
+		tst_fzsync_end_race_a(&fzp);
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable");
+			break;
+		}
+	}
+	tst_res(TPASS, "Did not crash with VT_RESIZE");
+}
+
+static void setup(void)
+{
+	sprintf(tty_path, "/dev/tty%d", test_tty_port);
+	fd = SAFE_OPEN(tty_path, O_RDWR);
+	tst_fzsync_pair_init(&fzp);
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzp);
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{ "linux-git", "6cd1ed50efd8"},
+		{}
+	}
+};
-- 
2.20.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
