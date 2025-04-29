Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6179DC369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 698843CBBEF
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:26:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ED713CBC06
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAF8410005E9
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D9381F808;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCe0ZEfqdWBnRsaW2f/Spd423KiCb7JzutEfhUwaqhI=;
 b=JinFmiAKp22JwrPIu/JuTtS9NZguuEeTMySdr7pRBvAov1wlaKv4WTTU/YsPx2YyWGvgAy
 R92ziEHrhGxfnZW5mUIFqq5TP79Uu/yZCn87+DUU0IdOJnsy3WlB51EeZ4JcINC8rHmxSX
 3E8YPHjIzlk8w0ju7MsLgsb0U0CtNng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCe0ZEfqdWBnRsaW2f/Spd423KiCb7JzutEfhUwaqhI=;
 b=BRmWsR9/xl07JrS4RS2QRlNkLELSQ/Fbawgad/+pGCvCv26kQj64Z9reCNs85qDCM3N6Rc
 dW6NEGtbq6XL71Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JinFmiAK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BRmWsR9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCe0ZEfqdWBnRsaW2f/Spd423KiCb7JzutEfhUwaqhI=;
 b=JinFmiAKp22JwrPIu/JuTtS9NZguuEeTMySdr7pRBvAov1wlaKv4WTTU/YsPx2YyWGvgAy
 R92ziEHrhGxfnZW5mUIFqq5TP79Uu/yZCn87+DUU0IdOJnsy3WlB51EeZ4JcINC8rHmxSX
 3E8YPHjIzlk8w0ju7MsLgsb0U0CtNng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCe0ZEfqdWBnRsaW2f/Spd423KiCb7JzutEfhUwaqhI=;
 b=BRmWsR9/xl07JrS4RS2QRlNkLELSQ/Fbawgad/+pGCvCv26kQj64Z9reCNs85qDCM3N6Rc
 dW6NEGtbq6XL71Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 547741340C;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KLPzEnN+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:36 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-7-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=4052;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=FkYoUEqGGh3HOmfEuzKwze64odw7DA8++rg+rp4anOU=;
 b=kJSSjedsrkRDJ8XhBzu1uenpqnCzznOhVCmyRlaE/D2AWgfwFG/+cwx046fHlUE+SHzqYGwPd
 tMz3oDV2mEYBmWFBqGtYFfKjRqHtP9UNunnpPyKie6MfyNqSZHy3MXI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 6D9381F808
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
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

Verify that lsm_set_self_attr syscall is raising errors when invalid
data is provided.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/lsm/.gitignore           |   1 +
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 110 +++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 91709634b70686e7e7e1e2233d8205ae99c14f19..b082a79f3e833b3e4868a34885d17fec7385f86f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -764,6 +764,7 @@ lsm_get_self_attr02 lsm_get_self_attr02
 lsm_get_self_attr03 lsm_get_self_attr03
 lsm_list_modules01 lsm_list_modules01
 lsm_list_modules02 lsm_list_modules02
+lsm_set_self_attr01 lsm_set_self_attr01
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 766f81fd1c74a10001862f142c02ba251e666ef2..467f07cec5443393d231bbb98880b7183635dd9d 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -3,3 +3,4 @@ lsm_get_self_attr02
 lsm_get_self_attr03
 lsm_list_modules01
 lsm_list_modules02
+lsm_set_self_attr01
diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
new file mode 100644
index 0000000000000000000000000000000000000000..caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_set_self_attr syscall is raising errors when invalid data is
+ * provided.
+ */
+
+#include "lsm_common.h"
+
+static struct lsm_ctx *ctx;
+static struct lsm_ctx *ctx_orig;
+static struct lsm_ctx *ctx_null;
+static uint32_t ctx_size;
+static uint32_t ctx_size_small;
+static uint32_t ctx_size_big;
+static uint32_t page_size;
+
+static struct tcase {
+	uint32_t attr;
+	struct lsm_ctx **ctx;
+	uint32_t *size;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx_null,
+		.size = &ctx_size,
+		.exp_errno = EFAULT,
+		.msg = "ctx is NULL",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size_small,
+		.exp_errno = EINVAL,
+		.msg = "size is too small",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size_big,
+		.exp_errno = E2BIG,
+		.msg = "size is too big",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size,
+		.flags = 1,
+		.exp_errno = EINVAL,
+		.msg = "flags must be zero",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
+		.ctx = &ctx,
+		.size = &ctx_size,
+		.exp_errno = EINVAL,
+		.msg = "attr is overset",
+	}
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	/* just in case lsm_set_self_attr() pass , we won't change
+	 * LSM configuration for the following process
+	 */
+	memcpy(ctx, ctx_orig, LSM_CTX_SIZE_DEFAULT);
+
+	ctx_size = page_size;
+	ctx_size_small = 1;
+	ctx_size_big = ctx_size + 1;
+
+	TST_EXP_FAIL(lsm_set_self_attr(tc->attr, *tc->ctx, *tc->size, tc->flags),
+	      tc->exp_errno,
+	      "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	int ret;
+	uint32_t size;
+
+	verify_supported_attr_current();
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	size = page_size;
+
+	ret = lsm_get_self_attr(LSM_ATTR_CURRENT, ctx_orig, &size, 0);
+	if (ret < 0)
+		tst_brk(TBROK, "Can't read LSM current attribute");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers[]) {
+		{&ctx, .size = LSM_CTX_SIZE_DEFAULT},
+		{&ctx_orig, .size = LSM_CTX_SIZE_DEFAULT},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
