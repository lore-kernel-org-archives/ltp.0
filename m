Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A6FC83F1A
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 02:15:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5A53CC155
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 04:15:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D8E3C64EF
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 04:14:43 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19C8C60076D
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 04:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1752545677;
 bh=na4EDUea4wsAXvSBSe/DbAuCmz2+MiDkKHya/v3e+4I=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=h/KpAP3iIHOhCbGPW0uxnzkNM22yt39ffoaEsjkx8S6B5+y7egsE5sW6wBve3gZ1R
 9mWnxDXSUyC8b//zuDxZUmWEPXSZNDCx0gz3EzcaqCu0Qr9AevC3m3IsCjGocK6DcO
 Xkh7eN55b2o8lFUMWAFqlKcT2U+VmdYXGOaFZi7w=
X-QQ-mid: esmtpgz13t1752545675ta11c8aa2
X-QQ-Originating-IP: TqKZuCqgINDc3PwBv0Zu5QG1NIr+iPbDY4iKH4/r7xE=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 15 Jul 2025 10:14:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16982580903855416811
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 15 Jul 2025 10:14:26 +0800
Message-Id: <20250715021426.59851-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711072406.41444-1-lufei@uniontech.com>
References: <20250711072406.41444-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MlgWB05FR+ArN5jn5uJOPpmywpakrOnXgYz8ikjfmYmBGTyq83r0stVu
 upgy7930cJbPkH0pFet0wv7dcgdSIYGWcWNVfEztJin26W5MTRk+Du6sRXPkxpQ7iFlypRU
 JLs/6NlbiohbtqAGVsjZfjDSNXuQsW4IavuNGfF0qR+sDsOgF7hfE4V7tLWh7giJVZBLThR
 GGsMnpR9zogeV80zkmCfodz+xMRzHhFJSK191CqA1179p/vbHFg/3GgMlNmQqhU36obV4mL
 dffhCmBFDuXL4EjBEeKrHkYZnjAZo19OPt3uTU6cOHIcTkPDGKcIIKHRD0JMGbYYAZ+6qXj
 +Ti4xLYii0eikSiWalfX3stI5I7Pj0D0J4xt0pLV0wq59YW7q+lecNzJOG0RWw37KtXmdav
 LviVQ9qg5cKKlRoxuQiPzwqqeImgflDgMYuTbciSa1Zn8yVmU6pumfm1TtE5L1gJXhUfYDN
 1uAUTvFkGVTpLdeicMRwGlWsx/yQiwNlE31DRFxu/dJNpT/4ZSMwk6MFwcmS/PPUAWrJAjJ
 T+zZr1bv4ALKJHck3M6xBX82aibViaZJXMsFISw2+zpfJ8atBrMAoEEziJ/GtExTxdWDU8Z
 RE9LNJLPyoTRg23zTEFJGOAuu1dG8VDpQ9zXNjjcRt5TQYF/FB7aQQaPHG6xYm8gls+9v/J
 y3UquqTZdzhV8Xqj9T4aH8i4DYCHdgSaR0a3sor5cxrvVqH7fB48SPGPtfGymrfwAcoa0pX
 1nv3GyNYQH7HXbCosB0SoEFGZhqrEbfDuszJWeq7EzxOdb74Ks/7132yuaEbmU0bQXPzXtY
 +HV5doQPR6sdKbhDup01roADW5G/zW3Ja35cE2rp9YKKbnBRvYI3uZKlrnzrnvmCc6v+u6O
 T+0elHWQ4rO9p5wv6/bZjBoPmjhvN1T5CBBpESgnOdAAs9Ocg245pp2enupdp0V3xH6PoHe
 9rgHIdEZanEO5MJiaLO/sAqKIVLgH1SuoxBXxV3z89xM5n68xOzP4hl9I
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add unshare(CLONE_NEWPID) test
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

Test unshare(CLONE_NEWPID) to make first child in new PID namespce get
pid 1.

Signed-off-by: lufei <lufei@uniontech.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare05.c | 47 +++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unshare/unshare05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 57338297a..82e222bf4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1726,6 +1726,7 @@ unshare01 unshare01
 unshare02 unshare02
 unshare03 unshare03
 unshare04 unshare04
+unshare05 unshare05
 
 #
 # These tests require an unmounted block device
diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
index b1206e452..8ece5f988 100644
--- a/testcases/kernel/syscalls/unshare/.gitignore
+++ b/testcases/kernel/syscalls/unshare/.gitignore
@@ -2,3 +2,4 @@
 /unshare02
 /unshare03
 /unshare04
+/unshare05
diff --git a/testcases/kernel/syscalls/unshare/unshare05.c b/testcases/kernel/syscalls/unshare/unshare05.c
new file mode 100644
index 000000000..c85db36b9
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare05.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 lufei <lufei@uniontech.com>
+ */
+
+/*\
+ * This test case verifies unshare(CLONE_NEWPID) creates a new PID namespace
+ * and that the first child process in the new namespace gets PID 1.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+static struct tst_clone_args *args;
+
+static void setup(void)
+{
+	args->flags = CLONE_NEWPID;
+	args->exit_signal = SIGCHLD;
+}
+
+static void run(void)
+{
+	if (!SAFE_CLONE(args)) {
+		SAFE_UNSHARE(CLONE_NEWPID);
+
+		if (!SAFE_FORK()) {
+			TST_EXP_EQ_LI(getpid(), 1);
+			exit(0);
+		}
+
+		exit(0);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{},
+	}
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
