Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4059AC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 08:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8CA3C8DDE
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 09:19:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64EB43C9046
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BED67600120
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 598CA1F386;
 Tue,  4 Jan 2022 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641284323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oxy8o1JBAHgNcCUSdwmMQ2bxnPOv69Gbwestox36mBw=;
 b=fos4UCLJjhiUQVW+LIDPqA5lyekxyE7PfN1jdbjCdnp9mwuKUHQ9YAYCUjywqJrPipNPCs
 FwjgOUHZWIPg4Fmaii9MiJQTce10aNWEKKojHeiJ5sscRZq6WF+yz9SzQi5OEd3jV8lBJ8
 7F9od0Nshkqjc2pqwudCkIITyx5awvc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03ACC13AB9;
 Tue,  4 Jan 2022 08:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sBBXOOIC1GGeZwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 04 Jan 2022 08:18:42 +0000
To: ltp@lists.linux.it
Date: Tue,  4 Jan 2022 09:18:30 +0100
Message-Id: <20220104081836.22827-5-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104081836.22827-1-andrea.cervesato@suse.com>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 04/10] Add wqueue03 new test
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

This test checks if KEYCTL_REVOKE event is recognized by watch queue

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/watchqueue/wqueue03.c | 68 ++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 testcases/kernel/watchqueue/wqueue03.c

diff --git a/testcases/kernel/watchqueue/wqueue03.c b/testcases/kernel/watchqueue/wqueue03.c
new file mode 100644
index 000000000..a4bbdadcd
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue03.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if keyctl revoke is correctly recognized by watch queue.
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
+static void saw_key_revoked(struct watch_notification *n, size_t len, unsigned int wtype)
+{
+	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_REVOKED))
+		tst_res(TPASS, "keyctl revoke has been recognized");
+	else
+		tst_res(TFAIL, "keyctl revoke has not been recognized");
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
+	fd = wqueue_watch(256, &wqueue_key_filter);
+	key = wqueue_add_key(fd);
+
+	*keep_polling = 1;
+
+	pid = SAFE_FORK();
+	if (pid > 0) {
+		wqueue_consumer(fd, keep_polling, saw_key_revoked);
+		return;
+	}
+
+	safe_keyctl(KEYCTL_REVOKE, key);
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
