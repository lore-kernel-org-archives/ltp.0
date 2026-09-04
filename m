Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A057EC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:17:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC173E0E5B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:17:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE9B3E9764
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 77EBA200D1F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 296F41FB57;
 Fri,  4 Sep 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=YjjTaS+MhXdmP6Olx8q6YISimsLV05YDbyKU2JDJHF4BskqBky5bULgEolyf6MW6JbZVfn
 OZBH9XLbOPgraoM2KLD6M787V0tU7nMjMTitRw1XRzfa4dSZmaYudW91D0fT8m4ReB5eHo
 ZxGjrFLbQERZLuwNY3Gbgnkq04SX/40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=Kjfd5j46zebTwISxUWGmvGDzgnucOCvxDrdmU9zYw0b1KYiQPL45vIk19dXQUur83qvck0
 3Ov9WKkwZtGmhqDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sBVAIOS7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sxJR2Kls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=sBVAIOS7fbs5c5m9qTGvXc0Qig/hUbUKpjHzikzO3btD3BKpYbTI61McAkztI+GnejBB4G
 KitzRTGgaeEVD63ylfceOkmf8wK0Vq3aTAOPPNzCnfUG2Q7m9ntvhv3Nig02URlOZOLFy+
 uXX2eUkQZj2C30xJkXZdUT4L5sKBOl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=sxJR2KlsWCW6Bm7Q4iFJwdIgHOnw39jRdW5K4wz/CzsepiAXqTWt15g0OG2PkAzi9lcw9y
 EeQroCyuPYTiQJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0EB7139F3;
 Fri,  4 Sep 2026 12:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qPJCLNq0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:19 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-30-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=3530;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=64rkVLfxFHXH+sjSfRJe+VuVFYYeUPyzmtOHUDRHCtM=;
 b=xtOkAVjYJmFOTSwFnRezffTOdXlF3GTWwlS6s2jTB22sxyy3l7I0epWg/OplS1AghMNEdWtl3
 8eu0UaY8lNWCjVKIE1rs0fFWdYI+3J44LeuuuGcb39sYdE5CGeHmzxF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 296F41FB57
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 30/33] keyctl36: Test KEYCTL_CAPABILITIES buffer
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl36.c | 88 +++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 67d626c22..8ad8f0fe5 100644
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
index 58ebb452f..a4da8ae80 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -33,3 +33,4 @@
 /keyctl33
 /keyctl34
 /keyctl35
+/keyctl36
diff --git a/testcases/kernel/syscalls/keyctl/keyctl36.c b/testcases/kernel/syscalls/keyctl/keyctl36.c
new file mode 100644
index 000000000..58fa56a07
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl36.c
@@ -0,0 +1,88 @@
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
+	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)NULL, 0, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES size query failed");
+
+	caps_len = TST_RET;
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
