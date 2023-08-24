Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857CFC27C40
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 14:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66283CC5B3
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 16:45:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3DED3CC4B9
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 16:44:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E66351A00E79
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 16:44:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 201ED1F388;
 Thu, 24 Aug 2023 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692888291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T4YwOmrR2CNrewXsR9FAaB9SmlRTNvQ3bk8hax9iJtc=;
 b=rYWG2TF8jWyEEnFx5cavRtKzUECJ9sMYya0wN4F//Iswmrg4NfLqgToaJsrMkS/22DOZg9
 UiuRnmXM+cfytg7rCvSXKJjQo4kJ3gSCG1EO0Ce1VYbSwR4GVg+eFOGJDZzlEO0udg9cyE
 u23KnqQKRdcLH05EpAO3+9D/c8EaqFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692888291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T4YwOmrR2CNrewXsR9FAaB9SmlRTNvQ3bk8hax9iJtc=;
 b=aH8UG+pjhcnu73QfDA+77nhYR5bFyTgyw8Gv0pE0FENRZHvPZ6vS6zSk9khK56QwkijsV4
 Xe7w0YCi3R9xlgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6C5A1336F;
 Thu, 24 Aug 2023 14:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h5CQNuJs52SDLQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 24 Aug 2023 14:44:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 16:44:49 +0200
Message-Id: <20230824144449.21325-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Add epoll_wait06 test
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

This test verifies that epoll EPOLLET feature works for both EPOLLIN and
EPOLLOUT.

Implements: https://github.com/linux-test-project/ltp/issues/860
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7af2842f3..9c13c7094 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -175,6 +175,7 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_wait04 epoll_wait04
+epoll_wait06 epoll_wait06
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 222955dd2..204949e85 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -2,3 +2,4 @@ epoll_wait01
 epoll_wait02
 epoll_wait03
 epoll_wait04
+epoll_wait06
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
new file mode 100644
index 000000000..fa0bf650c
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that edge triggering is correctly handled by epoll, for both EPOLLIN
+ * and EPOLLOUT.
+ *
+ * [Algorithm]
+ *
+ * 1. The file descriptor that represents the non-blocking read side of a pipe
+ *    (rfd) is registered on the epoll instance.
+ * 2. A pipe writer writes data on the write side of the pipe.
+ * 3. A call to epoll_wait() is done that will return a EPOLLIN event.
+ * 4. The pipe reader reads half of data from rfd.
+ * 5. A call to epoll_wait() should hang because there's data left to read.
+ * 6. The pipe reader reads remaining data from rfd.
+ * 7. A call to epoll_wait() should return a EPOLLOUT event.
+ */
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static size_t write_size;
+static size_t read_size;
+static int fds[2];
+static int epfd;
+
+static void setup(void)
+{
+	write_size = getpagesize();
+	read_size = write_size / 2;
+
+	SAFE_PIPE2(fds, O_NONBLOCK);
+
+	/* EPOLLOUT will be raised when buffer became empty after becoming full */
+	SAFE_FCNTL(fds[1], F_SETPIPE_SZ, write_size);
+}
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
+	char buff[write_size];
+	struct epoll_event evt_receive;
+
+	tst_res(TINFO, "Polling on channel with EPOLLET");
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[0], &((struct epoll_event) {
+		.events = EPOLLIN | EPOLLET,
+		.data.fd = fds[0],
+	}));
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[1], &((struct epoll_event) {
+		.events = EPOLLOUT | EPOLLET,
+		.data.fd = fds[1],
+	}));
+
+	tst_res(TINFO, "Write bytes on channel: %zu bytes", write_size);
+
+	memset(buff, 'a', write_size);
+	SAFE_WRITE(SAFE_WRITE_ANY, fds[1], buff, write_size);
+	TST_EXP_FAIL(write(fds[1], buff, write_size), EAGAIN, "write() failed");
+
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 1);
+	TST_EXP_EQ_LI(evt_receive.data.fd, fds[0]);
+	TST_EXP_EQ_LI(evt_receive.events & EPOLLIN, EPOLLIN);
+
+	tst_res(TINFO, "Read half bytes from channel: %zu bytes", read_size);
+
+	memset(buff, 0, write_size);
+	SAFE_READ(1, fds[0], buff, read_size);
+
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 0);
+
+	tst_res(TINFO, "Read remaining bytes from channel: %zu bytes", read_size);
+
+	SAFE_READ(1, fds[0], buff + read_size, read_size);
+	TST_EXP_FAIL(read(fds[0], buff, read_size), EAGAIN, "read() failed");
+
+	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 1);
+	TST_EXP_EQ_LI(evt_receive.data.fd, fds[1]);
+	TST_EXP_EQ_LI(evt_receive.events & EPOLLOUT, EPOLLOUT);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
