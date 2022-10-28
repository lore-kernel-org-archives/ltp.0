Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79618ECAAA1
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 09:02:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C70F3CA9AD
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 11:02:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 445EB3CA610
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 11:02:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C2EDE1400DEF
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 11:02:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A43CA1F8AB;
 Fri, 28 Oct 2022 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1666947736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Lbp+qgFqYULU1pNchsYMANdwgDSSHdvojpRuyyq2k+k=;
 b=iwREdJjrqwW3ToPcicwiYN/7sn+2xIoHsTFryQsjjCcCz0FwMqXm6lZT0vYmh5hMvB0HFF
 thBqYBY9vK9DS0Q8ptTc3VOm0vI234ciTzNQcChQxvIx3cfwDuAK3ePZ4D98O6OrJE962W
 EDB+SjfomTrWASsMudSl/BDpP5KchJo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51E5713A6E;
 Fri, 28 Oct 2022 09:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kltIDpiaW2NCDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 28 Oct 2022 09:02:16 +0000
To: ltp@lists.linux.it
Date: Fri, 28 Oct 2022 11:00:53 +0200
Message-Id: <20221028090053.1662-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add epoll_wait07 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test verifies EPOLLONESHOT functionality.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Make use of SAFE_EPOLL_* macros
Listen to EPOLLIN event instead of EPOLLOUT

 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait07.c | 78 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c

diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 8c5ed7c5c..66ac18ae2 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -4,3 +4,4 @@ epoll_wait03
 epoll_wait04
 epoll_wait05
 epoll_wait06
+epoll_wait07
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
new file mode 100644
index 000000000..9a492c148
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
+#define WRITE_SIZE 2048
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
+	char buff[WRITE_SIZE];
+	struct epoll_event evt_receive;
+	struct epoll_event evt_request;
+
+	SAFE_PIPE(fds);
+
+	evt_request.events = EPOLLIN | EPOLLONESHOT;
+	evt_request.data.fd = fds[1];
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	tst_res(TINFO, "Polling channel with EPOLLONESHOT");
+
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[0], &evt_request);
+
+	tst_res(TINFO, "Write on channel multiple times");
+
+	memset(buff, 'a', WRITE_SIZE);
+	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
+	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
+
+	SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 2000);
+
+	if ((evt_receive.events & EPOLLIN) == 0) {
+		tst_res(TFAIL, "No data received");
+		goto close;
+	}
+
+	tst_res(TINFO, "Received first EPOLLIN event");
+
+	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 0), 0);
+
+close:
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
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
