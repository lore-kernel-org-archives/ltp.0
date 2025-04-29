Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E47C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:24:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 010C83CBC05
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:24:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267113CBBF1
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C1876002FA
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC87821B6B;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulMb6zkFpor0fG6EgCnnevqTj3qbn4Ty+6xlKayjh4c=;
 b=BfFuHcj86hcnvkNAZkOuNG8CL6dGvmSyYfX0wIxF91sRHoYFnBG9xNlhjlgM8Rmao7cyip
 pupyXZyGOTvLQLwmspMdkybq7mKQ3wfr8BfTugtzybN7/YQxJVmhfvwbZxwMgnn/jz4qQs
 FrwTRe6resfosRyP/70kTP272Qjqc6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulMb6zkFpor0fG6EgCnnevqTj3qbn4Ty+6xlKayjh4c=;
 b=OYBDRq0YzRyHOi7iZZD+6GUuidkGKIHDIdnTYXX4l1yxbIaQRdxer7caWUozpsdJQ/ThXc
 Tzu56h6/UR9Gs/DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BfFuHcj8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OYBDRq0Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulMb6zkFpor0fG6EgCnnevqTj3qbn4Ty+6xlKayjh4c=;
 b=BfFuHcj86hcnvkNAZkOuNG8CL6dGvmSyYfX0wIxF91sRHoYFnBG9xNlhjlgM8Rmao7cyip
 pupyXZyGOTvLQLwmspMdkybq7mKQ3wfr8BfTugtzybN7/YQxJVmhfvwbZxwMgnn/jz4qQs
 FrwTRe6resfosRyP/70kTP272Qjqc6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulMb6zkFpor0fG6EgCnnevqTj3qbn4Ty+6xlKayjh4c=;
 b=OYBDRq0YzRyHOi7iZZD+6GUuidkGKIHDIdnTYXX4l1yxbIaQRdxer7caWUozpsdJQ/ThXc
 Tzu56h6/UR9Gs/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83ED113AB9;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MFqJHnJ+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:31 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-2-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=6265;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=HJ2JcE0WMFSS4jl7RnUIBN2ASDVcV1UCzrx/8GoSeBQ=;
 b=3Xtbvu18Utg7adzHUyy7bL03V2R+Ck4zgDzbg9RamDgRho1AazDC7a3eXKjAa6L0K9kRau6Wb
 0gbNQ4LmqrZD8V1p1w7H1OTSmGr7w2DDoqaTHhWB4HK7+3wlYsR3MdE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: AC87821B6B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.cz:email,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/7] Add lsm_get_self_attr01 test
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

Verify that lsm_get_self_attr syscall is raising errors when invalid
data is provided.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 testcases/kernel/syscalls/lsm/Makefile             |  7 ++
 testcases/kernel/syscalls/lsm/lsm_common.h         | 91 +++++++++++++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      | 92 ++++++++++++++++++++++
 5 files changed, 193 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 57338297a33b47075a3f801871753cc76b073bfa..ba45c1945fb77b093ba578fdda3596a8d38c54b0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -759,6 +759,8 @@ lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
 
+lsm_get_self_attr01 lsm_get_self_attr01
+
 lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..49f4a9263349ce633b8decb8fff1dd1d2111cf49
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -0,0 +1 @@
+lsm_get_self_attr01
diff --git a/testcases/kernel/syscalls/lsm/Makefile b/testcases/kernel/syscalls/lsm/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..8cf1b9024d8bdebe72408c90fef4b8b84ce9dc4b
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/lsm/lsm_common.h b/testcases/kernel/syscalls/lsm/lsm_common.h
new file mode 100644
index 0000000000000000000000000000000000000000..dcc2d7a4206a3610ed39bbc4a118394611f73bab
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_common.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LSM_GET_SELF_ATTR_H
+#define LSM_GET_SELF_ATTR_H
+
+#include "tst_test.h"
+#include "lapi/lsm.h"
+
+static inline struct lsm_ctx *next_ctx(struct lsm_ctx *tctx)
+{
+	return (struct lsm_ctx *)((char *)tctx + sizeof(*tctx) + tctx->ctx_len);
+}
+
+static inline void read_proc_attr(const char *attr, char *val, const size_t size)
+{
+	int fd;
+	char *ptr;
+	char path[BUFSIZ];
+
+	memset(val, 0, size);
+	memset(path, 0, BUFSIZ);
+
+	snprintf(path, BUFSIZ, "/proc/self/attr/%s", attr);
+
+	tst_res(TINFO, "Reading %s", path);
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+
+	if (read(fd, val, size) > 0) {
+		ptr = strchr(val, '\n');
+		if (ptr)
+			*ptr = '\0';
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static inline int verify_enabled_lsm(const char *name)
+{
+	int fd;
+	char *ptr;
+	char data[BUFSIZ];
+
+	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
+	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_CLOSE(fd);
+
+	ptr = strtok(data, ",");
+	while (ptr != NULL) {
+		if (!strcmp(ptr, name)) {
+			tst_res(TINFO, "%s is enabled", name);
+			return 1;
+		}
+
+		ptr = strtok(NULL, ",");
+	}
+
+	return 0;
+}
+
+static inline uint32_t count_supported_attr_current(void)
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
+	return lsm_count;
+}
+
+static inline uint32_t verify_supported_attr_current(void)
+{
+	uint32_t lsm_count;
+
+	lsm_count = count_supported_attr_current();
+
+	if (!lsm_count)
+		tst_brk(TCONF, "LSM_ATTR_CURRENT is not supported by any LSM");
+
+	return lsm_count;
+}
+#endif
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
new file mode 100644
index 0000000000000000000000000000000000000000..ec272b9374e4240b6d0a0cb5b06aba112e8ea2d2
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_get_self_attr syscall is raising errors when invalid data is
+ * provided.
+ */
+
+#include "lsm_common.h"
+
+static struct lsm_ctx *ctx;
+static uint32_t ctx_size;
+static uint32_t ctx_size_small;
+
+static struct tcase {
+	int attr;
+	struct lsm_ctx **ctx;
+	uint32_t *size;
+	uint32_t flags;
+	int exp_err;
+	char *msg;
+} tcases[] = {
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.exp_err = EINVAL,
+		.msg = "size is NULL",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size,
+		.flags = LSM_FLAG_SINGLE | (LSM_FLAG_SINGLE << 1),
+		.exp_err = EINVAL,
+		.msg = "flags is invalid",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size_small,
+		.exp_err = E2BIG,
+		.msg = "size is too smal",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT,
+		.ctx = &ctx,
+		.size = &ctx_size,
+		.flags = LSM_FLAG_SINGLE,
+		.exp_err = EINVAL,
+		.msg = "flags force to use ctx attributes",
+	},
+	{
+		.attr = LSM_ATTR_CURRENT | LSM_ATTR_PREV,
+		.ctx = &ctx,
+		.size = &ctx_size,
+		.flags = 0,
+		.exp_err = EOPNOTSUPP,
+		.msg = "flags overset",
+	}
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(ctx, 0, LSM_CTX_SIZE_DEFAULT);
+	ctx_size = LSM_CTX_SIZE_DEFAULT;
+	ctx_size_small = 1;
+
+	TST_EXP_FAIL(lsm_get_self_attr(
+		tc->attr, *tc->ctx, tc->size, tc->flags),
+		tc->exp_err,
+		"%s", tc->msg);
+}
+
+static void setup(void)
+{
+	verify_supported_attr_current();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
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
