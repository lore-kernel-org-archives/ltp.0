Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F37C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F7C03E8C4E
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:08:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29E3B3E79E5
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0B79600906
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5880421CF2;
 Wed, 16 Sep 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXc94UyZhUhFO66yPM+xVpYVOQ2cu8AtqqWZdPi1w9w=;
 b=ZLeDnu1TJRLdrtI1FvY6IEzd09awz2wYhTkE8rn10s9G3BJWgAUWR4XiP6Osc1yqltEbb4
 sax7w/MWSW5WU2F7Y0o250qaDTKEJatK7Oe77zpEk2XuG8kvJ/222rEfpY9g7paArnzwMN
 pncplWLLoWllo3QiJGZoTEa9SkfmJiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXc94UyZhUhFO66yPM+xVpYVOQ2cu8AtqqWZdPi1w9w=;
 b=4AG6vqZCfcbGeGxp6NYfQkTAQqArWheGYdTnOOHy5Mygtyaorv5jqHaRXQxbUzczjjl9sT
 SlcMqw044K8N5ECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXc94UyZhUhFO66yPM+xVpYVOQ2cu8AtqqWZdPi1w9w=;
 b=VyOSl74OQ5Et4a+q8xL1VBlZxkOKDWcjbVPTMTnqhobDEBT/WhqzxTOYDCBwXN2+bKtRFX
 LwInrnTRMPOy75IXkdqEUbwzTB39EsPpFu2H2kXzcwkxBaorEVVTFDDYob6A3Lhcq1iAsB
 p/TQR2Pf0CsOvGNyWn8mhFr54nHo0Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXc94UyZhUhFO66yPM+xVpYVOQ2cu8AtqqWZdPi1w9w=;
 b=7T7Pg3HtuJ4hpELsYKMCXqTlbAF2txMZfNOPDDTdQ5F/ghKT/ug/jJ+8bhXmVuZQpMBA08
 lHnQzj2xoCA0L5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFACD139AC;
 Wed, 16 Sep 2026 14:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T16
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:41 +0200
Message-ID: <20260916140402.1797325-16-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 15/36] keyctl21: Negative and boundary tests for
 KEYCTL_MOVE
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

Test error and boundary conditions of KEYCTL_MOVE using a
parameterized tcase table: KEYCTL_MOVE_EXCL (EEXIST), unknown flag
bits (EINVAL), bogus IDs (ENOKEY), non-keyrings (ENOTDIR), unlinked
key (ENOENT), keyring cycle (EDEADLK), and destination without
Write permission (EACCES).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_RING(), SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl21.c | 111 ++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl21.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 63a16dd5a3..460d43850e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -738,6 +738,7 @@ keyctl17 keyctl17
 keyctl18 keyctl18
 keyctl19 keyctl19
 keyctl20 keyctl20
+keyctl21 keyctl21
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index acddfa79ec..e8c71e79e6 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -18,3 +18,4 @@
 /keyctl18
 /keyctl19
 /keyctl20
+/keyctl21
diff --git a/testcases/kernel/syscalls/keyctl/keyctl21.c b/testcases/kernel/syscalls/keyctl/keyctl21.c
new file mode 100644
index 0000000000..a0578ea5b6
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl21.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative and boundary test cases for ``KEYCTL_MOVE`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - ``KEYCTL_MOVE_EXCL`` fails with ``EEXIST`` when the destination already
+ *   holds a matching key
+ * - unknown flag bits are rejected with ``EINVAL``
+ * - bogus key or keyring ids fail with ``ENOKEY``
+ * - a plain key used as source or destination keyring fails with ``ENOTDIR``
+ * - moving a key that is not linked in the source fails with ``ENOENT``
+ * - moving a keyring into itself fails with ``EDEADLK`` from the keyring
+ *   cycle detection
+ * - moving into a keyring without Write permission fails with ``EACCES``
+ */
+
+#include "keyctl_common.h"
+
+#define RING_A_DESC	"ltpkeyctl21_a"
+#define RING_B_DESC	"ltpkeyctl21_b"
+#define RING_C_DESC	"ltpkeyctl21_c"
+#define KEY_A_DESC	"ka"
+#define KEY_B_DESC	"kb"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_a, ring_b, ring_c, ring_no_write;
+static key_serial_t key_a, key_b, key_excl;
+static key_serial_t bogus_id = INT32_MAX;
+
+static struct tcase {
+	key_serial_t *keyid;
+	key_serial_t *from;
+	key_serial_t *to;
+	unsigned int flags;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{ &key_a, &ring_a, &ring_b, KEYCTL_MOVE_EXCL,
+	  EEXIST, "KEYCTL_MOVE_EXCL on existing key" },
+
+	{ &key_a, &ring_a, &ring_b, 0x2,
+	  EINVAL, "unknown flag bits" },
+
+	{ &bogus_id, &ring_a, &ring_b, 0,
+	  ENOKEY, "bogus key id" },
+
+	{ &key_a, &bogus_id, &ring_b, 0,
+	  ENOKEY, "bogus source keyring" },
+
+	{ &key_a, &ring_a, &bogus_id, 0,
+	  ENOKEY, "bogus destination keyring" },
+
+	{ &key_a, &key_b, &ring_b, 0,
+	  ENOTDIR, "plain key as source keyring" },
+
+	{ &key_a, &ring_a, &key_b, 0,
+	  ENOTDIR, "plain key as destination keyring" },
+
+	{ &key_b, &ring_a, &ring_b, 0,
+	  ENOENT, "key not linked in the source keyring" },
+
+	{ &ring_c, &ring_b, &ring_c, 0,
+	  EDEADLK, "keyring into itself" },
+
+	{ &key_a, &ring_a, &ring_no_write, 0,
+	  EACCES, "destination without Write permission" },
+};
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_a = SAFE_NEW_RING(RING_A_DESC);
+	ring_b = SAFE_NEW_RING(RING_B_DESC);
+	ring_c = SAFE_NEW_RING(RING_C_DESC);
+	ring_no_write = SAFE_NEW_RING("ltpkeyctl21_nowrite");
+	SAFE_KEYCTL(KEYCTL_SETPERM, ring_no_write, KEY_PERM_NO_WRITE, 0, 0);
+
+	key_a = SAFE_NEW_USER_KEY(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+	key_b = SAFE_NEW_USER_KEY(KEY_B_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+	key_excl = SAFE_NEW_USER_KEY(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+
+	/* Keep key_excl in session keyring */
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, KEY_SPEC_SESSION_KEYRING, 0, 0);
+
+	/* Link ring_c into ring_b for cycle test */
+	SAFE_KEYCTL(KEYCTL_LINK, ring_c, ring_b, 0, 0);
+}
+
+static void verify_negative(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(keyctl(KEYCTL_MOVE, (unsigned long)*tc->keyid,
+			    (unsigned long)*tc->from, (unsigned long)*tc->to,
+			    tc->flags),
+		     tc->exp_errno,
+		     "KEYCTL_MOVE with %s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_negative,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "5.3",
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
