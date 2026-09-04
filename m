Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1131EC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:15:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B179A3E1D87
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:15:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 965E83E976F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D77C0200AE9
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A271722B0D;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gUauShwARYK9UFRpnO6iZm1RvikuYvY9BkWJp2Snf4=;
 b=m4DY1eYG7reyH8bsu1BRCXjW6n5FvJHznVBO0LeLHFR4njD0/szhy7UZ3uWBX5ZyXG80lm
 spPDo97AJB+BlinBL7wTTLkcfzrxzT+Q8301VZX2G9RbMjJspU1/btdpIMSyZDb6wQjoxs
 o6t6y6xDfcRN99POA1SHzBBfEv2C/Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gUauShwARYK9UFRpnO6iZm1RvikuYvY9BkWJp2Snf4=;
 b=sBhVXZMNtRL9M8kHujdRYL0VaRB4IbshGGwQt86XIcwvloQJ3MYyADrmxW3jvAM8sR0ZSy
 2aVZdYWPOxipKqCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gUauShwARYK9UFRpnO6iZm1RvikuYvY9BkWJp2Snf4=;
 b=T4+FYbhuXDNUalIMNRXAcq27HV7D74i3WACOG+VupBAMprAIVLw8BaLj3yDLh6Gfr46O7C
 PkNrd78as/cPkeyWNqA5Y/F7VM+BfeHiEfzwxGpWYK2bm3RzDX1nO7TtsvadzR/g9nbv4y
 6MSNv1h9U/aTNwrxVHDJEu7RZicLTcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gUauShwARYK9UFRpnO6iZm1RvikuYvY9BkWJp2Snf4=;
 b=MSKoYm1TBat3Ag5VzLpQn52qZ5tI8tyVw/pjE70R1E0e/9SYoM53xGuEQ+MG0yiJf6PcEN
 XHBOetQct6jIA3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CE73139EB;
 Fri,  4 Sep 2026 12:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJfvE9m0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:13 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-24-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=4892;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1aGHGBPD9V6+iKmS5eXFWvDJUNYjUrnJUonEvM/oYTI=;
 b=yUI0NvPLSIOcec4jBDe/ltvzbMRiGgP1BNSU4wP16cZZrIBrOorbGAqgriSFqT66QJekc2G89
 R74cl6MV6NsDGMknI/WZ+EJOcfuaYqCHvIs9b77+8sEg1liuzH/zMAJ
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 24/33] keyctl31: Test KEYCTL_PKEY_ENCRYPT and
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl31.c | 110 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 15f8c892c..e43dd02ab 100644
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
index d5b6955f3..025dc27fc 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -28,3 +28,4 @@
 /keyctl28
 /keyctl29
 /keyctl30
+/keyctl31
diff --git a/testcases/kernel/syscalls/keyctl/keyctl31.c b/testcases/kernel/syscalls/keyctl/keyctl31.c
new file mode 100644
index 000000000..c1e6723ac
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
