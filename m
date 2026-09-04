Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6953EC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:11:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB5D3E4B68
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:11:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD0F3E9768
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ACBAF601FF0
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BD311FECF;
 Fri,  4 Sep 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=NMam7HlxJd7m3KWA/bubRFa4et8al/afsDSPo6unZnEt9r9HptP05CCsMDLmV1f7sGRDx7
 LgW+5WcjTEyPS0FoHa0B8GKEdQE1D/c/d1RnF22y+PixY54lA4MKtZ0FOMI1A/3n8/EKXG
 z3UCkbOwX6DAR/2hv4sHOpyQRfblLBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=ydcdgZO26Pb+Fn1Elsbu2MbVbIQUFD2q7YVy0kxq2AIomjA8t9zx5xSABYYG/NJRg9YxNr
 jccQFlReIJfThtBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sCqp89ft;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RdsjHr9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=sCqp89ftRR4rqmAcIStw7omZaDYlIjalhEToJEGQKnIMPT0NszJroLpVYENXStcIKo9+d+
 MOLKSDH6sXN7/pJXeAHrDLEuM9EQlkXOrEBoesXBHBdjjnwb3xmXVwmbt5SL5FA2OIuV1f
 eZbkdML4tMpYkBWLZ3X/b17O7sy/L58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCc8pJamyJRK6ReHfIYvKxAEItSkdnwGvOLnFYopo6o=;
 b=RdsjHr9Afw5WAd0qYIfUCL8bAK3Q0UNnAxkYksllwjWKm2LCYTxEq9t6rPrKIU5FVZo52I
 4SBPBS/cCprh+qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0B013991;
 Fri,  4 Sep 2026 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iNudA9a0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:59 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-10-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2802;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PKV0MTLvss/oBkc6vTwTLe2008Xx+Jp/hGtIftleIUc=;
 b=opXcJjr1DP2lnCJz89GMveKLeRw8Utq90p3+bsDBbLtOwEur7l65xEuetvgbZ24t4udZ0QSzt
 r/RhD0YwTUvANQ+84a2cRpxwg+Fa91IgDBrK/tVJlqpFkGoiMiD+DZy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1BD311FECF
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
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/33] keyctl18: Test basic KEYCTL_MOVE
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
