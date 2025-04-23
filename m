Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A79C369CB
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 12:06:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34593CAF8F
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 14:06:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 314733C02B9
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 14:05:59 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DF0E600678
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 14:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1745409947;
 bh=sMu9939CBaTsLNl+Z383Ik4DOnJ4J+KzLgw4sd9Jtbw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=FUISSSm/rmeHhGoovm5wKHwnbzp9gCTFepM9nCYXQmm6eqhpX1RZcMXyRN3i7pugH
 OOmIobKwBE/+rmUKDINY9/civOZ8TB7M8lSl181tws2cf8jMGPDk2VX8QkXLU5ZvU5
 Mlo/3GukB+LZAIqseO89BcRPEaw2eCmhifnAT+hk=
X-QQ-mid: izesmtp89t1745409945t08487731
X-QQ-Originating-IP: NPkeLQBiIArcslbjMH3ju7sqvCcodSqiDldxgaePXMg=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 23 Apr 2025 20:05:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11255545926128710316
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 23 Apr 2025 20:05:16 +0800
Message-Id: <20250423120516.10680-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250423044601.9320-1-lufei@uniontech.com>
References: <20250423044601.9320-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MBM7ZRXIsfHgO02IvQkoxh1guexizlbanuyGdYvUCo9xGgD4qHV0N0QY
 l3OzqE3SHPLrkSMwNDOwqjlm4Dyc43YQJccgoUuaYOlCe4sJ3iSc+zUP301B6AYMUxXwayc
 MEXgaEYdzaXknlMX0Dgr3BDWmkawUugFniqu/B1kej9M88VfArUdVKHJ0v5Na/EHo5buVj5
 hiS+tBqEgMLF+BB0XD2L0MXwjJmDAuNo/4R8aSQ+DJoKoIUqVRHmCHQcS2gpYibY9vkQKT/
 qgZSD+48CTKUYUKA122cHAc7UrO0otlccLmOnzJwQe9nqPWT9aGEauCOlzJtjOw66ny2HqV
 aLWa//XIIrWBr+0f2gDTO0k6y5CiR9MWlJt4oU+Z5WP1dtsk34sxa93zY/TcKtRwFUMRpoc
 CdawcO17RlCaJ0+A78Fo9y0quIdH72oOLXE2Yl5hoL/9X2ggAxnfgDxCJ11Ez1z1HY319JP
 wlTrzKijWJmqWuUBdVUbjXJuHpr2m+WUaOYdIFNUA5sLoxCo+THk9ILUrmRozPWJ9dOgKwz
 od64fQYes06deVQXBDGIQySlrIBWvSMohh6aoK2dJB/3qvMd+q3C4mFxXXnsR82ORyVLC93
 PJkWf+aQxLW9dOVkV4Hoof6w8xXBHtJDI8ttR5pcSExwpguCQBtz+ojDHMau7TTr3BU7Db4
 UA6nuhsuDgYi+z9jutG+Ma0ecENuu5buKPDqJKbr5tU+BT5iS7FTLXRhclJhyUY7FRo9x2z
 t4eFdYbOP1bvpm14xCdaU7Vg+24fAi6vf+AjfrPiC0ddLL9gvgiZO5WjevXckEJlYnGffcT
 4cxMs7uakDNHkWG7VUNsG3TnPgNJCnVfG9YbMOjo5GkHF1B4bgU3AcXxy5OstHbB7V61QLD
 EQe0N8gi4ueWjO7GoF0GWi44g4KFUskWR6minyVcsdQrgEi3V1WE2D7msrXBeB9+cR6M3d+
 JpqlIacGW/V4Z8UqqsTo37SzHYzv5AKITd/eJeSwfgvl3jGg8vw0wyq10
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/unshare: New test: CLONE_NEWNS unshares
 fs info
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add test case unshare04, to verify unshare(CLONE_NEWNS) also unshares
filesystem information.

Signed-off-by: lufei <lufei@uniontech.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare04.c | 82 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unshare/unshare04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 844ae7a13..57338297a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1725,6 +1725,7 @@ unlinkat01 unlinkat01
 unshare01 unshare01
 unshare02 unshare02
 unshare03 unshare03
+unshare04 unshare04
 
 #
 # These tests require an unmounted block device
diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
index e5b5c261d..b1206e452 100644
--- a/testcases/kernel/syscalls/unshare/.gitignore
+++ b/testcases/kernel/syscalls/unshare/.gitignore
@@ -1,3 +1,4 @@
 /unshare01
 /unshare02
 /unshare03
+/unshare04
diff --git a/testcases/kernel/syscalls/unshare/unshare04.c b/testcases/kernel/syscalls/unshare/unshare04.c
new file mode 100644
index 000000000..d76e6a836
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare04.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * This test case is to verify unshare(CLONE_NEWNS) also unshares filesystem
+ * information.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+#define TMP "/tmp1"
+
+static char *cwd;
+static char *tmpdir;
+static char *c_cwd;
+static char *p_cwd;
+static size_t size = 1024;
+
+static void setup(void)
+{
+	cwd = SAFE_MALLOC(size);
+	SAFE_GETCWD(cwd, size);
+
+	tmpdir = tst_tmpdir_genpath(TMP);
+	SAFE_MKDIR(tmpdir, 0700);
+
+	c_cwd = SAFE_MALLOC(size);
+	p_cwd = SAFE_MALLOC(size);
+}
+
+static void cleanup(void)
+{
+	free(c_cwd);
+	free(p_cwd);
+	free(cwd);
+}
+
+
+static void run(void)
+{
+	struct tst_clone_args args = {
+		.flags = CLONE_FS,
+		.exit_signal = SIGCHLD,
+	};
+
+	if (!SAFE_CLONE(&args)) {
+
+		TST_EXP_PASS(unshare(CLONE_NEWNS));
+
+		SAFE_CHDIR(tmpdir);
+		SAFE_GETCWD(c_cwd, size);
+
+		if (strcmp(cwd, c_cwd) == 0)
+			tst_res(TFAIL, "current dir not changed");
+		else
+			tst_res(TPASS, "current dir changed to %s", c_cwd);
+	} else {
+		SAFE_WAIT(NULL);
+
+		SAFE_GETCWD(p_cwd, size);
+
+		if (strcmp(cwd, p_cwd) == 0)
+			tst_res(TPASS, "cwd unshared");
+		else
+			tst_res(TFAIL, "cwd not unshare as expected");
+	}
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
