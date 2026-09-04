Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D29C79F83
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:13:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BA573E4B68
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:13:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74E6F3E978A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADBC1601FF5
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E8C21FE6C;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnMBjzzTSFICvKmolxVum2sTwLKKC+15o3gh6Wzy228=;
 b=ZWgZ3pE50IZsTy7Uj281B8Hf9FKsaD+ekVDzcF97q2QAWqj0PuDa781ecBvKqOm7xm87Jh
 n506i1mhUBNKCQzz0xO8aZeKGG6FGShUc/9x2eZrrcf+JlaUuPXFWk/G/tWiBff0znxVf4
 eEO4hk3iiptV9W5n65DGzd2S3+JYoZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnMBjzzTSFICvKmolxVum2sTwLKKC+15o3gh6Wzy228=;
 b=TNdmQRiFXSIc8lKXqmUfnXwnvonD/Z7VFrAsP3QmVAbRXtj725rQa5wGz8KKxmQ1WQ4H5A
 a8OVOtC6+5DQQ2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnMBjzzTSFICvKmolxVum2sTwLKKC+15o3gh6Wzy228=;
 b=SWFdO1BxK8YKxcOIAuwoxDsceDC4gWp0IQbTF54CDubUZLR+61rxbqzeC71op5PbOib0pH
 na/BdyQXhH2uyAFQB4sTEyP8Q9pbJNRgjBxP7Nzjiv7e9gun7QYbhQuCrswdh7nR2iAfkO
 3CqrQaCU4ySflcvflLVnbphsh7aJovI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnMBjzzTSFICvKmolxVum2sTwLKKC+15o3gh6Wzy228=;
 b=eja8VsAHxNb8aw5ZjNrTrWaFipATV0s7SfhgJNr8oyHPIIlXZawLwPZqkdv5o1akv7MaNU
 iADwY8dpC1aVDiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 787E9139B1;
 Fri,  4 Sep 2026 12:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODS1Gte0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:05 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-16-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=6614;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=/daZg61PYGLCxm5rrqDgaAzPStn9RZ3eHlVrsf8d8oU=;
 b=jJga3BqWp57x5dcyJ9tGnmMN0eFyMRxWYOI38d43yhN0HWHs1g+h8YQPutqMadjp/HB2csllm
 FbnaZz7E6CfA8Jop/AfDEb6In8YYrulM3m/HqfKPAwSVWHs7Y1cTp5y
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 16/33] keyctl24: Negative tests for
 KEYCTL_RESTRICT_KEYRING
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

Test error conditions of KEYCTL_RESTRICT_KEYRING using a parameterized
tcase table: invalid type/restriction combinations (EINVAL), non-keyrings
(ENOTDIR), unknown key type (ENOKEY), key type without lookup (ENOENT),
invalid restriction string (EINVAL), bogus key serial (ENOKEY), already
restricted (EEXIST), self-chain cycle (EDEADLK), and missing Setattr
(EACCES).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl24.c | 173 ++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index f7c4830a9..be35e9f93 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -741,6 +741,7 @@ keyctl20 keyctl20
 keyctl21 keyctl21
 keyctl22 keyctl22
 keyctl23 keyctl23
+keyctl24 keyctl24
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 803e4e94c..767ccf61a 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -21,3 +21,4 @@
 /keyctl21
 /keyctl22
 /keyctl23
+/keyctl24
diff --git a/testcases/kernel/syscalls/keyctl/keyctl24.c b/testcases/kernel/syscalls/keyctl/keyctl24.c
new file mode 100644
index 000000000..2ec78e720
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl24.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_RESTRICT_KEYRING`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - restrict with ``NULL`` type and non-NULL restriction fails with ``EINVAL``
+ * - restrict with non-NULL type and ``NULL`` restriction fails with ``EINVAL``
+ * - restrict on a non-keyring key fails with ``ENOTDIR``
+ * - restrict with unknown key type fails with ``ENOKEY``
+ * - restrict with key type having no restriction lookup fails with ``ENOENT``
+ * - restrict with asymmetric type and invalid restriction string fails with
+ *   ``EINVAL``
+ * - restrict with asymmetric type and bogus key serial fails with ``ENOKEY``
+ * - restrict an already restricted keyring fails with ``EEXIST``
+ * - restrict with self-referencing key_or_keyring chain fails with ``EDEADLK``
+ * - restrict without Setattr permission fails with ``EACCES``
+ */
+
+#include <stdio.h>
+
+#include "keyctl_common.h"
+
+static key_serial_t ring_reject, ring_no_setattr;
+static key_serial_t user_key;
+static int asym_supported;
+
+/*
+ * A tcase with .id = NULL asks verify_negative() to allocate a fresh
+ * unrestricted keyring for the case and unlink it afterwards, so that a
+ * false-positive result cannot restrict a ring shared with later cases.
+ * .self_cycle asks for a "key_or_keyring:<fresh>:chain" restriction string
+ * pointing back at that fresh ring, needed for the EDEADLK check.
+ */
+static struct tcase {
+	key_serial_t *id;
+	int self_cycle;
+	const char *type;
+	const char *restriction;
+	int exp_errno;
+	int needs_asym;
+	const char *desc;
+} tcases[] = {
+	{
+		.restriction = "builtin_trusted",
+		.exp_errno = EINVAL,
+		.desc = "NULL type and non-NULL restriction",
+	},
+	{
+		.type = "asymmetric",
+		.exp_errno = EINVAL,
+		.desc = "non-NULL type and NULL restriction",
+	},
+	{
+		.id = &user_key,
+		.exp_errno = ENOTDIR,
+		.desc = "non-keyring key",
+	},
+	{
+		.type = "nosuchtype",
+		.restriction = "builtin_trusted",
+		.exp_errno = ENOKEY,
+		.desc = "unknown key type",
+	},
+	{
+		.type = "user",
+		.restriction = "builtin_trusted",
+		.exp_errno = ENOENT,
+		.desc = "key type having no lookup_restriction",
+	},
+	{
+		.type = "asymmetric",
+		.restriction = "bogus",
+		.exp_errno = EINVAL,
+		.needs_asym = 1,
+		.desc = "asymmetric with invalid restriction string",
+	},
+	{
+		.type = "asymmetric",
+		.restriction = "key_or_keyring:2147483647",
+		.exp_errno = ENOKEY,
+		.needs_asym = 1,
+		.desc = "asymmetric with bogus key serial",
+	},
+	{
+		.id = &ring_reject,
+		.exp_errno = EEXIST,
+		.desc = "already restricted keyring",
+	},
+	{
+		.self_cycle = 1,
+		.type = "asymmetric",
+		.exp_errno = EDEADLK,
+		.needs_asym = 1,
+		.desc = "self-referencing key_or_keyring chain",
+	},
+	{
+		.id = &ring_no_setattr,
+		.exp_errno = EACCES,
+		.desc = "keyring without Setattr permission",
+	},
+};
+
+static void setup(void)
+{
+	key_serial_t probe_ring;
+
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_reject = new_ring("ltpkeyctl24_reject");
+	ring_no_setattr = new_ring("ltpkeyctl24_no_setattr");
+	SAFE_KEYCTL(KEYCTL_SETPERM, ring_no_setattr, KEY_PERM_NO_SETATTR, 0, 0);
+
+	/* Permanently restrict ring_reject with reject-all for EEXIST test */
+	SAFE_KEYCTL(KEYCTL_RESTRICT_KEYRING, ring_reject, 0, 0, 0);
+
+	user_key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+
+	/* Probe asymmetric support on a throwaway ring so we cannot poison
+	 * any ring reused later by the tcase table.
+	 */
+	probe_ring = new_ring("ltpkeyctl24_probe");
+	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, probe_ring,
+		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
+	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);
+	keyctl(KEYCTL_UNLINK, probe_ring, KEY_SPEC_PROCESS_KEYRING, 0, 0);
+}
+
+static void verify_negative(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	key_serial_t id, fresh_ring = 0;
+	const char *restriction = tc->restriction;
+	char cycle_buf[64];
+
+	if (tc->needs_asym && !asym_supported) {
+		tst_res(TCONF, "asymmetric key type not supported");
+		return;
+	}
+
+	if (tc->id) {
+		id = *tc->id;
+	} else {
+		fresh_ring = new_ring("ltpkeyctl24_fresh");
+		id = fresh_ring;
+		if (tc->self_cycle) {
+			snprintf(cycle_buf, sizeof(cycle_buf),
+				 "key_or_keyring:%d:chain", fresh_ring);
+			restriction = cycle_buf;
+		}
+	}
+
+	TST_EXP_FAIL(keyctl(KEYCTL_RESTRICT_KEYRING, (unsigned long)id,
+			    (unsigned long)tc->type,
+			    (unsigned long)restriction, 0),
+		     tc->exp_errno,
+		     "KEYCTL_RESTRICT_KEYRING with %s", tc->desc);
+
+	if (fresh_ring)
+		keyctl(KEYCTL_UNLINK, fresh_ring, KEY_SPEC_PROCESS_KEYRING,
+		       0, 0);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_negative,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "4.12",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
