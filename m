Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018ABC83F17
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 02:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D25373CB326
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 04:15:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A49593C06E9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:15:18 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B908A1400779
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1752459312;
 bh=SJmbo7QaEQHp4QoztTiMX5kxp8SEQeuq3xccE2NaDDA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ItsA6CwrWwtjch2gHwLn2TwdjNJKOJcrsOIsELZDeoYsrRU/DBC3QQo+Hos+XLM5W
 10C8rpCR7a0l9qdNWdTQyXy4bND+HXPp3Cqm2FdgE7lqdFJKscIcmygPmxN+aM3eUE
 Ii0zR5hwvoiNNFe2IU95LYCU+sQy1uBtr3/D174I=
X-QQ-mid: zesmtpgz7t1752459309t3c78d8c5
X-QQ-Originating-IP: AGqEthe8LMLnRSX4pXb0UTeq+/pKETRgHZLNC9k8atY=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 14 Jul 2025 10:15:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5825497736320936593
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 14 Jul 2025 10:14:43 +0800
Message-Id: <20250714021443.47321-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711072406.41444-1-lufei@uniontech.com>
References: <20250711072406.41444-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MQZ/dZQlO/THM/ZGfSc58E6FoudSQUvbSOyXyu9kCeNQFdLD+K72njiy
 +Z1CRzcpXujBz5IRK+0EUnPAxnATqADMwfEInUIuaNvY3DBQK5dEJf2sW0oSUClf6qmtFIy
 nutGHPd3xioh2LIuRlm7iHeMvtzTFuQqR6vKoYYaNrAtAivgbJroWFPC0RXQaFYTh6e72zi
 rO/wTf2l9qzlWv2Y436O3lwTbJ18palM3RrOUlwASixBhoShXXq1i98KIclBwGCGZQ9hfN3
 whrQCkkq6cltjk3kc5h22aAKZA4itfU7fPldU5KC5a/PzMQX1Z+uy0EFjHclCxLiWrZqDNn
 QQzNc1u1FI9cU+I0GKTweKYUgEG0SUxAadeyVBaQJvi5oRLZ9D3heK7g4h0CBjDxtY4+Rqw
 KdRktWA9HnIzmRp+NZ/fhmTvLLB05x8GRUjPrZWN/ueiCa3pQ07R/ek+ivAf37RJaUcBb6N
 Cyn4vn0ju331d2vO0Znbt2eV2HmiA/qSkh/97qvJcfGnDSIyKRVCSgIKxkn69E1wl/i9eVI
 AMfLSzFmep+UUig6VQtqHnzYTJ9eByjLzVVASYeo7GUtPC3Gi7t9cEEZ0qFpZ8zQNkjejCJ
 +GVyjX0Zz1ATlHw1n+FsnrNEf0dfbRyML2/f4M8BhNJaM+SyVd8GzXql8BumEy1gx+K+xpS
 DKwSJbjyn8TI2ixxuzjwQOWwEix29lnHafduN9q38F+6jkMLzAXbuw5E6zJWlpWvMnMc1tl
 Xmp15Df3c1WItSfmyRVGsdMNmOtOiKoCrpT11UkTbG85nAHigX0uTuSEubPVzlh/MDt8oKG
 osYUuo3MCKVB21fFQ21OQ8YNvSZXDHza37I/0Moq38Cc8y2uPh2G5uaTgVBCML/xb2xGZKL
 UdtsCqaj7rccm83NIZW+12mdrJQ16FPKJ+RClqHgE7SLA255Me4AAeEs0vwaG9K1EL/mAKL
 e4LkuqU/uEvqHG4SbYbfxaXZxSRbHpEYkmdhoIrksQQyOJtaBEBBOBtEvxrztmcs/nDU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
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
