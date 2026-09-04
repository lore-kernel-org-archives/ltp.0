Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049CFC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76DB43E30CD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:16:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F4683E5A9A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCA8D60207E
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 399C91FDD4;
 Fri,  4 Sep 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=smQDew//Ko2OrV3kcr4NYj9IH+YstpCya4qIyiTGGjuf+74QrWClExX8rL8MgYjALHtpXX
 3+/AYHma9xAPvQfGwAgKrpcr7bGzr3rxy4VNU2De//5v7z8jFPTcuQxgqVTawPOZiXM0Ii
 oKi7hsAJ5OI2nG/xoHbXJeCBzRrhQhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=fDFoTeG1oi8L1pO8lDnx1JOpoR9Zl0jXdGUK82Xt5UMYDJBq78BgMneGfpOFZpDhwxIfBX
 4RqpVkwgjI3QnUBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MQXRfnO4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DXtoJWXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=MQXRfnO43FiJLKHAsi93Sj45QejDYH33hu9nhAOc2RD8FlgJjBs1xQ9prAxNNCLhfUf7vJ
 e9Cj5zy2KsLUePrX182PdyiOxAI4eaap2suDGxTsJwVyJXGgNfF4d12nrzXSr2LiQ4Sw6l
 Lq94PPvNDLUJlB0csJeSzU3Ku9Qp1GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=DXtoJWXa1jpACPO8030yqE981cuPxO0bHuZJHkPSr4saS/GiKKobQew3lop2KytLY9kMDz
 b2bdLxuVcvx0wcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0574A13A01;
 Fri,  4 Sep 2026 12:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CEyOtq0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:20 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-31-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2673;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xgAsIxoSSMpJS4C9tP/UmgDmYUMmj9MnCMwcyVTwIxw=;
 b=unGmtHQWXLOS1soCIXAUueOPziu7j+ptUi/hVaPo22tEmRNhR6HJNr2TaqpN6tKp2Kv2aCXF+
 YQHgDtxyyKKCgFxsGBAEDlCRQrsvjow4ysy09eu2Ait1FxURMKu6aB1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 399C91FDD4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 31/33] keyctl37: Negative tests for
 KEYCTL_CAPABILITIES
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

Add negative test cases for KEYCTL_CAPABILITIES verifying that
passing a NULL buffer with a non-zero length or an invalid buffer
pointer fails with EFAULT.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl37.c | 63 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8ad8f0fe5..66215afd7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -754,6 +754,7 @@ keyctl33 keyctl33
 keyctl34 keyctl34
 keyctl35 keyctl35
 keyctl36 keyctl36
+keyctl37 keyctl37
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index a4da8ae80..7ee6b9098 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -34,3 +34,4 @@
 /keyctl34
 /keyctl35
 /keyctl36
+/keyctl37
diff --git a/testcases/kernel/syscalls/keyctl/keyctl37.c b/testcases/kernel/syscalls/keyctl/keyctl37.c
new file mode 100644
index 000000000..08d1db03b
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl37.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_CAPABILITIES`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify ``KEYCTL_CAPABILITIES`` with NULL buffer and ``buflen > 0`` fails with ``EFAULT``
+ * - verify ``KEYCTL_CAPABILITIES`` with invalid pointer fails with ``EFAULT``
+ */
+
+#include "keyctl_common.h"
+
+static void *bad_addr;
+
+static struct tcase {
+	void **buf;
+	size_t buflen;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{
+		.buf = NULL,
+		.buflen = 1,
+		.exp_errno = EFAULT,
+		.desc = "NULL buffer with non-zero buflen",
+	},
+	{
+		.buf = &bad_addr,
+		.buflen = 1,
+		.exp_errno = EFAULT,
+		.desc = "invalid buffer pointer",
+	},
+};
+
+static void setup(void)
+{
+	bad_addr = tst_get_bad_addr(NULL);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	void *p = tc->buf ? *tc->buf : NULL;
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_CAPABILITIES, (unsigned long)p, tc->buflen, 0, 0),
+		      tc->exp_errno,
+		      "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "5.3",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		NULL
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
