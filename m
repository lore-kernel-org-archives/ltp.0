Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A1C369D1
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 09:34:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 763D83CB4D4
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 11:34:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D78773C0717
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:34:20 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF3A52009EF
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1745573653;
 bh=8ljI226h5z4spkMl8Yyl78EofFk+eDj6rMD/j9SX8uk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ojAyOL9S1M/RAaw70BibPBJjEWuMSrW++jFWU2CZp3DJeWddmdjXu49bkE4EWCNQy
 YZMYP3yZ9Ad4wok1+vIJVuL8C4Oqfyxs7EorBDmfSLAuowKdWv0DbHK5l0WDTb6arj
 icNX0hOLrKf65k3FCXUJIjwRgVot0WYNDXqHerEA=
X-QQ-mid: esmtpgz15t1745573650t64dfea24
X-QQ-Originating-IP: +aZwBBYplid07bjZDhZp8CU6i0LW1U5ZAJyySC09iKo=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 25 Apr 2025 17:34:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6513872185490752326
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:33:55 +0800
Message-Id: <20250425093355.14063-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250423120516.10680-1-lufei@uniontech.com>
References: <20250423120516.10680-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Ob+TdET2B71e5cDBJnvYmgzAH8nE11gy0+mvUHMx9ZLMB1d7LUgmDvrY
 Pzv6J/mGBx4WzmoI6ztu/9TuEkCLlFeO4Yk0V4q0FFrbzLaCAnUp5dzaKZX7l92ccSGzZHl
 UFX8iZe5zSyHkDma/+J+5/ir87B0h3V0V5ZWUE9AlRqR63yKqAweYCsVDD6sJmnbs2+MH9s
 jHFKXySCAgbarp2Qr1v/YE5KEMPxL3yClxSIck6AN1gjblQmr2nBOO1iJJtoEr1EXAUlM2w
 PNP86mDYdUCNIt7XvwfEF6aSnpYMYkCjKzU8gyK17qIAIDr831lCTnLAZnpWCGMYz3QBxJj
 FHMtnQgU0AbprU8ycBsIK7uKEFVJ9n67t90MCpgmJPv4//2SKGlHglhuita7fnFt3zsHXGv
 ifp/cNjc7A9kJOewdQYm3udN8GeqQvHcgO/KLWR0/vDjMmPVwsYrb37jjny2HkK0bMwQOL5
 61LtyW2YcOqQaW0nDDfT7sNA2KDy5jfUdeMYU6ltHHDYboIdel1a5JkneBoc7GxeryL1jTA
 fPqJFMtRtzOCRG3G+VV5avwYDOmvjoprkXPclkQ+1iFJ19918qpthZZz+Ux9qPcoQFNM/pI
 HWWMTAduaUv//4OazJwJWoUNB7kOy339eMM35fEi09EjqQFKzyuE3EmQRLOxhgAgbGIh64S
 y0iUvvCmikCASfyrHfVVzU+A6JPxM1LgNifL8bSpxHmI+ZkpgcMgIUCppe/sEqYzbWvl1LC
 vOZVjv6LPgLoBPgvCXOJvNm+jy5jF17wu4OuQ0mUc+btInLl8M8uPdBaoi6Tj/pLJ6RnONZ
 GaxY1XAfORRSx7YsXKb3idfmqvd71VlZSqpE7Vgt5pzLASia+uoTJS8KkZuIMrZRocH1pFE
 XOBfSLZAJNpiMtABin0oKWVUgf3mih6lvM5iv5uW5V2/eNoBW8+Oo4LglEvu0DSpW0Um9jv
 tkVKFDV8IahsnlyliR5GaNfPr9M5zYpllcQwiHDl+BjxNvamOfC5Fw7lo
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/unshare: New test: CLONE_NEWNS unshares
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
 testcases/kernel/syscalls/unshare/unshare04.c | 77 +++++++++++++++++++
 3 files changed, 79 insertions(+)
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
index 000000000..5b3e5d98f
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare04.c
@@ -0,0 +1,77 @@
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
+#define TESTDIR "test_dir"
+
+static char *cwd;
+static char *buff;
+static size_t size = 1024;
+
+static void setup(void)
+{
+	cwd = SAFE_MALLOC(size);
+	SAFE_GETCWD(cwd, size);
+
+	SAFE_MKDIR(TESTDIR, 0700);
+
+	buff = SAFE_MALLOC(size);
+}
+
+static void cleanup(void)
+{
+	free(buff);
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
+		SAFE_CHDIR(TESTDIR);
+		SAFE_GETCWD(buff, size);
+
+		if (strcmp(cwd, buff) == 0)
+			tst_res(TFAIL, "current dir not changed");
+		else
+			tst_res(TPASS, "current dir changed to %s", buff);
+	} else {
+		SAFE_WAIT(NULL);
+
+		SAFE_GETCWD(buff, size);
+
+		if (strcmp(cwd, buff) == 0)
+			tst_res(TPASS, "cwd unshared");
+		else
+			tst_res(TFAIL, "cwd not unshared as expected");
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
