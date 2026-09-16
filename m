Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3CDC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:10:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6053E806D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:10:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450D33E803E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7AE5110009B5
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C08481F74B;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi6b+IeFpr+BIKPhDCRFDegbZVT8iQWjjuI3rd8oO2U=;
 b=i0TVTR/tNE/h2xzW4lkDqjY4TuLXd0l6DsD1Svyas1ln7bB/CxTDb5d/1uW63SGIBy+2mR
 IuTm5yzsbhzVAuGBmW1PCAxmw5xf7nc6y8ymh3O8iJlQfUq1uJsQL1cFCw493Y9+L1P/WD
 Hz8GH+o6fRTVKLq71mv//ijfnGTSm5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi6b+IeFpr+BIKPhDCRFDegbZVT8iQWjjuI3rd8oO2U=;
 b=v+S6nJu/k/t8OZHB9ekOWN/H5vI817Hh7ajbemqmObRNFjfqVqex/pDn6Vx0TdwrrnxipG
 91EHApfvgmJiv5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi6b+IeFpr+BIKPhDCRFDegbZVT8iQWjjuI3rd8oO2U=;
 b=PZtKMmizd7kHVMiN0ksOKr0OCSm0r58yF3GfHk5h6nd+ZUmBGnJv+9VaKvO3XgnkufPSHP
 GR2NnbDIM1KeyL45btjrAPrFNWr5qyOfwHkDZmMhqyUNgBeI3HnxsIgsp3IC4DvpjpA6Nk
 sWjeCFdCgWb7z9+iSg31a8zd6wi5ozg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi6b+IeFpr+BIKPhDCRFDegbZVT8iQWjjuI3rd8oO2U=;
 b=W+eb0nibvd+Td/plUnWx2XG5/kUXz2JRpzcZu61lf5vXflH4U9J6JdVgvU/4KQe8OuVL6F
 Sw+zeKnhqippxWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83FD413888;
 Wed, 16 Sep 2026 14:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T30
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:55 +0200
Message-ID: <20260916140402.1797325-30-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 29/36] keyctl33: Negative tests for KEYCTL_PKEY_*
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

Add negative and boundary test cases for KEYCTL_PKEY_* operations
(QUERY, ENCRYPT, DECRYPT, SIGN, VERIFY), testing invalid key serials,
unsupported key types, invalid info strings, and buffer size limits.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl33.c | 247 ++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl33.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9c74b3db82..8b6dc16250 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -750,6 +750,7 @@ keyctl29 keyctl29
 keyctl30 keyctl30
 keyctl31 keyctl31
 keyctl32 keyctl32
+keyctl33 keyctl33
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 8b1627bee3..0f209d7e07 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -30,3 +30,4 @@
 /keyctl30
 /keyctl31
 /keyctl32
+/keyctl33
diff --git a/testcases/kernel/syscalls/keyctl/keyctl33.c b/testcases/kernel/syscalls/keyctl/keyctl33.c
new file mode 100644
index 0000000000..60404f2b16
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl33.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative and boundary test cases for ``KEYCTL_PKEY_*`` of :manpage:`keyctl(2)`.
+ *
+ * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
+ * ``pkcs8_key_parser`` modules.
+ *
+ * [Algorithm]
+ *
+ * - verify ``KEYCTL_PKEY_QUERY`` with non-zero ``arg3`` fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_QUERY`` with bogus key serial fails with ``ENOKEY``
+ * - verify ``KEYCTL_PKEY_QUERY`` with non-asymmetric key fails with ``EOPNOTSUPP``
+ * - verify ``KEYCTL_PKEY_QUERY`` with invalid info string fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_ENCRYPT`` with bogus key serial fails with ``ENOKEY``
+ * - verify ``KEYCTL_PKEY_ENCRYPT`` with non-asymmetric key fails with ``EOPNOTSUPP``
+ * - verify ``KEYCTL_PKEY_ENCRYPT`` with invalid info string fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_ENCRYPT`` with ``in_len`` exceeding limit fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_DECRYPT`` on public key certificate fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_DECRYPT`` with ``in_len`` exceeding limit fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_SIGN`` on public key certificate fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_SIGN`` with ``in_len`` exceeding limit fails with ``EINVAL``
+ * - verify ``KEYCTL_PKEY_VERIFY`` with non-asymmetric key fails with ``EOPNOTSUPP``
+ * - verify ``KEYCTL_PKEY_VERIFY`` with ``in2_len`` exceeding limit fails with ``EINVAL``
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_pkey_data.h"
+#include "tst_module.h"
+
+static key_serial_t cert_key, priv_key, user_key;
+static key_serial_t bogus_key = INT32_MAX;
+
+static struct keyctl_pkey_query *query_buf;
+static struct keyctl_pkey_params *params;
+
+static unsigned char in_buf[512];
+static unsigned char out_buf[512];
+
+static struct tcase {
+	int op;
+	key_serial_t *key;
+	unsigned long arg3;
+	const char *info;
+	uint32_t in_len;
+	uint32_t out_in2_len;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{
+		.op = KEYCTL_PKEY_QUERY,
+		.key = &cert_key,
+		.arg3 = 1,
+		.info = "enc=pkcs1",
+		.exp_errno = EINVAL,
+		.desc = "PKEY_QUERY with non-zero arg3",
+	},
+	{
+		.op = KEYCTL_PKEY_QUERY,
+		.key = &bogus_key,
+		.info = "enc=pkcs1",
+		.exp_errno = ENOKEY,
+		.desc = "PKEY_QUERY with bogus key serial",
+	},
+	{
+		.op = KEYCTL_PKEY_QUERY,
+		.key = &user_key,
+		.info = "enc=pkcs1",
+		.exp_errno = EOPNOTSUPP,
+		.desc = "PKEY_QUERY with non-asymmetric key",
+	},
+	{
+		.op = KEYCTL_PKEY_QUERY,
+		.key = &cert_key,
+		.info = "bogus_opt",
+		.exp_errno = EINVAL,
+		.desc = "PKEY_QUERY with invalid info string",
+	},
+	{
+		.op = KEYCTL_PKEY_ENCRYPT,
+		.key = &bogus_key,
+		.info = "enc=pkcs1",
+		.in_len = 32,
+		.out_in2_len = 256,
+		.exp_errno = ENOKEY,
+		.desc = "PKEY_ENCRYPT with bogus key serial",
+	},
+	{
+		.op = KEYCTL_PKEY_ENCRYPT,
+		.key = &user_key,
+		.info = "enc=pkcs1",
+		.in_len = 32,
+		.out_in2_len = 256,
+		.exp_errno = EOPNOTSUPP,
+		.desc = "PKEY_ENCRYPT with non-asymmetric key",
+	},
+	{
+		.op = KEYCTL_PKEY_ENCRYPT,
+		.key = &cert_key,
+		.info = "invalid_info",
+		.in_len = 32,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_ENCRYPT with invalid info string",
+	},
+	{
+		.op = KEYCTL_PKEY_ENCRYPT,
+		.key = &cert_key,
+		.info = "enc=pkcs1",
+		.in_len = 500,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_ENCRYPT with in_len exceeding limit",
+	},
+	{
+		.op = KEYCTL_PKEY_DECRYPT,
+		.key = &cert_key,
+		.info = "enc=pkcs1",
+		.in_len = 256,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_DECRYPT on public key certificate",
+	},
+	{
+		.op = KEYCTL_PKEY_DECRYPT,
+		.key = &priv_key,
+		.info = "enc=pkcs1",
+		.in_len = 500,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_DECRYPT with in_len exceeding limit",
+	},
+	{
+		.op = KEYCTL_PKEY_SIGN,
+		.key = &cert_key,
+		.info = "enc=pkcs1 hash=sha256",
+		.in_len = 32,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_SIGN on public key certificate",
+	},
+	{
+		.op = KEYCTL_PKEY_SIGN,
+		.key = &priv_key,
+		.info = "enc=pkcs1 hash=sha256",
+		.in_len = 500,
+		.out_in2_len = 256,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_SIGN with in_len exceeding limit",
+	},
+	{
+		.op = KEYCTL_PKEY_VERIFY,
+		.key = &user_key,
+		.info = "enc=pkcs1 hash=sha256",
+		.in_len = 32,
+		.out_in2_len = 256,
+		.exp_errno = EOPNOTSUPP,
+		.desc = "PKEY_VERIFY with non-asymmetric key",
+	},
+	{
+		.op = KEYCTL_PKEY_VERIFY,
+		.key = &cert_key,
+		.info = "enc=pkcs1 hash=sha256",
+		.in_len = 32,
+		.out_in2_len = 500,
+		.exp_errno = EINVAL,
+		.desc = "PKEY_VERIFY with in2_len exceeding limit",
+	},
+};
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	tst_modprobe("x509_key_parser", NULL);
+	tst_modprobe("pkcs8_key_parser", NULL);
+
+	user_key = SAFE_NEW_USER_KEY("ltp_user", "data", 4,
+				KEY_SPEC_PROCESS_KEYRING);
+
+	cert_key = add_asymmetric_key_or_tconf("cert", rsa2048_cert,
+					       sizeof(rsa2048_cert),
+					       "CONFIG_X509_CERTIFICATE_PARSER");
+	priv_key = add_asymmetric_key_or_tconf("priv", rsa2048_pkcs8,
+					       sizeof(rsa2048_pkcs8),
+					       "CONFIG_PKCS8_PRIVATE_KEY_PARSER");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (tc->op == KEYCTL_PKEY_QUERY) {
+		TST_EXP_FAIL(keyctl(KEYCTL_PKEY_QUERY, (unsigned long)*tc->key,
+				    tc->arg3, (unsigned long)tc->info,
+				    (unsigned long)query_buf),
+			     tc->exp_errno,
+			     "%s", tc->desc);
+		return;
+	}
+
+	memset(params, 0, sizeof(*params));
+	params->key_id = *tc->key;
+	params->in_len = tc->in_len;
+	params->out_len = tc->out_in2_len;
+
+	if (tc->op == KEYCTL_PKEY_VERIFY) {
+		TST_EXP_FAIL(keyctl(tc->op, (unsigned long)params,
+				    (unsigned long)tc->info,
+				    (unsigned long)in_buf,
+				    (unsigned long)out_buf),
+			     tc->exp_errno,
+			     "%s", tc->desc);
+	} else {
+		TST_EXP_FAIL2(keyctl(tc->op, (unsigned long)params,
+				     (unsigned long)tc->info,
+				     (unsigned long)in_buf,
+				     (unsigned long)out_buf),
+			      tc->exp_errno,
+			      "%s", tc->desc);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
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
+		{&query_buf, .size = sizeof(*query_buf)},
+		{&params, .size = sizeof(*params)},
+		{},
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
