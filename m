Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37298C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:10:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C2B3E60EA
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:10:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32713E93AA
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5C20600B42
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A653321E1E;
 Wed,  2 Sep 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AotBAKiMxyUEjk24rjZ4DdBNHZWVfZXC+Mbc9Qz1JHo=;
 b=zfrm1L1QvNMV5SyfH/MXiA5KANi8bXE19TkhrD4EZeRg4ERoayimSebqTDOyvyiIZi3sx2
 ZR83NTtX6veT5wjiT1R0JwaWw1kLrrzmSp0PJYy6PkK223sLCG4Jr2cQN8DacD84L/nQwN
 4LV209CssMCQBGwrkckX2EqtPcqE/aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AotBAKiMxyUEjk24rjZ4DdBNHZWVfZXC+Mbc9Qz1JHo=;
 b=YgWIzdcT+7FT6s4sxH0y2k+90CVN8s7Gc6061ey4FXUJM5Opwn6YKMd8Y+fxeHvYxGELut
 Nb86z77G89T4k9BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1nAIkF/D";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qM/tJte+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AotBAKiMxyUEjk24rjZ4DdBNHZWVfZXC+Mbc9Qz1JHo=;
 b=1nAIkF/DQihOTqLThzmdy7SMolKsflZjzQUqYywYWy5M0PbmOxJ9dJhuZqGv+C58jmjgUJ
 Ns0TxAvU5KWtJr07dlUls5giDib/wITIMNY+Gn1K4pGZqixhyUDvyMDGP/S5Eu08RcbW/m
 oCDftry4RCeRjHvGW9OPwYi90ua2Xno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AotBAKiMxyUEjk24rjZ4DdBNHZWVfZXC+Mbc9Qz1JHo=;
 b=qM/tJte+AtrM4YtJFMaSe5W6VAw1ASWZHyFlehUj1aWHQSp33uUlfRFDuBjI+NXMHze0Zh
 ikfAqe72+iS7p/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E9113991;
 Wed,  2 Sep 2026 11:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8LsAErkCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:35 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-20-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=5905;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1KaH7ZrpY9GmPfITScuKGa1b3Oi+tMI1dNLUb2/I6uY=;
 b=5F9hGYdBTNNkInvVjVW2I2n1cp83YkBmadr0GfEPcyBbkbeUkXi0XZCgx4xmFqUv4riT5LETm
 YN3DJ7a+hMmBTsCYiIgHu1hd9AEkZI65mUt7viOosjKkrZk38Ez2hWp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: A653321E1E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 20/33] keyctl28: Negative and boundary tests for
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl28.c | 140 ++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d23461c4b..6fdbbea17 100644
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
index 720ba1de6..139e480b3 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -25,3 +25,4 @@
 /keyctl25
 /keyctl26
 /keyctl27
+/keyctl28
diff --git a/testcases/kernel/syscalls/keyctl/keyctl28.c b/testcases/kernel/syscalls/keyctl/keyctl28.c
new file mode 100644
index 000000000..f62aeb582
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
+	key_priv = new_user_key("dh_priv", dh_priv, sizeof(dh_priv),
+				KEY_SPEC_PROCESS_KEYRING);
+	key_prime = new_user_key("dh_prime", dh_prime, sizeof(dh_prime),
+				 KEY_SPEC_PROCESS_KEYRING);
+	key_base = new_user_key("dh_base", dh_base, sizeof(dh_base),
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
