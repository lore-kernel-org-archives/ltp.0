Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9E1C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 11:01:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42D9E3C8E78
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 12:01:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B66A3C7B52
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D95C600944
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B93942113B;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641553158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwdhJWxT4+6vYFwrio4Vx0ncUB2/dsceIsvDIi3tXMk=;
 b=o5RAYgH1Rj1il8b1RtaK7J0mBKW9rY5trRJ4g13Ls3B2TPo8jOXh8tJ3uzQ4gcfPO+W83q
 97ct6hOrPmJ7HSD8T0pBHfQ/HEGbIdNyrj3kzFQfXZkUKphP2h/Lv+qDQ+G7E2tWA21iyZ
 FV4IIPXSh7T5cdEQ2zOxXEtN+DI5mTM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 934D213CCC;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4FXpIQYd2GExFwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 07 Jan 2022 10:59:18 +0000
To: ltp@lists.linux.it
Date: Fri,  7 Jan 2022 11:59:13 +0100
Message-Id: <20220107105913.29036-11-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107105913.29036-1-andrea.cervesato@suse.com>
References: <20220107105913.29036-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/10] Add wqueue09 test
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

This test is testing WATCH_META_LOSS_NOTIFICATION event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/watchqueue                     |  1 +
 testcases/kernel/watchqueue/.gitignore |  3 +-
 testcases/kernel/watchqueue/wqueue09.c | 53 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/watchqueue/wqueue09.c

diff --git a/runtest/watchqueue b/runtest/watchqueue
index badf7afb0..bd6b0a423 100644
--- a/runtest/watchqueue
+++ b/runtest/watchqueue
@@ -6,3 +6,4 @@ wqueue05 wqueue05
 wqueue06 wqueue06
 wqueue07 wqueue07
 wqueue08 wqueue08
+wqueue09 wqueue09
diff --git a/testcases/kernel/watchqueue/.gitignore b/testcases/kernel/watchqueue/.gitignore
index 56ede9fc5..9ea33b701 100644
--- a/testcases/kernel/watchqueue/.gitignore
+++ b/testcases/kernel/watchqueue/.gitignore
@@ -5,4 +5,5 @@ wqueue04
 wqueue05
 wqueue06
 wqueue07
-wqueue08
\ No newline at end of file
+wqueue08
+wqueue09
\ No newline at end of file
diff --git a/testcases/kernel/watchqueue/wqueue09.c b/testcases/kernel/watchqueue/wqueue09.c
new file mode 100644
index 000000000..2d287ba1c
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue09.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Fill the watch queue and wait for a notification loss.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static int data_lost;
+
+static void saw_data_loss(struct watch_notification *n, LTP_ATTRIBUTE_UNUSED size_t len, unsigned int wtype)
+{
+	if (wtype != WATCH_TYPE_META)
+		return;
+
+	if (n->subtype == WATCH_META_LOSS_NOTIFICATION)
+		data_lost = 1;
+}
+
+static void run(void)
+{
+	int fd;
+	key_serial_t key;
+
+	fd = wqueue_watch(1, &wqueue_filter);
+
+	key = wqueue_add_key(fd);
+	keyctl(KEYCTL_UPDATE, key, "b", 1);
+	keyctl(KEYCTL_REVOKE, key);
+
+	data_lost = 0;
+	while (!data_lost)
+		wqueue_consumer(fd, saw_data_loss);
+
+	SAFE_CLOSE(fd);
+
+	if (data_lost)
+		tst_res(TPASS, "Meta loss notification received");
+	else
+		tst_res(TFAIL, "Event not recognized");
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
