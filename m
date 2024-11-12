Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F1D41D5F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:17:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E4663D5A31
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:17:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609963D5A02
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5D66622495
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A7511F396
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8O6YmIcAbQRNnYmFT+gFsIxtDZYASEJAFd9oIajzvI=;
 b=atDGy+EU/5f6S6d4uK7fFU2peu2a7kHKwW2DryFwKruV+cyhI3MbFScwBmRqBv4cDdErzB
 hQ8fQXTstEhNUGP4uqYn/hwyQpVicNlAHfipLtNckZnYgtVItsO1oMlIiQUNYDQ4fWLdcE
 9mL7cBhhRzMw/jiW4iraqoxkTLfjzUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8O6YmIcAbQRNnYmFT+gFsIxtDZYASEJAFd9oIajzvI=;
 b=zr6XrZ9Ro7wWDtdZZz9VEhNWG8Hw3zrTP0K8ykkaXelQjM/btW9aNVkHUjN174jHvTVzhG
 z7wWYS/9As0L/uDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8O6YmIcAbQRNnYmFT+gFsIxtDZYASEJAFd9oIajzvI=;
 b=atDGy+EU/5f6S6d4uK7fFU2peu2a7kHKwW2DryFwKruV+cyhI3MbFScwBmRqBv4cDdErzB
 hQ8fQXTstEhNUGP4uqYn/hwyQpVicNlAHfipLtNckZnYgtVItsO1oMlIiQUNYDQ4fWLdcE
 9mL7cBhhRzMw/jiW4iraqoxkTLfjzUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8O6YmIcAbQRNnYmFT+gFsIxtDZYASEJAFd9oIajzvI=;
 b=zr6XrZ9Ro7wWDtdZZz9VEhNWG8Hw3zrTP0K8ykkaXelQjM/btW9aNVkHUjN174jHvTVzhG
 z7wWYS/9As0L/uDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18FD013721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0G97NZoAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:35 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-4-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=3461;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=TXdYmAXCUMSYBJh8fo7PCCKdCrmOnhgakPKUM115vrk=;
 b=7klj0E31EtVdj19HDw6kMGEfbJQrUoorye7HYCU4WlDq8s6hOWJohapZnKw/2OjM5EO3TiYIP
 ViQT3DGbSmfCSAsC6H+zbcHS6wU45HmQmcDF6Z2kKFQyzTWFL+YULEX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/7] Add lsm_get_self_attr03 test
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
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      | 82 ++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b3350af4db6d00cf86f621b5efee5d603af920f0..e6cff7763649d8b5c7eb9945473052c63b7a48aa 100644
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
index 0000000000000000000000000000000000000000..8d20289569d074648f4432aad2b0bcf1356bf2c3
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
@@ -0,0 +1,82 @@
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
+	uint32_t lsm_count = 0;
+
+	if (verify_enabled_lsm("selinux"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("apparmor"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("smack"))
+		lsm_count++;
+
+	if (!lsm_count)
+		tst_brk(TCONF, "LSM_ATTR_CURRENT is not supported by any LSM");
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
