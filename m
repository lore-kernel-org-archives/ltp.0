Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568A1C3DA66
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 10:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07EEA3CC3AA
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 12:17:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E8AA3CC186
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 12:17:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B3B4601171
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 12:17:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D8382224B;
 Fri, 25 Aug 2023 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692958632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqLE6a0mHoxZnSdA8k5y5NWpj8QLqcSNxp6ShfYO8xc=;
 b=nh5nIpiZATVip7fNzngY5ifpdsbhKYv1djEhLcLZXBnW9UHc6S/ZEcRxpotZs+aR9c+4DK
 p2E+wB521JTtuGNdF/7dRl9ajHoWlQjI8GD83h3cLs87A/iD58COyIBS5lzJzrb6+qKKPF
 933ChnbNt8CR4CR8UZwm+a+45mZ/vsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692958632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqLE6a0mHoxZnSdA8k5y5NWpj8QLqcSNxp6ShfYO8xc=;
 b=DP0RNWu/itO7LtroN/03TTvP/E1awDeEBT7S2pYaYBkjAkEe6Gw6HXAH0HyhYlCIi86OLI
 os7Nlyh788HTbpDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B9321340A;
 Fri, 25 Aug 2023 10:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YHoaAah/6GRNGwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Aug 2023 10:17:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:17:11 +0200
Message-Id: <20230825101711.6370-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add epoll_wait07 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies that EPOLLONESHOT is correctly handled by
epoll_wait.

Implements: https://github.com/linux-test-project/ltp/issues/860
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait07.c | 73 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 88e868a74..1cdba11ce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -175,6 +175,7 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_wait04 epoll_wait04
+epoll_wait07 epoll_wait07
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 222955dd2..c0be9a88e 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -2,3 +2,4 @@ epoll_wait01
 epoll_wait02
 epoll_wait03
 epoll_wait04
+epoll_wait07
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
new file mode 100644
index 000000000..23fa7ec55
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that EPOLLONESHOT is correctly handled by epoll_wait.
+ * We open a channel, write in it two times and verify that EPOLLIN has been
+ * received only once.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int fds[2];
+static int epfd;
+
+static void cleanup(void)
+{
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
+
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+}
+
+static void run(void)
+{
+	struct epoll_event evt_receive;
+    char buff = 'a';
+
+	SAFE_PIPE(fds);
+
+	tst_res(TINFO, "Polling on channel with EPOLLONESHOT");
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[0], &((struct epoll_event) {
+		.events = EPOLLIN | EPOLLONESHOT,
+        .data.fd = fds[0],
+	}));
+
+	tst_res(TINFO, "Write channel for the 1st time. EPOLLIN expected");
+
+	SAFE_WRITE(0, fds[1], &buff, 1);
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 1);
+	TST_EXP_EQ_LI(evt_receive.events & EPOLLIN, EPOLLIN);
+	TST_EXP_EQ_LI(evt_receive.data.fd, fds[0]);
+
+    SAFE_READ(1, fds[0], &buff, 1);
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
+
+	tst_res(TINFO, "Write channel for the 2nd time. No events expected");
+
+	SAFE_WRITE(0, fds[1], &buff, 1);
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
+
+	SAFE_CLOSE(epfd);
+    SAFE_CLOSE(fds[0]);
+    SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
