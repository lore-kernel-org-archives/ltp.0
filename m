Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5164C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FA323E9787
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:12:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 639AB3E978A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC8A51001141
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8993122B1E;
 Fri,  4 Sep 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=aIV9iTx//FKUe8fywojUlHXW07YZuY9zoObbDUsNUu8u45mltdJQuitfegZI3Mt1UtMruR
 wMtOS2uGe7zf8cT7+LBhzrdF/Cm2+sWt4uqK3/LjhllvB9aWSxtXAWVKzxF4iZBmSG1vPu
 auEFpUzRhGy02lJQna79YS02Cyzrzgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=yPBZxJ/prnxu41AwSx4SsGO0BjVbOXAQsJXn/r2yRPwEaZ4rmnDoMV+xoPxafB4drPw5Nf
 uP3kpoDYRsQpq7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=AbRyeVG47N/n7XoAhw8uoLTN9jMeqsUdDiNpWd+wsTQ3OIMN3mU6LBwVDu9wY5fcGDuaaE
 bhUb9mP0CBMoqMelnmmUH0dcA43KvwYrxWKJFUlJg0OeDEdIV4GvSSo1sXgapJA2NVXzv4
 pQ9l1hvbvfqXwEzcXUxD9z3KoBYvmJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=hCYT3xrwQya7SH49Qn21/Dfzc4l7bIua7EwWRLCev5WGR31sWfem6k7aGbYZ4tqYfPRCbc
 w8Gg8t+/C+6TbGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3753139A3;
 Fri,  4 Sep 2026 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id INUULda0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:02 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-13-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=4847;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=yWEqz7rDHj13aGYBDKrpClw3tmtN/7+WVfqF6kuSAYg=;
 b=/EjrbcGurSo7HXw2Rmd6IpxPnQo7flZWh6NbmNAdSE95gGn6WJKxO+6+HZ7D3pNyfiLDMQog1
 d+eKL8mwWyrCxBA1uYLqjyv+izF+5fs9KLsbZcUHNJFNmRkqpyto9DV
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/33] keyctl21: Negative and boundary tests for
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl21.c | 111 ++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bfe4090a0..b95264564 100644
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
index acddfa79e..e8c71e79e 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -18,3 +18,4 @@
 /keyctl18
 /keyctl19
 /keyctl20
+/keyctl21
diff --git a/testcases/kernel/syscalls/keyctl/keyctl21.c b/testcases/kernel/syscalls/keyctl/keyctl21.c
new file mode 100644
index 000000000..a2db5a406
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
+	ring_a = new_ring(RING_A_DESC);
+	ring_b = new_ring(RING_B_DESC);
+	ring_c = new_ring(RING_C_DESC);
+	ring_no_write = new_ring("ltpkeyctl21_nowrite");
+	SAFE_KEYCTL(KEYCTL_SETPERM, ring_no_write, KEY_PERM_NO_WRITE, 0, 0);
+
+	key_a = new_user_key(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+	key_b = new_user_key(KEY_B_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+	key_excl = new_user_key(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
