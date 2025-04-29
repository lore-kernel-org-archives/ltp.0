Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7A2C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:25:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFC83C53B4
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:25:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06D73CBBF8
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A2EF21A00143
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F34431F800;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=K4prGlN/cg35Z1HCqYQ5w3Qk0M6a7mprTtwkbpOL0vDHj+KzkZEZQYPunGD0BNQ9s02OYs
 9zm0Z1k4J+UORtcoyq+WSgvd4QVeHQoSaXZeuQvT/B26ihcJTO0XXa8FFTqKpuaXk7ucdM
 e1W1zSMVluMNW4cFwvXr9BXgm5oXRuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=AdG/COfOs2CUdYQGrJeax8Hld5OoWntJRxvLqOFwX+Z45gQ2vZ1IlxmjRaewepA41pMH0W
 X6FuaahbNVD/0SBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="K4prGlN/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AdG/COfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=K4prGlN/cg35Z1HCqYQ5w3Qk0M6a7mprTtwkbpOL0vDHj+KzkZEZQYPunGD0BNQ9s02OYs
 9zm0Z1k4J+UORtcoyq+WSgvd4QVeHQoSaXZeuQvT/B26ihcJTO0XXa8FFTqKpuaXk7ucdM
 e1W1zSMVluMNW4cFwvXr9BXgm5oXRuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVeKwBC7/0+E5lh6A8Ac0uJm1OglI9CA8rzECfKokwc=;
 b=AdG/COfOs2CUdYQGrJeax8Hld5OoWntJRxvLqOFwX+Z45gQ2vZ1IlxmjRaewepA41pMH0W
 X6FuaahbNVD/0SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F1813A8B;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eI8VM3J+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:33 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-4-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=3179;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IlQsR38Iaz+C7E63V1bPIKJQ+FxvHPAOT76xJdJHZN0=;
 b=xuPZvFaAqBswEU6lnUbjuCBxf2sAjvnVVgu/sUUe2fBWtVFbbsnThEmUGG+fbNpirRVwjH7On
 wXVcjnfonGDA16ePttBjm7dvL8hipIwkJzY4p49DkhFzyBwF5CakfTZ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: F34431F800
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/7] Add lsm_get_self_attr03 test
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
