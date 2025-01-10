Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E78EE7719D
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:57:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13CC83C30D5
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:57:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 782A03C308A
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:45 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA7EE622FDD
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD8492117E
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dL+v/UOG8YVTqXq6rGqB0pl9X0QSU9+modWAasTy0c=;
 b=ey5apLydiAKAFPxJOUtI5J2e8mvJS1zI8iQk/EmvpBoG1jn4+cbPaZc+QVLM1fsdAyXc6V
 Eq3AdKpA9sLwuHWVP4YQbtsziclks3SAWzZbTD11eV+/X0gcu2n+b+Veclg5xSugHsGuO4
 C/Q9cYiv5a1qLjIJHe7XIuX8GVK0Bi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dL+v/UOG8YVTqXq6rGqB0pl9X0QSU9+modWAasTy0c=;
 b=AKdD/yl51xV3YPUPY5oS4AzT+gppflWXafWh7MUxsdsMIv+C5+beQ1k8i12xFrekq6yqrL
 zKKZy9UCPqm+WKDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ey5apLyd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AKdD/yl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dL+v/UOG8YVTqXq6rGqB0pl9X0QSU9+modWAasTy0c=;
 b=ey5apLydiAKAFPxJOUtI5J2e8mvJS1zI8iQk/EmvpBoG1jn4+cbPaZc+QVLM1fsdAyXc6V
 Eq3AdKpA9sLwuHWVP4YQbtsziclks3SAWzZbTD11eV+/X0gcu2n+b+Veclg5xSugHsGuO4
 C/Q9cYiv5a1qLjIJHe7XIuX8GVK0Bi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dL+v/UOG8YVTqXq6rGqB0pl9X0QSU9+modWAasTy0c=;
 b=AKdD/yl51xV3YPUPY5oS4AzT+gppflWXafWh7MUxsdsMIv+C5+beQ1k8i12xFrekq6yqrL
 zKKZy9UCPqm+WKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9780113AA7
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8BMzI88YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:43 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-4-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=3207;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=PJR2GLLKDOwjlq61CzLz7KNh4EbInfHm4bUICBPPUlw=;
 b=WTrawES8Q8kWcvk1o0Jg/r7rs/EvBezfyfJx2OIotoUZM1oDskzNRLetRKYFe41wdaRmob4jj
 qUTW6Z5mjnBA//OSRlUhthJ8eec7R0xYLA9JRyxmO0iKDHLMs7G5S5L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: AD8492117E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/7] Add lsm_get_self_attr03 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that LSM_ATTR_CURRENT attribute is correctly recognizing
the current, active security context of the process. This is done by
checking that /proc/self/attr/current matches with the obtained value.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      | 70 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 63855dd786a62fe017882549c5edcc715d9e7e18..56eb6449c11102f0148215f8a1efbea51fad6a27 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -758,6 +758,7 @@ lseek11 lseek11
 
 lsm_get_self_attr01 lsm_get_self_attr01
 lsm_get_self_attr02 lsm_get_self_attr02
+lsm_get_self_attr03 lsm_get_self_attr03
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 9f7c9b00b026a377f1b36f483ac2c1a0adba6249..19956fdf8b9952b4850c3a20826e29ec67ea3560 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1,2 +1,3 @@
 lsm_get_self_attr01
 lsm_get_self_attr02
+lsm_get_self_attr03
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
new file mode 100644
index 0000000000000000000000000000000000000000..b432006650bff697eb60eb7ad6fdd62dbe0eb984
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that LSM_ATTR_CURRENT attribute is correctly recognizing
+ * the current, active security context of the process. This is done by
+ * checking that /proc/self/attr/current matches with the obtained value.
+ */
+
+#include "lsm_common.h"
+
+static struct lsm_ctx *ctx;
+static uint32_t page_size;
+
+static void run(void)
+{
+	tst_res(TINFO, "Verifying 'LSM_ATTR_CURRENT' attribute");
+
+	uint32_t count;
+	uint32_t size = page_size;
+	char attr[size];
+
+	memset(attr, 0, size);
+	memset(ctx, 0, sizeof(struct lsm_ctx));
+
+	count = TST_EXP_POSITIVE(
+		lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
+
+	if (TST_RET == -1)
+		return;
+
+	if (!count) {
+		tst_res(TFAIL, "Can't read any attribute");
+		return;
+	}
+
+	read_proc_attr("current", attr, page_size);
+
+	TST_EXP_EQ_STR(attr, (char *)ctx->ctx);
+
+	struct lsm_ctx *next = ctx;
+
+	for (uint32_t i = 1; i < count; i++) {
+		TST_EXP_EXPR(strcmp(attr, (char *)next->ctx) != 0,
+			"Attribute and next LSM context must be different");
+
+		next = next_ctx(next);
+	}
+}
+
+static void setup(void)
+{
+	verify_supported_attr_current();
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers[]) {
+		{&ctx, .size = sizeof(struct lsm_ctx)},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
