Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBC3C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:09:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BE833E76D7
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:09:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08FA83E8C48
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A3C56008C8
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 281D01FDA4;
 Wed, 16 Sep 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcFqEOKNDpwjQUf7nKGqX3xzd53V+vBDbhCHhxpQeXg=;
 b=wxGJuMQFo1G28z6tXSVqiJR5b32YqhWQsIWfR0CS/VbMVgxj0T4FDPHnQcaX3ove63/uXv
 TeBq2E0FouX7gkhHX5FKW1M6sHd06xcrYEpVGTQ3Hz99MezR0mn44AP0lTN2jmTrQpC0I1
 lW0QX0visYpnpA6G30pUjYTRWN4DnfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcFqEOKNDpwjQUf7nKGqX3xzd53V+vBDbhCHhxpQeXg=;
 b=qGVK6J7j92lO4uKy9PQFhaLJYYuBY0byWfVIvi2yp1yKxjmdydUVBILRUWvFghnhlmnpGj
 /Lwf+goW9NHZsZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcFqEOKNDpwjQUf7nKGqX3xzd53V+vBDbhCHhxpQeXg=;
 b=WaSnCRh7t92w5so7e9rPaaoPRVaNYti2WbptKaZLAkS0FRH/46faSg3dkjFN+ez9+GdfeN
 Z0TwONjEkRi3LlM+QGhwpdLSLdVjPMPUmJ+CF2SAyTm0pvuGj4KGSavhP3VHYFSSqr8WLx
 ZFTc6+4zU8d7t4qAs6po74tgA3r59s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcFqEOKNDpwjQUf7nKGqX3xzd53V+vBDbhCHhxpQeXg=;
 b=t2FTlViNl8aw25t2nBUftXDnYtPVEWsjUUsFSGPX2FgB1lgeg8ykTotVN5ZyCDNjpLILgo
 0mDROinVAobASwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4555139B1;
 Wed, 16 Sep 2026 14:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T19
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:44 +0200
Message-ID: <20260916140402.1797325-19-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 18/36] keyctl23: Test KEYCTL_RESTRICT_KEYRING
 builtin_trusted
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

Test KEYCTL_RESTRICT_KEYRING builtin_trusted restriction: verify that
restricting a keyring with asymmetric builtin_trusted allows only
trusted asymmetric keys, rejecting user keys with EOPNOTSUPP and
untrusted certs with ENOKEY.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
[ pvorel:
* check asym. with !(TST_RET == -1 && TST_ERR == ENOKEY) instead of
  (TST_RET != -1 || TST_ERR != ENODEV);
* Move check to is_asym_supported()
* Use tst_brk() on TCONF (Cyril) ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore   |   1 +
 testcases/kernel/syscalls/keyctl/keyctl23.c   | 134 ++++++++++++++++++
 .../kernel/syscalls/keyctl/keyctl_common.h    |   9 ++
 4 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl23.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d33b24167a..50708a00cf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -740,6 +740,7 @@ keyctl19 keyctl19
 keyctl20 keyctl20
 keyctl21 keyctl21
 keyctl22 keyctl22
+keyctl23 keyctl23
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 82a74e4a38..803e4e94c3 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -20,3 +20,4 @@
 /keyctl20
 /keyctl21
 /keyctl22
+/keyctl23
diff --git a/testcases/kernel/syscalls/keyctl/keyctl23.c b/testcases/kernel/syscalls/keyctl/keyctl23.c
new file mode 100644
index 0000000000..af9218975b
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl23.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_RESTRICT_KEYRING`` builtin_trusted of :manpage:`keyctl(2)`.
+ *
+ * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` module.
+ *
+ * [Algorithm]
+ *
+ * - restrict a keyring with ``asymmetric`` and ``builtin_trusted``, verify
+ *   linking a user key fails with ``EOPNOTSUPP`` and adding an untrusted
+ *   cert fails with ``ENOKEY``
+ */
+
+#include "keyctl_common.h"
+#include "tst_module.h"
+
+#define PAYLOAD		"payload"
+
+/*
+ * Self-signed RSA-2048 X.509 certificate in DER format generated using:
+ * openssl req -x509 -newkey rsa:2048 -subj "/CN=ltp-keyctl23-untrusted" \
+ *     -days 36500 -nodes -batch -outform der
+ *
+ * Used only as an untrusted certificate to verify that add_key() on a
+ * keyring restricted with builtin_trusted rejects it with ENOKEY.
+ */
+static const unsigned char untrusted_cert[] = {
+	0x30, 0x82, 0x03, 0x25, 0x30, 0x82, 0x02, 0x0d, 0xa0, 0x03, 0x02, 0x01, 0x02, 0x02, 0x14, 0x52,
+	0xad, 0xef, 0x01, 0xca, 0xbb, 0x64, 0x17, 0xa7, 0x1a, 0xa7, 0xcb, 0x2f, 0x82, 0x44, 0x6e, 0xec,
+	0x5a, 0x2e, 0x2c, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x0b,
+	0x05, 0x00, 0x30, 0x21, 0x31, 0x1f, 0x30, 0x1d, 0x06, 0x03, 0x55, 0x04, 0x03, 0x0c, 0x16, 0x6c,
+	0x74, 0x70, 0x2d, 0x6b, 0x65, 0x79, 0x63, 0x74, 0x6c, 0x32, 0x33, 0x2d, 0x75, 0x6e, 0x74, 0x72,
+	0x75, 0x73, 0x74, 0x65, 0x64, 0x30, 0x20, 0x17, 0x0d, 0x32, 0x36, 0x30, 0x39, 0x30, 0x32, 0x30,
+	0x39, 0x32, 0x33, 0x34, 0x39, 0x5a, 0x18, 0x0f, 0x32, 0x31, 0x32, 0x36, 0x30, 0x38, 0x30, 0x39,
+	0x30, 0x39, 0x32, 0x33, 0x34, 0x39, 0x5a, 0x30, 0x21, 0x31, 0x1f, 0x30, 0x1d, 0x06, 0x03, 0x55,
+	0x04, 0x03, 0x0c, 0x16, 0x6c, 0x74, 0x70, 0x2d, 0x6b, 0x65, 0x79, 0x63, 0x74, 0x6c, 0x32, 0x33,
+	0x2d, 0x75, 0x6e, 0x74, 0x72, 0x75, 0x73, 0x74, 0x65, 0x64, 0x30, 0x82, 0x01, 0x22, 0x30, 0x0d,
+	0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01,
+	0x0f, 0x00, 0x30, 0x82, 0x01, 0x0a, 0x02, 0x82, 0x01, 0x01, 0x00, 0xd5, 0xee, 0x8d, 0xec, 0x85,
+	0x8e, 0x29, 0xc7, 0xe7, 0xf8, 0x3f, 0xed, 0xc8, 0x82, 0xb2, 0x17, 0x95, 0xf4, 0xe0, 0x99, 0x02,
+	0x84, 0xc5, 0xb3, 0x46, 0x62, 0x8c, 0x8a, 0xd3, 0x89, 0xd5, 0x62, 0x25, 0xa7, 0xc8, 0x92, 0xcc,
+	0xc5, 0x64, 0x20, 0x80, 0xb7, 0xf3, 0xc2, 0x40, 0xdc, 0xf0, 0xf0, 0xd8, 0x85, 0x5f, 0x58, 0x61,
+	0x77, 0xd6, 0xd5, 0x3a, 0x32, 0xec, 0x81, 0x15, 0x25, 0xb4, 0x08, 0x21, 0x6d, 0xf3, 0xd6, 0x80,
+	0xa6, 0x91, 0x5a, 0x53, 0x9e, 0x54, 0x49, 0x5b, 0x91, 0x6b, 0x74, 0x0b, 0xb5, 0x99, 0xd5, 0x49,
+	0x46, 0x41, 0x56, 0x67, 0xb4, 0xed, 0x17, 0x82, 0x96, 0x03, 0x40, 0xd7, 0x0d, 0x0a, 0x00, 0x95,
+	0x3c, 0xb7, 0x75, 0x9e, 0x61, 0xab, 0xe9, 0x10, 0x4a, 0xa9, 0x90, 0x21, 0xd2, 0xb4, 0x3d, 0xd0,
+	0x83, 0x48, 0x0c, 0x59, 0xa9, 0xd7, 0xbe, 0x7b, 0x4c, 0x75, 0xf0, 0xd1, 0x8a, 0x29, 0x1c, 0x06,
+	0x35, 0x29, 0x6d, 0x3c, 0x6e, 0xb9, 0xce, 0x11, 0xa9, 0x1b, 0x4d, 0xf7, 0xfd, 0x6d, 0x2e, 0x02,
+	0x7f, 0xbe, 0x45, 0xb7, 0x11, 0xae, 0x1d, 0xbb, 0x70, 0x02, 0xae, 0xc1, 0xb3, 0x31, 0x3d, 0x99,
+	0xd9, 0x70, 0x01, 0xbd, 0xea, 0xd3, 0x0d, 0x04, 0xe0, 0x2f, 0xac, 0x79, 0xe4, 0xb2, 0x0c, 0x96,
+	0xba, 0x66, 0x9e, 0xcf, 0x72, 0x13, 0xa3, 0x37, 0x44, 0x03, 0x2d, 0xe9, 0x5c, 0x71, 0x6f, 0x35,
+	0x71, 0xf8, 0xdc, 0x58, 0xa3, 0x1f, 0x57, 0x88, 0x59, 0x79, 0xe6, 0x7e, 0x37, 0x9b, 0xc9, 0xa3,
+	0x36, 0x03, 0x5c, 0xcb, 0x30, 0x92, 0x5e, 0x9e, 0x43, 0x48, 0xa2, 0x3e, 0x7f, 0xdc, 0xb8, 0xe3,
+	0x6a, 0xe6, 0x8c, 0x18, 0xb2, 0x42, 0x4c, 0xbb, 0x2d, 0x6a, 0x6c, 0x5f, 0xd1, 0xc1, 0xd5, 0x33,
+	0x3b, 0xdb, 0x8c, 0x3c, 0xa2, 0xec, 0xaa, 0xed, 0xce, 0xe1, 0xd1, 0x02, 0x03, 0x01, 0x00, 0x01,
+	0xa3, 0x53, 0x30, 0x51, 0x30, 0x1d, 0x06, 0x03, 0x55, 0x1d, 0x0e, 0x04, 0x16, 0x04, 0x14, 0xd3,
+	0x8d, 0xd1, 0xe4, 0x77, 0x4e, 0xe2, 0xb2, 0xb6, 0xab, 0x31, 0x58, 0x69, 0x7b, 0x27, 0x31, 0xce,
+	0x00, 0xcd, 0x60, 0x30, 0x1f, 0x06, 0x03, 0x55, 0x1d, 0x23, 0x04, 0x18, 0x30, 0x16, 0x80, 0x14,
+	0xd3, 0x8d, 0xd1, 0xe4, 0x77, 0x4e, 0xe2, 0xb2, 0xb6, 0xab, 0x31, 0x58, 0x69, 0x7b, 0x27, 0x31,
+	0xce, 0x00, 0xcd, 0x60, 0x30, 0x0f, 0x06, 0x03, 0x55, 0x1d, 0x13, 0x01, 0x01, 0xff, 0x04, 0x05,
+	0x30, 0x03, 0x01, 0x01, 0xff, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01,
+	0x01, 0x0b, 0x05, 0x00, 0x03, 0x82, 0x01, 0x01, 0x00, 0x1e, 0xb9, 0x52, 0x16, 0xf2, 0xef, 0xca,
+	0xbc, 0x35, 0x93, 0xb4, 0x38, 0xb8, 0xab, 0xfe, 0x73, 0x1a, 0x06, 0x50, 0x99, 0x58, 0xc4, 0xa8,
+	0xf4, 0x26, 0xb1, 0xe1, 0x8e, 0x0b, 0xd3, 0xe7, 0xa8, 0x8d, 0x1f, 0xa0, 0x79, 0x4c, 0x9f, 0xdd,
+	0x3a, 0xf0, 0xb7, 0xf2, 0x18, 0xfc, 0x99, 0x11, 0x45, 0x8f, 0xeb, 0xc9, 0xf2, 0x48, 0x2e, 0x4a,
+	0x7b, 0x24, 0x37, 0xa4, 0xbc, 0x52, 0x96, 0x80, 0x76, 0x46, 0x59, 0x27, 0xb5, 0xa0, 0x07, 0x5b,
+	0x6c, 0x38, 0x5c, 0xde, 0x95, 0x76, 0xfc, 0x21, 0xb8, 0x1e, 0x7e, 0x13, 0x3e, 0x59, 0x95, 0xf9,
+	0x39, 0xdb, 0xd5, 0x41, 0x3d, 0x8d, 0xfd, 0x4c, 0x1a, 0x4b, 0xdd, 0x41, 0x3b, 0x27, 0x58, 0xf8,
+	0x72, 0xa3, 0x70, 0x97, 0xc6, 0xb9, 0x0e, 0x4e, 0x3c, 0x08, 0xba, 0x2f, 0xa9, 0x55, 0x6d, 0x23,
+	0xdd, 0xc4, 0x0a, 0x43, 0xad, 0x20, 0x75, 0x0d, 0xea, 0xbc, 0x49, 0x6c, 0xd2, 0x87, 0x59, 0x46,
+	0x72, 0x3e, 0x77, 0x9b, 0x29, 0x63, 0x38, 0x0a, 0x2f, 0x61, 0xcc, 0xda, 0xd0, 0x21, 0x47, 0x6f,
+	0x9f, 0x19, 0x26, 0x0c, 0xbb, 0x77, 0x22, 0x8d, 0xc7, 0x65, 0x01, 0x25, 0x4b, 0x69, 0x38, 0xae,
+	0x6e, 0x16, 0x4f, 0x70, 0x35, 0xab, 0xea, 0x76, 0xe4, 0x37, 0xe4, 0x92, 0x6b, 0xf0, 0x6e, 0xc5,
+	0x4c, 0xc1, 0x37, 0xc1, 0x28, 0xa6, 0x78, 0xc7, 0x90, 0xb4, 0xea, 0xbb, 0x8d, 0x12, 0xe1, 0x30,
+	0xe1, 0x7b, 0x76, 0xc3, 0x65, 0xc3, 0x99, 0x7b, 0xb3, 0xb1, 0x9a, 0xe9, 0x73, 0xb2, 0x4d, 0x08,
+	0x2a, 0xa4, 0x67, 0x42, 0xef, 0x7c, 0xf5, 0x67, 0x3e, 0xa4, 0x78, 0xe1, 0x04, 0x93, 0x5e, 0x1b,
+	0xf9, 0xae, 0xe1, 0x5a, 0x7f, 0x42, 0x38, 0xb7, 0x93, 0xfb, 0x27, 0xff, 0x1c, 0x7e, 0xdd, 0x8a,
+	0x71, 0x10, 0xcb, 0x65, 0xc9, 0xf2, 0x0f, 0x9e, 0x7d,
+};
+
+static key_serial_t ring_builtin;
+static key_serial_t user_key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	tst_modprobe("x509_key_parser", NULL);
+
+	ring_builtin = SAFE_NEW_RING("ltpkeyctl23_builtin");
+
+	user_key = SAFE_NEW_USER_KEY("k", PAYLOAD, sizeof(PAYLOAD),
+				KEY_SPEC_PROCESS_KEYRING);
+
+	if (!is_asym_supported(ring_builtin))
+		tst_brk(TCONF, "asymmetric key type not supported");
+}
+
+static void run(void)
+{
+	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_builtin,
+		    (unsigned long)"asymmetric",
+		    (unsigned long)"builtin_trusted", 0));
+
+	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
+		tst_brk(TCONF, "builtin_trusted restriction not supported");
+
+	if (TST_RET == 0)
+		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING builtin_trusted passed");
+	else if (TST_RET == -1 && TST_ERR == EEXIST)
+		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING builtin_trusted already active");
+	else
+		tst_res(TFAIL | TTERRNO, "KEYCTL_RESTRICT_KEYRING builtin_trusted failed");
+
+	TST_EXP_FAIL(keyctl(KEYCTL_LINK, user_key, ring_builtin, 0, 0),
+		     EOPNOTSUPP,
+		     "KEYCTL_LINK of non-asymmetric key on builtin_trusted restricted keyring");
+
+	TST_EXP_FAIL2(add_key("asymmetric", "cert", untrusted_cert,
+			      sizeof(untrusted_cert), ring_builtin), ENOKEY,
+		      "add_key of untrusted cert on builtin_trusted restricted keyring");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.12",
+	.needs_root = 1,
+	.iterations = 2,
+};
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_common.h b/testcases/kernel/syscalls/keyctl/keyctl_common.h
index 1063163bc1..1465824334 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl_common.h
+++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
@@ -7,6 +7,7 @@
 #define KEYCTL_COMMON_H__
 
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 
 #include "tst_test.h"
@@ -30,4 +31,12 @@
 #define SAFE_NEW_USER_KEY(desc, payload, plen, ring) \
 	safe_add_key(__FILE__, __LINE__, "user", (desc), (payload), (plen), (ring))
 
+static inline bool is_asym_supported(key_serial_t ring_builtin)
+{
+	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_builtin,
+		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
+
+	return !(TST_RET == -1 && TST_ERR == ENOKEY);
+}
+
 #endif /* KEYCTL_COMMON_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
