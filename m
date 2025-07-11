Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0ACC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 07:24:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1975D3CB1BB
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 09:24:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05AEB3C218B
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 09:24:26 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B51091A00CB7
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 09:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1752218657;
 bh=SJmbo7QaEQHp4QoztTiMX5kxp8SEQeuq3xccE2NaDDA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Rj3IoLDQhjJt1c0l0lu+FBBkofaBDqRYSG0H5nQGO9tuutzQbGnfB0BiwSARv+5iA
 H0CEBeZiijkJZ9KHPOr1h9VGks0PKfEzcRJTiVVjHFAwaZOw1yYR/hxj52pI/+EqvB
 6SPgnsfxQ2QrgZtz1F+M3vnQcg2FlgueQFEqR9do=
X-QQ-mid: zesmtpgz7t1752218653t8110959a
X-QQ-Originating-IP: /+iaDU7Y1KijdWJw2KMNzUuSyjWj93aYuuznSNQ8B2g=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 11 Jul 2025 15:24:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17497584149694867037
EX-QQ-RecipientCnt: 2
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 11 Jul 2025 15:24:06 +0800
Message-Id: <20250711072406.41444-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MACXe2l6e7j9bt3c3YVwG15ZzXb3tDI1JHi5NqJAx7FqgkCmFUWZosSA
 JCtGC5hq4MAEBhUwyfQ5hsTqN3RCXvPUwUYizxRJGHF1fWfzrbXSmht8eKARCc+l7TwAaL8
 zvFci3zN0/RqJJoYeBgeThA+N+pSfp7UbW2E/FI6ewY3WpVh0ckfFjsFB/SfSeR/dhN3OyD
 F7kdjZ8rWQabKWgqVNXIBWmmKWnPHfnzHi0vD/mUEqwAY/PbEkXifnmbkhvEgLiZxvXt6lG
 a7rHrP5+T7DuXdQ5I5NNJGQW6cbNoXvyYecAnQP8wXt2+eMrPbwjJN86IIcsAWBQ9iW1s8x
 0+sLWuxg7q0bbVNzMGgx/YyPUP+ElQyNivwO9SQn483JD4r1HIWs0OZfyKv5pKP2qDvUvKm
 KKF/XDRaqUXnd+xQwbmOjJjwCTttP3wU8N2zM6YtAvsPm+vsvLQKhgTXgEZOsiKgEUVAsEh
 8z8GawR+4WJyn5q9WBRsbFLoecb74S2/Ff53z+C010s7HENsjgg4/dRTZrek8fl9ShxMyFY
 sGweXeqnWhvT+q6OWgOyYPLaR43T18Qdn13N1ILrScPZWX8Y6ZKqNRAv4jYjU1qM4QGe1hf
 NsxQmKm95x+P4yUe76Xp+80sesIj9dgBc7n3EnM1vRWBctDH3cx7GnKa6ixKnXnaEyvsxOE
 8BUEEG5LjmKN8kS9W9EVVv15KdcbhxahwJtrpV9w2AH2Frnpx4QnQi/YFR+61g5PxuZuJNo
 lkVjNcQrr9N6fGnBrspiH0qbwGc3rP26Ug4lkiklpX/YkvM64NiUV9tiAAATcnYYR3SZ8Yg
 v76j9MSEZIN44pg+iZ8uiNKoT8Vg9z3A/CxhCt09YfaDr4MwDDWdbiYwycF1Ddbrro37T90
 13wcKe870E3jT+DzqALdEbL84ktscb9XCroOw1jj3RB6m/cQdNIxmfLq6sviyUlD4qHRGi4
 CGJecVv0JrY5M/iqUGarsaeC1MECAUTb6CQx+FMxF6p5DIw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add unshare(CLONE_NEWPID) test
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
 testcases/kernel/syscalls/unshare/unshare05.c | 54 +++++++++++++++++++
 3 files changed, 56 insertions(+)
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
index 000000000..cfc5877da
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare05.c
@@ -0,0 +1,54 @@
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
+static void run(void)
+{
+	struct tst_clone_args args = {
+		.flags = CLONE_NEWPID,
+		.exit_signal = SIGCHLD,
+	};
+
+	if (!SAFE_CLONE(&args)) {
+		TST_EXP_PASS(unshare(CLONE_NEWPID));
+
+		pid_t child_pid = SAFE_FORK();
+
+		if (child_pid == 0) {
+			pid_t pid = getpid();
+
+			if (pid == 1)
+				tst_res(TPASS, "First child in new PID "
+						"namespace has PID 1");
+			else
+				tst_res(TFAIL, "First child in new PID "
+						"namespace has PID %d, "
+						"expected 1", pid);
+			exit(0);
+		} else {
+			SAFE_WAIT(NULL);
+		}
+
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.min_kver = "3.8",
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
