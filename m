Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F3D41D61
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:18:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DF233D5A1B
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:18:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03A203D5A10
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0AA7A2254A4
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDC191F396
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPA29ZGfZZ+7qaMw/lMqrqY9nfVVcdX3k0tKldz9O5U=;
 b=kQ14N9z/ILxhOiAaXhMqCxn7sIdp8XKLAQqIIwzcR52MGzuOUfbqTZ73+mTAhPftKnCVAY
 aigFkaGLi9s2ECu8CgF6qov9512XxuwRpwPoekKGUW+X8wHflwdrFgpx39bucK39e00TnW
 35Hdq7dMBTYiMMRTuRzTVuhy6P5zdZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPA29ZGfZZ+7qaMw/lMqrqY9nfVVcdX3k0tKldz9O5U=;
 b=Mkc+STi5VvQ9IW+TBpWCqvc2kib2GOIQCXKKkpgAs7Tm7Z12IviR7PRhwn8j16JBjT9t2x
 jvV2S9G9keJf8kCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPA29ZGfZZ+7qaMw/lMqrqY9nfVVcdX3k0tKldz9O5U=;
 b=kQ14N9z/ILxhOiAaXhMqCxn7sIdp8XKLAQqIIwzcR52MGzuOUfbqTZ73+mTAhPftKnCVAY
 aigFkaGLi9s2ECu8CgF6qov9512XxuwRpwPoekKGUW+X8wHflwdrFgpx39bucK39e00TnW
 35Hdq7dMBTYiMMRTuRzTVuhy6P5zdZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPA29ZGfZZ+7qaMw/lMqrqY9nfVVcdX3k0tKldz9O5U=;
 b=Mkc+STi5VvQ9IW+TBpWCqvc2kib2GOIQCXKKkpgAs7Tm7Z12IviR7PRhwn8j16JBjT9t2x
 jvV2S9G9keJf8kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702A513721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CFVhD50AM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:38 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-7-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=4328;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=h/wxl8YPF1+9lgbcFHocF1GHe+yJtXXcL17eL0OO+1Q=;
 b=jNz2saLoA7rEv7cO4nMBtHnNQ247km67O+CgPcd2SbfNvgGmYAjPmHFEZoqHTlFMJQK0e32Oi
 H4ifikpj/FNBQ3TtkRqFSLIMZpVqYJEMSkDgDn0TLsya9GmMkFqUQpS
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] Add lsm_set_self_attr01 test
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
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 123 +++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ee46f500859d08fba8d2553a01f8bc9e2cc8e3ea..1d017726782cce40feff964c3cf3260b98e4b24d 100644
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
index 0000000000000000000000000000000000000000..2d9d96bd7a42a99e8597d71bf05501ba18171af0
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
@@ -0,0 +1,123 @@
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
+	int lsm_count = 0;
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
