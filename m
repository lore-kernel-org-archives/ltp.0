Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1EFC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F00D93E93AD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:10:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C69273E588F
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 532F3600B46
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4711FAD2;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=RduuyDYMl+5+CHaMauf7euCpkk6eztKpYPMznZtuJ69hZeZORTpFKjhRHrl5iCzY+v0Pas
 eGuk7xxhg0MDlFYKTQLxcKhIPdTEhMV0gsaIUegVN2/ptM3u8hb9502bjrWcZOChlsrpuN
 uIy7Oz+8HwIADcicE1e84q3UQ2tR+yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=Is7s9aGVykh06wRioY3puB97CWssJh5LCF8UKR+T8QWmkX2dK0mdXjaYtbQRTfAGShU/sI
 gqCd/50oWmSRf+Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=JXPo66U4Jsx5yKbabNAEO+REIzbPzhCsiAubqIQmZi0/D6TPGEnVikeAnxW4EgbR4IO7G4
 3FlZ3Jj1cM9sJz14G/bxIeut+Csg9QhoEY/EivMFQYfKh70URgKMhN3ailunk83rq5ZF9l
 x8u1IekaZVQDwjZU0sL6YPCN0z2VQ+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3aGT5Vz+D7SsKt6DxTY5jTGB756SHtewLFiEBKiT5Q=;
 b=3s9oSve9HdeVTxfjAUItIPvd9TzP/bNi4h7r4sTdWcZYGV5afP2zAS5hKus3uv8AJEtkXE
 8hbF6kcYCZgEzbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF780139AC;
 Wed,  2 Sep 2026 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2G/6MLoCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:45 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-30-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=3530;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=64rkVLfxFHXH+sjSfRJe+VuVFYYeUPyzmtOHUDRHCtM=;
 b=+W1Qdj3IAP8mEUzYFTo7DIBZxg1Q1LkqLn0qjJL5dURicgu/dcp2QfiVGUlVY3i0R9VtByg6i
 wcIpmDjXhYZBgO0DUguzKAXPKMDbKYu6Nsjtn94MWyiZn/hszrNo+rI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 30/33] keyctl36: Test KEYCTL_CAPABILITIES buffer sizing
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
