Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63195C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E06813C9732
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:26:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2FC23C971E
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2BD7C200AE3
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4FFA210FD;
 Thu, 27 Jan 2022 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYBrxf8ww+r6yZtlJCVE/KemY8Rdgh/9izBbGe+ULU=;
 b=O1qr76gURzsPqdjxa48lpGoHECWEYUHeE18Epc5v8tvJp6LUgoixgyYoxtO8oK3ae7BZtJ
 1EK49CMshqAoqUlwA+0B/JOdteDO1VGV8Oh0kCwcWX7nU7Wzw5TyzQ2HriyMe/tcl+XNjj
 0t5Y2okBsC+/QML9Ocy3ud+1DF7yxVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYBrxf8ww+r6yZtlJCVE/KemY8Rdgh/9izBbGe+ULU=;
 b=/xH1SKhedu7nkACDsPtwTM2bMZWJfFuhYA+pqFgJCqb6ePIvdBveIT/yr5m/dVgOHarCDV
 87WtQya5NRBWN2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E11213CFB;
 Thu, 27 Jan 2022 09:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KEGaJNNk8mHLHwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Jan 2022 09:24:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 10:24:30 +0100
Message-Id: <20220127092431.25996-11-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127092431.25996-1-andrea.cervesato@suse.de>
References: <20220127092431.25996-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 10/11] Add wqueue08 test
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

This test is testing WATCH_META_REMOVAL_NOTIFICATION event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/watchqueue                     |  1 +
 testcases/kernel/watchqueue/.gitignore |  1 +
 testcases/kernel/watchqueue/wqueue08.c | 48 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
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
index 891b19775..0f998fe79 100644
--- a/testcases/kernel/watchqueue/.gitignore
+++ b/testcases/kernel/watchqueue/.gitignore
@@ -5,3 +5,4 @@ wqueue04
 wqueue05
 wqueue06
 wqueue07
+wqueue08
diff --git a/testcases/kernel/watchqueue/wqueue08.c b/testcases/kernel/watchqueue/wqueue08.c
new file mode 100644
index 000000000..4933c5e0e
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue08.c
@@ -0,0 +1,48 @@
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
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static void saw_watch_removal(struct watch_notification *n,
+							  LTP_ATTRIBUTE_UNUSED size_t len,
+							  unsigned int wtype)
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
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
