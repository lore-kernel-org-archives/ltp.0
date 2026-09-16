Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2756AC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70AB33E7FA7
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:13:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 402A93E7AD0
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C49881400779
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BCF91FE57;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2CZNO0nI4Z+KQjSmr7B7hpnEWdH6uWR55vECAUDjNg=;
 b=RwguS+X5tSG9gvNDy7Y/xaST+jrBJ9c0OKV7FQkZftKY4efRBbfXdz4po8GIUAEPfBEYc0
 mU76h0eY9L+Nhz6Onh1Rk5EevyHm8kGYCF9xh6GacJhI6kziHVEHKLaED8jo9nvl4IDHZA
 YXS3S3N82J9Pd3X3xZlqb+3fEw6LjHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2CZNO0nI4Z+KQjSmr7B7hpnEWdH6uWR55vECAUDjNg=;
 b=YgGgBiEO5/K57zjb0/Wd9FnQuZ1HOykLKkl9+o/kMgYmduC1XJO4kSLjCFoCdeQoz4WjFc
 Jyiti0cv3tNtKUAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="AVI7/Efj";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PitEDggJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2CZNO0nI4Z+KQjSmr7B7hpnEWdH6uWR55vECAUDjNg=;
 b=AVI7/Efjm8lafLQqdX4Kx2lBEuzrmHY1VxVNnfsHfr7b38XqMPoLhmuFJHzNfT248KWK4I
 5n9XC8FMPy7RvHJMn+K0m+aKNtHzYumbeCehK83u7Rt4/CmFVvClcSoO8esud+LrKjGkud
 PXiP0BWvQvGalcxj41mqoxk4qXJ2+k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2CZNO0nI4Z+KQjSmr7B7hpnEWdH6uWR55vECAUDjNg=;
 b=PitEDggJe1yYi4DQpv70R0JIGwKZ12GPhgX9dd58G58Y6sesv6FqhE2PpgRZc2/KQhSTjt
 5w0dqGlJNf4JNICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DD9E139BB;
 Wed, 16 Sep 2026 14:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T24
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:49 +0200
Message-ID: <20260916140402.1797325-24-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BCF91FE57
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 23/36] keyctl28: Negative and boundary tests for
 KEYCTL_DH_COMPUTE
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

Test error and boundary conditions of KEYCTL_DH_COMPUTE using a
parameterized tcase table: buffer smaller than secret (EOVERFLOW),
bogus prime key (ENOKEY), non-user key (EOPNOTSUPP), NULL buffer
(EINVAL), non-zero __spare (EINVAL), buflen > 1024 (EMSGSIZE),
otherinfolen > 64 (EMSGSIZE), and unknown KDF hash name (ENOENT).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl28.c | 140 ++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl28.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a90138137f..6594dccb2d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -745,6 +745,7 @@ keyctl24 keyctl24
 keyctl25 keyctl25
 keyctl26 keyctl26
 keyctl27 keyctl27
+keyctl28 keyctl28
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 720ba1de65..139e480b39 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -25,3 +25,4 @@
 /keyctl25
 /keyctl26
 /keyctl27
+/keyctl28
diff --git a/testcases/kernel/syscalls/keyctl/keyctl28.c b/testcases/kernel/syscalls/keyctl/keyctl28.c
new file mode 100644
index 0000000000..4c7f6be17e
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl28.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative and boundary test cases for ``KEYCTL_DH_COMPUTE`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify ``EOVERFLOW`` when buffer is smaller than secret size (255 < 256)
+ * - verify ``ENOKEY`` when prime key id does not exist
+ * - verify ``EOPNOTSUPP`` when prime key is not of "user" type
+ * - verify ``EINVAL`` when buffer is ``NULL`` with non-zero buflen
+ * - verify ``EINVAL`` when KDF ``__spare`` field contains non-zero data
+ * - verify ``EMSGSIZE`` when KDF requested output length exceeds 1024
+ * - verify ``EMSGSIZE`` when KDF otherinfo length exceeds 64
+ * - verify ``ENOENT`` when KDF hash algorithm name is unknown
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_dh_data.h"
+
+static struct keyctl_dh_params *dh_params;
+static struct keyctl_dh_params *dh_bogus_prime;
+static struct keyctl_dh_params *dh_nonuser_prime;
+
+static struct keyctl_kdf_params *kdf_valid;
+static struct keyctl_kdf_params *kdf_spare_nonzero;
+static struct keyctl_kdf_params *kdf_oi_toolarge;
+static struct keyctl_kdf_params *kdf_unknown_hash;
+
+static unsigned char out_buf[1025];
+
+static struct tcase {
+	struct keyctl_dh_params **params;
+	void *buffer;
+	size_t buflen;
+	struct keyctl_kdf_params **kdf;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{ &dh_params, out_buf, 255, NULL,
+	  EOVERFLOW, "buffer smaller than secret size (255 < 256)" },
+
+	{ &dh_bogus_prime, out_buf, 256, NULL,
+	  ENOKEY, "bogus prime key ID" },
+
+	{ &dh_nonuser_prime, out_buf, 256, NULL,
+	  EOPNOTSUPP, "non-user key as prime parameter" },
+
+	{ &dh_params, NULL, 256, NULL,
+	  EINVAL, "NULL buffer with non-zero buflen" },
+
+	{ &dh_params, out_buf, 32, &kdf_spare_nonzero,
+	  EINVAL, "KDF non-zero __spare field" },
+
+	{ &dh_params, out_buf, 1025, &kdf_valid,
+	  EMSGSIZE, "KDF output length > 1024" },
+
+	{ &dh_params, out_buf, 32, &kdf_oi_toolarge,
+	  EMSGSIZE, "KDF otherinfolen > 64" },
+
+	{ &dh_params, out_buf, 32, &kdf_unknown_hash,
+	  ENOENT, "unknown KDF hash algorithm name" },
+};
+
+static void setup(void)
+{
+	key_serial_t key_priv, key_prime, key_base;
+
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key_priv = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				KEY_SPEC_PROCESS_KEYRING);
+	key_prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
+				 KEY_SPEC_PROCESS_KEYRING);
+	key_base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
+				KEY_SPEC_PROCESS_KEYRING);
+
+	dh_params->priv = key_priv;
+	dh_params->prime = key_prime;
+	dh_params->base = key_base;
+
+	*dh_bogus_prime = *dh_params;
+	dh_bogus_prime->prime = INT32_MAX;
+
+	*dh_nonuser_prime = *dh_params;
+	dh_nonuser_prime->prime = KEY_SPEC_PROCESS_KEYRING;
+
+	kdf_valid->hashname = "sha256";
+	kdf_valid->otherinfo = "info";
+	kdf_valid->otherinfolen = 4;
+
+	*kdf_spare_nonzero = *kdf_valid;
+	kdf_spare_nonzero->__spare[0] = 1;
+
+	*kdf_oi_toolarge = *kdf_valid;
+	kdf_oi_toolarge->otherinfolen = 65;
+
+	*kdf_unknown_hash = *kdf_valid;
+	kdf_unknown_hash->hashname = "sha9000";
+}
+
+static void verify_negative(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct keyctl_dh_params *p = *tc->params;
+	struct keyctl_kdf_params *kdf = tc->kdf ? *tc->kdf : NULL;
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)p,
+			     (unsigned long)tc->buffer, tc->buflen,
+			     (unsigned long)kdf),
+		      tc->exp_errno,
+		      "KEYCTL_DH_COMPUTE with %s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_negative,
+	.tcnt = ARRAY_SIZE(tcases),
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
+		{&dh_bogus_prime, .size = sizeof(*dh_bogus_prime)},
+		{&dh_nonuser_prime, .size = sizeof(*dh_nonuser_prime)},
+		{&kdf_valid, .size = sizeof(*kdf_valid)},
+		{&kdf_spare_nonzero, .size = sizeof(*kdf_spare_nonzero)},
+		{&kdf_oi_toolarge, .size = sizeof(*kdf_oi_toolarge)},
+		{&kdf_unknown_hash, .size = sizeof(*kdf_unknown_hash)},
+		{},
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
