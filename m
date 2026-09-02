Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A2C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:05:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEC183E93AF
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:05:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 205EA3E2D90
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3B06600B4E
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4928121E25;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=0dDWz2L3dJCP44GI8Y+s8TO/AyepxnG1JbSNhxkNkOFvfhWynd1/x9Yvac6WQbVJNsA2l0
 Nl4vdu2zY4ZOdCaOYvPasiFfbZHElccaI5RZ0lWSBZfgG3GehOQtGbVDynLKpMJetcDWW0
 ax2tocstZ4NRoYfircH/NcnnfgEuAyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=UeDpjM92ugsFvgGscEgHobB/p1Qi6HSG23XzZYSDsoSxMi1NzaDaCnbIpHAxNWJlPp/0J3
 St7UNKu734+8Q3Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kky6xepS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rpJwR5Mm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=Kky6xepSOuswtJ0SKlFNymzQ6/MYtIrEOf0/gdd2Owtn/zJqQipUO16yfiFdgYchyPhb2m
 2qZebyowIQ3KWX98zQAnYMVEK2Y6g0ZrAUUrR2a8u6Nptv4nPDiRkYWmqUR1xIfe0o+NbR
 bfgkR4RgRX9zqJ4xdyUbivNC4bkJqrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=rpJwR5Mmf96ooWaa9BKnuurVMn04CVUT0fCiFUKkLcUy4Slcj2WJrNc8bZc3NIr5A5+RRa
 X861SkXj2krztSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB06413874;
 Wed,  2 Sep 2026 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Ke1M7YCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:19 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-4-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2788;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=EvWeHOdCxUWRaqbWuZ8BFuK/axzFOZUDg5tOZfuIG8g=;
 b=TkN4GGnfFk4Ry2PkpQGtcFzbuuSmoUhCzaSuRW1LwMmZQixNBnAgO90h3dBMDGGFIAbo8/rig
 IUOr/Ms+c9GCE/JxwGpFcNE02a/wYbQigGdfUCes96QyS2PbfUx7NIQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4928121E25
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/33] keyctl12: Test KEYCTL_DESCRIBE with too small
 buffer
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

Test KEYCTL_DESCRIBE when called with a buffer smaller than the
full description length: verify the buffer is left untouched and the
return value still reports the full length.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl12.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7c9042471..d8e846e65 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -729,6 +729,7 @@ keyctl08 keyctl08
 keyctl09 keyctl09
 keyctl10 keyctl10
 keyctl11 keyctl11
+keyctl12 keyctl12
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 4974fe48d..9ce6e2250 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -9,3 +9,4 @@
 /keyctl09
 /keyctl10
 /keyctl11
+/keyctl12
diff --git a/testcases/kernel/syscalls/keyctl/keyctl12.c b/testcases/kernel/syscalls/keyctl/keyctl12.c
new file mode 100644
index 000000000..b135fbe49
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl12.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with too small buffer.
+ *
+ * [Algorithm]
+ *
+ * - describe a key with buffer smaller than full length, verify the buffer
+ *   remains untouched and the return value is unchanged
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	64
+
+static key_serial_t key;
+static long desc_len;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
+
+	desc_len = TST_RET;
+}
+
+static void run(void)
+{
+	size_t i;
+
+	memset(buf, 0xAA, sizeof(buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
+				    desc_len - 1, 0), desc_len);
+	if (!TST_PASS)
+		return;
+
+	for (i = 0; i < sizeof(buf); i++) {
+		if (buf[i] != (char)0xAA) {
+			tst_res(TFAIL,
+				"too small buffer was written to at offset %zu",
+				i);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "too small buffer was left untouched");
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
