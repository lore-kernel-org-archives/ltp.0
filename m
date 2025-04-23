Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6EAC369CB
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 04:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EEA93CA833
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 06:46:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0CA33C8F8C
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 06:46:23 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 25EA2200AE1
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 06:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1745383577;
 bh=tDcBB4ir33cUmjso4MctgZb98VYX+QVlV4PRYUjWA2w=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=YMUVg9Pawu1mWmoP/kCppfjUJXbaQGlTTV6o6ejFT1qqAPWiEmSMewbso7Rt6ydH+
 M7AhmD8v8yISglZ+JlHZ/dSsqKyLaUhw4JZ+/+UqJ9bGIr1zyJcFh7yJa6yeOE+znk
 G1dIOwyZ9MDeLkOHjn66GMSqGHosm/xZPdNGcTXs=
X-QQ-mid: izesmtp23t1745383572t1c74b271
X-QQ-Originating-IP: SWS690l7nC0zFhoZ8ri3f6GHgbi4w6SgszaI4vCPBhY=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 23 Apr 2025 12:46:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12540879982959695843
EX-QQ-RecipientCnt: 2
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 23 Apr 2025 12:46:01 +0800
Message-Id: <20250423044601.9320-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: OVnI2EuInbyJjNqfqNj/ofbUOhYSMl/Yu+98Acg0M3O1zE7gzT9u2dSP
 JhwGsHlc2LfFv7fP6F73X/LG+brdp+/TR6ll6AtS9U0OoFJzNq7KvRo3WfrsAcX/sGrebK4
 F4kO1zg34vEp0QROee+e8hgXfR91kBA0c6u4rGPjVgTG+66AuLcSACzeC0A+Fb9F05FvYo4
 Y+t6Hn24QqFgzKDYaTz/iunG+owkQFnnde4j0DaNQcio3vtiRKGfpfylXx9qcoVyUTnCy27
 onAcjVBsFAHwRgjF3XokRQs/yH/V0TfidL9T3atBL5+i3GPX9P1/CzPBDLQipXFBUasmJgb
 Qf3rlTfgKCQWbqMXsaVB/2HDv+YU0lTRbwp3Ue5fY5BJNTw0hpZsmwulevVR+N9HpjNzLcr
 8tX7RxAvbch5ePPKk8ejgT80xjpWVJp/f4nFG+ue0yD2KiZIdY/Xu+uQzV0mUor0/Aq3gdf
 Yr4vN19neWtdI3UC4jjObD3RPo7n88agtm9wNI1XO/t+oT0xvb8mLR6Jd/OnnIfn6kO4Gj3
 D8HAsYX/QW4Nu2VD67BpfRZpQ18V4DCZHeK9HndpyouoP9iAfLPAVZDq+tXwaJtZ4ConkO6
 h9vgi9sAvNPWR25TuMFEpVIcZ0ZUFnsFSh9a5md+5ZmNmURSZ3Ln/nwURQljT+eBcOL36qY
 /QZeCybTcBtw8EXAKm7Hq+qFmBHH/3e1jbCEKTj/j3wavHNRngmKhmJGV6SvGs9izS9hcNp
 oQu17K9Paj9otmW9mIEirY5fmAtPhpOTxlIODA+pZWrpV5fit4Bls3On5iUg7TLj4cQvCnS
 5h8lLRVQOrcjvhJpKE65Tzpf7P2hP0ogjQ4Qmh09obIUvziL5z/8rYOQpM36pQhUM5Eq15x
 gg9fPhQQVUp3Voay9XqCYdyC9ddO9iPbGuxf3IBpbNhHQ5Nt/qnaUCNPgsrqtYjlFJAYxDm
 ut2ZjJ7lQjGGjCnOKXbYVs5TggOd+BmDJRVo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/unshare: New test: CLONE_NEWNS unshares fs
 info
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
 testcases/kernel/syscalls/unshare/unshare04.c | 69 +++++++++++++++++++
 3 files changed, 71 insertions(+)
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
index 000000000..0bbb9d19d
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare04.c
@@ -0,0 +1,69 @@
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
+#ifdef HAVE_UNSHARE
+
+#define TMP "/tmp"
+
+static void run(void)
+{
+	char *c_cwd;
+	char *p_cwd;
+	size_t size = 1024;
+
+	c_cwd = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS,
+			-1, 0);
+
+	p_cwd = SAFE_MALLOC(size);
+
+	struct tst_clone_args args = {
+		.flags = CLONE_FS,
+		.exit_signal = SIGCHLD,
+	};
+
+	if (!SAFE_CLONE(&args)) {
+
+		TST_EXP_PASS(unshare(CLONE_NEWNS));
+
+		SAFE_CHDIR(TMP);
+		SAFE_GETCWD(c_cwd, size);
+	} else {
+		SAFE_WAIT(NULL);
+
+		SAFE_GETCWD(p_cwd, size);
+
+		tst_res(TDEBUG, "parent cwd: %s", p_cwd);
+		tst_res(TDEBUG, "child cwd: %s", c_cwd);
+
+		//in parent, cwd stays in tst_tmpdir_path than TMP.
+		if (strcmp(p_cwd, c_cwd) == 0)
+			tst_res(TFAIL, "cwd not unshared as expected");
+		else
+			tst_res(TPASS, "cwd unshared");
+	}
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test_all = run,
+};
+
+#else
+TST_TEST_TCONF("unshare syscall is undefined.");
+#endif
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
