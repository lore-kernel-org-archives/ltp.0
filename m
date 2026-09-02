Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A89C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 008B73E93AA
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:07:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF7CE3E5857
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CAC6600B42
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA8031F8B3;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=rf/7LcMvhqCAtIh/CC3EyPxf8Bn/qf6ajzCD4jUKSBpcUFGVtykeZcpYejJlFe/gpyP/tC
 R0rg9yYzIh0VUQk8VC9kmAee8eaQVOg3Hshwr0aqtUL5L8oTh2kjScd3e1+SPLmUO9V4x8
 ixSDA2hol+vKakQNs6sj8wiEth9QUMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=iJMB4E18YCX1yG90mujJybsHafLKuQfTKEKmfdFGqiz3Pk8nJlb7Kpj9ISGQOdiojArZRI
 an6Q8K3y7jJhYdAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xbhSC/wx";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WubPLnD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=xbhSC/wxKC+QiAGfyctV051706nXOYYdmQdvuZVuw35pLjIyBYTl6GyZ33PPPqFcrW+oe9
 SBG9GJPfj66hlsdcI0wFRGENWdeXtze5NCU1bNQhePaFpAgRQx3DP1QqQF38RCQNn0NVDt
 g3D808UIpiiSz9UdmG+aMdEKdA9tRn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fla/p9kmzRveOAH8iYhVYxyG2EtP5wx6bJZ6aF5To7A=;
 b=WubPLnD3CadtGLtgVIeyc/iVYoUaOPXeY9RC9zTvDMCccBReug3SJuMCM7+iAGtTjZoy6r
 XA1GG3rD2pEfrVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4348513981;
 Wed,  2 Sep 2026 11:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJEWDrgCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:28 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-13-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=4847;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=yWEqz7rDHj13aGYBDKrpClw3tmtN/7+WVfqF6kuSAYg=;
 b=5aMqzwSzYHLcTLVu05058GJGzX3tHHtlfDlrCILV0Xrdh/yHi4/jMyQ0ubvuduKTo1rYFDCHz
 jW9s2t/2NSzCR5W/75k8nAcnNO4b7UC5tZBEzjI7Qlo/mB38PGyrWTn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: AA8031F8B3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/33] keyctl21: Negative and boundary tests for
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
