Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4CAC43217
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F0B3CAEEC
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:42:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDEC53CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:41:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 53FAB1A00CD9
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:41:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31C031F38A;
 Thu, 13 Oct 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665646911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=djcyYh8ClTYAddUUt3VJOJDP1BRr8PZb2uYHXXvHZcw=;
 b=suEU3ygR6tDzVuMaUj2vT+mZhjRGcqkdODU15o8Tp5WXsPdTGbb587aOGnQExJTF38Igfi
 oydYtyLWumTqtXZsDT97B80oBe4K+kL8AosWg+yElnuhj9JucCfz/kL8+EAxmQS8VW3Ho5
 5qGTpgIKQvA2WohM+7YZ5qlHl6LGEHg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5567139F3;
 Thu, 13 Oct 2022 07:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Dr9lMD7BR2M+TgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 13 Oct 2022 07:41:50 +0000
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 09:40:36 +0200
Message-Id: <20221013074036.3887-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add epoll_wait06 test
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

This test verifies EPOLLET functionality.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 100 ++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c

diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index ab5a9c010..8c5ed7c5c 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -3,3 +3,4 @@ epoll_wait02
 epoll_wait03
 epoll_wait04
 epoll_wait05
+epoll_wait06
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
new file mode 100644
index 000000000..89316f6fc
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that edge triggered behavior is correctly handled by epoll
+ * using EPOLLET.
+ *
+ * [Algorithm]
+ *
+ * 1. The file descriptor that represents the read side of a pipe (rfd) is
+ *    registered on the epoll instance.
+ * 2. A pipe writer writes 2 kB of data on the write side of the pipe.
+ * 3. A call to epoll_wait(2) is done that will return rfd as a ready file
+ *    descriptor.
+ * 4. The pipe reader reads 1 kB of data from rfd.
+ * 5. A call to epoll_wait(2) should hang returning 0 because there's data
+ *    left to read.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+#include "tst_test.h"
+
+#define WRITE_SIZE 2048
+#define READ_SIZE (WRITE_SIZE / 2)
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
+	int res;
+	char buff[WRITE_SIZE];
+	struct epoll_event evt_receive;
+	struct epoll_event evt_request;
+
+	SAFE_PIPE(fds);
+
+	evt_request.events = EPOLLIN | EPOLLET;
+	evt_request.data.fd = fds[0];
+
+	epfd = epoll_create(2);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	tst_res(TINFO, "Polling channel with EPOLLET");
+
+	res = epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &evt_request);
+	if (res == -1)
+		tst_brk(TBROK | TERRNO, "epoll_ctl failure");
+
+	tst_res(TINFO, "Write bytes on channel");
+
+	memset(buff, 'a', WRITE_SIZE);
+	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
+
+	res = epoll_wait(epfd, &evt_receive, 1, 2000);
+	if (res <= 0) {
+		tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
+		goto close;
+	}
+
+	if ((evt_receive.events & EPOLLIN) == 0) {
+		tst_res(TFAIL, "No data received");
+		goto close;
+	}
+
+	tst_res(TINFO, "Received EPOLLIN event. Read half bytes from channel");
+
+	memset(buff, 0, READ_SIZE);
+	SAFE_READ(1, evt_receive.data.fd, buff, READ_SIZE);
+
+	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 10), 0);
+
+close:
+	SAFE_CLOSE(epfd);
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
