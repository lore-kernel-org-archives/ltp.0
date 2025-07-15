Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF52C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 07:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E15E23CC822
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:36:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A121D3CC5C2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:36:41 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DE896EEE9B
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1752564994;
 bh=jmJcqW722WZdK4I4b3QiTcZFTwkZwY/8V8r9FlotoYM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=oSOvaZKBkia3PbZMadYj4VHqWzPmlDHqkWcIcl8BZtPU94pbj8xKccy8dxiz85Irj
 9vZ7celMLRWrcDKHUAjvRYSg/44Q9BcUkOQHNdfNQga72jY2HvyKBZAX15Jg1WaLPU
 JnZ6IS4IGfSCu1pnEtiLxN45xbh80NiLbhrrfaLk=
X-QQ-mid: zesmtpgz5t1752564992t78b2840c
X-QQ-Originating-IP: ndBdypBpw27yGl0nyZzBT8mayZHl0a0DmPv1HqEt9qA=
Received: from localhost.localdomain ( [1.85.7.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 15 Jul 2025 15:36:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11710209410143582040
EX-QQ-RecipientCnt: 3
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 15 Jul 2025 15:36:22 +0800
Message-Id: <20250715073622.60572-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711072406.41444-1-lufei@uniontech.com>
References: <20250711072406.41444-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Mbko2vceDzPNVomOhcronlv4gUPnTatieNcsOPeUjakbIoOOna8jIvk4
 f5X/nporJ2ha2WGoNxJJG52qVN2J9xrHZJceAlghUHylsTjGEgL0+HcyaBRrxv4J5esaVVM
 b8VBx57xHeprS8+WbwvtCjLMDVDu8/anLLDhCYFcHUs96DrIxtMwNPzn/t4EIfqq/2aqIoC
 hMD5qD8qrUV8fhfveFExvnylbsbV2JX/TvE9Zxfe2uDx1EynXVcFb1kVj8qbnnLhVihMYQC
 JbRawlbgUDfU84/TEwi9GILJjcijFOQrtl5+EpvmQb60Q44xr31XkveXOjI8Or8NrMpB+KS
 UCscDU3eVVpMl/WLQKQSW3hjnLHoruLqlM+OoREMlUVVHLKSKdpzfuZ2TPBroPGTCeCpk69
 lrJnoMFxT44s4zAzq52A4iMltoVOQEWvMe9fTwPmR+lA52FKrZ9WX2uH97IsWZ2Ue3LdKfI
 2X9qDYB0QshL3Kd+DXITB6FW6fbko+ewnz4jjwZUPUzT5ksgaFNhCmNnazmR5JEjrjqFnD6
 KkRsV8fQs7Erkm97KVAEDuSncPXPhGj1vGN0sniU8HrppMa5pqZrORUPBX9EnPjRcuUzTbN
 +XtwgWCIrMjFHK2NRTE9KwrENJT0ZR9SPL6clwCcQh6tAqzJbN7nPdFZVrj9RC1b9po7fRr
 f9vQvMCWqr65h3gACttEF4DK0VhH1ch8SqnKlsxI5f3JC48VFnmuHjsW+kczmAUhjXs2ovI
 Qcs4FFa5w67ALloDJf3InGpSHHQziIgGrAdwxsAVoTLdor9rl6bPSWQnkHYJ4iQRbv+vIoR
 FFI/fRIj1Dkbr2WclfSjluP3RNnKHmPMZmZZtFhqF0jL3HrHcusPXgEW7iqgHNWo/G2tYcN
 pJq8USwyZ0EfI1PJQHKWXRLKEuYmU1rl9LkXWkg4EPkrkCTIFTOV+tmqzO2A0wOwG4w8jLN
 6zq/JZQUIai107/1rQvxdqJoldVZUfL1ILk8fZ9t8UZVimpYrjKEWIZqRF5aKicNSfMupFA
 oSGvSTQg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add unshare(CLONE_NEWPID) test
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
 testcases/kernel/syscalls/unshare/unshare05.c | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+)
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
index 000000000..3185d4d2a
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare05.c
@@ -0,0 +1,48 @@
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
+	if (SAFE_CLONE(args))
+		return;
+
+	SAFE_UNSHARE(CLONE_NEWPID);
+
+	if (!SAFE_FORK()) {
+		TST_EXP_EQ_LI(getpid(), 1);
+		exit(0);
+	}
+
+	tst_reap_children();
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
