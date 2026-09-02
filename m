Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7FBC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 066E03E2D90
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:07:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2C313E93AB
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B3C6600B45
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CF8621E2E;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=rzn/Psn17ogVB6Svv6tjdx9I/NBCj6bflUxrgKv5AL9oKlUudLm5ldaWdzhOQAEZmlhgKo
 2w0GnnnkFQguvIG2wENoNGyjdckLEXz5VJowbMWrvMwsymuHbhNZ/lj07R1+ffyjAzBFaL
 JePBSvSbhVoYkWb0E3JqqD+GAfvjg8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=H2hastZsy+A5XRulg5w49nZmHRQsTJQSoYvBv9Y8D6RV47DCTBvggaKADn74XUix+2qgNh
 MlvPZQeW+bCDDXCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=psrDlISu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TjLwhowO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=psrDlISuXuU0JHRUuo2MSPZlACDLxrzfpiTZfymc7w/x7EyRFs7JxSQTR44HY8oJ+sGgQo
 KK7SAu1ssozXG/YW1/BahhehHxxOJoFS3Ipj0tda6zu4hjWEzymb47lXu4oT6kyLy3Ir8s
 PU+/7ZWKsznaQJEhjV8YwaVfTMWyj7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=TjLwhowO18laQlMbFvTKwXjI87Swg5Li30tLgYR90LxV1qSLzS/lyEfNu8ZMFRPhRhW3i2
 2Uj1RI4Z4NV5RaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7849913976;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EutG7cCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:23 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-8-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=3148;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QPZPaU/pNiZP89O1mDougadtkoSNRrsEfz+V7ZCczjQ=;
 b=tQ/Iqgu4OK4S3s9WvGsArDIsL/gtBkzigxHnB9UHy09F8VzHyJYm9QhnakcjycMzCPbQyjgpf
 8q7LLhTeIRSCf7fNqp3V9wqLP0ZpqsLm3ju/tXg+qOPqy2Cwe6EViI3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 2CF8621E2E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/33] keyctl16: Test KEYCTL_GET_SECURITY truncated
 copy
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

Test KEYCTL_GET_SECURITY truncated copy behavior: verify that calling
with a 1-byte buffer receives exactly one byte while the return value
still reports the full label length.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl16.c | 74 +++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index da901baae..89c8a95af 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -733,6 +733,7 @@ keyctl12 keyctl12
 keyctl13 keyctl13
 keyctl14 keyctl14
 keyctl15 keyctl15
+keyctl16 keyctl16
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 852fee4ea..c351716d0 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -13,3 +13,4 @@
 /keyctl13
 /keyctl14
 /keyctl15
+/keyctl16
diff --git a/testcases/kernel/syscalls/keyctl/keyctl16.c b/testcases/kernel/syscalls/keyctl/keyctl16.c
new file mode 100644
index 000000000..f5662e326
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl16.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_GET_SECURITY`` truncated copy of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_GET_SECURITY`` returns the full length of the label, but unlike
+ * ``KEYCTL_DESCRIBE`` the kernel performs a truncated copy when the user
+ * buffer is too small.
+ *
+ * [Algorithm]
+ *
+ * - verify a one byte buffer receives exactly one byte while the full
+ *   length is still returned
+ */
+
+#include "keyctl_common.h"
+
+#define KEY_DESC	"ltpkeyctl16"
+#define PAYLOAD		"payload"
+#define BUF_SIZE	128
+
+static key_serial_t key;
+static long sec_len;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
+			   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");
+
+	sec_len = TST_RET;
+}
+
+static void run(void)
+{
+	size_t i;
+
+	memset(buf, 0xAA, sizeof(buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_GET_SECURITY, key,
+				    (unsigned long)buf, 1, 0), sec_len);
+	if (!TST_PASS)
+		return;
+
+	if (buf[0] == (char)0xAA) {
+		tst_res(TFAIL, "nothing was copied into the buffer");
+		return;
+	}
+
+	for (i = 1; i < sizeof(buf); i++) {
+		if (buf[i] != (char)0xAA) {
+			tst_res(TFAIL, "copy overran the buffer at offset %zu",
+				i);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "exactly one byte copied, full length %ld returned",
+		sec_len);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
