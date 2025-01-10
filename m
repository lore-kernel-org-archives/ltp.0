Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC7E7719D
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:57:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BE123C310D
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:57:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 484223C308A
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7441263E968
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDB31F455
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RUOfBryLrvlS075h5AiOfb+SFaWMb7JNyOE5vLe6MI=;
 b=00n1Sj+Y+il9cjHWWFBrV6THDg5uUYUmJCqemaRbudlAW9B+CErAvTkBuFdM/eAXBWrOZ5
 30xtbewjniZx+pUK/eVEhBSG4Bis+D+xEPBfb0pWaMrdFbsyKyjU02pKBu1rNyGhezdUyp
 +c0Qj7dbHrg5L+hWc+x/8fpBi2HR3D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RUOfBryLrvlS075h5AiOfb+SFaWMb7JNyOE5vLe6MI=;
 b=NLYJd6I9LAd7h8FqPLr8ps6mlUjptrKN0034QphAUT8qH9NwR3Y7LMzOyeKELO6pAt45OE
 c8AWNSgR0/5gcKCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RUOfBryLrvlS075h5AiOfb+SFaWMb7JNyOE5vLe6MI=;
 b=00n1Sj+Y+il9cjHWWFBrV6THDg5uUYUmJCqemaRbudlAW9B+CErAvTkBuFdM/eAXBWrOZ5
 30xtbewjniZx+pUK/eVEhBSG4Bis+D+xEPBfb0pWaMrdFbsyKyjU02pKBu1rNyGhezdUyp
 +c0Qj7dbHrg5L+hWc+x/8fpBi2HR3D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RUOfBryLrvlS075h5AiOfb+SFaWMb7JNyOE5vLe6MI=;
 b=NLYJd6I9LAd7h8FqPLr8ps6mlUjptrKN0034QphAUT8qH9NwR3Y7LMzOyeKELO6pAt45OE
 c8AWNSgR0/5gcKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B09713AAA
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qDrCANAYgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:46 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-7-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=4082;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=b3IAaINalPo9k/vjhosDtWycSYtVEoeCqbajLeSbob8=;
 b=QVQBZ9iG9fftQRkeLMzo/rZv99a28AbvHQK5sUBtMtVwz913jCCRzctnjPkNdtkeYjfwBP/w2
 qaxGfJ1lBhyA1SRZJuWI6rd6njiuvA7jgTRF7SHt+qxurXmh/qgdoIr
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] Add lsm_set_self_attr01 test
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
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 112 +++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 71c644b2da0e55df40ec753c5c31eeb9c474e146..4bbf0f8948f7076202d0231ffba909d242f78098 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -761,6 +761,7 @@ lsm_get_self_attr02 lsm_get_self_attr02
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
index 0000000000000000000000000000000000000000..5ccf05c03c4215ec92264be0981e35bc521d7394
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
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
+	memcpy(ctx, ctx_orig, sizeof(struct lsm_ctx));
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
+		{&ctx, .size = sizeof(struct lsm_ctx)},
+		{&ctx_orig, .size = sizeof(struct lsm_ctx)},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
