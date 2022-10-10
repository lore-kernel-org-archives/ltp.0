Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8FDC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 10:20:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E79A3CAE90
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:20:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CDF93C0FBC
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:20:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66B80200388
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:20:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB5671F8C7;
 Mon, 10 Oct 2022 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665397211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u7JE6pbsRFpH8fsRIT60SSBEyxl1yTBflWkNI+U89+E=;
 b=VdobJ8BNm/YCqu6fhwMekBx64tZueUWdPBF8QFEH5qA4OiSz8nUS97me6X8NusexCoOJ8W
 pqzhueDi7UCH3nFNFnMbj2YWX6YjhAZgRHt3TvHGXrnb54C5UWD/Gx47mty8RJ1JmiEGEf
 wscQ0P1I+BwLIXOAWq1v/rRqH1rHP4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8153C13ACA;
 Mon, 10 Oct 2022 10:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dZtcHdvxQ2MNJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 10 Oct 2022 10:20:11 +0000
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 12:18:57 +0200
Message-Id: <20221010101857.14585-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add epoll_wait05 test
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
 .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait05.c | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
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
index 000000000..7909a6586
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -0,0 +1,74 @@
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
+	int res;
+	struct epoll_event evt_req;
+	struct epoll_event evt_rec;
+
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+
+	epfd = epoll_create1(0);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	tst_res(TINFO, "Polling on socket");
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
