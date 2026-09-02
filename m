Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340A7C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:10:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE59F3E93AB
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:10:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C683E93B4
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 18F0C1000A2D
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CEA621E35;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=t97dI9ZKMmvWFUBkbOhTVYSU77JhykXAutgy55hdDV+tekBGGTIGb04ZkO6oZEta1INEXb
 lRDLCTdBMDAuIyM9hzwTy8bsPVfbYQi7rCibQDMcpQG7yi9Dl/cj8OtJKUYT11uR24EnId
 uEMWQFQw4WH9yu1JZyMAUrFR+0C8a4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=bO/DYriQSUrwue5LREOgpQl1mu/xf5mj1rwFD+hss66ybFA90QCZhlBRGt+EwghRhL2aow
 L6/AsMg65FJQkpCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=UZVpp91uLzbe0vgJzemywapcBxAtdy/WoqoDWh37C5DK91c2thu0PGdQLu8LT7PqkTEw1B
 nr1vgn6Z3P9snWDsJlf43M0/Qrog+4XR5v4wZgty/dWBMmARsIzNnYV1089iQ+ScHrqCit
 E9dyP/0RSKeHwrO0QWgTr4wzmx0vWhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA2+o2435U44H/r0d0rbcMxaFKtI5OIW0TXb7ppLuGk=;
 b=fJH1HEBVP035B8flxJu0VQd3nXcf7ONTRy8PhTJyhIDosJWyqipLCkX/5RkLl9UCNYs3bb
 DdUEPE3ulIruHrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01A6B139AD;
 Wed,  2 Sep 2026 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yDxDOroCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:46 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-31-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2673;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xgAsIxoSSMpJS4C9tP/UmgDmYUMmj9MnCMwcyVTwIxw=;
 b=t2I0ysQT/wa/9n6kduB4k4VLSaQLcFUSlXFPqttvEfrUJbAZt6cmH7rvve1mZ7KwW1YLPdgz9
 5+1WjSnLJK2DwgWfeuccjDbFlUh/YolAsBjngN/PwOlEFm1hNFOmrhk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 31/33] keyctl37: Negative tests for KEYCTL_CAPABILITIES
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
