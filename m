Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D41C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E0AC3E1D87
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:13:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EAEF3E978F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8723601FFB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3006E1FFF9;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmDJfpbt3FqPWs4yDng/EN2Koqfjjt+NHhTv+LvxaxA=;
 b=TkZnoB/yhfHJ4vQ+BnBVig9093oQLI0U8BC3lVwWeR5zDfInctXb8svuKDLFnkLl8c1xOR
 lOSEI6/ViWqV7ZaVk/yN9fXKrEHQWYKJAM37U873WvXRc8O/ioTNGa8H7fu7iK/BocqT7x
 K+MfO2kxtYdgHjTRJXz0KFpFzm4LoQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmDJfpbt3FqPWs4yDng/EN2Koqfjjt+NHhTv+LvxaxA=;
 b=AunTlXiyfrewTWucrQoteVwDZtnGJrEBBFbRPQM4jOti8gIM/o0avSXUZtCHhb8AxARjGV
 oLv5Ry69YEomHqBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rk1cfkXr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iYIjqWjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmDJfpbt3FqPWs4yDng/EN2Koqfjjt+NHhTv+LvxaxA=;
 b=rk1cfkXrYyeowVrxXM15U2r8Rx13DrGy75HUsV7En72bdkL7MMBaSpDoM/dx7rP+vwINIL
 dpSi4gLfc8Rpq2ogx9AWSJueaIp6WE28Tv3rRLHyNGW82r4wALZyF3BIoD4TYmhyaYnKxp
 XOvtlAJPykvS6aUoFu8QNNlzHOWUPqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmDJfpbt3FqPWs4yDng/EN2Koqfjjt+NHhTv+LvxaxA=;
 b=iYIjqWjMWZvM5Hy5fNJujULzD0esarUAycAEwcSbqoX0xyp0V/dJyC5JWRqo+Ae4Th8r9b
 3nPW6mD0MD6YefBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2111139B6;
 Fri,  4 Sep 2026 12:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wBHnKNe0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:06 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-17-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=9045;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=By2b610OoV7I0u9oMWyqVGbudSZrGISKpfW8d4GVkwc=;
 b=DRUzr8SA3fcBOd4NF337lPDnMzTAxsWHVMfucTOzehxdBplCqLMeIUpxBUWl6Trv99n5SO/0L
 l0EgLYTSwS0D+A5iVMJKcjF6K2gUc/fo82Q2W38iZFrLAW3JrfUWL3e
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3006E1FFF9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 17/33] keyctl25: Test KEYCTL_DH_COMPUTE shared
 secret computation
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

Test KEYCTL_DH_COMPUTE shared secret computation: verify that
computing a 256-byte DH shared secret with RFC 7919 FFDHE-2048
parameters matches the precomputed mathematical value.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore       |  1 +
 testcases/kernel/syscalls/keyctl/keyctl25.c       | 66 ++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl_dh_data.h | 74 +++++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index be35e9f93..1b059f652 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -742,6 +742,7 @@ keyctl21 keyctl21
 keyctl22 keyctl22
 keyctl23 keyctl23
 keyctl24 keyctl24
+keyctl25 keyctl25
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 767ccf61a..4cf772558 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -22,3 +22,4 @@
 /keyctl22
 /keyctl23
 /keyctl24
+/keyctl25
diff --git a/testcases/kernel/syscalls/keyctl/keyctl25.c b/testcases/kernel/syscalls/keyctl/keyctl25.c
new file mode 100644
index 000000000..f2d94a9f0
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl25.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DH_COMPUTE`` shared secret computation of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - compute DH shared secret using RFC 7919 FFDHE-2048 parameters and
+ *   verify the 256-byte result matches the expected secret
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_dh_data.h"
+
+static struct keyctl_dh_params *dh_params;
+static unsigned char out_buf[256];
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
+	memset(out_buf, 0, sizeof(out_buf));
+
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)dh_params,
+				    (unsigned long)out_buf,
+				    sizeof(dh_expected_secret), 0),
+			     (long)sizeof(dh_expected_secret));
+	if (!TST_PASS)
+		return;
+
+	if (memcmp(out_buf, dh_expected_secret, sizeof(dh_expected_secret))) {
+		tst_res(TFAIL, "computed secret does not match expected value");
+		return;
+	}
+
+	tst_res(TPASS, "KEYCTL_DH_COMPUTE computed expected shared secret");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.7",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_KEY_DH_OPERATIONS=y",
+		"CONFIG_CRYPTO_DH",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&dh_params, .size = sizeof(*dh_params)},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h b/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
new file mode 100644
index 000000000..bc1432dc3
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl_dh_data.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ *
+ * Static test vectors for KEYCTL_DH_COMPUTE tests (keyctl25..keyctl28).
+ */
+
+#ifndef KEYCTL_DH_DATA_H__
+#define KEYCTL_DH_DATA_H__
+
+/* RFC 7919 2048-bit FFDHE Group parameters (ffdhe2048) */
+static const unsigned char dh_prime[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc9, 0x0f, 0xda, 0xa2, 0x21, 0x68, 0xc2, 0x34,
+	0xc4, 0xc6, 0x62, 0x8b, 0x80, 0xdc, 0x1c, 0xd1, 0x29, 0x02, 0x4e, 0x08, 0x8a, 0x67, 0xcc, 0x74,
+	0x02, 0x0b, 0xbe, 0xa6, 0x3b, 0x13, 0x9b, 0x22, 0x51, 0x4a, 0x08, 0x79, 0x8e, 0x34, 0x04, 0xdd,
+	0xef, 0x95, 0x19, 0xb3, 0xcd, 0x3a, 0x43, 0x1b, 0x30, 0x2b, 0x0a, 0x6d, 0xf2, 0x5f, 0x14, 0x37,
+	0x4f, 0xe1, 0x35, 0x6d, 0x6d, 0x51, 0xc2, 0x45, 0xe4, 0x85, 0xb5, 0x76, 0x62, 0x5e, 0x7e, 0xc6,
+	0xf4, 0x4c, 0x42, 0xe9, 0xa6, 0x37, 0xed, 0x6b, 0x0b, 0xff, 0x5c, 0xb6, 0xf4, 0x06, 0xb7, 0xed,
+	0xee, 0x38, 0x6b, 0xfb, 0x5a, 0x89, 0x9f, 0xa5, 0xae, 0x9f, 0x24, 0x11, 0x7c, 0x4b, 0x1f, 0xe6,
+	0x49, 0x28, 0x66, 0x51, 0xec, 0xe4, 0x5b, 0x3d, 0xc2, 0x00, 0x7c, 0xb8, 0xa1, 0x63, 0xbf, 0x05,
+	0x98, 0xda, 0x48, 0x36, 0x1c, 0x55, 0xd3, 0x9a, 0x69, 0x16, 0x3f, 0xa8, 0xfd, 0x24, 0xcf, 0x5f,
+	0x83, 0x65, 0x5d, 0x23, 0xdc, 0xa3, 0xad, 0x96, 0x1c, 0x62, 0xf3, 0x56, 0x20, 0x85, 0x52, 0xbb,
+	0x9e, 0xd5, 0x29, 0x07, 0x70, 0x96, 0x96, 0x6d, 0x67, 0x0c, 0x35, 0x4e, 0x4a, 0xbc, 0x98, 0x04,
+	0xf1, 0x74, 0x6c, 0x08, 0xca, 0x18, 0x21, 0x7c, 0x32, 0x90, 0x5e, 0x46, 0x2e, 0x36, 0xce, 0x3b,
+	0xe3, 0x9e, 0x77, 0x2c, 0x18, 0x0e, 0x86, 0x03, 0x9b, 0x27, 0x83, 0xa2, 0xec, 0x07, 0xa2, 0x8f,
+	0xb5, 0xc5, 0x5d, 0xf0, 0x6f, 0x4c, 0x52, 0xc9, 0xde, 0x2b, 0xcb, 0xf6, 0x95, 0x58, 0x17, 0x18,
+	0x39, 0x95, 0x49, 0x7c, 0xea, 0x95, 0x6a, 0xe5, 0x15, 0xd2, 0x26, 0x18, 0x98, 0xfa, 0x05, 0x10,
+	0x15, 0x72, 0x8e, 0x5a, 0x8a, 0xac, 0xaa, 0x68, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+static const unsigned char dh_priv[] = {
+	0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+	0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+};
+
+static const unsigned char dh_base[] = {
+	0xdd, 0x5d, 0x87, 0xa6, 0xf9, 0xdf, 0x57, 0xf1, 0x3d, 0xf2, 0xc6, 0x58, 0xe5, 0x01, 0xab, 0xd7,
+	0x2a, 0xdb, 0xa3, 0x48, 0x63, 0x61, 0x3b, 0xd1, 0x67, 0x69, 0xee, 0xf9, 0x55, 0x25, 0x8e, 0x36,
+	0x11, 0xee, 0x8e, 0xc5, 0x42, 0xa4, 0x26, 0xe3, 0x75, 0xc6, 0xb4, 0xd8, 0x3b, 0x71, 0x7c, 0x97,
+	0xf8, 0x85, 0x04, 0xb4, 0x3a, 0xcc, 0x5d, 0xf0, 0x3a, 0x49, 0x04, 0xe8, 0x8d, 0x26, 0x19, 0xdf,
+	0xb7, 0xfb, 0x3c, 0xda, 0x68, 0xbc, 0x13, 0x6c, 0x46, 0x8d, 0xfe, 0xdf, 0x1c, 0x5a, 0x5b, 0x73,
+	0x04, 0x64, 0x08, 0x86, 0x6f, 0xec, 0x89, 0x49, 0xbe, 0xb5, 0x87, 0xa0, 0xa4, 0xb6, 0xe6, 0xc0,
+	0xde, 0xf5, 0xf2, 0x44, 0x05, 0x38, 0x51, 0x84, 0xa6, 0x9e, 0x9d, 0xce, 0x42, 0x08, 0xf3, 0x63,
+	0xad, 0xb0, 0xe1, 0xce, 0x88, 0x18, 0x63, 0xeb, 0x8d, 0x82, 0xd4, 0xae, 0xad, 0x5e, 0x1c, 0x19,
+	0x50, 0x47, 0xd7, 0x0d, 0x9b, 0xdc, 0x44, 0x7b, 0xda, 0x02, 0x76, 0x84, 0xb4, 0x35, 0x1d, 0x98,
+	0x50, 0x3f, 0xee, 0x1b, 0xcf, 0x82, 0x7f, 0xfd, 0x07, 0x50, 0x17, 0x01, 0xc7, 0xf3, 0x91, 0x24,
+	0x22, 0xdd, 0x2f, 0x42, 0xb2, 0x6c, 0xf4, 0x0a, 0xdd, 0xe0, 0x7d, 0x63, 0xe2, 0x35, 0xf4, 0x2f,
+	0x65, 0x21, 0x40, 0x2a, 0x90, 0xdd, 0x2c, 0xea, 0x4a, 0x2e, 0x17, 0x76, 0x40, 0x74, 0x2d, 0x3c,
+	0xac, 0x85, 0x3e, 0x96, 0xfa, 0x49, 0x44, 0x13, 0xfe, 0xe9, 0x45, 0x97, 0x2b, 0x24, 0x23, 0xa0,
+	0xf5, 0x1b, 0xec, 0xf2, 0x85, 0x28, 0xc9, 0xdb, 0x92, 0x60, 0x02, 0xc5, 0x0f, 0xfe, 0x2b, 0x1a,
+	0x97, 0xc9, 0x78, 0xcf, 0x48, 0x8b, 0xa2, 0x9b, 0xbb, 0x47, 0x2e, 0x7e, 0x63, 0x28, 0x2d, 0xdd,
+	0x32, 0x0a, 0x15, 0xa0, 0x72, 0xd8, 0x17, 0x60, 0x75, 0x20, 0x4f, 0x7d, 0xed, 0x29, 0x35, 0x61,
+};
+
+static const unsigned char dh_expected_secret[] = {
+	0x61, 0xfc, 0x0d, 0x4d, 0x01, 0xce, 0xe1, 0x52, 0x34, 0x0f, 0x52, 0xb4, 0x53, 0x28, 0xaa, 0x11,
+	0xd8, 0x6e, 0x92, 0xce, 0x8e, 0x8f, 0x7b, 0xa2, 0x91, 0x80, 0xf6, 0x2d, 0x99, 0x9b, 0xc7, 0x71,
+	0x4c, 0xbb, 0x05, 0xef, 0xde, 0x22, 0xbd, 0xdf, 0x6f, 0x8d, 0xbb, 0x00, 0xdf, 0x4e, 0xfa, 0x1c,
+	0x14, 0xea, 0x54, 0x20, 0xac, 0xec, 0x51, 0xcd, 0xbd, 0xd0, 0x63, 0xfc, 0x35, 0x7b, 0xd9, 0xab,
+	0x36, 0x7f, 0x1b, 0x67, 0xc3, 0xb1, 0x51, 0x4e, 0x2d, 0x19, 0x05, 0x50, 0xbe, 0x1d, 0x44, 0x51,
+	0x5f, 0xfe, 0x65, 0xf8, 0xf6, 0x12, 0xad, 0x6c, 0xc5, 0x84, 0x96, 0xd9, 0xc3, 0xc9, 0x39, 0x7d,
+	0x87, 0x98, 0xa7, 0x8e, 0x52, 0x4d, 0x1f, 0x26, 0xbe, 0x62, 0x14, 0xf4, 0x66, 0xcf, 0x9a, 0x90,
+	0x4d, 0x28, 0xdd, 0x29, 0x11, 0x6e, 0x51, 0x0c, 0x7b, 0x18, 0x1e, 0xac, 0x55, 0x49, 0xce, 0x1d,
+	0xef, 0xcc, 0x6c, 0xa2, 0x0e, 0x80, 0xd3, 0x0d, 0x24, 0xc0, 0x77, 0x68, 0x87, 0xf8, 0xa3, 0x05,
+	0x0f, 0x8d, 0xaa, 0x58, 0x6b, 0xbb, 0x6b, 0xd0, 0x76, 0xea, 0x87, 0x5c, 0xc3, 0x3e, 0xef, 0x19,
+	0x66, 0x9e, 0xc7, 0xd4, 0x4e, 0x85, 0xdf, 0x06, 0x61, 0x0b, 0x94, 0x9c, 0xd3, 0x58, 0x23, 0xa7,
+	0xb1, 0xf6, 0x36, 0xaf, 0x6b, 0x4c, 0xf1, 0x88, 0x40, 0xd4, 0x5f, 0x6e, 0x9d, 0x1f, 0xa7, 0x3c,
+	0x8b, 0xc2, 0x71, 0xba, 0x87, 0xcd, 0xc2, 0x9b, 0x33, 0xcf, 0x18, 0xee, 0x59, 0x8e, 0xf6, 0x6c,
+	0x76, 0xcc, 0xed, 0xcc, 0x09, 0xfe, 0xe1, 0xf8, 0xce, 0x5c, 0x78, 0xb3, 0xb9, 0xe3, 0xf5, 0x29,
+	0x14, 0xaa, 0x67, 0xd0, 0xb5, 0xcb, 0x7a, 0x7e, 0xd1, 0x2e, 0x83, 0x97, 0xf1, 0x6b, 0xfb, 0xe4,
+	0xfb, 0xeb, 0xdd, 0x18, 0x54, 0x0d, 0x4c, 0xa7, 0x65, 0xc1, 0x0c, 0x11, 0xad, 0xea, 0x83, 0x9f,
+};
+
+#endif /* KEYCTL_DH_DATA_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
