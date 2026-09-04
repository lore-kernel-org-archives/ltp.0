Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E5BC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:17:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DEE23E9785
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:17:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92DDD3E978C
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 550891001142
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0E8C22B34;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=uVgsxMHFWphOaYWqFBaCN58A2w/pINFNEHqRTEyE0Op+5AcCGbtFCIh3D3Yr7S6M2Fft/S
 P0JmlfpK6GvDUwI4dWOAb6fnGel7RYG/Xp4W9qC3U5h/dtuqJSepSeVp6wiXt7kFQD2xWv
 /CXkoRD3xDpYaS96XOYr9BW6XKwlZZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=ASe2iH6mAeFgfWb+UtDiPw83n0T5aeIBZKpdCWogw5TL2AKEJ7+xtfPfUik10oklSbgh60
 ag2YwYiK2DRsvGDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=QCew03V8k11PtlpmTCwesFyKYv3bwZJN4k0PlA8TfBzTFCAAQAsXyQo58wmc3BYTj2Q0Q2
 9twcEjJSNgofGMkUiSEkinFHpc3BeUvXqyzSxN9lewPruAjZPXSZ+SNyX6aFD+yBb+9R82
 LUYDqd9wLgP2kzBOQ5qwmRtJ90grwck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=aoASWMq+Gh1JfJ3wcubUJsQKOagtnZhQTnwmVrdrNxh/TXQuAg2sEVjO+wTW7i3nlKrPQb
 BbRyyl5JnuGXNNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F568139F0;
 Fri,  4 Sep 2026 12:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2CK4ENq0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:17 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-28-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=3272;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gHr91qQODKoy9V/89tSNgVhlcbiDpHQZYcjlVMgMvn8=;
 b=fOsXKuILVjFx8VvF9bBb/HyjwLMv5RLY6H7eUhvYKQy1lkd1esvpVqqXczTM2vHrW7J9cCJMM
 LuuZ2S37jFuAFrdIYWjrsAoGHPzYc2t8S2H3iHo7aRDfxq5SAWTEH7t
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 28/33] keyctl34: Test KEYCTL_CAPABILITIES flag
 retrieval
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

Test keyrings subsystem capabilities retrieval with KEYCTL_CAPABILITIES
and verify standard capability bits (CAPABILITIES, INVALIDATE,
RESTRICT_KEYRING, MOVE, NS_KEYRING_NAME, NS_KEY_TAG).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl34.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7658ac859..08877ff49 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -751,6 +751,7 @@ keyctl30 keyctl30
 keyctl31 keyctl31
 keyctl32 keyctl32
 keyctl33 keyctl33
+keyctl34 keyctl34
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 0f209d7e0..f2ce330d7 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -31,3 +31,4 @@
 /keyctl31
 /keyctl32
 /keyctl33
+/keyctl34
diff --git a/testcases/kernel/syscalls/keyctl/keyctl34.c b/testcases/kernel/syscalls/keyctl/keyctl34.c
new file mode 100644
index 000000000..bfe15a6ed
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl34.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * ``KEYCTL_CAPABILITIES`` retrieves the bitmask of features and capabilities
+ * supported by the keyrings subsystem in the running kernel.
+ *
+ * [Algorithm]
+ *
+ * - retrieve keyrings subsystem capabilities into a buffer
+ * - verify return value is at least 2 bytes
+ * - verify standard capability bits ``KEYCTL_CAPS0_CAPABILITIES``,
+ *   ``KEYCTL_CAPS0_INVALIDATE``, ``KEYCTL_CAPS0_RESTRICT_KEYRING``,
+ *   ``KEYCTL_CAPS0_MOVE``, ``KEYCTL_CAPS1_NS_KEYRING_NAME``, and
+ *   ``KEYCTL_CAPS1_NS_KEY_TAG`` are set
+ */
+
+#include "keyctl_common.h"
+
+static unsigned char caps[8];
+
+static void run(void)
+{
+	memset(caps, 0, sizeof(caps));
+
+	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)caps, sizeof(caps), 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES failed");
+
+	if (TST_RET < 2) {
+		tst_res(TFAIL, "KEYCTL_CAPABILITIES returned %ld, expected at least 2",
+			TST_RET);
+		return;
+	}
+
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_CAPABILITIES,
+		     "KEYCTL_CAPS0_CAPABILITIES is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_INVALIDATE,
+		     "KEYCTL_CAPS0_INVALIDATE is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_RESTRICT_KEYRING,
+		     "KEYCTL_CAPS0_RESTRICT_KEYRING is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_MOVE,
+		     "KEYCTL_CAPS0_MOVE is set");
+
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEYRING_NAME,
+		     "KEYCTL_CAPS1_NS_KEYRING_NAME is set");
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEY_TAG,
+		     "KEYCTL_CAPS1_NS_KEY_TAG is set");
+}
+
+static struct tst_test test = {
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
