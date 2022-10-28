Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8121AECAAA1
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 08:59:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BB2E3CA942
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 10:59:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABF53CA863
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 10:59:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E29AB1A0114E
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 10:58:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D3A0218E2;
 Fri, 28 Oct 2022 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1666947539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2Fy1JnUeq7x47ttalK9KTXrGC0Up6qazNDzJrNSMrNo=;
 b=BduTYRiLhuBa7kLAbZzM3N7/1rm20F6LzGCT6zvlHSTxxcvpsL9VAS7vMLehIlWI96qPgT
 2dRmC/zWJ6jT2k3+2PENyNzfAMQB7VkffOw0034QCHfoPc7/98HlobAdoHX4rS+Jjjr1I7
 NaeMclLOr6klkOjI5ing0FXlnvwqqnw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6FD613A6E;
 Fri, 28 Oct 2022 08:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qurjKtKZW2OKDAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 28 Oct 2022 08:58:58 +0000
To: ltp@lists.linux.it
Date: Fri, 28 Oct 2022 10:57:35 +0200
Message-Id: <20221028085735.32615-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add epoll_wait05 test
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

This test verifies that epoll receives EPOLLHUP/EPOLLRDHUP event
when we hang a reading half-socket we are polling on.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Make use of SAFE_EPOLL_* macros

 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait05.c | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
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
index 000000000..2ed0b2ab1
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll receives EPOLLHUP/EPOLLRDHUP event when we hang a reading
+ * half-socket we are polling on.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+static int sockfd;
+static int epfd;
+
+static void cleanup(void)
+{
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
+
+	if (sockfd > 0)
+		SAFE_CLOSE(sockfd);
+}
+
+static void run(void)
+{
+	int ret;
+	struct epoll_event evt_req;
+	struct epoll_event evt_rec;
+
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	epfd = SAFE_EPOLL_CREATE1(0);
+
+	tst_res(TINFO, "Polling on socket");
+
+	evt_req.events = EPOLLRDHUP;
+	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
+
+	tst_res(TINFO, "Hang reading half-socket");
+
+	ret = shutdown(sockfd, SHUT_RD);
+	if (ret == -1 && errno != ENOTCONN) {
+		tst_brk(TBROK | TERRNO, "shutdown error");
+		goto close;
+	}
+
+	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
+
+	if (evt_rec.events & EPOLLHUP)
+		tst_res(TPASS, "Received EPOLLHUP");
+	else
+		tst_res(TFAIL, "EPOLLHUP has not been received");
+
+	if (evt_rec.events & EPOLLRDHUP)
+		tst_res(TPASS, "Received EPOLLRDHUP");
+	else
+		tst_res(TFAIL, "EPOLLRDHUP has not been received");
+
+close:
+	SAFE_CLOSE(epfd);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
