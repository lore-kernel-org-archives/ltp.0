Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA5FC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:10:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D31DC3E8C50
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:09:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 020483E803E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39E6A140051B
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36CD521AEA;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZ3DK43bXMeFBs+dTUYk813SUFf/pvFYFWnQ7HFZhLQ=;
 b=phUMDNURYtLW1anfxS92lhtugGgLOc/lqnFN+902rdwIBp+97t2Guxe+9dW+ArOZDoxklZ
 lt1eIZgX+Ug+jRV/RPa2abkaNTgGalRellcB0EXzH3po8xgM0viPzH8VpfJGqLBG3UBf1V
 LVEITp3z2aZ6TcnDvIKHs/Jso6gaxBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZ3DK43bXMeFBs+dTUYk813SUFf/pvFYFWnQ7HFZhLQ=;
 b=l2GDneOZUtjcDVw/FH43PpHYCDCy2swkFwf9uolGqiw0c+5BMjEUrr/K+dWmPas7ioCimp
 U96JteUTrTJaIjDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wBy9DDa/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wl819NpC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZ3DK43bXMeFBs+dTUYk813SUFf/pvFYFWnQ7HFZhLQ=;
 b=wBy9DDa/w2f+WfGZAT2EPUWY5mxFadc58164P4oTrFE8tSEUPk0+fM3TmCqFJpVaVw8JHl
 SmO2H2IwNWmZkL7Z9sjOxpT0TNfQxGr4w4RdT3iqB4P7FJUnLXLIknip3RLUOdygfogRqt
 wd53KvQcYdQdVjl7Zt/3YEUwaqTYhGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZ3DK43bXMeFBs+dTUYk813SUFf/pvFYFWnQ7HFZhLQ=;
 b=Wl819NpCXRAcxlIFZ5Rjr3N7zrpnTc7kMV8AUtNdxqac4lbJIUgVS9mAVCKJ7lFM9aud0i
 DYQY/uXuxfL7T0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9F45139B9;
 Wed, 16 Sep 2026 14:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T23
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:48 +0200
Message-ID: <20260916140402.1797325-23-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 36CD521AEA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 22/36] keyctl27: Test KEYCTL_DH_COMPUTE KDF key
 derivation
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

Test KEYCTL_DH_COMPUTE SP800-56A KDF key derivation: verify that
deriving a key using SHA-256 and otherinfo matches the precomputed
mathematical test vector.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore   |  1 +
 testcases/kernel/syscalls/keyctl/keyctl27.c   | 78 +++++++++++++++++++
 .../kernel/syscalls/keyctl/keyctl_dh_data.h   |  5 ++
 4 files changed, 85 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl27.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7485996ec0..a90138137f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -744,6 +744,7 @@ keyctl23 keyctl23
 keyctl24 keyctl24
 keyctl25 keyctl25
 keyctl26 keyctl26
+keyctl27 keyctl27
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index dd282b7ced..720ba1de65 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -24,3 +24,4 @@
 /keyctl24
 /keyctl25
 /keyctl26
+/keyctl27
diff --git a/testcases/kernel/syscalls/keyctl/keyctl27.c b/testcases/kernel/syscalls/keyctl/keyctl27.c
new file mode 100644
index 0000000000..bf697b1fab
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl27.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DH_COMPUTE`` KDF key derivation of :manpage:`keyctl(2)`.
+ *
+ * The KDF extension to ``KEYCTL_DH_COMPUTE`` (SP800-56A) landed in Linux 4.12.
+ *
+ * [Algorithm]
+ *
+ * - derive key with SP800-56A KDF (SHA-256 + otherinfo), verify derived
+ *   key matches expected 32-byte value
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_dh_data.h"
+
+#define KDF_OTHERINFO	"LTP-KDF-TEST-INFO"
+
+static struct keyctl_dh_params *dh_params;
+static struct keyctl_kdf_params *kdf_params;
+static unsigned char out_buf[32];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	dh_params->priv = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				       KEY_SPEC_PROCESS_KEYRING);
+	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
+					KEY_SPEC_PROCESS_KEYRING);
+	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
+				       KEY_SPEC_PROCESS_KEYRING);
+}
+
+static void run(void)
+{
+	memset(kdf_params, 0, sizeof(*kdf_params));
+	kdf_params->hashname = "sha256";
+	kdf_params->otherinfo = (char *)KDF_OTHERINFO;
+	kdf_params->otherinfolen = strlen(KDF_OTHERINFO);
+
+	memset(out_buf, 0, sizeof(out_buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)dh_params,
+				    (unsigned long)out_buf,
+				    sizeof(dh_kdf_expected),
+				    (unsigned long)kdf_params),
+			     (long)sizeof(dh_kdf_expected));
+	if (!TST_PASS)
+		return;
+
+	if (memcmp(out_buf, dh_kdf_expected, sizeof(dh_kdf_expected))) {
+		tst_res(TFAIL, "derived KDF key does not match expected value");
+		return;
+	}
+
+	tst_res(TPASS, "KEYCTL_DH_COMPUTE with KDF derived expected key");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.12",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_KEY_DH_OPERATIONS=y",
+		"CONFIG_CRYPTO_DH",
+		"CONFIG_CRYPTO_SHA256",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&dh_params, .size = sizeof(*dh_params)},
+		{&kdf_params, .size = sizeof(*kdf_params)},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h b/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
index bc1432dc30..7ac7876a06 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
+++ b/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
@@ -71,4 +71,9 @@ static const unsigned char dh_expected_secret[] = {
 	0xfb, 0xeb, 0xdd, 0x18, 0x54, 0x0d, 0x4c, 0xa7, 0x65, 0xc1, 0x0c, 0x11, 0xad, 0xea, 0x83, 0x9f,
 };
 
+static const unsigned char dh_kdf_expected[] = {
+	0x66, 0x39, 0xec, 0x41, 0x31, 0x33, 0xe6, 0xc0, 0x61, 0x67, 0x28, 0x51, 0x61, 0xf7, 0x8c, 0xd7,
+	0xc0, 0x55, 0xc9, 0xcc, 0x83, 0x46, 0xf3, 0xaa, 0x62, 0xed, 0xca, 0x90, 0x99, 0x2d, 0xc4, 0x07,
+};
+
 #endif /* KEYCTL_DH_DATA_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
