Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C83C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A68F3CBF31
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:49:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 375093CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:49:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 90C9320093B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:49:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E78CB20A64;
 Wed, 15 Feb 2023 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676472584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ig1lMmRJurNcnOL6MSYiynbCWr6xMBal9FBqheN+JZY=;
 b=rTd5VCH8J9A1YPUWKDLEFnJGac1VZhq+TaiBP9wgJ9ycb8JZoRaJK0yKnjo108AwSfnZ5T
 lmdxZM4srZFZDb01BfTjIEqJ11RM+cgBuiN/4CE7JGWpxiSmbAxU+EVbDfVARMiJPDYpEE
 ISrbrR8RuF9gEd0t7jD49B+WuifXxE0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7DCC13483;
 Wed, 15 Feb 2023 14:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x8gAKQfx7GNJEQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Feb 2023 14:49:43 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 09:48:20 -0500
Message-Id: <20230215144820.17876-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mq_notify03.c: New test CVE-2021-38604
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test is come from glibc test mq_notify.c.
Implements following logic:
1) Create POSIX message queue.
   Register a notification with mq_notify (using NULL attributes).
   Then immediately unregister the notification with mq_notify.
   Helper thread in a vulnerable version of glibc
   should cause NULL pointer dereference after these steps.
2) Once again, register the same notification.
   Try to send a dummy message.
   Test is considered successfulif the dummy message
   is successfully received by the callback function.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/mq_notify/.gitignore      |   1 +
 .../kernel/syscalls/mq_notify/mq_notify03.c   | 105 ++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mq_notify/mq_notify03.c

diff --git a/runtest/cve b/runtest/cve
index 1ba63c2a7..07bcac0b0 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -74,6 +74,7 @@ cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
 cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
+cve-2021-38604 mq_notify03
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-4378 cve-2022-4378
diff --git a/runtest/syscalls b/runtest/syscalls
index 81c30402b..536140a3e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -832,6 +832,7 @@ pkey01 pkey01
 
 mq_notify01 mq_notify01
 mq_notify02 mq_notify02
+mq_notify03 mq_notify03
 mq_open01 mq_open01
 mq_timedreceive01 mq_timedreceive01
 mq_timedsend01 mq_timedsend01
diff --git a/testcases/kernel/syscalls/mq_notify/.gitignore b/testcases/kernel/syscalls/mq_notify/.gitignore
index cca05a7fa..3f9403c05 100644
--- a/testcases/kernel/syscalls/mq_notify/.gitignore
+++ b/testcases/kernel/syscalls/mq_notify/.gitignore
@@ -1,2 +1,3 @@
 /mq_notify01
 /mq_notify02
+/mq_notify03
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify03.c b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
new file mode 100644
index 000000000..6b31e1df1
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) The GNU Toolchain Authors.
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ *
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for NULL pointer dereference in mq_notify(CVE-2021-38604)
+ *
+ * References links:
+ * - https://sourceware.org/bugzilla/show_bug.cgi?id=28213
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <mqueue.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
+
+static mqd_t m = -1;
+static const char msg[] = "hello";
+
+static void check_bz28213_cb(union sigval sv)
+{
+	char buf[sizeof(msg)];
+
+	(void)sv;
+
+	TST_EXP_PASS(!((size_t) mq_receive(m, buf, sizeof(buf), NULL)
+				== sizeof(buf)));
+	TST_EXP_PASS(!(memcmp(buf, msg, sizeof(buf)) == 0));
+
+	exit(0);
+}
+
+static void check_bz28213(void)
+{
+	struct sigevent sev;
+
+	memset(&sev, '\0', sizeof(sev));
+	sev.sigev_notify = SIGEV_THREAD;
+	sev.sigev_notify_function = check_bz28213_cb;
+
+	/* Step 1: Register & unregister notifier.
+	 * Helper thread should receive NOTIFY_REMOVED notification.
+	 * In a vulnerable version of glibc, NULL pointer dereference follows.
+	 */
+	TST_EXP_PASS(!(mq_notify(m, &sev) == 0));
+	TST_EXP_PASS(!(mq_notify(m, NULL) == 0));
+
+	/* Step 2: Once again, register notification.
+	 * Try to send one message.
+	 * Test is considered successful, if the callback does exit (0).
+	 */
+	TST_EXP_PASS(!(mq_notify(m, &sev) == 0));
+	TST_EXP_PASS(!(mq_send(m, msg, sizeof(msg), 1) == 0));
+
+	/* Wait... */
+	pause();
+}
+
+static void do_test(void)
+{
+	static const char m_name[] = "/bz28213_queue";
+	struct mq_attr m_attr;
+
+	memset(&m_attr, '\0', sizeof(m_attr));
+	m_attr.mq_maxmsg = 1;
+	m_attr.mq_msgsize = sizeof(msg);
+
+	m = SAFE_MQ_OPEN(m_name,
+			O_RDWR | O_CREAT | O_EXCL,
+			0600,
+			&m_attr);
+
+	if (m < 0) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "POSIX message queues are not implemented");
+		tst_brk(TFAIL | TTERRNO, "mq_open failed");
+	}
+
+	TST_EXP_PASS(!(mq_unlink(m_name) == 0));
+
+	check_bz28213();
+}
+
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"glibc-git", "b805aebd42"},
+		{"CVE", "2021-38604"},
+		{}
+	},
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
