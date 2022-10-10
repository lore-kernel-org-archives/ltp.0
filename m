Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813FEC433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 09:11:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C89C3CA9F4
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 11:10:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EBC3C28F3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:10:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6FF771400336
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:10:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5427D218EE;
 Mon, 10 Oct 2022 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665393046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HZYulLNACdiLIGJLTm7SMr+b03vfNq3JqAblDlmLkSk=;
 b=A810Cu4KyTz7GaUneVLJvg9pVTWc12moC1NAJeLb4koRnTc+e5myRzEar7t94CLiwGVQA6
 gqR8KvSViBlIBhtY+mgMSK4KcPhC3JKyNxi9zYb16h69L2RJpx67dWBX3Od3cIhXdi9TzW
 27WpFDDzmT5HEBUnZ3R9k7JjSq2Xin0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C84313479;
 Mon, 10 Oct 2022 09:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0gXwAJbhQ2MFBAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 10 Oct 2022 09:10:46 +0000
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 11:09:32 +0200
Message-Id: <20221010090932.29417-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add epoll_ctl06 test
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

The epoll_ctl06 test verifies that EPOLLRDHUP event is correctly
recognised by epoll.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/epoll_ctl/.gitignore      |  1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c

diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index 3e05f2e1f..9c555f41b 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -3,3 +3,4 @@ epoll_ctl02
 epoll_ctl03
 epoll_ctl04
 epoll_ctl05
+epoll_ctl06
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
new file mode 100644
index 000000000..bd08fd7f9
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll receives EPOLLRDHUP event when we hang a reading
+ * half-socket we are polling on.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+#include "tst_test.h"
+
+static int sockfd;
+static int epfd;
+
+static void setup(void)
+{
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+}
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
+	int res;
+	struct epoll_event evt_req;
+	struct epoll_event evt_rec;
+
+	epfd = epoll_create1(0);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	tst_res(TINFO, "Looking at EPOLLRDHUP events");
+
+	evt_req.events = EPOLLRDHUP;
+	res = epoll_ctl(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
+	if (res == -1)
+		tst_brk(TBROK | TERRNO, "epoll_ctl failure");
+
+	tst_res(TINFO, "Hang reading half-socket");
+	shutdown(sockfd, SHUT_RD);
+
+	res = epoll_wait(epfd, &evt_rec, 1, 2000);
+	if (res <= 0) {
+		tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
+		return;
+	}
+
+	if (evt_rec.events & evt_req.events)
+		tst_res(TPASS, "Received EPOLLRDHUP");
+	else
+		tst_res(TFAIL, "EPOLLRDHUP has not been received");
+
+	SAFE_CLOSE(epfd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
