Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1558EE4993
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 13:09:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBB453CC66D
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 15:09:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3716D3C8AC4
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:09:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1F961400125
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:09:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F2D822363;
 Wed, 23 Aug 2023 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692796146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6qPlBrdoH2WuAeuyjxGWcvy3RV029HgsB+VvXKzK+CY=;
 b=Wx+qxmEQ/NAGuv/bBGZw5qhho8yZ8il02564XoH51T/jqfzKOEKrXU8UeweuGvqv6x/uUq
 A0dkcvH0Lw7+BxiESZeHofRrV/wGJlEjU9N0uuecMm2YeMcbHhwQy9DJsnuBuPOlgnOJJV
 uSRv2McNt7ZOLoA4armoVijIXCS8D9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692796146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6qPlBrdoH2WuAeuyjxGWcvy3RV029HgsB+VvXKzK+CY=;
 b=tyn8vjAnehSNy2dRm8hFsUijbCX1bKQ4EXmA8Iz7cK4GrbusjlDF7rudrj7f2aXNu5w2Tz
 GQeyXl6TmAnvX3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0121D13458;
 Wed, 23 Aug 2023 13:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JbFyOvEE5mSbZQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Aug 2023 13:09:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 23 Aug 2023 15:09:04 +0200
Message-Id: <20230823130904.26051-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add epoll_wait05 test
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

This test verifies that epoll receives EPOLLRDHUP event when we hang
a reading half-socket we are polling on.

Implements: https://github.com/linux-test-project/ltp/issues/860
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait05.c | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7af2842f3..27819b41b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -175,6 +175,7 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_wait04 epoll_wait04
+epoll_wait05 epoll_wait05
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 222955dd2..ab5a9c010 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -2,3 +2,4 @@ epoll_wait01
 epoll_wait02
 epoll_wait03
 epoll_wait04
+epoll_wait05
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
new file mode 100644
index 000000000..a055a5885
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll receives EPOLLRDHUP event when we hang a reading
+ * half-socket we are polling on.
+ *
+ * As reference please check https://lwn.net/Articles/864947/
+ */
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_epoll.h"
+
+static int epfd;
+static int sockfd_client;
+static int sockfd_server;
+static in_port_t *sock_port;
+
+static void create_server(void)
+{
+	int sockfd_server;
+	socklen_t len;
+	struct sockaddr_in serv_addr;
+	struct sockaddr_in sin;
+
+	tst_init_sockaddr_inet_bin(&serv_addr, INADDR_ANY, 0);
+
+	sockfd_server = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(sockfd_server, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
+	SAFE_LISTEN(sockfd_server, 10);
+
+	len = sizeof(sin);
+	memset(&sin, 0, sizeof(struct sockaddr_in));
+	SAFE_GETSOCKNAME(sockfd_server, (struct sockaddr *)&sin, &len);
+
+	*sock_port = ntohs(sin.sin_port);
+
+	tst_res(TINFO, "Listening on port %d", *sock_port);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CLOSE(sockfd_server);
+}
+
+static void run(void)
+{
+	struct sockaddr_in client_addr;
+	struct epoll_event evt_req;
+	struct epoll_event evt_rec;
+
+	if (!SAFE_FORK()) {
+		create_server();
+		return;
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TINFO, "Connecting to port %d", *sock_port);
+
+	sockfd_client = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+
+	tst_init_sockaddr_inet(&client_addr, "127.0.0.1", *sock_port);
+
+	SAFE_CONNECT(sockfd_client,
+		(struct sockaddr *)&client_addr,
+		sizeof(client_addr));
+
+	tst_res(TINFO, "Polling on socket");
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+	evt_req.events = EPOLLRDHUP;
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd_client, &evt_req);
+
+	tst_res(TINFO, "Hang socket");
+
+	TST_EXP_PASS_SILENT(shutdown(sockfd_client, SHUT_RD));
+	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
+
+	if (evt_rec.events & EPOLLRDHUP)
+		tst_res(TPASS, "Received EPOLLRDHUP");
+	else
+		tst_res(TFAIL, "EPOLLRDHUP has not been received");
+
+	SAFE_CLOSE(epfd);
+	SAFE_CLOSE(sockfd_client);
+
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void setup(void)
+{
+	sock_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (sock_port)
+		SAFE_MUNMAP(sock_port, sizeof(in_port_t));
+
+	if (fcntl(sockfd_client, F_GETFD) > 0)
+		SAFE_CLOSE(sockfd_client);
+
+	if (fcntl(sockfd_server, F_GETFD) > 0)
+		SAFE_CLOSE(sockfd_server);
+
+	if (fcntl(epfd, F_GETFD) > 0)
+		SAFE_CLOSE(epfd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3a34b13a88ca"},
+		{},
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
