Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B5D41D61
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:16:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C1D23D5A1D
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:16:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3A903D5A02
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:39 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98B931BF9048
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E08C51F396
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+cL0tSdjiROcpk+C9/RoYEkk0MNyG2uAeTiCa/73DI=;
 b=JdQJNGRw4bO7721BaquhY37/bf54Itd5x/CsCtKN3rlTTT1CPueIGNOS4bN+tXMUi2Bf2d
 aI60IQwNkBrCTuR4llFQJUSEUTFVBXgdQwu89geVH57Ic1tY/FNnk8y91Vgf27IUGLCS46
 zZzAO4bOfjsimQYC/cQGv2cB4vKYoFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+cL0tSdjiROcpk+C9/RoYEkk0MNyG2uAeTiCa/73DI=;
 b=/hPl272gydM4jTqXyXdzyKJr1WgKmfz9lbgGQhBSZz2Mj9zqksWlcjWe9cuEXCfLg9XMLy
 y8JLWVBVSK9A5yDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JdQJNGRw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/hPl272g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+cL0tSdjiROcpk+C9/RoYEkk0MNyG2uAeTiCa/73DI=;
 b=JdQJNGRw4bO7721BaquhY37/bf54Itd5x/CsCtKN3rlTTT1CPueIGNOS4bN+tXMUi2Bf2d
 aI60IQwNkBrCTuR4llFQJUSEUTFVBXgdQwu89geVH57Ic1tY/FNnk8y91Vgf27IUGLCS46
 zZzAO4bOfjsimQYC/cQGv2cB4vKYoFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+cL0tSdjiROcpk+C9/RoYEkk0MNyG2uAeTiCa/73DI=;
 b=/hPl272gydM4jTqXyXdzyKJr1WgKmfz9lbgGQhBSZz2Mj9zqksWlcjWe9cuEXCfLg9XMLy
 y8JLWVBVSK9A5yDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70DC413AA1
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yO3pD5kAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:33 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-2-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=4947;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=f+FSFwO7xVM6vaxnW1PldbVuZaEM95Yi+SuGyz+NWv0=;
 b=GELvQ6/uiQSed4h7ipWKMgktwnWR43G1BazOXGoIT0l66vUPcaizCi4FSjQCvPslsuwcDSLVm
 5dkEZ6iZ8RVC+uYdiTTML52h42f/P4x/BpjDz3asGpx6tMH/9liODud
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E08C51F396
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/7] Add lsm_get_self_attr01 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/lsm/Makefile             |  7 ++
 testcases/kernel/syscalls/lsm/lsm_common.h         | 57 +++++++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      | 81 ++++++++++++++++++++++
 4 files changed, 147 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 5fd62617df1a116b1d94c57ff30f74693320a2ab..d59faf08a3f36b5f64d56952f69641191c70bf33 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -756,6 +756,8 @@ lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
 
+lsm_get_self_attr01 lsm_get_self_attr01
+
 lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
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
index 0000000000000000000000000000000000000000..33ddda13720d843907404662e6c6dc72ffac3233
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_common.h
@@ -0,0 +1,57 @@
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
+	return (struct lsm_ctx *)((void *)tctx + sizeof(*tctx) + tctx->ctx_len);
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
+	char data[BUFSIZ];
+
+	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
+	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_CLOSE(fd);
+
+	if (!strstr(data, name)) {
+		tst_res(TINFO, "%s is running", name);
+		return 1;
+	}
+
+	return 0;
+}
+#endif
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
new file mode 100644
index 0000000000000000000000000000000000000000..2317941af1b73240368820e6a51591e7c18cc140
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that lsm_get_self_attr syscall is raising errors when invalid data is
+ * provided.
+ */
+
+#include "tst_test.h"
+#include "lapi/lsm.h"
+
+static struct lsm_ctx *ctx;
+static uint32_t ctx_size;
+static uint32_t ctx_size_small;
+
+static struct tcase {
+	uint32_t attr;
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
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(ctx, 0, sizeof(struct lsm_ctx));
+	ctx_size = sizeof(struct lsm_ctx);
+	ctx_size_small = 1;
+
+	TST_EXP_FAIL(lsm_get_self_attr(
+		LSM_ATTR_CURRENT, *tc->ctx, tc->size, tc->flags),
+		tc->exp_err,
+		"%s", tc->msg);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
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
