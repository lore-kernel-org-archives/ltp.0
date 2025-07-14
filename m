Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FEDC83F1D
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 02:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19813CB24E
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 04:20:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 683A63C06E9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:20:02 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20F8310001C6
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1752459598;
 bh=aVdQzg1yuf6Vb3E3deuCiYLFrwLUmAIpqCb1ZW8Dhsk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=TQP/Ofv/YELPpwQ/25uYff3bKfiKUjboygwtBoL0rTarnnLih4cviOhAtPCYwnk0u
 l8oypHlkpFRzDASi4sffyEbXh38XUmrgthZQd2NGbgpRHIcNARDwDyPyI1w17XQRRJ
 X3VJ3OvC2TECb3JIWUEOu6egXLxT5XIxPRuRtoIE=
X-QQ-mid: zesmtpgz4t1752459595t957a2b28
X-QQ-Originating-IP: Wz+zPaSDmlltQIt33XtBkdsYbOyJNsrW6pkbGqqsSVs=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 14 Jul 2025 10:19:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17498532796608779609
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 14 Jul 2025 10:19:51 +0800
Message-Id: <20250714021951.47362-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711072406.41444-1-lufei@uniontech.com>
References: <20250711072406.41444-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: NIMEubczz4fZZK2p+o0AklsPAx0mbAWC+5bCG8qw5EWF13MJrS010jJv
 n95B49ctROLAtX1OyI0/swL3rWSRlWR9iH315BOV44dZPD8JXSHNG1M84JbvoF1Q1KMHSDP
 CfCvj8pik+CGfUGoUumfP+R9s30/PWyGWF2zO9u5xlmFYXrimlxe50tz1ccqy9o66ZpbNM6
 YVjbUhMxh4SM7UM0GIIpB0Im58IV22pzetg14m+i4rOCsqR8iDOnQHg5HPgl0M9I3Fa3qpB
 oLT6n7tqWCZjssJeRaHIeDjBtCChnEwz724tJNgAJ8pMbfucrmovXmcr44hSsRA14m5HnGS
 5SDjNVQBY0JB3jP2QJmc8PxGlVUuhUEDgvbMUwE+uY61e9TvWTpHKnrRDjM7NBfsTMh5X1b
 3+fPVzYdxE5W7T55Pvo1tPYVGUba69STfWKrf2mf7G5uGsONhYXD1hHd/QkIJ/AAfQ1/5mz
 5GDVLx2BbpE6TadVEZBA7nm/10vazbcfe+3oJ/7kbxSiaJA0OsatnzzwFBQ053OqOmBgxno
 laOtk/Tt7eGd6qr4n9VrSl2aSi7HxPfTGppDcGKSuRMnwlvK4R5S6tbTtgCjXU/4h52eDC3
 y//5eh92hirQHkaimNIDWM29cLbTJLpK8yw5arFYTm7j4suNfIyQYzebQrFQTjEAJL6YFMA
 U1qkXSliTe7SHUvU+TP9gPaK9HMA+wUAn5fbJ1IqarhjXBsKs/Xk7eUSfVmjuBSxBU51KNB
 sTRjVRjeNDIz4wrUcc01qgR+OiHYt5v+UmkycDj3hd0OlI0XIGLgRBQAbwuALhQvOZFiKjW
 NuQVsA0BCffwX/cokQGooPSgLRkh5gUU8GuLzMJ7pjn9PvJkRqMZFMh3aYt95k0ffntKWk7
 RBMPKr9QXX0pS8PQWRkWSK9n1Bjce2paB3VZakWP7Y9jDNv7YHtOIbDoqbdMy2Xxe1t8AZJ
 57HfrQ6XtcUZbZZGVvTfpHFNTz57dQyYUNny+4FI/i8IQW2M+a4D6w48vD/8PABhWyL3w9i
 LIs8oKJA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add unshare(CLONE_NEWPID) test
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
index 000000000..59fc782ab
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
+#include "sched.h"
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
+	}
+
+	SAFE_WAIT(NULL);
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
