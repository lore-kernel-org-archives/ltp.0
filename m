Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C001EC624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F64B3C6603
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:07:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32EF13E5857
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A44901000A2D
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A30221E21;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=pguHbcvlNVoPoIVUAbHl0cPTbpnmIxMyu14+5e2mpbBqtjNtlWWbSnaibtKzhM4b6ObrII
 91MeE+YSIU+JLuc9Tbe+i2X0Zf6RGLhKm5s4vOBRvBfkKV3c1o6MM0ZRbvkNaunZEAlxye
 ugko4nMTLHI03QnmsTqcrB6/+3CIk3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=foDjo8WBrKZ5Yf3TeGXLK/EGcmKxmmf9Uyhq1bmUoMLKgawYVwNh5IMU1FZVtLDifRPlmS
 mykIngIAVQfyRBAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=iRh51blVxCxphh2h0msvFsFLOtlUCO5DxKgBvsfIDoE6b41P8R9LhUMLdBYsyUnclvtbJ0
 0KgtA99NKzPBWCWuEZ9jUhYq48oWOw8/tG/bidDAa1jzfR6deQla3O70cj+FwfjMNzgjnf
 wU5O5EmT8rL98WSMOny9tQlTNlKKuuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=V4wBnLIyQikGA7c48ce/OfXceI/z6YEAOdRF4XGmOtuEN9DqVAXZK7dVJ7zruu5CIipcgN
 VYtzLSIT8wRamyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C22DE1397A;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aECTLbcCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:25 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-10-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2802;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PKV0MTLvss/oBkc6vTwTLe2008Xx+Jp/hGtIftleIUc=;
 b=ooAP/1yDWr/kqHD6evp8Z3aYbirf2cxYjH0LNylq6hHI4BxUohCCAli1uu6JULZazrlaaNDn1
 J8NitkwHtZRBd4io5eNZvx89f4krEw+2bDdvYdtee0cnn///AS5JUhW
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
Subject: [LTP] [PATCH 10/33] keyctl18: Test basic KEYCTL_MOVE
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

Test basic moving of a key between two keyrings with KEYCTL_MOVE:
verify the key is moved to the destination and no longer found in
the source keyring.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl18.c | 60 +++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fcc1d58a8..895dd0fc4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -735,6 +735,7 @@ keyctl14 keyctl14
 keyctl15 keyctl15
 keyctl16 keyctl16
 keyctl17 keyctl17
+keyctl18 keyctl18
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index dddb45f85..808cd2d23 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -15,3 +15,4 @@
 /keyctl15
 /keyctl16
 /keyctl17
+/keyctl18
diff --git a/testcases/kernel/syscalls/keyctl/keyctl18.c b/testcases/kernel/syscalls/keyctl/keyctl18.c
new file mode 100644
index 000000000..2b87e65d4
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl18.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test basic ``KEYCTL_MOVE`` of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * [Algorithm]
+ *
+ * - move a key between two keyrings, verify it can be found only in the
+ *   destination afterwards
+ */
+
+#include "keyctl_common.h"
+
+#define RING_A_DESC	"ltpkeyctl18_a"
+#define RING_B_DESC	"ltpkeyctl18_b"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_a, ring_b;
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_a = new_ring(RING_A_DESC);
+	ring_b = new_ring(RING_B_DESC);
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+}
+
+static void reset_state(void)
+{
+	SAFE_KEYCTL(KEYCTL_LINK, key, ring_a, 0, 0);
+	TEST(keyctl(KEYCTL_UNLINK, key, ring_b, 0, 0));
+	if (TST_RET == -1 && TST_ERR != ENOENT)
+		tst_brk(TBROK | TTERRNO, "failed to unlink key from ring_b");
+}
+
+static void run(void)
+{
+	reset_state();
+
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring_a, ring_b, 0));
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(search_ring(ring_b, "user", KEY_DESC), key);
+
+	TST_EXP_FAIL2(search_ring(ring_a, "user", KEY_DESC), ENOKEY,
+		      "key no longer found in the source keyring");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
