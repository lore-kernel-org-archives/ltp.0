Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB20FC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DFAC3E8B97
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:13:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFAE63E8C4C
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCB681A000A2
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3095421D79;
 Wed, 16 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=388JDcrdct3464pG2AENLKVm8svrjO0VJKOycNS8/kw=;
 b=Y4pfBNzrQGewuq7Lej8MkGfkcSzThMb2HoUUhuqIS8M2hvVP6SbHlqQXTM+8Ygh2q9lcQx
 oYhbiSjxCHPc/6EyNj7hwWzK8cmxLE29w/hQrcigpsGH0vtjcwnOHnMjxdjtfCNuoZepKu
 8FhimT6jYxtCZ4/LONjWd5taL/esh6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=388JDcrdct3464pG2AENLKVm8svrjO0VJKOycNS8/kw=;
 b=gyy4aA2PmbHfb/E/WLK7ejAOTIPOie+WNwH9VLKCrf7dPP5a2S6kbJbDvBmN+4har57ag2
 FJcjYcEAoJxJA5CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="nl/t4pM8";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HyAKv1qm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=388JDcrdct3464pG2AENLKVm8svrjO0VJKOycNS8/kw=;
 b=nl/t4pM83LVKM4ZYZR9HGXvpPpbv1SnnDubz8adQj2NBq+e3bWQkmo/h21cuT2nMPWY4wX
 RXYzMtdiEgIWMrdNV+sPnFt+iklMvk8issqcE4+2W3I4RDIdnzzlHkUrZ9bvrIRHLMtwCB
 cEXMAFkMbbG7kDZl21IorCx8IkcIFqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=388JDcrdct3464pG2AENLKVm8svrjO0VJKOycNS8/kw=;
 b=HyAKv1qm/YtoFxqvRpS1tlbLHXU+FiixuN7HnQ+fE4k72z1CRtFsxURB5NYxtSRO/L4juF
 5tc5CD7aWKDW7kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E7B139CE;
 Wed, 16 Sep 2026 14:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T34
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:59 +0200
Message-ID: <20260916140402.1797325-34-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3095421D79
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RL47ebk195wksjxkdm8ez9hex8)];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 33/36] keyctl36: Test KEYCTL_CAPABILITIES buffer
 sizing
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

Test KEYCTL_CAPABILITIES with short buffer (verifying partial copy
without overrun) and oversized buffer (verifying trailing space is
zero-filled while returning the full capability length).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_KEYCTL() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl36.c | 84 +++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl36.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 55299bd7c0..f42303345e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -753,6 +753,7 @@ keyctl32 keyctl32
 keyctl33 keyctl33
 keyctl34 keyctl34
 keyctl35 keyctl35
+keyctl36 keyctl36
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 58ebb452fa..a4da8ae805 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -33,3 +33,4 @@
 /keyctl33
 /keyctl34
 /keyctl35
+/keyctl36
diff --git a/testcases/kernel/syscalls/keyctl/keyctl36.c b/testcases/kernel/syscalls/keyctl/keyctl36.c
new file mode 100644
index 0000000000..4f0cb70378
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl36.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` buffer sizing and padding of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify a 1-byte buffer receives 1 byte while the full size is returned
+ *   and canary bytes beyond 1 byte remain untouched
+ * - verify an oversized buffer is zero-filled beyond the capability size
+ */
+
+#include "keyctl_common.h"
+
+#define CANARY		0xaa
+#define OVERSIZE	16
+
+static long caps_len;
+static unsigned char short_buf[4];
+static unsigned char large_buf[OVERSIZE];
+
+static void setup(void)
+{
+	caps_len = SAFE_KEYCTL(KEYCTL_CAPABILITIES, (unsigned long)NULL, 0, 0, 0);
+}
+
+static void run(void)
+{
+	size_t i;
+	int zero_padded = 1;
+
+	memset(short_buf, CANARY, sizeof(short_buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_CAPABILITIES,
+				    (unsigned long)short_buf, 1, 0, 0),
+			     caps_len);
+	if (!TST_PASS)
+		return;
+
+	if (short_buf[0] == CANARY) {
+		tst_res(TFAIL, "short buffer was not populated");
+		return;
+	}
+
+	for (i = 1; i < sizeof(short_buf); i++) {
+		if (short_buf[i] != CANARY) {
+			tst_res(TFAIL, "copy overran short buffer at offset %zu", i);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "short buffer copied 1 byte without overrun");
+
+	memset(large_buf, CANARY, sizeof(large_buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_CAPABILITIES,
+				    (unsigned long)large_buf, sizeof(large_buf), 0, 0),
+			     caps_len);
+	if (!TST_PASS)
+		return;
+
+	for (i = caps_len; i < sizeof(large_buf); i++) {
+		if (large_buf[i] != 0) {
+			zero_padded = 0;
+			break;
+		}
+	}
+
+	if (!zero_padded)
+		tst_res(TFAIL, "oversized buffer was not zero-filled at offset %zu", i);
+	else
+		tst_res(TPASS, "oversized buffer zero-filled trailing space");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		NULL
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
