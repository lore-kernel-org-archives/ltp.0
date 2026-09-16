Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D958BC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:07:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BA073E7A02
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A64FB3E8C4F
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3AE7C1400BDA
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C62F421C7B;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em7XB3u23nS1145BK0d0hmj9FjEfiPWtYg7mo3p+Yxw=;
 b=1wiMxIUsKByWRiXra+2FG1futJRqR/e7b+6HxPVLZt2hkEyREJwRg4TEMVoooowzHpMu/w
 Tdk6LSHqEm83jvgHxFuYQJZ1q36oLfWA4ePEJ4mVNKQfPKsJ8GzTFycUnSrHRZ1ilAOuFT
 NLABR6yp72xAQbnBXCwO23C9zvUg1oE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em7XB3u23nS1145BK0d0hmj9FjEfiPWtYg7mo3p+Yxw=;
 b=af6nJvO6AHZOk1yftrSsu34iVAqefX9N90f+g8oSxxtNz3ZN96q2/2r7U/m4B0sdN3ytHS
 Yg/z9iRd9qvweZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em7XB3u23nS1145BK0d0hmj9FjEfiPWtYg7mo3p+Yxw=;
 b=WC4H9DZCU6DDPcgu/nJmlTQAHRYT87ueUdPczipawxc4sEgbVlZaZFb2y7lqTAKyWEFBOC
 Mwh1HCMjo4PMUdd+hJeOBKkcKXKXTUpqPFYlakD1BRV6fIRP0pQurVzZjSb1TXLrTlfdtO
 wG1RMG6djvPWFV8GJ2notgdYqU81MOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em7XB3u23nS1145BK0d0hmj9FjEfiPWtYg7mo3p+Yxw=;
 b=KUlo8Z4cfSoxxGtuXdiv5MQNqAHYPpUxjc/5HdfabECA5q6JU5Hl2crkYDWstnltiMgUZO
 eH8cHXxIGPLYgiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A91B5139A1;
 Wed, 16 Sep 2026 14:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T11
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:36 +0200
Message-ID: <20260916140402.1797325-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 10/36] keyctl16: Test KEYCTL_GET_SECURITY truncated
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl16.c | 74 +++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bdac6e09e1..210552fec1 100644
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
index 852fee4eab..c351716d07 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -13,3 +13,4 @@
 /keyctl13
 /keyctl14
 /keyctl15
+/keyctl16
diff --git a/testcases/kernel/syscalls/keyctl/keyctl16.c b/testcases/kernel/syscalls/keyctl/keyctl16.c
new file mode 100644
index 0000000000..76e6ab7511
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
+	key = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
