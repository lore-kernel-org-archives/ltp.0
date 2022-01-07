Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCDBC433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 11:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 730263C8F4A
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 12:01:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5116A3C7B52
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D24E910009F4
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8704F1F39C;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641553158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IiSZeNg3MVy7GleDF8WklqhXh5nTaFWmiJ1JuIfhlek=;
 b=lxRnkqmrRNDTa/Y468haoBVrla4o78bg+OdsjWOxpgzP65Q9+yAOjZaoTqjYgqQ6u6BQYO
 b1wodXZiMULr/FsRrsD7XzsMQPPemaMEKb55l4F71s0vS5HbfRUqJX8IxoQrSilRto5h1L
 X++j2z+okzF4ctUqflbYqXRySzBVQeA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 608C213CCC;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6PF+FQYd2GExFwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 07 Jan 2022 10:59:18 +0000
To: ltp@lists.linux.it
Date: Fri,  7 Jan 2022 11:59:12 +0100
Message-Id: <20220107105913.29036-10-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107105913.29036-1-andrea.cervesato@suse.com>
References: <20220107105913.29036-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/10] Add wqueue08 test
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

This test is testing WATCH_META_REMOVAL_NOTIFICATION event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/watchqueue                     |  1 +
 testcases/kernel/watchqueue/.gitignore |  3 +-
 testcases/kernel/watchqueue/wqueue08.c | 45 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/watchqueue/wqueue08.c

diff --git a/runtest/watchqueue b/runtest/watchqueue
index bdb461018..badf7afb0 100644
--- a/runtest/watchqueue
+++ b/runtest/watchqueue
@@ -5,3 +5,4 @@ wqueue04 wqueue04
 wqueue05 wqueue05
 wqueue06 wqueue06
 wqueue07 wqueue07
+wqueue08 wqueue08
diff --git a/testcases/kernel/watchqueue/.gitignore b/testcases/kernel/watchqueue/.gitignore
index 0d64c110c..56ede9fc5 100644
--- a/testcases/kernel/watchqueue/.gitignore
+++ b/testcases/kernel/watchqueue/.gitignore
@@ -4,4 +4,5 @@ wqueue03
 wqueue04
 wqueue05
 wqueue06
-wqueue07
\ No newline at end of file
+wqueue07
+wqueue08
\ No newline at end of file
diff --git a/testcases/kernel/watchqueue/wqueue08.c b/testcases/kernel/watchqueue/wqueue08.c
new file mode 100644
index 000000000..3e286e2ab
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue08.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if key watch removal is correctly recognized by watch queue.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static void saw_watch_removal(struct watch_notification *n, LTP_ATTRIBUTE_UNUSED size_t len, unsigned int wtype)
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
+static void run(void)
+{
+	int fd;
+	key_serial_t key;
+
+	fd = wqueue_watch(256, &wqueue_filter);
+	key = wqueue_add_key(fd);
+
+	/* if watch_id = -1 key is removed from the watch queue */
+	keyctl(KEYCTL_WATCH_KEY, key, fd, -1);
+	wqueue_consumer(fd, saw_watch_removal);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
