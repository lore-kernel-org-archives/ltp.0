Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A018CC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:14:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C1883E7AD0
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:14:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9E593E7FA7
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3E2B600273
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 993F921D92;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnP6eEQ8dkfitjeKy7rVG5y1h1nmywG9rISb+wIsB3w=;
 b=1WGNDdgwxeIYaHAFhBphzCqPRmyXFzkZtkafAFcvGVfLXm7MjKHFkt66DMBr3xNHqxZXe0
 V5Vzna+h95+UINUpmAgVChVpG9Lf9gYn/el/z7Gh5Zh5r1GsJVydmQbXvYivQXUY+/k9bp
 Ltp9xG3I+lbR5vE2odZ+DapmjosHf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnP6eEQ8dkfitjeKy7rVG5y1h1nmywG9rISb+wIsB3w=;
 b=8GAPTucecZmJOzxm+1pZu5AfivpDsP0ht0CX8h9FfG/fhUcK80ujw1tA+wsdi9Tw8FM2+e
 B4+HSwHIu5OsQJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnP6eEQ8dkfitjeKy7rVG5y1h1nmywG9rISb+wIsB3w=;
 b=fusXh8zFwUlQLqaUwNoh/WmMWiNk7pe8B3P04hnaHycOZjY1VaRoaWhDlBfw096LArHCMc
 ymm6C6y1JTToXNBWFWhgN8LT27mxz/uToRC8tXeMIl79VFIwM4PSlMh2x5m8RhbqY+Zzu7
 /JyU7XnTDWJ9cbjXWLK1cnQM0OXUrTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnP6eEQ8dkfitjeKy7rVG5y1h1nmywG9rISb+wIsB3w=;
 b=ELNHSSGm3NL5AvmqUPPhOFevq5ESi7VipQVL8HrA+Th4UF7UCojlawEZ31Ybu6pYWLkc5e
 zO5CJ+HHCdmU0qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6FB1374A;
 Wed, 16 Sep 2026 14:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T28
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:53 +0200
Message-ID: <20260916140402.1797325-28-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLtzdurrd6usbijy4f5nozqpqy)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.com:email];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 27/36] keyctl31: Test KEYCTL_PKEY_ENCRYPT and
 KEYCTL_PKEY_DECRYPT
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

Test public key encryption and private key decryption with
KEYCTL_PKEY_ENCRYPT and KEYCTL_PKEY_DECRYPT: encrypt a 32-byte
plaintext using an RSA-2048 X.509 public key with enc=pkcs1,
decrypt with the matching PKCS#8 private key, and verify the
decrypted output matches the original plaintext.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl31.c | 110 ++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl31.c

diff --git a/runtest/syscalls b/runtest/syscalls
index accdf2df9b..a8c3486cb5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -748,6 +748,7 @@ keyctl27 keyctl27
 keyctl28 keyctl28
 keyctl29 keyctl29
 keyctl30 keyctl30
+keyctl31 keyctl31
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index d5b6955f33..025dc27fc9 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -28,3 +28,4 @@
 /keyctl28
 /keyctl29
 /keyctl30
+/keyctl31
diff --git a/testcases/kernel/syscalls/keyctl/keyctl31.c b/testcases/kernel/syscalls/keyctl/keyctl31.c
new file mode 100644
index 0000000000..c1e6723ac8
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl31.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_PKEY_ENCRYPT`` and ``KEYCTL_PKEY_DECRYPT`` of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_PKEY_ENCRYPT`` encrypts a data blob using an asymmetric public key
+ * and ``KEYCTL_PKEY_DECRYPT`` decrypts the encrypted blob using the matching
+ * private key.
+ *
+ * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
+ * ``pkcs8_key_parser`` modules.
+ *
+ * [Algorithm]
+ *
+ * - encrypt a 32-byte plaintext using an RSA-2048 X.509 public key with ``enc=pkcs1``
+ * - decrypt the 256-byte ciphertext using the matching PKCS#8 private key
+ * - verify the decrypted output matches the original 32-byte plaintext
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_pkey_data.h"
+#include "tst_module.h"
+
+#define CIPHERTEXT_SIZE	256
+
+static const char plaintext[] = "LTP_PKEY_ENCRYPT_DECRYPT_TEST_32";
+#define PLAINTEXT_SIZE	(sizeof(plaintext) - 1)
+static unsigned char ciphertext[CIPHERTEXT_SIZE];
+static unsigned char decrypted[CIPHERTEXT_SIZE];
+
+static key_serial_t cert_key, priv_key;
+static struct keyctl_pkey_params *enc_params;
+static struct keyctl_pkey_params *dec_params;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	tst_modprobe("x509_key_parser", NULL);
+	tst_modprobe("pkcs8_key_parser", NULL);
+
+	cert_key = add_asymmetric_key_or_tconf("cert", rsa2048_cert,
+					       sizeof(rsa2048_cert),
+					       "CONFIG_X509_CERTIFICATE_PARSER");
+	priv_key = add_asymmetric_key_or_tconf("priv", rsa2048_pkcs8,
+					       sizeof(rsa2048_pkcs8),
+					       "CONFIG_PKCS8_PRIVATE_KEY_PARSER");
+}
+
+static void run(void)
+{
+	memset(ciphertext, 0, sizeof(ciphertext));
+	memset(decrypted, 0, sizeof(decrypted));
+
+	memset(enc_params, 0, sizeof(*enc_params));
+	enc_params->key_id = cert_key;
+	enc_params->in_len = PLAINTEXT_SIZE;
+	enc_params->out_len = CIPHERTEXT_SIZE;
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_ENCRYPT, (unsigned long)enc_params,
+				    (unsigned long)"enc=pkcs1",
+				    (unsigned long)plaintext,
+				    (unsigned long)ciphertext),
+			     CIPHERTEXT_SIZE);
+	if (!TST_PASS)
+		return;
+
+	memset(dec_params, 0, sizeof(*dec_params));
+	dec_params->key_id = priv_key;
+	dec_params->in_len = CIPHERTEXT_SIZE;
+	dec_params->out_len = CIPHERTEXT_SIZE;
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_DECRYPT, (unsigned long)dec_params,
+				    (unsigned long)"enc=pkcs1",
+				    (unsigned long)ciphertext,
+				    (unsigned long)decrypted),
+			     PLAINTEXT_SIZE);
+	if (!TST_PASS)
+		return;
+
+	if (memcmp(plaintext, decrypted, PLAINTEXT_SIZE)) {
+		tst_res(TFAIL, "decrypted text does not match original plaintext");
+		return;
+	}
+
+	tst_res(TPASS, "KEYCTL_PKEY_ENCRYPT and KEYCTL_PKEY_DECRYPT roundtrip succeeded");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.20",
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_ASYMMETRIC_KEY_TYPE=y",
+		"CONFIG_X509_CERTIFICATE_PARSER",
+		"CONFIG_PKCS8_PRIVATE_KEY_PARSER",
+		"CONFIG_CRYPTO_RSA",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&enc_params, .size = sizeof(*enc_params)},
+		{&dec_params, .size = sizeof(*dec_params)},
+		{},
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
