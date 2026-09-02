Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E91C624D5
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53E673C6603
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:11:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 865C53E5888
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E1F361400DC6
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FD741FAAC;
 Wed,  2 Sep 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3yLAzj+YI7xWiNv6Bk0ucVMmhvLOO0344DqMVu7fEA=;
 b=yYkoustuwGv/MAuP8rttxtxHEQKYBd7ZPx6Udf54D1QcI6Frwpwnj6iDuRFpz1qV7pL1et
 un/FDHzVzZvCFTUh3M92mydZsbtZs4NBAx67+bN9YKgMhC20zqlgivUX8u6qOLSHQfJSsc
 lTbv9JXerorDFeiZYUJ3k/e5zwPJFbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3yLAzj+YI7xWiNv6Bk0ucVMmhvLOO0344DqMVu7fEA=;
 b=K3GlQc3zFMdSBWe8wE8kXk3opcXtGnQncRVwsOA8W+0xcVG9Nu/NC1pDrn/vIaiVmI+Ya7
 4EzDsVwTGM+1UIBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ry4U/IG/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w3+8K9Ja
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3yLAzj+YI7xWiNv6Bk0ucVMmhvLOO0344DqMVu7fEA=;
 b=ry4U/IG/kbh6s2VdpaAJ15/5argwCl+0R1Eg4W/aVe64Nd8J5IoxvlAohrlcErzl6qpIAy
 tUv95quJ2U6KenT9M4i/yRJMRqYgb0TeQnUNrtskNsN6wiCJTAq7RtWovPBaQo2aNq/esh
 FUA//28aFk0NMeExe0tWrmMBYJDs2X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3yLAzj+YI7xWiNv6Bk0ucVMmhvLOO0344DqMVu7fEA=;
 b=w3+8K9JaXbGqKLYZ/GbW0NNorr3/daP/GNBH/kEw7DcAg1MBidzx+3a5Gd0l3r2M7iSlS0
 m/Ep8corKoSLxqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4811398F;
 Wed,  2 Sep 2026 11:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WH0NCbkCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:34 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-19-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=4385;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=cMsxGKdowqKl89oPvXVJUNkRdqrLMCUQ1tlZ/MGKa/w=;
 b=/Ht2uc2DBC3SgBfbB8OMJ6xe6WNGkuvDrJesHjhx293ClrVqDdOVqYs7shQNpn7rPR2vfrDae
 P1fjvygPTcXCOVssSfUAFwD5g04xGP7vlRZk3Ef+4FPWAgUWxyPx2uP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9FD741FAAC
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 19/33] keyctl27: Test KEYCTL_DH_COMPUTE KDF key
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore       |  1 +
 testcases/kernel/syscalls/keyctl/keyctl27.c       | 78 +++++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl_dh_data.h |  5 ++
 4 files changed, 85 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 108efa4a8..d23461c4b 100644
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
index dd282b7ce..720ba1de6 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -24,3 +24,4 @@
 /keyctl24
 /keyctl25
 /keyctl26
+/keyctl27
diff --git a/testcases/kernel/syscalls/keyctl/keyctl27.c b/testcases/kernel/syscalls/keyctl/keyctl27.c
new file mode 100644
index 000000000..288bd0f37
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
+	dh_params->priv = new_user_key("dh_priv", dh_priv, sizeof(dh_priv),
+				       KEY_SPEC_PROCESS_KEYRING);
+	dh_params->prime = new_user_key("dh_prime", dh_prime, sizeof(dh_prime),
+					KEY_SPEC_PROCESS_KEYRING);
+	dh_params->base = new_user_key("dh_base", dh_base, sizeof(dh_base),
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
index bc1432dc3..7ac7876a0 100644
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
