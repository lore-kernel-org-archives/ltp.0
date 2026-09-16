Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF87C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:07:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 733F33E7D4A
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA9D13E7FCC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B8F32000FD
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F033A1FE16;
 Wed, 16 Sep 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/40sgSY+d6M8rn2F0jsDtYr+amiFhO7vBEBjErqaFc=;
 b=OWtQq90Xs0lNQaAijlrWTqS37B/Zs5uaWtdxFqMWpnR5cAb8I+g/sDuLBhjQyGau/gbEEI
 syWOjeICi+1hbp0u2D+kZ9LRpt2V2bOyjDP3ECzDqAeC7+BV9lp5bczEm+C+Qj9fX5hMXc
 jrC44HipL7D9mvTDdnqV6DUE/3f/4pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/40sgSY+d6M8rn2F0jsDtYr+amiFhO7vBEBjErqaFc=;
 b=LdGRQaFrPErYSsLa3kugt7iIu5rZdxHvRTo4EbJZIAcQWEL3oK+1zeGUIV3wVncA/Y4qrt
 Z5YNTXEDoZFnhWAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/40sgSY+d6M8rn2F0jsDtYr+amiFhO7vBEBjErqaFc=;
 b=TqFPebAhtLqZcimCioVNhl7CB4vD4ENlQ9l81qoICH1XSBnoAFCWXk3aI6gBfEGLm64C5Y
 mMgBH/Qwq4i0zhRRRJPfenjnRnFFKI0ksMoPk2EjJhtwC44OszBCwIJJIfPja/pv1qMG7z
 Eyou5uH8NzBn1PeWtKg0T8KTQBkj4LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/40sgSY+d6M8rn2F0jsDtYr+amiFhO7vBEBjErqaFc=;
 b=4j+44LXJx8aS/sW3sGnM1JdGnLpu9yy06p7SBQNvgpfQ6FkZAz5vKQgjOKzbEXXghB5eT5
 rNHurJOc+f5V0hBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32BB2139A3;
 Wed, 16 Sep 2026 14:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T13
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:38 +0200
Message-ID: <20260916140402.1797325-13-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 12/36] keyctl18: Test basic KEYCTL_MOVE
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel:
* Use SAFE_NEW_RING(), SAFE_NEW_USER_KEY(), keyctl() instead of
  search_ring()
* Remove keyctl(KEYCTL_UNLINK, ...) check (Cyril)
]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I found on VM with 6.17.0-rc5-4.gc548b9b-default that keyctl15.c
fails:

keyctl15.c:46: TFAIL: empty label is not NUL terminated 
That might be a reason why Andrea did not test it on failure
(modification asked by Cyril).

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl18.c | 51 +++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl18.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aba31b2c27..12923a4df2 100644
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
index dddb45f856..808cd2d231 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -15,3 +15,4 @@
 /keyctl15
 /keyctl16
 /keyctl17
+/keyctl18
diff --git a/testcases/kernel/syscalls/keyctl/keyctl18.c b/testcases/kernel/syscalls/keyctl/keyctl18.c
new file mode 100644
index 0000000000..25f99cc476
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl18.c
@@ -0,0 +1,51 @@
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
+ * Move a key between two keyrings, verify it can be found only in the
+ * destination afterwards.
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
+	ring_a = SAFE_NEW_RING(RING_A_DESC);
+	ring_b = SAFE_NEW_RING(RING_B_DESC);
+	key = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+}
+
+static void run(void)
+{
+	SAFE_KEYCTL(KEYCTL_LINK, key, ring_a, 0, 0);
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring_a, ring_b, 0));
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key);
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_SEARCH, ring_a, "user", KEY_DESC), ENOKEY,
+		      "key no longer found in the source keyring");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
