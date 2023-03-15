Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB5DC61DA4
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 15:05:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01AB53CE614
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 16:05:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 334613CAC8A
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:05:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DD5E200C78
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:05:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9756E1FD7D;
 Wed, 15 Mar 2023 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678892739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fRb+TLInTlszU6maeL6LVPcAf/8kUVHe0bnZ3weoEqM=;
 b=zxq6CbGgoI4dFo1dpL59baWVgBa/oJqgKkJH7ObTXD8er4EKlL1u9XQNhJuMYUQ5TDhSGe
 CJ5AvopV5pDOZ6B4NIAnIxY59CtbCY0xkBjy2+8tGYn4qcT0y/ojYwn5kP0+GNhXoNSXQW
 dz1zD7xG2Jx/t3Bd/8lOHQFEWISHFyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678892739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fRb+TLInTlszU6maeL6LVPcAf/8kUVHe0bnZ3weoEqM=;
 b=m7BkIUU4i7cWxNEICxWZs70lUaZ/QmD0tgo+nnE206TQIXIj4oXULSOzIPwdsSF6cPVn1g
 6eZD3OIjCVohKqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F4BC13A00;
 Wed, 15 Mar 2023 15:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rdy2EcPeEWTaXQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 Mar 2023 15:05:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 Mar 2023 16:03:30 +0100
Message-Id: <20230315150330.2964-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add epoll_wait05 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait05.c | 117 ++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c

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
index 000000000..e43cac933
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -0,0 +1,117 @@
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
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int epfd;
+static in_port_t *sock_port;
+
+static void create_server(void)
+{
+	int sockfd;
+	socklen_t len;
+	struct sockaddr_in serv_addr;
+	struct sockaddr_in sin;
+
+	memset(&serv_addr, 0, sizeof(struct sockaddr_in));
+	serv_addr.sin_family = AF_INET;
+	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	serv_addr.sin_port = 0;
+
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
+	SAFE_LISTEN(sockfd, 10);
+
+	len = sizeof(sin);
+	memset(&sin, 0, sizeof(struct sockaddr_in));
+	SAFE_GETSOCKNAME(sockfd, (struct sockaddr *)&sin, &len);
+
+	*sock_port = sin.sin_port;
+
+	tst_res(TINFO, "Listening on port %d", *sock_port);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_CLOSE(sockfd);
+}
+
+static void run(void)
+{
+	int sockfd;
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
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+
+	memset(&client_addr, 0, sizeof(struct sockaddr));
+	client_addr.sin_family = AF_INET;
+	client_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	client_addr.sin_port = *sock_port;
+
+	SAFE_CONNECT(sockfd, (struct sockaddr *)&client_addr, sizeof(client_addr));
+
+	tst_res(TINFO, "Polling on socket");
+
+	epfd = SAFE_EPOLL_CREATE1(0);
+	evt_req.events = EPOLLRDHUP;
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
+
+	tst_res(TINFO, "Hang socket");
+
+	TST_EXP_PASS_SILENT(shutdown(sockfd, SHUT_RD));
+	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
+
+	if (evt_rec.events & EPOLLRDHUP)
+		tst_res(TPASS, "Received EPOLLRDHUP");
+	else
+		tst_res(TFAIL, "EPOLLRDHUP has not been received");
+
+	SAFE_CLOSE(epfd);
+	SAFE_CLOSE(sockfd);
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
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
