Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEB3C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 21:23:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3133C92A3
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 22:23:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31FF33C8850
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 22:21:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA8466005DB
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 22:21:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ED38212BE;
 Fri,  7 Jan 2022 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641590481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8dbMHZqI08WJBAgemzVhkLhZ3EWRPCFMhmTDwRu2Bc=;
 b=UAq0FKgapB07PToMUMbcNAyhMsxefHOu+HE38l8xP21ppIkXhCPwSx9T6rkjuvOMkaWyMP
 7/opQ1XxtEJVuSe5J43OGhM7+qOPu24oNrV7dR1ps7j87WUJA1bGI8WlQjTAPUn47vucpq
 13+AX2KQc7o8SGwkr3Dl/bZ+u3ZaA4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641590481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8dbMHZqI08WJBAgemzVhkLhZ3EWRPCFMhmTDwRu2Bc=;
 b=DDw3Abmudvf5ka4Pk0BO3/5v4gDj0c8KfwzP2SwNFranUQlGmtNonn16LEHfxqKfKpjCVP
 HEIZ9kFER+w2+TDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4790B13D44;
 Fri,  7 Jan 2022 21:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ADhtD9Gu2GEHFwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Jan 2022 21:21:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  7 Jan 2022 22:20:58 +0100
Message-Id: <20220107212058.19768-12-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107212058.19768-1-andrea.cervesato@suse.de>
References: <20220107212058.19768-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 11/11] Add wqueue09 test
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

This test is testing WATCH_META_LOSS_NOTIFICATION event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/watchqueue/wqueue09.c | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 testcases/kernel/watchqueue/wqueue09.c

diff --git a/testcases/kernel/watchqueue/wqueue09.c b/testcases/kernel/watchqueue/wqueue09.c
new file mode 100644
index 000000000..ac49bb8a0
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue09.c
@@ -0,0 +1,52 @@
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
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
