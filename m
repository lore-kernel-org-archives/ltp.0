Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B9EC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:10:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEE7F3E8C54
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:10:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 399D43C72EC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA9A91400778
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1F3021D93;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOXj/k19oT9yqjMu0vGLZjvOLCg9h5iWqS2qEZ8XXEc=;
 b=VHi3hFdMYHksyZvDRnUtSpWq93AXiJmWZnMWNH9xSnVATwcCDNfSvr6biaPLSMDObn/58g
 /r9R8P6o57Yken47oL6/XdVO5YbmpsONKoAJPabVYfyaRu8Fgd6x7qnivgwLttoQ65qgOt
 Z8s4jv61ExHe74INOaVl/N72cVhI47s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOXj/k19oT9yqjMu0vGLZjvOLCg9h5iWqS2qEZ8XXEc=;
 b=jbiqRL1jFoO+T+ReZXHjBRV4oYhoPbHJ61/ncbCdRGcVHYk3fXHZX/W5QVx4BNPmz8wfS3
 /CGINS3VYrqasTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOXj/k19oT9yqjMu0vGLZjvOLCg9h5iWqS2qEZ8XXEc=;
 b=Kc13iWTO4w1OCHzNqqLVbnMNsPUmjdGh3XNbkB2FxrbYnBBzqHricX0lkD4lV2L3xjPX92
 i2mQh13xwSEdwkudwknmgk9SL8uxRitxJwmKNb2jx4xBO2UqawXj3juCfP77C/PcKlVjGI
 6sci/Xbex4iBmFUhAVDv/cKXFtX65JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOXj/k19oT9yqjMu0vGLZjvOLCg9h5iWqS2qEZ8XXEc=;
 b=ujIA+26GR4QtQgJjIobZvwQOFVS+TGLPT8WlfA7EX3j7gdCGcXxN9pOfqp4xjfuJLpZEfz
 Lbtv7f1osrWWlDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED44F137FE;
 Wed, 16 Sep 2026 14:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T29
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:54 +0200
Message-ID: <20260916140402.1797325-29-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 28/36] keyctl32: Test KEYCTL_PKEY_SIGN and VERIFY
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

Test public key signature creation and verification with
KEYCTL_PKEY_SIGN and KEYCTL_PKEY_VERIFY: sign a 32-byte digest
using an RSA-2048 PKCS#8 private key with enc=pkcs1, verify
the 256-byte signature with the matching X.509 public key,
and verify that a mismatched digest fails with EKEYREJECTED.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl32.c | 121 ++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl32.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a8c3486cb5..9c74b3db82 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -749,6 +749,7 @@ keyctl28 keyctl28
 keyctl29 keyctl29
 keyctl30 keyctl30
 keyctl31 keyctl31
+keyctl32 keyctl32
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 025dc27fc9..8b1627bee3 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -29,3 +29,4 @@
 /keyctl29
 /keyctl30
 /keyctl31
+/keyctl32
diff --git a/testcases/kernel/syscalls/keyctl/keyctl32.c b/testcases/kernel/syscalls/keyctl/keyctl32.c
new file mode 100644
index 0000000000..4a00225f6f
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl32.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_PKEY_SIGN`` and ``KEYCTL_PKEY_VERIFY`` of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_PKEY_SIGN`` signs a digest using an asymmetric private key and
+ * ``KEYCTL_PKEY_VERIFY`` verifies the signature using the matching public key.
+ *
+ * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
+ * ``pkcs8_key_parser`` modules.
+ *
+ * [Algorithm]
+ *
+ * - sign a 32-byte digest using an RSA-2048 PKCS#8 private key with
+ *   ``enc=pkcs1 hash=sha256``
+ * - verify the 256-byte signature using the matching X.509 public key
+ * - verify a mismatched digest fails verification with ``EKEYREJECTED``
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_pkey_data.h"
+#include "tst_module.h"
+
+#define DIGEST_SIZE	32
+#define SIG_SIZE	256
+
+static const unsigned char digest[DIGEST_SIZE] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+};
+
+static unsigned char sig[SIG_SIZE];
+static unsigned char wrong_digest[DIGEST_SIZE];
+
+static key_serial_t cert_key, priv_key;
+static struct keyctl_pkey_params *sign_params;
+static struct keyctl_pkey_params *verify_params;
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
+	memset(sig, 0, sizeof(sig));
+
+	memset(sign_params, 0, sizeof(*sign_params));
+	sign_params->key_id = priv_key;
+	sign_params->in_len = DIGEST_SIZE;
+	sign_params->out_len = SIG_SIZE;
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_SIGN, (unsigned long)sign_params,
+				    (unsigned long)"enc=pkcs1 hash=sha256",
+				    (unsigned long)digest,
+				    (unsigned long)sig),
+			     SIG_SIZE);
+	if (!TST_PASS)
+		return;
+
+	memset(verify_params, 0, sizeof(*verify_params));
+	verify_params->key_id = cert_key;
+	verify_params->in_len = DIGEST_SIZE;
+	verify_params->in2_len = SIG_SIZE;
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_VERIFY, (unsigned long)verify_params,
+				    (unsigned long)"enc=pkcs1 hash=sha256",
+				    (unsigned long)digest,
+				    (unsigned long)sig),
+			     0);
+	if (!TST_PASS)
+		return;
+
+	tst_res(TPASS, "KEYCTL_PKEY_SIGN and KEYCTL_PKEY_VERIFY roundtrip succeeded");
+
+	memcpy(wrong_digest, digest, sizeof(wrong_digest));
+	wrong_digest[0] ^= 0xff;
+
+	TST_EXP_FAIL(keyctl(KEYCTL_PKEY_VERIFY, (unsigned long)verify_params,
+			    (unsigned long)"enc=pkcs1 hash=sha256",
+			    (unsigned long)wrong_digest,
+			    (unsigned long)sig),
+		     EKEYREJECTED,
+		     "KEYCTL_PKEY_VERIFY with mismatched digest");
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
+		"CONFIG_CRYPTO_SHA256",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&sign_params, .size = sizeof(*sign_params)},
+		{&verify_params, .size = sizeof(*verify_params)},
+		{},
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
