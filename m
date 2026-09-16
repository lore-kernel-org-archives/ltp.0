Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A5C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:11:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 462CD3E8C51
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:11:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFE563E8C48
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 273B96008DC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7539521BF7;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sp65SYblRi3w+a28Dlq9Toeq5tBvM7THNABeiAqhjg=;
 b=U0V12SCALilDIrySZBy6EcJnkLVREeYtJKZlrynWKL0ckmU8n+Z1AWvoJYVPcTch3fcxwk
 DYa1m4BqVG8K+4NDdxknnMk/NFZdu77EbAJ762RL2YRPDkkCAltB1viO1b1h8RszGXbnwv
 A82ZspN3JPRI7neMKSjYSysKEX0MtdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sp65SYblRi3w+a28Dlq9Toeq5tBvM7THNABeiAqhjg=;
 b=1fMqJ0EAUlVfI9KT4FFlA2b4BPFH7fVxTSpedT10BHch4w2Y9yljRTIeeFqvrSbri8cp59
 E4W9S6rGUBDAmuBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sp65SYblRi3w+a28Dlq9Toeq5tBvM7THNABeiAqhjg=;
 b=l6re0FNEq4VsAgU/W+L7bn4FHUdE71FJyHd6XcPaI+fVgAzQBjrEGeaTaw1qbYPd6wD7w1
 +q9VM5iOAwo+R46+1xqtNWo+IqKl4N8efuPHAyWOq3TQJsBDY90/kLWITrvloPbhFnt+AD
 5onILfjTOOufUvQJCXZqIjYoUX63Dmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sp65SYblRi3w+a28Dlq9Toeq5tBvM7THNABeiAqhjg=;
 b=MgfjuP/CbqkzOsaE7yVmMpIUDSxoPPp7XFutwlW3YYhz2KpxvnLv39mgC1UTuFuS3BdJ2a
 /OuVDnQM6geg7UCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ACFB1348F;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T26
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:51 +0200
Message-ID: <20260916140402.1797325-26-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 25/36] keyctl29: Test KEYCTL_PKEY_QUERY on public
 key
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

Test KEYCTL_PKEY_QUERY operation on an RSA-2048 X.509 public key
certificate: verify key_size is 2048, supported_ops contains
ENCRYPT and VERIFY, and max_enc_size/max_sig_size are 256.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore   |  1 +
 testcases/kernel/syscalls/keyctl/keyctl29.c   | 90 +++++++++++++++++++
 .../kernel/syscalls/keyctl/keyctl_common.h    | 20 +++++
 .../kernel/syscalls/keyctl/keyctl_pkey_data.h | 68 ++++++++++++++
 5 files changed, 180 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl29.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl_pkey_data.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 6594dccb2d..c41321b407 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -746,6 +746,7 @@ keyctl25 keyctl25
 keyctl26 keyctl26
 keyctl27 keyctl27
 keyctl28 keyctl28
+keyctl29 keyctl29
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 139e480b39..91310b0018 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -26,3 +26,4 @@
 /keyctl26
 /keyctl27
 /keyctl28
+/keyctl29
diff --git a/testcases/kernel/syscalls/keyctl/keyctl29.c b/testcases/kernel/syscalls/keyctl/keyctl29.c
new file mode 100644
index 0000000000..8fee5fb082
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl29.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_PKEY_QUERY`` on public key of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_PKEY_QUERY`` queries the parameters, operations, and buffer
+ * size limits of an asymmetric public or private key.
+ *
+ * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` module.
+ *
+ * [Algorithm]
+ *
+ * - query an RSA-2048 X.509 public key certificate
+ * - verify ``key_size`` is 2048 bits
+ * - verify ``supported_ops`` contains ``KEYCTL_SUPPORTS_ENCRYPT`` and
+ *   ``KEYCTL_SUPPORTS_VERIFY``
+ * - verify ``max_enc_size`` is 256 bytes
+ * - verify ``max_sig_size`` is 256 bytes
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_pkey_data.h"
+#include "tst_module.h"
+
+static key_serial_t cert_key;
+static struct keyctl_pkey_query *query_buf;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	tst_modprobe("x509_key_parser", NULL);
+
+	cert_key = add_asymmetric_key_or_tconf("cert", rsa2048_cert,
+					       sizeof(rsa2048_cert),
+					       "CONFIG_X509_CERTIFICATE_PARSER");
+}
+
+static void run(void)
+{
+	memset(query_buf, 0, sizeof(*query_buf));
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_QUERY, (unsigned long)cert_key,
+				    0, (unsigned long)"enc=pkcs1",
+				    (unsigned long)query_buf), 0);
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LU_SILENT(query_buf->key_size, 2048);
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EXPR(query_buf->supported_ops & KEYCTL_SUPPORTS_ENCRYPT,
+		     "KEYCTL_PKEY_QUERY supports ENCRYPT");
+
+	TST_EXP_EXPR(query_buf->supported_ops & KEYCTL_SUPPORTS_VERIFY,
+		     "KEYCTL_PKEY_QUERY supports VERIFY");
+
+	TST_EXP_EQ_LU_SILENT(query_buf->max_enc_size, 256);
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LU_SILENT(query_buf->max_sig_size, 256);
+	if (!TST_PASS)
+		return;
+
+	tst_res(TPASS, "KEYCTL_PKEY_QUERY on X.509 cert returned valid parameters");
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
+		"CONFIG_CRYPTO_RSA",
+		"CONFIG_CRYPTO_SHA256",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&query_buf, .size = sizeof(*query_buf)},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_common.h b/testcases/kernel/syscalls/keyctl/keyctl_common.h
index 1465824334..95e3d173a1 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl_common.h
+++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
@@ -39,4 +39,24 @@ static inline bool is_asym_supported(key_serial_t ring_builtin)
 	return !(TST_RET == -1 && TST_ERR == ENOKEY);
 }
 
+static inline key_serial_t add_asymmetric_key_or_tconf(const char *desc,
+						       const void *payload,
+						       size_t plen,
+						       const char *parser_kconfig)
+{
+	TEST(add_key("asymmetric", desc, payload, plen, KEY_SPEC_PROCESS_KEYRING));
+	if (TST_RET >= 0)
+		return TST_RET;
+
+	if (TST_ERR == ENODEV)
+		tst_brk(TCONF, "kernel does not support asymmetric keys");
+	if (TST_ERR == EBADMSG)
+		tst_brk(TCONF, "missing asymmetric parser (%s)", parser_kconfig);
+	if (TST_ERR == ENOENT)
+		tst_brk(TCONF, "missing crypto RSA / SHA256 algorithms");
+
+	tst_brk(TBROK | TTERRNO, "failed to add asymmetric key '%s'", desc);
+	return -1;
+}
+
 #endif /* KEYCTL_COMMON_H__ */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_pkey_data.h b/testcases/kernel/syscalls/keyctl/keyctl_pkey_data.h
new file mode 100644
index 0000000000..f5e55d94e0
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl_pkey_data.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ *
+ * Static test vectors for KEYCTL_PKEY_* tests (keyctl29..keyctl33).
+ */
+
+#ifndef KEYCTL_PKEY_DATA_H__
+#define KEYCTL_PKEY_DATA_H__
+
+/*
+ * RSA-2048 self-signed X.509 certificate in DER format generated using:
+ * openssl req -x509 -newkey rsa:2048 -subj "/CN=ltp-keyctl-pkey" -days 36500 -nodes -batch -outform der
+ */
+static const unsigned char rsa2048_cert[] = {
+	0x30, 0x82, 0x03, 0x17, 0x30, 0x82, 0x01, 0xff, 0xa0, 0x03, 0x02, 0x01, 0x02, 0x02, 0x14, 0x52,
+	0xd4, 0x3e, 0xcb, 0x8a, 0x14, 0xa8, 0x5b, 0x02, 0x72, 0x3b, 0x64, 0xf9, 0x9d, 0x52, 0xa3, 0xca,
+	0x61, 0x08, 0x78, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x0b,
+	0x05, 0x00, 0x30, 0x1a, 0x31, 0x18, 0x30, 0x16, 0x06, 0x03, 0x55, 0x04, 0x03, 0x0c, 0x0f, 0x6c,
+	0x74, 0x70, 0x2d, 0x6b, 0x65, 0x79, 0x63, 0x74, 0x6c, 0x2d, 0x70, 0x6b, 0x65, 0x79, 0x30, 0x20,
+	0x17, 0x0d, 0x32, 0x36, 0x30, 0x39, 0x30, 0x31, 0x30, 0x39, 0x31, 0x31, 0x32, 0x36, 0x5a, 0x18,
+	0x0f, 0x32, 0x31, 0x32, 0x36, 0x30, 0x38, 0x30, 0x38, 0x30, 0x39, 0x31, 0x31, 0x32, 0x36, 0x5a,
+	0x30, 0x1a, 0x31, 0x18, 0x30, 0x16, 0x06, 0x03, 0x55, 0x04, 0x03, 0x0c, 0x0f, 0x6c, 0x74, 0x70,
+	0x2d, 0x6b, 0x65, 0x79, 0x63, 0x74, 0x6c, 0x2d, 0x70, 0x6b, 0x65, 0x79, 0x30, 0x82, 0x01, 0x22,
+	0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03,
+	0x82, 0x01, 0x0f, 0x00, 0x30, 0x82, 0x01, 0x0a, 0x02, 0x82, 0x01, 0x01, 0x00, 0xd3, 0x97, 0x61,
+	0x14, 0x08, 0xb7, 0xca, 0x73, 0x54, 0xd0, 0x39, 0xb9, 0xaf, 0x62, 0x12, 0xcc, 0x90, 0xde, 0x86,
+	0xeb, 0x13, 0x91, 0x06, 0x83, 0xf3, 0x41, 0x48, 0xd7, 0xf7, 0xc5, 0x50, 0x26, 0x1f, 0x2d, 0x53,
+	0x09, 0x43, 0x59, 0x25, 0x81, 0x04, 0x98, 0x84, 0x4c, 0x10, 0x32, 0xee, 0x63, 0x60, 0xde, 0x1a,
+	0x76, 0x63, 0xc3, 0x5d, 0x79, 0x12, 0xf2, 0xbf, 0x33, 0xd6, 0x4c, 0xf2, 0x47, 0x56, 0x03, 0x41,
+	0x51, 0x74, 0x7f, 0x7d, 0x80, 0x64, 0x32, 0x1c, 0x1c, 0x19, 0xac, 0x12, 0x08, 0xd6, 0xd2, 0x27,
+	0x21, 0x6c, 0xda, 0x40, 0xea, 0x3b, 0x9c, 0x7f, 0xa8, 0xee, 0x86, 0x0a, 0x18, 0xca, 0xc3, 0xb6,
+	0x6a, 0xe8, 0x90, 0xcc, 0xaf, 0x44, 0x1c, 0x03, 0xdd, 0x57, 0xfc, 0x67, 0xba, 0xae, 0x5b, 0x7b,
+	0x3e, 0xc3, 0xda, 0xcc, 0xcf, 0x96, 0x90, 0xad, 0x72, 0x4d, 0x44, 0x7d, 0x46, 0xa5, 0x7c, 0x83,
+	0x4b, 0x74, 0x5d, 0x16, 0x20, 0x33, 0x4b, 0x8a, 0xdf, 0x8b, 0x14, 0x21, 0x6f, 0xbb, 0xb3, 0xd9,
+	0x97, 0xef, 0xd2, 0xbf, 0x4f, 0x41, 0x01, 0x86, 0x69, 0xa0, 0xe6, 0xce, 0x7b, 0xdd, 0xb9, 0x5c,
+	0x35, 0xce, 0x2f, 0x0c, 0x5d, 0x23, 0x60, 0x71, 0xd7, 0x09, 0x05, 0x1c, 0x70, 0xb4, 0x02, 0xaf,
+	0x75, 0xb6, 0xcd, 0x2f, 0xbf, 0xba, 0xd0, 0x35, 0xc6, 0xd0, 0x09, 0x50, 0xcf, 0xf9, 0xd9, 0xe8,
+	0xdc, 0x3b, 0xca, 0x19, 0x45, 0x63, 0x1c, 0x88, 0xc9, 0x4c, 0xa7, 0x09, 0xe6, 0x2c, 0x7e, 0x81,
+	0xd0, 0x06, 0xe4, 0x37, 0xb9, 0x42, 0xc9, 0x3b, 0x5c, 0xb5, 0x70, 0xc4, 0xb5, 0x20, 0x14, 0xa1,
+	0x51, 0x37, 0xf2, 0x58, 0xa8, 0x9c, 0x11, 0xc1, 0x70, 0xe6, 0xb0, 0x45, 0xf3, 0xc5, 0x23, 0xe7,
+	0xee, 0xa7, 0x9d, 0x9b, 0x2b, 0x81, 0xef, 0xeb, 0x63, 0xf2, 0x93, 0x15, 0x21, 0x02, 0x03, 0x01,
+	0x00, 0x01, 0xa3, 0x53, 0x30, 0x51, 0x30, 0x1d, 0x06, 0x03, 0x55, 0x1d, 0x0e, 0x04, 0x16, 0x04,
+	0x14, 0x19, 0x69, 0xa7, 0x0c, 0x58, 0xc5, 0xd7, 0xb3, 0x0b, 0x26, 0xce, 0x2a, 0x34, 0x65, 0xae,
+	0xa7, 0xad, 0xf6, 0xab, 0x74, 0x30, 0x1f, 0x06, 0x03, 0x55, 0x1d, 0x23, 0x04, 0x18, 0x30, 0x16,
+	0x80, 0x14, 0x19, 0x69, 0xa7, 0x0c, 0x58, 0xc5, 0xd7, 0xb3, 0x0b, 0x26, 0xce, 0x2a, 0x34, 0x65,
+	0xae, 0xa7, 0xad, 0xf6, 0xab, 0x74, 0x30, 0x0f, 0x06, 0x03, 0x55, 0x1d, 0x13, 0x01, 0x01, 0xff,
+	0x04, 0x05, 0x30, 0x03, 0x01, 0x01, 0xff, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
+	0x0d, 0x01, 0x01, 0x0b, 0x05, 0x00, 0x03, 0x82, 0x01, 0x01, 0x00, 0x01, 0x8a, 0x1b, 0x54, 0x91,
+	0xbb, 0xf6, 0xd9, 0xc5, 0x09, 0x4c, 0x9f, 0xd2, 0x64, 0xaf, 0xcf, 0x4e, 0x45, 0xda, 0xc6, 0x31,
+	0x0f, 0x55, 0x7d, 0xe7, 0x83, 0xa1, 0xfe, 0x51, 0x42, 0xda, 0xb4, 0x8b, 0xba, 0xf7, 0x15, 0xae,
+	0xde, 0xf3, 0x05, 0x44, 0xb7, 0xc2, 0x40, 0x03, 0x33, 0x88, 0x2b, 0x32, 0xee, 0x13, 0x3b, 0x50,
+	0xb4, 0x38, 0x32, 0x3b, 0xa6, 0xdf, 0x58, 0x6a, 0x46, 0x48, 0x0d, 0xbc, 0x4a, 0xbf, 0xce, 0xb5,
+	0x98, 0x7f, 0x5c, 0xcb, 0x04, 0xa8, 0xbf, 0x7b, 0x28, 0x04, 0xcf, 0x3b, 0xaa, 0x4d, 0x16, 0xb8,
+	0x5f, 0x0a, 0x60, 0xca, 0xde, 0xe1, 0x87, 0x1a, 0x40, 0xc1, 0x2c, 0x93, 0x29, 0x30, 0x79, 0x21,
+	0xca, 0xa3, 0x58, 0xea, 0x8d, 0x93, 0x96, 0x17, 0x69, 0xa9, 0xaf, 0x16, 0xaf, 0x6f, 0x44, 0x6a,
+	0x4e, 0x59, 0x9d, 0x4d, 0x8e, 0x69, 0x7a, 0x11, 0x62, 0xbc, 0x99, 0x7e, 0x8e, 0xa6, 0x70, 0x2a,
+	0x7b, 0xbb, 0x33, 0xde, 0x81, 0x22, 0x6d, 0x7f, 0x18, 0xa6, 0x25, 0x1f, 0x84, 0x03, 0x9b, 0x8e,
+	0x88, 0x1b, 0x5c, 0x08, 0xf8, 0xb1, 0xf1, 0x27, 0x39, 0xbb, 0x06, 0x6c, 0x54, 0xfa, 0xb9, 0x9c,
+	0xe1, 0x5b, 0xff, 0xc1, 0xf2, 0x24, 0xf0, 0x79, 0xbd, 0xb1, 0x9f, 0xa5, 0xb8, 0x9c, 0x11, 0x96,
+	0x6b, 0xa1, 0x05, 0x64, 0x41, 0x45, 0x56, 0xf3, 0x5b, 0x51, 0x5d, 0x7f, 0x5d, 0x50, 0x15, 0x48,
+	0xd0, 0x68, 0x87, 0x8a, 0x39, 0x86, 0xae, 0x03, 0xdd, 0x2a, 0x7f, 0x48, 0x25, 0x7b, 0xde, 0xd4,
+	0x8b, 0x3c, 0xba, 0x07, 0xc6, 0x53, 0xbb, 0x2b, 0x67, 0x98, 0x00, 0xc5, 0x5d, 0x38, 0xc0, 0xc4,
+	0x51, 0x8e, 0x24, 0xc9, 0x85, 0x83, 0xb3, 0x16, 0x79, 0x7c, 0xcc, 0x76, 0xed, 0x02, 0x1f, 0x91,
+	0x2c, 0xa7, 0x23, 0xae, 0x7b, 0xfd, 0xd5, 0x09, 0x09, 0x70, 0x28,
+};
+
+#endif /* KEYCTL_PKEY_DATA_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
