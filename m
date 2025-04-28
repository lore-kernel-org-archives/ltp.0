Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A38C369D5
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 14:44:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C19E3CBBB8
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 16:44:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40E23C071B
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D75581000B73
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 047211F390;
 Mon, 28 Apr 2025 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=S9Lm/eqxs2rvYorqmjE0INRJBVjK3esE9EdwXdWuiELKPsnZTAEtSKHwEMzkruQ0pke4dy
 XbsNwvPXRNbdvA94trR2Oqh9Wji4HuqClpy+ng95zZZbsaEtbg5HhHO2BReZ1PTH/8xZgq
 8zzk0VpVr8CljUfL0cCyqLF4yeqZ62U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=pejb3gxACnoiINx9AHe5L2CTETde8qbb56zRHqAOrgIiV4+if+CM+ZIQdinwzIGUkTSDLJ
 bFscB5+b0CeeXpAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=S9Lm/eqxs2rvYorqmjE0INRJBVjK3esE9EdwXdWuiELKPsnZTAEtSKHwEMzkruQ0pke4dy
 XbsNwvPXRNbdvA94trR2Oqh9Wji4HuqClpy+ng95zZZbsaEtbg5HhHO2BReZ1PTH/8xZgq
 8zzk0VpVr8CljUfL0cCyqLF4yeqZ62U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=pejb3gxACnoiINx9AHe5L2CTETde8qbb56zRHqAOrgIiV4+if+CM+ZIQdinwzIGUkTSDLJ
 bFscB5+b0CeeXpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D308013AB9;
 Mon, 28 Apr 2025 14:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oPohLzOUD2ioegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Apr 2025 14:44:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 28 Apr 2025 16:43:59 +0200
MIME-Version: 1.0
Message-Id: <20250428-lsm-v3-4-33a4caa9aaf2@suse.com>
References: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
In-Reply-To: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745851441; l=3179;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IlQsR38Iaz+C7E63V1bPIKJQ+FxvHPAOT76xJdJHZN0=;
 b=bsqG5eYj7zt+vxoEebAjUKXWbzP3AHUs4GpLyxA3pcGyl1P/DAwz+S1F0tkdip9MQUTfZ17K9
 5RzYFE/B4fYCxl0RFDMg3+u4t2QSum4d2S+ejCQTjv14ML9lRG9jJdO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] Add lsm_get_self_attr03 test
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
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      | 68 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 73b6b98c7748f5ed31ad23d7464f1ab4fbc5f42e..d45cda4082ed87bf674ca34d315af9c162a41fe9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -761,6 +761,7 @@ lseek11 lseek11
 
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
index 0000000000000000000000000000000000000000..3b767b94c025e350b9cc83d9bf2dc3061b3c6a1c
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
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
+	memset(ctx, 0, LSM_CTX_SIZE_DEFAULT);
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
+		{&ctx, .size = LSM_CTX_SIZE_DEFAULT},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
