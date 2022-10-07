Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C97AC433FE
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 08:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281AD3CAE2D
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 10:35:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83233C4C32
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 10:35:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A698C6019A1
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 10:35:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF8DD21902;
 Fri,  7 Oct 2022 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665131719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GPwTX883rc2as2C9THnhz/kB0oRpo+5f7mfh7gvzHd0=;
 b=eISQSlEvqNaqwmUda+fsMLioS3qvvsyNMf5O92F7YQofU+FgZ7lS2CRqS8oT8YEP0ndtQK
 4BNg9KvmBDe/Wzln4K3CZgRyLwq9pEPBZxjKHzrJWrU3H+otkpqxMor1xJji7iWgYHURUm
 VbzSaRoE1i+Zzlu4sJU0ND5OiZse24Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9985B13A3D;
 Fri,  7 Oct 2022 08:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4MBvI8fkP2NJeQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 07 Oct 2022 08:35:19 +0000
To: ltp@lists.linux.it
Date: Fri,  7 Oct 2022 10:34:06 +0200
Message-Id: <20221007083406.16036-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add epoll_create1_03 test
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

The test verifies epoll_create1 will raises EMFILE when
/proc/sys/fs/epoll/max_user_watches is reached.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../syscalls/epoll_create1/epoll_create1_03.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c

diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
new file mode 100644
index 000000000..7f51edf7a
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_create1 returns -1 and set errno to EMFILE when maximum
+ * number of epoll watchers is reached.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	int i, max_inst;
+
+	SAFE_FILE_LINES_SCANF("/proc/sys/fs/epoll/max_user_watches", "%d", &max_inst);
+
+	for (i = 0; i < max_inst; i++)
+		TST_EXP_PASS_SILENT(epoll_create1(0) == 0);
+
+	TST_EXP_FAIL(epoll_create1(0), EMFILE);
+}
+
+static struct tst_test test = {
+	.min_kver = "2.6.27",
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
