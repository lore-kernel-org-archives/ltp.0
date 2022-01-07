Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F239C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 11:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49933C9046
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 12:00:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 286063C12CF
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BFBBD10009EE
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 543C6212B8;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641553158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wR0ZJUEkIRQ8g4iB86eHFLKJOi7cQQGK+O4tm8hA1fI=;
 b=KsVngQu1sXXAGWtc2+sJNNEmAOGLgGTQr0tViubY/jpMnNGA9SkurtQfKgAjVuwQNtKhuS
 M13jOcJK9uwlSuhmPuXYpmG5NpgsWthiBO/AxC2o4RNHkDyhWqhM5iXITqhsxyWYezSEsg
 FQCJ41KL1i3M5+6C7CtcAMHnO8tdOzg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C91813CCC;
 Fri,  7 Jan 2022 10:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SHbeCAYd2GExFwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 07 Jan 2022 10:59:18 +0000
To: ltp@lists.linux.it
Date: Fri,  7 Jan 2022 11:59:11 +0100
Message-Id: <20220107105913.29036-9-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107105913.29036-1-andrea.cervesato@suse.com>
References: <20220107105913.29036-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/10] Add wqueue07 test
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

This test is testing NOTIFY_KEY_SETATTR event

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/watchqueue                     |  1 +
 testcases/kernel/watchqueue/.gitignore |  3 +-
 testcases/kernel/watchqueue/wqueue07.c | 41 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/watchqueue/wqueue07.c

diff --git a/runtest/watchqueue b/runtest/watchqueue
index de086b6a7..bdb461018 100644
--- a/runtest/watchqueue
+++ b/runtest/watchqueue
@@ -4,3 +4,4 @@ wqueue03 wqueue03
 wqueue04 wqueue04
 wqueue05 wqueue05
 wqueue06 wqueue06
+wqueue07 wqueue07
diff --git a/testcases/kernel/watchqueue/.gitignore b/testcases/kernel/watchqueue/.gitignore
index c3253f684..0d64c110c 100644
--- a/testcases/kernel/watchqueue/.gitignore
+++ b/testcases/kernel/watchqueue/.gitignore
@@ -3,4 +3,5 @@ wqueue02
 wqueue03
 wqueue04
 wqueue05
-wqueue06
\ No newline at end of file
+wqueue06
+wqueue07
\ No newline at end of file
diff --git a/testcases/kernel/watchqueue/wqueue07.c b/testcases/kernel/watchqueue/wqueue07.c
new file mode 100644
index 000000000..03912baf4
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue07.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if keyctl setperm is correctly recognized by watch queue.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static void saw_key_setattr(struct watch_notification *n, size_t len, unsigned int wtype)
+{
+	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_SETATTR))
+		tst_res(TPASS, "keyctl setattr has been recognized");
+	else
+		tst_res(TFAIL, "keyctl setattr has not been recognized");
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
+	keyctl(KEYCTL_SETPERM, key, KEY_POS_ALL | KEY_USR_ALL);
+	wqueue_consumer(fd, saw_key_setattr);
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
