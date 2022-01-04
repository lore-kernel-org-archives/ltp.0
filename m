Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BFDC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 08:26:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0A6D3C9046
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 09:20:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A573C910D
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD9541A008A7
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 841BC1F398;
 Tue,  4 Jan 2022 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641284325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjjMpYIlb+Gv0Bh4vxWmd7YcXiYPDMHR25S6IA+GqIU=;
 b=b2wm4iro1EhlkQ2Y14j92KJDF0j47rG4xMqLdps/Uctz7KBl5O/GRx92U51LfhLK7ovFvf
 jZ87R5ZY/TflX2JByWVh1HLXIm5OCgfrA81LkHO/HLV+C11aL0k782TNtv5Sd/TdkelIeJ
 t4rf8312IFs8sIe7Qf/9VEZvCZEQzvU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38D4213AB9;
 Tue,  4 Jan 2022 08:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8IL7CeUC1GGeZwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 04 Jan 2022 08:18:45 +0000
To: ltp@lists.linux.it
Date: Tue,  4 Jan 2022 09:18:35 +0100
Message-Id: <20220104081836.22827-10-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104081836.22827-1-andrea.cervesato@suse.com>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 09/10] Add wqueue08 new test
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

This test checks if KEYCTL_WATCH_KEY event is recognized by watch queue

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/watchqueue/wqueue08.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 testcases/kernel/watchqueue/wqueue08.c

diff --git a/testcases/kernel/watchqueue/wqueue08.c b/testcases/kernel/watchqueue/wqueue08.c
new file mode 100644
index 000000000..202cc0274
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue08.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if key watch removal is correctly recognized by watch queue.
+ */
+
+#define _FCNTL_H
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static int *keep_polling;
+
+static struct watch_notification_filter meta_filter = {
+	.nr_filters = 1,
+	.__reserved = 0,
+	.filters = {
+		[0] = {
+			.type = WATCH_TYPE_META,
+			.subtype_filter[0] = UINT_MAX,
+		},
+	},
+};
+
+static void saw_watch_removal(struct watch_notification *n, size_t len, unsigned int wtype)
+{
+	if (wtype != WATCH_TYPE_META)
+		return;
+
+	if (n->subtype == WATCH_META_REMOVAL_NOTIFICATION)
+		tst_res(TPASS, "Meta removal notification received");
+	else
+		tst_res(TFAIL, "Event not recognized");
+}
+
+static void setup(void)
+{
+	keep_polling = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	*keep_polling = 0;
+	SAFE_MUNMAP(keep_polling, sizeof(int));
+}
+
+static void run(void)
+{
+	int fd;
+	int pid;
+	key_serial_t key;
+
+	fd = wqueue_watch(256, &meta_filter);
+	key = wqueue_add_key(fd);
+
+	*keep_polling = 1;
+
+	pid = SAFE_FORK();
+	if (pid > 0) {
+		wqueue_consumer(fd, keep_polling, saw_watch_removal);
+		return;
+	}
+
+	/* if watch_id = -1 key is removed from the watch queue */
+	safe_keyctl(KEYCTL_WATCH_KEY, key, fd, -1);
+
+	*keep_polling = 0;
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
