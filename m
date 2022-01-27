Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BDC433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E7D63C9731
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:26:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19BAE3C970E
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B0D4F6002B3
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60420210FB;
 Thu, 27 Jan 2022 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+A8DzCEv4GyDWujBVc9PA23G8+DjdTnONaI+1mcOgDk=;
 b=ZPVJxcB3CQkbA6NmxO8VRlGkAsIk6dXpRp4fkPky820LgKG4CB97FhQqRrJMiRwi7lmYkF
 sgMo0q8XiN5OeMjaAuZ+uP525kcuRQqOaw/XN6bhGxIq4GQaAfYT5KFhc5mk3OOhmjxylf
 A0Tql0pGquE8ArKl5NncfOlsUKCkb3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+A8DzCEv4GyDWujBVc9PA23G8+DjdTnONaI+1mcOgDk=;
 b=MHkUHavOGU+wmUxkeIfY1FRFcirAQMvPvquUZ8EOweTrfc5CDD9LgMR8QgO1Jq67vBOfch
 720xJ+b1DAulnpDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A43F13CFB;
 Thu, 27 Jan 2022 09:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YH5HDNNk8mHLHwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Jan 2022 09:24:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 10:24:28 +0100
Message-Id: <20220127092431.25996-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127092431.25996-1-andrea.cervesato@suse.de>
References: <20220127092431.25996-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 08/11] Add wqueue06 test
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

This test is testing NOTIFY_KEY_INVALIDATED event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/watchqueue                     |  1 +
 testcases/kernel/watchqueue/.gitignore |  1 +
 testcases/kernel/watchqueue/wqueue06.c | 42 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 testcases/kernel/watchqueue/wqueue06.c

diff --git a/runtest/watchqueue b/runtest/watchqueue
index 596d45154..de086b6a7 100644
--- a/runtest/watchqueue
+++ b/runtest/watchqueue
@@ -3,3 +3,4 @@ wqueue02 wqueue02
 wqueue03 wqueue03
 wqueue04 wqueue04
 wqueue05 wqueue05
+wqueue06 wqueue06
diff --git a/testcases/kernel/watchqueue/.gitignore b/testcases/kernel/watchqueue/.gitignore
index 9f4ac81e7..e167b500d 100644
--- a/testcases/kernel/watchqueue/.gitignore
+++ b/testcases/kernel/watchqueue/.gitignore
@@ -3,3 +3,4 @@ wqueue02
 wqueue03
 wqueue04
 wqueue05
+wqueue06
diff --git a/testcases/kernel/watchqueue/wqueue06.c b/testcases/kernel/watchqueue/wqueue06.c
new file mode 100644
index 000000000..d7806998e
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue06.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if keyctl clear is correctly recognized by watch queue.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static void saw_key_cleared(struct watch_notification *n, size_t len,
+							unsigned int wtype)
+{
+	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_CLEARED))
+		tst_res(TPASS, "keyctl clear has been recognized");
+	else
+		tst_res(TFAIL, "keyctl clear has not been recognized");
+}
+
+static void run(void)
+{
+	int fd;
+
+	fd = wqueue_watch(256, &wqueue_filter);
+	wqueue_add_key(fd);
+
+	keyctl(KEYCTL_CLEAR, KEY_SPEC_SESSION_KEYRING);
+	wqueue_consumer(fd, saw_key_cleared);
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
