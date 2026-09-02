Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490B9C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3013E6162
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:07:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19A93E5860
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51C63200C74
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4371F839;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=0qjpy9lxIjZgX/cpWg0MvkVObrs1EeOtHsKZv/09dCd5GcqexvDsqnOPHk04HZlgXxRHXx
 IBz8Lsau2eBN7BGccQT3340p5Uqa7+PVRYLv1z1qFjlxq2LiPc9wzZiuJ4hit2uzBhXw9g
 8+H3ct0iz+oPWC5kQL27eYgfzYEq92c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=snO1hDx672kzgT+osqAsYORoCPgajrBI6M+af+yvYPITRiyfkT5klRSa0fvcUWBXmqDA1e
 oujU9fXbAf7HtiAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=vRHb9SIQJp9ydFsnLx5B/v82KiEZY7v+ZjMooaklVQ5nhB/bh1JRCyZNDWxtDyTttFPatb
 MlD9gfKAxsG5iUOIZMzIkTl6ykrmghn3rD3h8sbpOS8rfOIbvEHGof8OGxZzbjYpMTH96e
 C/Uas4di6SCUSoxOLKDrNnsi38sncwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n263ojVll9TfTWZ1BC1allEu8W3vtCyWo7SHBFp225M=;
 b=2vDtetG95JdpnDrb1z3iD4Iy4G9BYbDceQCCRKdXo5C0Mr/Y54scYaDOMQIfa2+3Vkklts
 ai/cmNWNNEK/0vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1944E1397E;
 Wed,  2 Sep 2026 11:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMp6BLgCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:27 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-12-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2997;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+G5DJhUbYX+ZZat+e4b63OcKKJMem/rds9knmtoopWQ=;
 b=Iv9I04wAIqB6nyXrktThIHceZ8nQgIUWmt5z+YbFnP46LsWt2ES7OkFVW4BjzBSw8L2sFqmVl
 SnsORGYnKvhDFCny1gJcVN6FtqTnu+amDwFaAxuMlhwN/MEVlaSjWfm
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/33] keyctl20: Test KEYCTL_MOVE displacement
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

Test KEYCTL_MOVE displacement behavior: verify moving a key without
KEYCTL_MOVE_EXCL into a destination holding a matching key displaces
the existing key.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl20.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 1935bee31..bfe4090a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -737,6 +737,7 @@ keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
 keyctl19 keyctl19
+keyctl20 keyctl20
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f32107923..acddfa79e 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -17,3 +17,4 @@
 /keyctl17
 /keyctl18
 /keyctl19
+/keyctl20
diff --git a/testcases/kernel/syscalls/keyctl/keyctl20.c b/testcases/kernel/syscalls/keyctl/keyctl20.c
new file mode 100644
index 000000000..6da36fe32
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl20.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` displacement of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - move a key without ``KEYCTL_MOVE_EXCL`` into a destination keyring that
+ *   already contains a matching key, verify it displaces the existing key
+ */
+
+#include "keyctl_common.h"
+
+#define RING_A_DESC	"ltpkeyctl20_a"
+#define RING_B_DESC	"ltpkeyctl20_b"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_a, ring_b;
+static key_serial_t key_a, key_excl;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_a = new_ring(RING_A_DESC);
+	ring_b = new_ring(RING_B_DESC);
+
+	key_a = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+	key_excl = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+
+	/* Keep key_excl in session keyring so displacement does not destroy it */
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, KEY_SPEC_SESSION_KEYRING, 0, 0);
+}
+
+static void reset_state(void)
+{
+	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
+	TEST(keyctl(KEYCTL_UNLINK, key_a, ring_b, 0, 0));
+	if (TST_RET == -1 && TST_ERR != ENOENT)
+		tst_brk(TBROK | TTERRNO, "failed to unlink key_a from ring_b");
+
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, ring_b, 0, 0);
+}
+
+static void run(void)
+{
+	reset_state();
+
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
+
+	TST_EXP_EQ_LI(search_ring(ring_b, "user", KEY_DESC), key_a);
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
